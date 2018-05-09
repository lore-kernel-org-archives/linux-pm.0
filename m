From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 2/8] firmware: arm_scmi: fix kernel-docs documentation
Date: Wed,  9 May 2018 18:07:08 +0100
Message-ID: <1525885634-22348-3-git-send-email-sudeep.holla@arm.com>
References: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1525885634-22348-1-git-send-email-sudeep.holla@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-pm@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

There are few missing descriptions for function parameters and structure
members along with certain instances where excessive function parameters
or structure members are described.

This patch fixes all of those warnings.

Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scmi/base.c   | 20 +++++++++--------
 drivers/firmware/arm_scmi/common.h |  7 ++++--
 drivers/firmware/arm_scmi/driver.c | 45 ++++++++++++++++++++------------------
 include/linux/scmi_protocol.h      |  8 +++++++
 4 files changed, 48 insertions(+), 32 deletions(-)

diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index 0d3806c0d432..c36ded9dbb83 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -26,7 +26,7 @@ struct scmi_msg_resp_base_attributes {
  * scmi_base_attributes_get() - gets the implementation details
  *	that are associated with the base protocol.
  *
- * @handle - SCMI entity handle
+ * @handle: SCMI entity handle
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
@@ -50,14 +50,15 @@ static int scmi_base_attributes_get(const struct scmi_handle *handle)
 	}
 
 	scmi_one_xfer_put(handle, t);
+
 	return ret;
 }
 
 /**
  * scmi_base_vendor_id_get() - gets vendor/subvendor identifier ASCII string.
  *
- * @handle - SCMI entity handle
- * @sub_vendor - specify true if sub-vendor ID is needed
+ * @handle: SCMI entity handle
+ * @sub_vendor: specify true if sub-vendor ID is needed
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
@@ -97,7 +98,7 @@ scmi_base_vendor_id_get(const struct scmi_handle *handle, bool sub_vendor)
  *	implementation 32-bit version. The format of the version number is
  *	vendor-specific
  *
- * @handle - SCMI entity handle
+ * @handle: SCMI entity handle
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
@@ -128,8 +129,8 @@ scmi_base_implementation_version_get(const struct scmi_handle *handle)
  * scmi_base_implementation_list_get() - gets the list of protocols it is
  *	OSPM is allowed to access
  *
- * @handle - SCMI entity handle
- * @protocols_imp - pointer to hold the list of protocol identifiers
+ * @handle: SCMI entity handle
+ * @protocols_imp: pointer to hold the list of protocol identifiers
  *
  * Return: 0 on success, else appropriate SCMI error.
  */
@@ -173,15 +174,16 @@ static int scmi_base_implementation_list_get(const struct scmi_handle *handle,
 	} while (loop_num_ret);
 
 	scmi_one_xfer_put(handle, t);
+
 	return ret;
 }
 
 /**
  * scmi_base_discover_agent_get() - discover the name of an agent
  *
- * @handle - SCMI entity handle
- * @id - Agent identifier
- * @name - Agent identifier ASCII string
+ * @handle: SCMI entity handle
+ * @id: Agent identifier
+ * @name: Agent identifier ASCII string
  *
  * An agent id of 0 is reserved to identify the platform itself.
  * Generally operating system is represented as "OSPM"
diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
index e8f332c9c469..0821662a4633 100644
--- a/drivers/firmware/arm_scmi/common.h
+++ b/drivers/firmware/arm_scmi/common.h
@@ -51,8 +51,11 @@ struct scmi_msg_resp_prot_version {
  * @id: The identifier of the command being sent
  * @protocol_id: The identifier of the protocol used to send @id command
  * @seq: The token to identify the message. when a message/command returns,
- *       the platform returns the whole message header unmodified including
- *	 the token.
+ *	the platform returns the whole message header unmodified including
+ *	the token
+ * @status: Status of the transfer once it's complete
+ * @poll_completion: Indicate if the transfer needs to be polled for
+ *	completion or interrupt mode is used
  */
 struct scmi_msg_hdr {
 	u8 id;
diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
index 917786d91f55..6fee11f06a66 100644
--- a/drivers/firmware/arm_scmi/driver.c
+++ b/drivers/firmware/arm_scmi/driver.c
@@ -51,7 +51,7 @@ enum scmi_error_codes {
 	SCMI_ERR_MAX
 };
 
-/* List of all  SCMI devices active in system */
+/* List of all SCMI devices active in system */
 static LIST_HEAD(scmi_list);
 /* Protection for the entire list */
 static DEFINE_MUTEX(scmi_list_mutex);
@@ -68,7 +68,6 @@ static DEFINE_MUTEX(scmi_list_mutex);
 struct scmi_xfers_info {
 	struct scmi_xfer *xfer_block;
 	unsigned long *xfer_alloc_table;
-	/* protect transfer allocation */
 	spinlock_t xfer_lock;
 };
 
@@ -94,6 +93,7 @@ struct scmi_desc {
  * @payload: Transmit/Receive mailbox channel payload area
  * @dev: Reference to device in the SCMI hierarchy corresponding to this
  *	 channel
+ * @handle: Pointer to SCMI entity handle
  */
 struct scmi_chan_info {
 	struct mbox_client cl;
@@ -104,7 +104,7 @@ struct scmi_chan_info {
 };
 
 /**
- * struct scmi_info - Structure representing a  SCMI instance
+ * struct scmi_info - Structure representing a SCMI instance
  *
  * @dev: Device pointer
  * @desc: SoC description for this instance
@@ -113,9 +113,9 @@ struct scmi_chan_info {
  *	implementation version and (sub-)vendor identification.
  * @minfo: Message info
  * @tx_idr: IDR object to map protocol id to channel info pointer
- * @protocols_imp: list of protocols implemented, currently maximum of
+ * @protocols_imp: List of protocols implemented, currently maximum of
  *	MAX_PROTOCOLS_IMP elements allocated by the base protocol
- * @node: list head
+ * @node: List head
  * @users: Number of users of this instance
  */
 struct scmi_info {
@@ -221,9 +221,7 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
 
 	xfer_id = MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
 
-	/*
-	 * Are we even expecting this?
-	 */
+	/* Are we even expecting this? */
 	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
 		dev_err(dev, "message for %d is not expected!\n", xfer_id);
 		return;
@@ -248,6 +246,8 @@ static void scmi_rx_callback(struct mbox_client *cl, void *m)
  *
  * @hdr: pointer to header containing all the information on message id,
  *	protocol id and sequence id.
+ *
+ * Return: 32-bit packed command header to be sent to the platform.
  */
 static inline u32 pack_scmi_header(struct scmi_msg_hdr *hdr)
 {
@@ -282,9 +282,9 @@ static void scmi_tx_prepare(struct mbox_client *cl, void *m)
 }
 
 /**
- * scmi_one_xfer_get() - Allocate one message
+ * scmi_xfer_get() - Allocate one message
  *
- * @handle: SCMI entity handle
+ * @handle: Pointer to SCMI entity handle
  *
  * Helper function which is used by various command functions that are
  * exposed to clients of this driver for allocating a message traffic event.
@@ -326,8 +326,8 @@ static struct scmi_xfer *scmi_one_xfer_get(const struct scmi_handle *handle)
 /**
  * scmi_one_xfer_put() - Release a message
  *
- * @minfo: transfer info pointer
- * @xfer: message that was reserved by scmi_one_xfer_get
+ * @handle: Pointer to SCMI entity handle
+ * @xfer: message that was reserved by scmi_xfer_get
  *
  * This holds a spinlock to maintain integrity of internal data structures.
  */
@@ -374,12 +374,12 @@ static bool scmi_xfer_done_no_timeout(const struct scmi_chan_info *cinfo,
 /**
  * scmi_do_xfer() - Do one transfer
  *
- * @info: Pointer to SCMI entity information
+ * @handle: Pointer to SCMI entity handle
  * @xfer: Transfer to initiate and wait for response
  *
  * Return: -ETIMEDOUT in case of no response, if transmit error,
- *   return corresponding error, else if all goes well,
- *   return 0.
+ *	return corresponding error, else if all goes well,
+ *	return 0.
  */
 int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 {
@@ -438,9 +438,9 @@ int scmi_do_xfer(const struct scmi_handle *handle, struct scmi_xfer *xfer)
 /**
  * scmi_one_xfer_init() - Allocate and initialise one message
  *
- * @handle: SCMI entity handle
+ * @handle: Pointer to SCMI entity handle
  * @msg_id: Message identifier
- * @msg_prot_id: Protocol identifier for the message
+ * @prot_id: Protocol identifier for the message
  * @tx_size: transmit message size
  * @rx_size: receive message size
  * @p: pointer to the allocated and initialised message
@@ -478,13 +478,16 @@ int scmi_one_xfer_init(const struct scmi_handle *handle, u8 msg_id, u8 prot_id,
 	xfer->hdr.poll_completion = false;
 
 	*p = xfer;
+
 	return 0;
 }
 
 /**
  * scmi_version_get() - command to get the revision of the SCMI entity
  *
- * @handle: Handle to SCMI entity information
+ * @handle: Pointer to SCMI entity handle
+ * @protocol: Protocol identifier for the message
+ * @version: Holds returned version of protocol.
  *
  * Updates the SCMI information in the internal data structure.
  *
@@ -541,7 +544,7 @@ scmi_is_protocol_implemented(const struct scmi_handle *handle, u8 prot_id)
  * @dev: pointer to device for which we want SCMI handle
  *
  * NOTE: The function does not track individual clients of the framework
- * and is expected to be maintained by caller of  SCMI protocol library.
+ * and is expected to be maintained by caller of SCMI protocol library.
  * scmi_handle_put must be balanced with successful scmi_handle_get
  *
  * Return: pointer to handle if successful, NULL on error
@@ -572,7 +575,7 @@ struct scmi_handle *scmi_handle_get(struct device *dev)
  * @handle: handle acquired by scmi_handle_get
  *
  * NOTE: The function does not track individual clients of the framework
- * and is expected to be maintained by caller of  SCMI protocol library.
+ * and is expected to be maintained by caller of SCMI protocol library.
  * scmi_handle_put must be balanced with successful scmi_handle_get
  *
  * Return: 0 is successfully released
@@ -595,7 +598,7 @@ int scmi_handle_put(const struct scmi_handle *handle)
 }
 
 static const struct scmi_desc scmi_generic_desc = {
-	.max_rx_timeout_ms = 30,	/* we may increase this if required */
+	.max_rx_timeout_ms = 30,	/* We may increase this if required */
 	.max_msg = 20,		/* Limited by MBOX_TX_QUEUE_LEN */
 	.max_msg_size = 128,
 };
diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index b458c87b866c..a171c1e293e8 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -189,6 +189,14 @@ struct scmi_sensor_ops {
  * @perf_ops: pointer to set of performance protocol operations
  * @clk_ops: pointer to set of clock protocol operations
  * @sensor_ops: pointer to set of sensor protocol operations
+ * @perf_priv: pointer to private data structure specific to performance
+ *	protocol(for internal use only)
+ * @clk_priv: pointer to private data structure specific to clock
+ *	protocol(for internal use only)
+ * @power_priv: pointer to private data structure specific to power
+ *	protocol(for internal use only)
+ * @sensor_priv: pointer to private data structure specific to sensors
+ *	protocol(for internal use only)
  */
 struct scmi_handle {
 	struct device *dev;
-- 
2.7.4
