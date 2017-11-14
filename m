From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [RFC PATCH v2 4/7] typec: tcpm: Add core support for sink side PPS
Date: Tue, 14 Nov 2017 11:44:45 +0000
Message-ID: <cbb79a0c3fa0bdda829a5d9994f686713d5322fc.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail1.bemta6.messagelabs.com ([193.109.254.113]:9865 "EHLO
        mail1.bemta6.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755178AbdKNLot (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Nov 2017 06:44:49 -0500
In-Reply-To: <cover.1510657748.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sebastian Reichel <sre@kernel.org>, Hans de Goede <hdegoede@redhat.com>, Yueyao Zhu <yueyao.zhu@gmail.com>, Rui Miguel Silva <rmfrfs@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, support.opensource@diasemi.com

This commit adds code to handle requesting of PPS APDOs. Switching
between standard PDOs and APDOs, and re-requesting an APDO to
modify operating voltage/current will be triggered by an
external call into TCPM.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 drivers/usb/typec/tcpm.c | 476 +++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/usb/tcpm.h |   2 +-
 2 files changed, 464 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
index c166fc7..78983e1 100644
--- a/drivers/usb/typec/tcpm.c
+++ b/drivers/usb/typec/tcpm.c
@@ -47,6 +47,7 @@
 	S(SNK_DISCOVERY_DEBOUNCE_DONE),		\
 	S(SNK_WAIT_CAPABILITIES),		\
 	S(SNK_NEGOTIATE_CAPABILITIES),		\
+	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
 	S(SNK_TRANSITION_SINK),			\
 	S(SNK_TRANSITION_SINK_VBUS),		\
 	S(SNK_READY),				\
@@ -166,6 +167,16 @@ struct pd_mode_data {
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
 
@@ -233,6 +244,7 @@ struct tcpm_port {
 	struct completion swap_complete;
 	int swap_status;
 
+	unsigned int negotiated_rev;
 	unsigned int message_id;
 	unsigned int caps_count;
 	unsigned int hard_reset_count;
@@ -259,6 +271,7 @@ struct tcpm_port {
 	unsigned int max_snk_ma;
 	unsigned int max_snk_mw;
 	unsigned int operating_snk_mw;
+	bool update_sink_caps;
 
 	/* Requested current / voltage */
 	u32 current_limit;
@@ -275,8 +288,13 @@ struct tcpm_port {
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
@@ -494,6 +512,13 @@ static void tcpm_log_source_caps(struct tcpm_port *port)
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
@@ -788,11 +813,13 @@ static int tcpm_pd_send_source_caps(struct tcpm_port *port)
 		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id, 0);
 	} else {
 		msg.header = PD_HEADER_LE(PD_DATA_SOURCE_CAP,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id,
 					  port->nr_src_pdo);
 	}
@@ -813,11 +840,13 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
 		msg.header = PD_HEADER_LE(PD_CTRL_REJECT,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id, 0);
 	} else {
 		msg.header = PD_HEADER_LE(PD_DATA_SINK_CAP,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id,
 					  port->nr_snk_pdo);
 	}
@@ -1184,6 +1213,7 @@ static void vdm_run_state_machine(struct tcpm_port *port)
 		msg.header = PD_HEADER_LE(PD_DATA_VENDOR_DEF,
 					  port->pwr_role,
 					  port->data_role,
+					  port->negotiated_rev,
 					  port->message_id, port->vdo_count);
 		for (i = 0; i < port->vdo_count; i++)
 			msg.payload[i] = cpu_to_le32(port->vdo_data[i]);
@@ -1250,11 +1280,16 @@ static void vdm_state_machine_work(struct work_struct *work)
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
 	enum pd_data_msg_type type = pd_header_type_le(msg->header);
 	unsigned int cnt = pd_header_cnt_le(msg->header);
+	unsigned int rev = pd_header_rev_le(msg->header);
 	unsigned int i;
 
 	switch (type) {
@@ -1270,6 +1305,16 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 		tcpm_log_source_caps(port);
 
 		/*
+		 * Adjust revision in subsequent message headers, as required,
+		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
+		 * support Rev 1.0 so just do nothing in that scenario.
+		 */
+		if (rev == PD_REV10)
+			break;
+		else if (rev < PD_MAX_REV)
+			port->negotiated_rev = rev;
+
+		/*
 		 * This message may be received even if VBUS is not
 		 * present. This is quite unexpected; see USB PD
 		 * specification, sections 8.3.3.6.3.1 and 8.3.3.6.3.2.
@@ -1290,6 +1335,19 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
 			break;
 		}
+
+		/*
+		 * Adjust revision in subsequent message headers, as required,
+		 * to comply with 6.2.1.1.5 of the USB PD 3.0 spec. We don't
+		 * support Rev 1.0 so just reject in that scenario.
+		 */
+		if (rev == PD_REV10) {
+			tcpm_queue_message(port, PD_MSG_CTRL_REJECT);
+			break;
+		} else if (rev < PD_MAX_REV) {
+			port->negotiated_rev = rev;
+		}
+
 		port->sink_request = le32_to_cpu(msg->payload[0]);
 		tcpm_set_state(port, SRC_NEGOTIATE_CAPABILITIES, 0);
 		break;
@@ -1314,6 +1372,15 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
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
@@ -1390,6 +1457,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
@@ -1412,6 +1484,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
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
@@ -1566,6 +1645,7 @@ static int tcpm_pd_send_control(struct tcpm_port *port,
 	memset(&msg, 0, sizeof(msg));
 	msg.header = PD_HEADER_LE(type, port->pwr_role,
 				  port->data_role,
+				  port->negotiated_rev,
 				  port->message_id, 0);
 
 	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
@@ -1675,6 +1755,8 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
 	unsigned int i, max_mw = 0, max_mv = 0;
 	int ret = -EINVAL;
 
+	port->pps_data.supported = false;
+
 	/*
 	 * Select the source PDO providing the most power while staying within
 	 * the board's voltage limits. Prefer PDO providing exp
@@ -1684,17 +1766,38 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
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
@@ -1709,6 +1812,64 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port)
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
@@ -1720,13 +1881,22 @@ static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
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
@@ -1789,6 +1959,92 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
 	msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
 				  port->pwr_role,
 				  port->data_role,
+				  port->negotiated_rev,
+				  port->message_id, 1);
+	msg.payload[0] = cpu_to_le32(rdo);
+
+	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
+}
+
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
+				  port->negotiated_rev,
 				  port->message_id, 1);
 	msg.payload[0] = cpu_to_le32(rdo);
 
@@ -1974,6 +2230,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_typec_disconnect(port);
 	port->attached = false;
 	port->pd_capable = false;
+	port->pps_data.supported = false;
 
 	/*
 	 * First Rx ID should be 0; set this to a sentinel of -1 so that
@@ -1989,6 +2246,8 @@ static void tcpm_reset_port(struct tcpm_port *port)
 	tcpm_set_attached_state(port, false);
 	port->try_src_count = 0;
 	port->try_snk_count = 0;
+	port->supply_voltage = 0;
+	port->current_limit = 0;
 }
 
 static void tcpm_detach(struct tcpm_port *port)
@@ -2235,6 +2494,7 @@ static void run_state_machine(struct tcpm_port *port)
 		typec_set_pwr_opmode(port->typec_port, opmode);
 		port->pwr_opmode = TYPEC_PWR_MODE_USB;
 		port->caps_count = 0;
+		port->negotiated_rev = PD_MAX_REV;
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
@@ -2295,6 +2555,7 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
+
 		tcpm_check_send_discover(port);
 		/*
 		 * 6.3.5
@@ -2318,6 +2579,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_UNATTACHED:
 		if (!port->non_pd_role_swap)
 			tcpm_swap_complete(port, -ENOTCONN);
+		tcpm_pps_complete(port, -ENOTCONN);
 		tcpm_snk_detach(port);
 		if (tcpm_start_drp_toggling(port)) {
 			tcpm_set_state(port, DRP_TOGGLING, 0);
@@ -2326,6 +2588,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_cc(port, TYPEC_CC_RD);
 		if (port->port_type == TYPEC_PORT_DRP)
 			tcpm_set_state(port, SRC_UNATTACHED, PD_T_DRP_SRC);
+
 		break;
 	case SNK_ATTACH_WAIT:
 		if ((port->cc1 == TYPEC_CC_OPEN &&
@@ -2407,6 +2670,7 @@ static void run_state_machine(struct tcpm_port *port)
 					      port->cc2 : port->cc1);
 		typec_set_pwr_opmode(port->typec_port, opmode);
 		port->pwr_opmode = TYPEC_PWR_MODE_USB;
+		port->negotiated_rev = PD_MAX_REV;
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		port->explicit_contract = false;
@@ -2477,6 +2741,24 @@ static void run_state_machine(struct tcpm_port *port)
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
@@ -2484,6 +2766,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case SNK_READY:
 		port->try_snk_count = 0;
+		port->update_sink_caps = false;
 		if (port->explicit_contract) {
 			typec_set_pwr_opmode(port->typec_port,
 					     TYPEC_PWR_MODE_PD);
@@ -2492,7 +2775,11 @@ static void run_state_machine(struct tcpm_port *port)
 
 		tcpm_swap_complete(port, 0);
 		tcpm_typec_connect(port);
+
 		tcpm_check_send_discover(port);
+
+		tcpm_pps_complete(port, port->pps_status);
+
 		break;
 
 	/* Accessory states */
@@ -2539,6 +2826,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_state(port, SRC_UNATTACHED, PD_T_PS_SOURCE_ON);
 		break;
 	case SNK_HARD_RESET_SINK_OFF:
+		memset(&port->pps_data, 0, sizeof(port->pps_data));
 		tcpm_set_vconn(port, false);
 		tcpm_set_charge(port, false);
 		tcpm_set_roles(port, false, TYPEC_SINK, TYPEC_DEVICE);
@@ -2759,6 +3047,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case ERROR_RECOVERY:
 		tcpm_swap_complete(port, -EPROTO);
+		tcpm_pps_complete(port, -EPROTO);
 		tcpm_set_state(port, PORT_RESET, 0);
 		break;
 	case PORT_RESET:
@@ -3224,7 +3513,7 @@ static int tcpm_dr_set(const struct typec_capability *cap,
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
-				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
 		ret = port->swap_status;
@@ -3269,7 +3558,7 @@ static int tcpm_pr_set(const struct typec_capability *cap,
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
-				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
 		ret = port->swap_status;
@@ -3309,7 +3598,7 @@ static int tcpm_vconn_set(const struct typec_capability *cap,
 	mutex_unlock(&port->lock);
 
 	if (!wait_for_completion_timeout(&port->swap_complete,
-				msecs_to_jiffies(PD_ROLE_SWAP_TIMEOUT)))
+				msecs_to_jiffies(PD_STATE_MACHINE_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
 		ret = port->swap_status;
@@ -3341,6 +3630,161 @@ static int tcpm_try_role(const struct typec_capability *cap, int role)
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
@@ -3473,13 +3917,18 @@ void tcpm_update_sink_capabilities(struct tcpm_port *port, const u32 *pdo,
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
@@ -3520,6 +3969,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	init_completion(&port->tx_complete);
 	init_completion(&port->swap_complete);
+	init_completion(&port->pps_complete);
 
 	port->nr_src_pdo = tcpm_copy_pdos(port->src_pdo, tcpc->config->src_pdo,
 					  tcpc->config->nr_src_pdo);
@@ -3540,7 +3990,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
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
