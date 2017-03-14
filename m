From: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] soc/tegra: bpmp: Update ABI header
Date: Tue, 14 Mar 2017 20:15:15 +0100
Message-ID: <20170314191516.13083-3-thierry.reding@gmail.com>
References: <20170314191516.13083-1-thierry.reding@gmail.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170314191516.13083-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Stefan Kristiansson <stefank-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mikko Perttunen <mperttunen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Update the BPMP ABI header to a more recent version. The new version
adds support for a new powergating ABI as well as access to the ring
buffer console, which allows debug messages to be output to the BPMP
debug console.

Some of the previously undocumented fields have been documented and
missing bitmasks have been added. Furthermore the MRQ_RESET request
now has a sub-command that allows to determine the maximum ID which
in turn allows the resets to be enumerated, thereby allowing drivers
to become agnostic of the Tegra generation.

Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
---
 include/soc/tegra/bpmp-abi.h | 418 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 408 insertions(+), 10 deletions(-)

diff --git a/include/soc/tegra/bpmp-abi.h b/include/soc/tegra/bpmp-abi.h
index 0aaef5960e29..98d8d38b99a1 100644
--- a/include/soc/tegra/bpmp-abi.h
+++ b/include/soc/tegra/bpmp-abi.h
@@ -81,13 +81,18 @@
  * Provides the MRQ number for the MRQ message: #mrq. The remainder of
  * the MRQ message is a payload (immediately following the
  * mrq_request) whose format depends on mrq.
- *
- * @todo document the flags
  */
 struct mrq_request {
 	/** @brief MRQ number of the request */
 	uint32_t mrq;
-	/** @brief flags for the request */
+	/**
+	 * @brief flags providing follow up directions to the receiver
+	 *
+	 * | Bit | Description                                |
+	 * |-----|--------------------------------------------|
+	 * | 1   | ring the sender's doorbell when responding |
+	 * | 0   | should be 1                                |
+	 */
 	uint32_t flags;
 } __ABI_PACKED;
 
@@ -99,13 +104,11 @@ struct mrq_request {
  *  remainder of the MRQ response is a payload (immediately following
  *  the mrq_response) whose format depends on the associated
  *  mrq_request::mrq
- *
- * @todo document the flags
  */
 struct mrq_response {
 	/** @brief error code for the MRQ request itself */
 	int32_t err;
-	/** @brief flags for the response */
+	/** @brief reserved for future use */
 	uint32_t flags;
 } __ABI_PACKED;
 
@@ -147,6 +150,8 @@ struct mrq_response {
 #define MRQ_ABI_RATCHET		29
 #define MRQ_EMC_DVFS_LATENCY	31
 #define MRQ_TRACE_ITER		64
+#define MRQ_RINGBUF_CONSOLE	65
+#define MRQ_PG			66
 
 /** @} */
 
@@ -155,7 +160,7 @@ struct mrq_response {
  * @brief Maximum MRQ code to be sent by CPU software to
  * BPMP. Subject to change in future
  */
-#define MAX_CPU_MRQ_ID		64
+#define MAX_CPU_MRQ_ID		66
 
 /**
  * @addtogroup MRQ_Payloads Message Payloads
@@ -175,6 +180,7 @@ struct mrq_response {
  *   @defgroup Vhint CPU Voltage hint
  *   @defgroup MRQ_Deprecated Deprecated MRQ messages
  *   @defgroup EMC
+ *   @defgroup RingbufConsole
  * @}
  */
 
@@ -637,7 +643,7 @@ struct mrq_debugfs_response {
  * * Initiators: Any
  * * Targets: BPMP
  * * Request Payload: @ref mrq_reset_request
- * * Response Payload: N/A
+ * * Response Payload: @ref mrq_reset_response
  */
 
 /**
@@ -647,6 +653,7 @@ enum mrq_reset_commands {
 	CMD_RESET_ASSERT = 1,
 	CMD_RESET_DEASSERT = 2,
 	CMD_RESET_MODULE = 3,
+	CMD_RESET_GET_MAX_ID = 4,
 	CMD_RESET_MAX, /* not part of ABI and subject to change */
 };
 
@@ -665,6 +672,38 @@ struct mrq_reset_request {
 } __ABI_PACKED;
 
 /**
+ * @ingroup Reset
+ * @brief Response for MRQ_RESET sub-command CMD_RESET_GET_MAX_ID. When
+ * this sub-command is not supported, firmware will return -BPMP_EBADCMD
+ * in mrq_response::err.
+ */
+struct cmd_reset_get_max_id_response {
+	/** @brief max reset id */
+	uint32_t max_id;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Reset
+ * @brief Response with MRQ_RESET
+ *
+ * Each sub-command supported by @ref mrq_reset_request may return
+ * sub-command-specific data. Some do and some do not as indicated
+ * in the following table
+ *
+ * | sub-command          | payload          |
+ * |----------------------|------------------|
+ * | CMD_RESET_ASSERT     | -                |
+ * | CMD_RESET_DEASSERT   | -                |
+ * | CMD_RESET_MODULE     | -                |
+ * | CMD_RESET_GET_MAX_ID | reset_get_max_id |
+ */
+struct mrq_reset_response {
+	union {
+		struct cmd_reset_get_max_id_response reset_get_max_id;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
  * @ingroup MRQ_Codes
  * @def MRQ_I2C
  * @brief issue an i2c transaction
@@ -812,6 +851,17 @@ enum {
 };
 /** @} */
 
+/**
+ * @name MRQ_CLK properties
+ * Flag bits for cmd_clk_properties_response::flags and
+ * cmd_clk_get_all_info_response::flags
+ * @{
+ */
+#define BPMP_CLK_HAS_MUX	(1 << 0)
+#define BPMP_CLK_HAS_SET_RATE	(1 << 1)
+#define BPMP_CLK_IS_ROOT	(1 << 2)
+/** @} */
+
 #define MRQ_CLK_NAME_MAXLEN	40
 #define MRQ_CLK_MAX_PARENTS	16
 
@@ -1010,7 +1060,7 @@ struct mrq_clk_response {
  *
  * * Platforms: All
  * * Initiators: Any
- * * Targets: Any
+ * * Targets: Any except DMCE
  * * Request Payload: @ref mrq_query_abi_request
  * * Response Payload: @ref mrq_query_abi_response
  */
@@ -1030,6 +1080,9 @@ struct mrq_query_abi_request {
 /**
  * @ingroup ABI_info
  * @brief response to MRQ_QUERY_ABI
+ *
+ * @note mrq_response::err of 0 indicates that the query was
+ * successful, not that the MRQ itself is supported!
  */
 struct mrq_query_abi_response {
 	/** @brief 0 if queried MRQ is supported. Else, -#BPMP_ENODEV */
@@ -1080,7 +1133,9 @@ struct mrq_pg_read_state_response {
 /**
  * @ingroup MRQ_Codes
  * @def MRQ_PG_UPDATE_STATE
- * @brief modify the power-gating state of a partition
+ * @brief modify the power-gating state of a partition. In contrast to
+ * MRQ_PG calls, the operations that change state (on/off) of power
+ * partition are reference counted.
  *
  * * Platforms: T186
  * * Initiators: Any
@@ -1126,6 +1181,171 @@ struct mrq_pg_update_state_request {
 
 /**
  * @ingroup MRQ_Codes
+ * @def MRQ_PG
+ * @brief Control power-gating state of a partition. In contrast to
+ * MRQ_PG_UPDATE_STATE, operations that change the power partition
+ * state are NOT reference counted
+ *
+ * * Platforms: T186
+ * * Initiators: Any
+ * * Targets: BPMP
+ * * Request Payload: @ref mrq_pg_request
+ * * Response Payload: @ref mrq_pg_response
+ * @addtogroup Powergating
+ * @{
+ */
+
+/**
+ * @name MRQ_PG sub-commands
+ * @{
+ */
+enum mrq_pg_cmd {
+	/**
+	 * @brief Check whether the BPMP driver supports the specified
+	 * request type
+	 *
+	 * mrq_response::err is 0 if the specified request is
+	 * supported and -#BPMP_ENODEV otherwise.
+	 */
+	CMD_PG_QUERY_ABI = 0,
+
+	/**
+	 * @brief Set the current state of specified power domain. The
+	 * possible values for power domains are defined in enum
+	 * pg_states
+	 *
+	 * mrq_response:err is
+	 * 0: Success
+	 * -#BPMP_EINVAL: Invalid request parameters
+	 */
+	CMD_PG_SET_STATE = 1,
+
+	/**
+	 * @brief Get the current state of specified power domain. The
+	 * possible values for power domains are defined in enum
+	 * pg_states
+	 *
+	 * mrq_response:err is
+	 * 0: Success
+	 * -#BPMP_EINVAL: Invalid request parameters
+	 */
+	CMD_PG_GET_STATE = 2,
+
+	/**
+	 * @brief get the name string of specified power domain id.
+	 *
+	 * mrq_response:err is
+	 * 0: Success
+	 * -#BPMP_EINVAL: Invalid request parameters
+	 */
+	CMD_PG_GET_NAME = 3,
+
+
+	/**
+	 * @brief get the highest power domain id in the system. Not
+	 * all IDs between 0 and max_id are valid IDs.
+	 *
+	 * mrq_response:err is
+	 * 0: Success
+	 * -#BPMP_EINVAL: Invalid request parameters
+	 */
+	CMD_PG_GET_MAX_ID = 4,
+};
+/** @} */
+
+#define MRQ_PG_NAME_MAXLEN	40
+
+/**
+ * @brief possible power domain states in
+ * cmd_pg_set_state_request:state and cmd_pg_get_state_response:state.
+ *  PG_STATE_OFF: power domain is OFF
+ *  PG_STATE_ON: power domain is ON
+ *  PG_STATE_RUNNING: power domain is ON and made into directly usable
+ *                    state by turning on the clocks associated with
+ *                    the domain
+ */
+enum pg_states {
+	PG_STATE_OFF = 0,
+	PG_STATE_ON = 1,
+	PG_STATE_RUNNING = 2,
+};
+
+struct cmd_pg_query_abi_request {
+	uint32_t type; /* enum mrq_pg_cmd */
+} __ABI_PACKED;
+
+struct cmd_pg_set_state_request {
+	uint32_t state; /* enum pg_states */
+} __ABI_PACKED;
+
+struct cmd_pg_get_state_response {
+	uint32_t state; /* enum pg_states */
+} __ABI_PACKED;
+
+struct cmd_pg_get_name_response {
+	uint8_t name[MRQ_PG_NAME_MAXLEN];
+} __ABI_PACKED;
+
+struct cmd_pg_get_max_id_response {
+	uint32_t max_id;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Powergating
+ * @brief request with #MRQ_PG
+ *
+ * Used by the sender of an #MRQ_PG message to control power
+ * partitions. The pg_request is split into several sub-commands. Some
+ * sub-commands require no additional data. Others have a sub-command
+ * specific payload
+ *
+ * |sub-command                 |payload                |
+ * |----------------------------|-----------------------|
+ * |CMD_PG_QUERY_ABI            | query_abi             |
+ * |CMD_PG_SET_STATE            | set_state             |
+ * |CMD_PG_GET_STATE            | -                     |
+ * |CMD_PG_GET_NAME             | -                     |
+ * |CMD_PG_GET_MAX_ID           | -                     |
+ *
+ */
+
+struct mrq_pg_request {
+	uint32_t cmd;
+	uint32_t id;
+	union {
+		struct cmd_pg_query_abi_request query_abi;
+		struct cmd_pg_set_state_request set_state;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
+ * @ingroup Powergating
+ * @brief response to MRQ_PG
+ *
+ * Each sub-command supported by @ref mrq_pg_request may return
+ * sub-command-specific data. Some do and some do not as indicated in
+ * the following table
+ *
+ * |sub-command                 |payload                |
+ * |----------------------------|-----------------------|
+ * |CMD_PG_QUERY_ABI            | -                     |
+ * |CMD_PG_SET_STATE            | -                     |
+ * |CMD_PG_GET_STATE            | get_state             |
+ * |CMD_PG_GET_NAME             | get_name              |
+ * |CMD_PG_GET_MAX_ID           | get_max_id            |
+ *
+ */
+
+struct mrq_pg_response {
+	union {
+		struct cmd_pg_get_state_response get_state;
+		struct cmd_pg_get_name_response get_name;
+		struct cmd_pg_get_max_id_response get_max_id;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
+ * @ingroup MRQ_Codes
  * @def MRQ_THERMAL
  * @brief interact with BPMP thermal framework
  *
@@ -1529,6 +1749,184 @@ struct mrq_trace_iter_request {
 
 /** @} */
 
+/**
+ * @ingroup MRQ_Codes
+ * @def MRQ_RINGBUF_CONSOLE
+ * @brief A ring buffer debug console for BPMP
+ * @addtogroup RingbufConsole
+ *
+ * The ring buffer debug console aims to be a substitute for the UART debug
+ * console. The debug console is implemented with two ring buffers in the
+ * BPMP-FW, the RX (receive) and TX (transmit) buffers. Characters can be read
+ * and written to the buffers by the host via the MRQ interface.
+ *
+ * @{
+ */
+
+/**
+ * @brief Maximum number of bytes transferred in a single write command to the
+ * BPMP
+ *
+ * This is determined by the number of free bytes in the message struct,
+ * rounded down to a multiple of four.
+ */
+#define MRQ_RINGBUF_CONSOLE_MAX_WRITE_LEN 112
+
+/**
+ * @brief Maximum number of bytes transferred in a single read command to the
+ * BPMP
+ *
+ * This is determined by the number of free bytes in the message struct,
+ * rounded down to a multiple of four.
+ */
+#define MRQ_RINGBUF_CONSOLE_MAX_READ_LEN 116
+
+enum mrq_ringbuf_console_host_to_bpmp_cmd {
+	/**
+	 * @brief Check whether the BPMP driver supports the specified request
+	 * type
+	 *
+	 * mrq_response::err is 0 if the specified request is supported and
+	 * -#BPMP_ENODEV otherwise
+	 */
+	CMD_RINGBUF_CONSOLE_QUERY_ABI = 0,
+	/**
+	 * @brief Perform a read operation on the BPMP TX buffer
+	 *
+	 * mrq_response::err is 0
+	 */
+	CMD_RINGBUF_CONSOLE_READ = 1,
+	/**
+	 * @brief Perform a write operation on the BPMP RX buffer
+	 *
+	 * mrq_response::err is 0 if the operation was successful and
+	 * -#BPMP_ENODEV otherwise
+	 */
+	CMD_RINGBUF_CONSOLE_WRITE = 2,
+	/**
+	 * @brief Get the length of the buffer and the physical addresses of
+	 * the buffer data and the head and tail counters
+	 *
+	 * mrq_response::err is 0 if the operation was successful and
+	 * -#BPMP_ENODEV otherwise
+	 */
+	CMD_RINGBUF_CONSOLE_GET_FIFO = 3,
+};
+
+/**
+ * @ingroup RingbufConsole
+ * @brief Host->BPMP request data for request type
+ * #CMD_RINGBUF_CONSOLE_QUERY_ABI
+ */
+struct cmd_ringbuf_console_query_abi_req {
+	/** @brief Command identifier to be queried */
+	uint32_t cmd;
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_ringbuf_console_query_abi_resp {
+	EMPTY
+} __ABI_PACKED;
+
+/**
+ * @ingroup RingbufConsole
+ * @brief Host->BPMP request data for request type #CMD_RINGBUF_CONSOLE_READ
+ */
+struct cmd_ringbuf_console_read_req {
+	/**
+	 * @brief Number of bytes requested to be read from the BPMP TX buffer
+	 */
+	uint8_t len;
+} __ABI_PACKED;
+
+/**
+ * @ingroup RingbufConsole
+ * @brief BPMP->Host response data for request type #CMD_RINGBUF_CONSOLE_READ
+ */
+struct cmd_ringbuf_console_read_resp {
+	/** @brief The actual data read from the BPMP TX buffer */
+	uint8_t data[MRQ_RINGBUF_CONSOLE_MAX_READ_LEN];
+	/** @brief Number of bytes in cmd_ringbuf_console_read_resp::data */
+	uint8_t len;
+} __ABI_PACKED;
+
+/**
+ * @ingroup RingbufConsole
+ * @brief Host->BPMP request data for request type #CMD_RINGBUF_CONSOLE_WRITE
+ */
+struct cmd_ringbuf_console_write_req {
+	/** @brief The actual data to be written to the BPMP RX buffer */
+	uint8_t data[MRQ_RINGBUF_CONSOLE_MAX_WRITE_LEN];
+	/** @brief Number of bytes in cmd_ringbuf_console_write_req::data */
+	uint8_t len;
+} __ABI_PACKED;
+
+/**
+ * @ingroup RingbufConsole
+ * @brief BPMP->Host response data for request type #CMD_RINGBUF_CONSOLE_WRITE
+ */
+struct cmd_ringbuf_console_write_resp {
+	/** @brief Number of bytes of available space in the BPMP RX buffer */
+	uint32_t space_avail;
+	/** @brief Number of bytes that were written to the BPMP RX buffer */
+	uint8_t len;
+} __ABI_PACKED;
+
+/** @private */
+struct cmd_ringbuf_console_get_fifo_req {
+	EMPTY
+} __ABI_PACKED;
+
+/**
+ * @ingroup RingbufConsole
+ * @brief BPMP->Host reply data for request type #CMD_RINGBUF_CONSOLE_GET_FIFO
+ */
+struct cmd_ringbuf_console_get_fifo_resp {
+	/** @brief Physical address of the BPMP TX buffer */
+	uint64_t bpmp_tx_buf_addr;
+	/** @brief Physical address of the BPMP TX buffer head counter */
+	uint64_t bpmp_tx_head_addr;
+	/** @brief Physical address of the BPMP TX buffer tail counter */
+	uint64_t bpmp_tx_tail_addr;
+	/** @brief Length of the BPMP TX buffer */
+	uint32_t bpmp_tx_buf_len;
+} __ABI_PACKED;
+
+/**
+ * @ingroup RingbufConsole
+ * @brief Host->BPMP request data.
+ *
+ * Reply type is union #mrq_ringbuf_console_bpmp_to_host_response .
+ */
+struct mrq_ringbuf_console_host_to_bpmp_request {
+	/**
+	 * @brief type of request. Values listed in enum
+	 * #mrq_ringbuf_console_host_to_bpmp_cmd.
+	 */
+	uint32_t type;
+	/** @brief  request type specific parameters. */
+	union {
+		struct cmd_ringbuf_console_query_abi_req query_abi;
+		struct cmd_ringbuf_console_read_req read;
+		struct cmd_ringbuf_console_write_req write;
+		struct cmd_ringbuf_console_get_fifo_req get_fifo;
+	} __UNION_ANON;
+} __ABI_PACKED;
+
+/**
+ * @ingroup RingbufConsole
+ * @brief Host->BPMP reply data
+ *
+ * In response to struct #mrq_ringbuf_console_host_to_bpmp_request.
+ */
+union mrq_ringbuf_console_bpmp_to_host_response {
+	struct cmd_ringbuf_console_query_abi_resp query_abi;
+	struct cmd_ringbuf_console_read_resp read;
+	struct cmd_ringbuf_console_write_resp write;
+	struct cmd_ringbuf_console_get_fifo_resp get_fifo;
+} __ABI_PACKED;
+/** @} */
+
 /*
  *  4. Enumerations
  */
-- 
2.12.0
