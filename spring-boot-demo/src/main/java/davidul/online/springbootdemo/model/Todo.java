package davidul.online.springbootdemo.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import org.springframework.data.annotation.Id;

import java.time.LocalDateTime;

public record Todo(
        @Id
        @JsonProperty("id") Long id,
        @JsonProperty("todo") String todo,
        @JsonProperty("createDate") LocalDateTime createDate
        ) {
}
