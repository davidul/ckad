package davidul.online.springbootdemo.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.time.LocalDateTime;

@Document("todo")
public record Todo(
        @Id
        @JsonProperty("id") Long id,
        @JsonProperty("todo") String todo,
        @JsonProperty("createDate") LocalDateTime createDate
        ) {
}
