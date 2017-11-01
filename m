From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RFC PATCH 4/7] typec: tcpm: Add core support for sink side PPS
Date: Wed, 1 Nov 2017 17:03:12 +0000
Message-ID: <661704c39148f63a0dda50d9b680425f4cb186f0.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1509554370.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com
List-Id: linux-pm@vger.kernel.org

This commit adds code to handle requesting of PPS APDOs. Switching
between standard PDOs and APDOs, and re-requesting an APDO to
modify operating voltage/current will be triggered by an
external call into TCPM.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/tcpm.c | 441 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/usb/tcpm.h |   2 +-
 2 files changed, 429 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index 8483d3e..c4045cc 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -56,6 +56,7 @@
 	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
 	S(SNK_WAIT_CAPABILITIES),		\
 	S(SNK_NEGOTIATE_CAPABILITIES),		\
+	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
 	S(SNK_TRANSITION_SINK),			\
 	S(SNK_TRANSITION_SINK_VBUS),		\
 	S(SNK_READY),				\
@@ -175,6 +176,16 @@ struct pd_mode_data {
 	struct typec_altmode_desc altmode_desc[SVID_DISCOVERY_MAX];
 };
 
+struct pd_pps_data {
+	u16 min_volt;
+	u16 max_volt;
+	u16 max_curr;
+	u16 out_volt;
+	u16 op_curr;
+	bool supported;
+	bool active;
+};
+
 struct tcpm_port {
 	struct device *dev;
 
@@ -268,6 +279,7 @@ struct tcpm_port {
 	unsigned int max_snk_ma;
 	unsigned int max_snk_mw;
 	unsigned int operating_snk_mw;
+	bool update_sink_caps;
 
 	/* Requested current / voltage */
 	u32 current_limit;
@@ -284,8 +296,13 @@ struct tcpm_port {
 	/* VDO to retry if UFP responder replied busy */
 	u32 vdo_retry;
 
-	/* Alternate mode data */
+	/* PPS */
+	struct pd_pps_data pps_data;
+	struct completion pps_complete;
+	bool pps_pending;
+	int pps_status;
 
+	/* Alternate mode data */
 	struct pd_mode_data mode_data;
 	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX];
 	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX];
@@ -503,6 +520,13 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
 				  pdo_max_voltage(pdo),
 				  pdo_max_power(pdo));
 			break;
+		case PDO_TYPE_APDO:
+			scnprintf(msg, sizeof(msg),
+				  "%u-%u mV, %u mA",
+				  pdo_apdo_min_voltage(pdo),
+				  pdo_apdo_max_voltage(pdo),
+				  pdo_apdo_max_current(pdo));
+			break;
 		default:
 			strcpy(msg, "undefined");
 			break;
@@ -1259,6 +1283,10 @@ static void vdm_state_machine_work(struct work_struct *work)
 /*
  * PD (data, control) command handling functions
  */
+
+static int tcpm_pd_send_control(struct tcpm_port *port,
+				enum pd_ctrl_msg_type type);
+
 static void tcpm_pd_data_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1323,6 +1351,15 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	}
 }
 
+static void tcpm_pps_complete(struct tcpm_port *port, int result)
+{
+	if (port->pps_pending) {
+		port->pps_status = result;
+		port->pps_pending = false;
+		complete(&port->pps_complete);
+	}
+}
+
 static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 				 const struct pd_message *msg)
 {
@@ -1399,6 +1436,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 				next_state = SNK_WAIT_CAPABILITIES;
 			tcpm_set_state(port, next_state, 0);
 			break;
+		case SNK_NEGOTIATE_PPS_CAPABILITIES:
+			port->pps_status = (type == PD_CTRL_WAIT ?
+					    -EAGAIN : -EOPNOTSUPP);
+			tcpm_set_state(port, SNK_READY, 0);
+			break;
 		case DR_SWAP_SEND:
 			port->swap_status = (type == PD_CTRL_WAIT ?
 					     -EAGAIN : -EOPNOTSUPP);
@@ -1421,6 +1463,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 	case PD_CTRL_ACCEPT:
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
+			port->pps_data.active = false;
+			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
+			break;
+		case SNK_NEGOTIATE_PPS_CAPABILITIES:
+			port->pps_data.active = true;
+			port->pps_data.out_volt = port->supply_voltage;
+			port->pps_data.op_curr = port->current_limit;
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SOFT_RESET_SEND:
@@ -1684,6 +1733,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 	unsigned int i, max_mw = 0, max_mv = 0;
 	int ret = -EINVAL;
 
+	port->pps_data.supported = false;
+
 	/*
 	 * Select the source PDO providing the most power while staying within
 	 * the board's voltage limits. Prefer PDO providing exp
@@ -1693,17 +1744,38 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 		enum pd_pdo_type type = pdo_type(pdo);
 		unsigned int mv, ma, mw;
 
-		if (type == PDO_TYPE_FIXED)
+		switch (type) {
+		case PDO_TYPE_FIXED:
 			mv = pdo_fixed_voltage(pdo);
-		else
+			break;
+		case PDO_TYPE_BATT:
+		case PDO_TYPE_VAR:
 			mv = pdo_min_voltage(pdo);
+			break;
+		case PDO_TYPE_APDO:
+			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS)
+				port->pps_data.supported = true;
+			continue;
+		default:
+			tcpm_log(port, "Invalid PDO type, ignoring");
+			continue;
+		}
 
-		if (type == PDO_TYPE_BATT) {
-			mw = pdo_max_power(pdo);
-		} else {
+		switch (type) {
+		case PDO_TYPE_FIXED:
+		case PDO_TYPE_VAR:
 			ma = min(pdo_max_current(pdo),
 				 port->max_snk_ma);
 			mw = ma * mv / 1000;
+			break;
+		case PDO_TYPE_BATT:
+			mw = pdo_max_power(pdo);
+			break;
+		case PDO_TYPE_APDO:
+			continue;
+		default:
+			tcpm_log(port, "Invalid PDO type, ignoring");
+			continue;
 		}
 
 		/* Perfer higher voltages if available */
@@ -1718,6 +1790,64 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 	return ret;
 }
 
+static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
+{
+	unsigned int i, max_mw = 0, max_mv = 0;
+	unsigned int pps_min_mv, pps_max_mv, ma, mw;
+	enum pd_pdo_type type;
+	u32 pdo;
+	unsigned int index = 0;
+
+	/*
+	 * Select the source PPS APDO providing the most power while staying
+	 * within the board's limits. We skip the first PDO as this is always
+	 * 5V 3A.
+	 */
+	for (i = 1; i < port->nr_source_caps; ++i) {
+		pdo = port->source_caps[i];
+		type = pdo_type(pdo);
+
+		switch (type) {
+		case PDO_TYPE_APDO:
+			if (pdo_apdo_type(pdo) != APDO_TYPE_PPS) {
+				tcpm_log(port, "Not PPS APDO, ignoring");
+				continue;
+			}
+
+			pps_min_mv = pdo_apdo_min_voltage(pdo);
+			pps_max_mv = pdo_apdo_max_voltage(pdo);
+			ma = min(pdo_apdo_max_current(pdo), port->max_snk_ma);
+			mw = (ma * pps_max_mv) / 1000;
+			break;
+		default:
+			tcpm_log(port, "Not APDO type, ignoring");
+			continue;
+		}
+
+		/* Perfer higher voltages if available */
+		if ((mw > max_mw || (mw == max_mw && pps_max_mv > max_mv)) &&
+		    pps_max_mv <= port->max_snk_mv) {
+			index = i;
+			max_mw = mw;
+			max_mv = pps_max_mv;
+		}
+	}
+
+	if (index) {
+		pdo = port->source_caps[index];
+
+		port->pps_data.min_volt = pdo_apdo_min_voltage(pdo);
+		port->pps_data.max_volt = pdo_apdo_max_voltage(pdo);
+		port->pps_data.max_curr = pdo_apdo_max_current(pdo);
+		port->pps_data.out_volt =
+			min(port->supply_voltage, pdo_apdo_max_voltage(pdo));
+		port->pps_data.op_curr =
+			min(port->current_limit, pdo_apdo_max_current(pdo));
+	}
+
+	return index;
+}
+
 static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
 {
 	unsigned int mv, ma, mw, flags;
@@ -1729,13 +1859,22 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
 	index = tcpm_pd_select_pdo(port);
 	if (index < 0)
 		return -EINVAL;
+
 	pdo = port->source_caps[index];
 	type = pdo_type(pdo);
 
-	if (type == PDO_TYPE_FIXED)
+	switch (type) {
+	case PDO_TYPE_FIXED:
 		mv = pdo_fixed_voltage(pdo);
-	else
+		break;
+	case PDO_TYPE_BATT:
+	case PDO_TYPE_VAR:
 		mv = pdo_min_voltage(pdo);
+		break;
+	default:
+		tcpm_log(port, "Invalid PDO selected!");
+		return -EINVAL;
+	}
 
 	/* Select maximum available current within the board's power limit */
 	if (type == PDO_TYPE_BATT) {
@@ -1804,6 +1943,90 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
 }
 
+static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
+{
+	unsigned int min_mv, max_mv, max_ma, max_mw, ma, mw, flags;
+	unsigned int out_mv, op_ma;
+	enum pd_pdo_type type;
+	unsigned int index;
+	u32 pdo;
+
+	index = tcpm_pd_select_pps_apdo(port);
+	if (!index)
+		return -EOPNOTSUPP;
+
+	pdo = port->source_caps[index];
+	type = pdo_type(pdo);
+
+	switch (type) {
+	case PDO_TYPE_APDO:
+		min_mv = pdo_apdo_min_voltage(pdo);
+		max_mv = pdo_apdo_max_voltage(pdo);
+		max_ma = pdo_apdo_max_current(pdo);
+		out_mv = min(port->supply_voltage, max_mv);
+		op_ma = min(port->current_limit, max_ma);
+		break;
+	default:
+		tcpm_log(port, "Invalid PDO selected!");
+		return -EINVAL;
+	}
+
+	if ((out_mv < min_mv) || (out_mv > max_mv) || (op_ma > max_ma))
+		return -EINVAL;
+
+	/* Select maximum available current within the board's power limit */
+	ma = min(op_ma, (1000 * port->max_snk_mw) / out_mv);
+	ma = min(ma, port->max_snk_ma);
+
+	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
+
+	/* Set mismatch bit if offered power is less than operating power */
+	mw = (ma * out_mv) / 1000;
+	max_ma = ma;
+	max_mw = mw;
+	if (mw < port->operating_snk_mw) {
+		flags |= RDO_CAP_MISMATCH;
+		max_mw = port->operating_snk_mw;
+		max_ma = (max_mw * 1000) / out_mv;
+	}
+
+	tcpm_log(port, "cc=%d cc1=%d cc2=%d vbus=%d vconn=%s polarity=%d",
+		 port->cc_req, port->cc1, port->cc2, port->vbus_source,
+		 port->vconn_role == TYPEC_SOURCE ? "source" : "sink",
+		 port->polarity);
+
+	*rdo = RDO_PROG(index + 1, out_mv, max_ma, flags);
+
+	tcpm_log(port, "Requesting APDO %d: %u mV, %u mA%s",
+		 index, out_mv, max_ma,
+		 flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
+
+	port->current_limit = max_ma;
+	port->supply_voltage = out_mv;
+
+	return 0;
+}
+
+static int tcpm_pd_send_pps_request(struct tcpm_port *port)
+{
+	struct pd_message msg;
+	int ret;
+	u32 rdo;
+
+	ret = tcpm_pd_build_pps_request(port, &rdo);
+	if (ret < 0)
+		return ret;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
+				  port->pwr_role,
+				  port->data_role,
+				  port->message_id, 1);
+	msg.payload[0] = cpu_to_le32(rdo);
+
+	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+}
+
 static int tcpm_set_vbus(struct tcpm_port *port, bool enable)
 {
 	int ret;
@@ -1983,6 +2206,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_typec_disconnect(port);
 	port->attached = false;
 	port->pd_capable = false;
+	port->pps_data.supported = false;
 
 	/*
 	 * First Rx ID should be 0; set this to a sentinel of -1 so that
@@ -1998,6 +2222,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
+	port->supply_voltage = 0;
+	port->current_limit = 0;
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2304,6 +2530,7 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
+
 		tcpm_check_send_discover(port);
 		/*
 		 * 6.3.5
@@ -2327,6 +2554,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_UNATTACHED:
 		if (!port->non_pd_role_swap)
 			tcpm_swap_complete(port, -ENOTCONN);
+		tcpm_pps_complete(port, -ENOTCONN);
 		tcpm_snk_detach(port);
 		if (tcpm_start_drp_toggling(port)) {
 			tcpm_set_state(port, DRP_TOGGLING, 0);
@@ -2335,6 +2563,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_cc(port, TYPEC_CC_RD);
 		if (port->port_type == TYPEC_PORT_DRP)
 			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
+
 		break;
 	case SNK_ATTACH_WAIT:
 		if ((port->cc1 == TYPEC_CC_OPEN &&
@@ -2486,6 +2715,24 @@ static void run_state_machine(struct tcpm_port *port)
 					    PD_T_SENDER_RESPONSE);
 		}
 		break;
+	case SNK_NEGOTIATE_PPS_CAPABILITIES:
+		ret = tcpm_pd_send_pps_request(port);
+		if (ret < 0) {
+			port->pps_status = ret;
+			/*
+			 * If this was called due to updates to sink
+			 * capabilities, and pps is no longer valid, we should
+			 * safely fall back to a standard PDO.
+			 */
+			if (port->update_sink_caps)
+				tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+			else
+				tcpm_set_state(port, SNK_READY, 0);
+		} else {
+			tcpm_set_state_cond(port, hard_reset_state(port),
+					    PD_T_SENDER_RESPONSE);
+		}
+		break;
 	case SNK_TRANSITION_SINK:
 	case SNK_TRANSITION_SINK_VBUS:
 		tcpm_set_state(port, hard_reset_state(port),
@@ -2493,6 +2740,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_READY:
 		port->try_snk_count = 0;
+		port->update_sink_caps = false;
 		if (port->explicit_contract) {
 			typec_set_pwr_opmode(port->typec_port,
 					     TYPEC_PWR_MODE_PD);
@@ -2501,7 +2749,11 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
+
 		tcpm_check_send_discover(port);
+
+		tcpm_pps_complete(port, port->pps_status);
+
 		break;
 
 	/* Accessory states */
@@ -2548,6 +2800,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
+		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		tcpm_set_charge(port, false);
 		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
@@ -2768,6 +3021,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case ERROR_RECOVERY:
 		tcpm_swap_complete(port, -EPROTO);
+		tcpm_pps_complete(port, -EPROTO);
 		tcpm_set_state(port, PORT_RESET, 0);
 		break;
 	case PORT_RESET:
@@ -3233,7 +3487,7 @@ static int tcpm_dr_set(const struct typec_capability *cap,
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
-				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
 		ret = port->swap_status;
@@ -3278,7 +3532,7 @@ static int tcpm_pr_set(const struct typec_capability *cap,
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
-				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
 		ret = port->swap_status;
@@ -3318,7 +3572,7 @@ static int tcpm_vconn_set(const struct typec_capability *cap,
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
-				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
 		ret = port->swap_status;
@@ -3350,6 +3604,161 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
 	return ret;
 }
 
+static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
+{
+	unsigned int target_mw;
+	int ret = 0;
+
+	mutex_lock(&port->swap_lock);
+	mutex_lock(&port->lock);
+
+	if (!port->pps_data.active) {
+		ret = -EOPNOTSUPP;
+		goto port_unlock;
+	}
+
+	if (port->state != SNK_READY) {
+		ret = -EAGAIN;
+		goto port_unlock;
+	}
+
+	if (op_curr > port->pps_data.max_curr) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	target_mw = (op_curr * port->pps_data.out_volt) / 1000;
+	if ((target_mw < port->operating_snk_mw) ||
+	    (target_mw > port->max_snk_mw)) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	reinit_completion(&port->pps_complete);
+	port->current_limit = op_curr;
+	port->pps_status = 0;
+	port->pps_pending = true;
+	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+	mutex_unlock(&port->lock);
+
+	if (!wait_for_completion_timeout(&port->pps_complete,
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
+		ret = -ETIMEDOUT;
+	else
+		ret = port->pps_status;
+
+	goto swap_unlock;
+
+port_unlock:
+	mutex_unlock(&port->lock);
+swap_unlock:
+	mutex_unlock(&port->swap_lock);
+
+	return ret;
+}
+
+static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
+{
+	unsigned int target_mw;
+	int ret = 0;
+
+	mutex_lock(&port->swap_lock);
+	mutex_lock(&port->lock);
+
+	if (!port->pps_data.active) {
+		ret = -EOPNOTSUPP;
+		goto port_unlock;
+	}
+
+	if (port->state != SNK_READY) {
+		ret = -EAGAIN;
+		goto port_unlock;
+	}
+
+	if ((out_volt < port->pps_data.min_volt) ||
+	    (out_volt > port->pps_data.max_volt)) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	target_mw = (port->pps_data.op_curr * out_volt) / 1000;
+	if ((target_mw < port->operating_snk_mw) ||
+	    (target_mw > port->max_snk_mw)) {
+		ret = -EINVAL;
+		goto port_unlock;
+	}
+
+	reinit_completion(&port->pps_complete);
+	port->supply_voltage = out_volt;
+	port->pps_status = 0;
+	port->pps_pending = true;
+	tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+	mutex_unlock(&port->lock);
+
+	if (!wait_for_completion_timeout(&port->pps_complete,
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
+		ret = -ETIMEDOUT;
+	else
+		ret = port->pps_status;
+
+	goto swap_unlock;
+
+port_unlock:
+	mutex_unlock(&port->lock);
+swap_unlock:
+	mutex_unlock(&port->swap_lock);
+
+	return ret;
+}
+
+static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
+{
+	int ret = 0;
+
+	mutex_lock(&port->swap_lock);
+	mutex_lock(&port->lock);
+
+	if (!port->pps_data.supported) {
+		ret = -EOPNOTSUPP;
+		goto port_unlock;
+	}
+
+	/* Trying to deactivate PPS when already deactivated so just bail */
+	if ((!port->pps_data.active) && (!activate))
+		goto port_unlock;
+
+	if (port->state != SNK_READY) {
+		ret = -EAGAIN;
+		goto port_unlock;
+	}
+
+	reinit_completion(&port->pps_complete);
+	port->pps_status = 0;
+	port->pps_pending = true;
+
+	/* Trigger PPS request or move back to standard PDO contract */
+	if (activate)
+		tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+	else
+		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+	mutex_unlock(&port->lock);
+
+	if (!wait_for_completion_timeout(&port->pps_complete,
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
+		ret = -ETIMEDOUT;
+	else
+		ret = port->pps_status;
+
+	goto swap_unlock;
+
+port_unlock:
+	mutex_unlock(&port->lock);
+swap_unlock:
+	mutex_unlock(&port->swap_lock);
+
+	return ret;
+}
+
 static void tcpm_init(struct tcpm_port *port)
 {
 	enum typec_cc_status cc1, cc2;
@@ -3482,13 +3891,18 @@ void tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
 	port->max_snk_ma = max_snk_ma;
 	port->max_snk_mw = max_snk_mw;
 	port->operating_snk_mw = operating_snk_mw;
+	port->update_sink_caps = true;
 
 	switch (port->state) {
 	case SNK_NEGOTIATE_CAPABILITIES:
+	case SNK_NEGOTIATE_PPS_CAPABILITIES:
 	case SNK_READY:
 	case SNK_TRANSITION_SINK:
 	case SNK_TRANSITION_SINK_VBUS:
-		tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
+		if (port->pps_data.active)
+			tcpm_set_state(port, SNK_NEGOTIATE_PPS_CAPABILITIES, 0);
+		else
+			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
 		break;
 	default:
 		break;
@@ -3529,6 +3943,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	init_completion(&port->tx_complete);
 	init_completion(&port->swap_complete);
+	init_completion(&port->pps_complete);
 
 	port->nr_src_pdo = tcpm_copy_pdos(port->src_pdo, tcpc->config->src_pdo,
 					  tcpc->config->nr_src_pdo);
@@ -3549,7 +3964,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 	port->typec_caps.prefer_role = tcpc->config->default_role;
 	port->typec_caps.type = tcpc->config->type;
 	port->typec_caps.revision = 0x0120;	/* Type-C spec release 1.2 */
-	port->typec_caps.pd_revision = 0x0200;	/* USB-PD spec release 2.0 */
+	port->typec_caps.pd_revision = 0x0300;	/* USB-PD spec release 3.0 */
 	port->typec_caps.dr_set = tcpm_dr_set;
 	port->typec_caps.pr_set = tcpm_pr_set;
 	port->typec_caps.vconn_set = tcpm_vconn_set;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index 073197f..dde3c2a 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -35,7 +35,7 @@ enum typec_cc_polarity {
 
 /* Time to wait for TCPC to complete transmit */
 #define PD_T_TCPC_TX_TIMEOUT	100		/* in ms	*/
-#define PD_ROLE_SWAP_TIMEOUT	(MSEC_PER_SEC * 10)
+#define PD_STATE_MACHINE_TIMEOUT	(MSEC_PER_SEC * 10)
 
 enum tcpm_transmit_status {
 	TCPC_TX_SUCCESS = 0,
-- 
1.9.1
