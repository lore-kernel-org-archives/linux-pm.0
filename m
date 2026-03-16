Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C784E39E164
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673395; cv=none; b=a6jdqUN6/ZnxVYwP0/Q2faLAGkJw9NJpF/HiAFNPEQtpCqoQ+u3tLdvxh08D3fmKLrNaqloisWpCy7a6x9NpVX6v9ndCMVan5rsCRwRnPrSC0jhXcw0DQbXraKP1r4eBjwnapTiwJlf/L7aTOpT9MHTymBLamfgfWaxhww/9Djw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673395; c=relaxed/simple;
	bh=7DWrQ9WproFUFYDwkNv7KMijJYh1auBTPTw4HDqrjxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kZtEoD58MiHo7PimvfTp5QBh3OuDOP2+qHEkyBQcOCnpPONVcb0s+k2K/90mPI7NDkrvk7VNfIlxogMWpYZyQTCTRGM/fh6s24m515I9BRQF5UQZXXm/lUOjrhZVpKvWvP2AW7kSgerXY8+FGNTg79MqpzUHLPPMp/vv0AENOZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SToZ7bsT; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SToZ7bsT"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12711ec96fbso86428697c88.0
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773673390; x=1774278190; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=70PG56c6aLevnJkQAOJmTZ/3zJM86WKie2/SSke5GJk=;
        b=SToZ7bsTvA67RSh+CKfdTkNPRX7f8NabG454gz3Ru4Sc173nTVpO+5ejTEp2B2tzJ6
         r8ufahLvdce/FntD/CMGgDX73Ai8OpJA1D2wjAm0EnQc+nYypp+m/UBnQEe4cxIniBJ4
         GeTDI4Kczp66D2gm6leaSH/eqyCzsFDvF/Cc9B4yvdoTvNmbq+jfQpSlK147P4U78ive
         z9vMCMtr1+nxjwjzz7pwIJPFAxwdnR3TySqc3Osr07qXCcOBpXGd8tfh85K+Jp1RC6uf
         bLZksMLn3LHdYcv3DzGV30C10zRrU4p0C+kgMdcExg4IbhVLKT6ZsmFSiw2i4u8HNtu6
         xpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673390; x=1774278190;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70PG56c6aLevnJkQAOJmTZ/3zJM86WKie2/SSke5GJk=;
        b=ilirfC2HorFJBGmllocOHm6ixSpNjSIZCXF+v8hbkJoGGYV+fIJXc+W2fOefIynkcu
         suY6Q7wuxL/JPpPuAxcD8tnxKqAIDeDeQwIiwFf8f84lgPWPnJqTI/7yFMyFwJuHt3Wh
         SEsLmDhfz4rVZ1svxBUvTVOrZuGflUxcVQP5K/NjpHcFpZll1qrnvbcDaQ+0U9V5j/1d
         nykDu1L40zhrA3eACWZyifGvNeE2YEl2+/igU8pq1Nr3FWJULsiQxisoSeoHVwq/w1HM
         TtRAzgtdHQ5Oq0xYt4EAeChW8aPAdmBNwznntYgedAxa3e3mqxAQoVeLpvzU7QsJ9+7L
         PK2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1K8T0+pOhPtVPyxt8HUTGF4ZXJOMRf0G4MMviwM5t9LOpr4smXUpMbgjmHdwLDt28nQD/Tm/ITg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzevhL1RbCKZFcetN3ZpFR74XanBztYziF7lBrsBMXpKJAZoMks
	HPgekR9+bcVOFfVqGC3rZRs1/jI441q2R0GAZ8KuSey1+ZiUZk0hx6eLnVpGANuD5LoMDj3GaJU
	Y4QIc3g==
X-Received: from dly14-n2.prod.google.com ([2002:a05:701b:204e:20b0:128:f513:4058])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4587:b0:119:e569:f27f
 with SMTP id a92af1059eb24-128f3e2a616mr6766517c88.40.1773673389576; Mon, 16
 Mar 2026 08:03:09 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:03:01 +0000
In-Reply-To: <20260316150301.3892223-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316150301.3892223-1-badhri@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316150301.3892223-4-badhri@google.com>
Subject: [PATCH v2 3/3] tcpm: Implement sink support for PD SPR AVS negotiation
From: Badhri Jagan Sridharan <badhri@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support to enable TCPM to negotiate with
USB PD Standard Power Range Adjustable Voltage Supply (SPR AVS) when
acting as a power sink.

* Added support to the tcpm power supply properties, allowing userspace
  to enable and control the dynamic limits (voltage and current)
  specific to the SPR AVS contract.
* Implemented tcpm_pd_select_spr_avs_apdo() to select the appropriate
  APDO and validate the requested voltage/current against both the
  Source and Sink capabilities.
* Implemented tcpm_pd_build_spr_avs_request() to construct the
  Request Data Object (RDO) for SPR AVS.
* Added SNK_NEGOTIATE_SPR_AVS_CAPABILITIES state to the state machine to
  handle negotiation for SPR AVS.
* Updated the SNK_TRANSITION_SINK state to implement the SPR
  AVS-specific VBUS transition rules, including reducing current draw to
  PD_I_SNK_STBY_MA for large voltage changes, as required by USB PD spec.

Log stub captured when enabling AVS:
$ echo 3 > /sys/class/power_supply/tcpm-source-psy-1-0025/online
$ cat /d/usb/tcpm-1-0025/log
[  358.895775] request to set AVS online
[  358.895792] AMS POWER_NEGOTIATION start
[  358.895806] state change SNK_READY -> AMS_START [rev3 POWER_NEGOTIATION]
[  358.895850] state change AMS_START -> SNK_NEGOTIATE_SPR_AVS_CAPABILITIES [rev3 POWER_NEGOTIATION]
[  358.895866] SPR AVS src_pdo_index:4 snk_pdo_index:2 req_op_curr_ma roundup:2200 req_out_volt_mv roundup:9000
[  358.895880] Requesting APDO SPR AVS 4: 9000 mV, 2200 mA
[  358.896405] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:0 pps_apdo_min_volt:0 ret:0
[  358.896422] PD TX, header: 0x1a82
[  358.900158] PD TX complete, status: 0
[  358.900205] pending state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev3 POWER_NEGOTIATION]
[  358.904832] PD RX, header: 0x1a3 [1]
[  358.904854] state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> SNK_TRANSITION_SINK [rev3 POWER_NEGOTIATION]
[  358.904888] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 700 ms [rev3 POWER_NEGOTIATION]
[  359.021530] PD RX, header: 0x3a6 [1]
[  359.021546] Setting voltage/current limit 9000 mV 2200 mA
[  359.023035] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9000 pps_apdo_min_volt:0 ret:0
[  359.023053] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
[  359.023090] AMS POWER_NEGOTIATION finished

$ cat /sys/class/power_supply/tcpm-source-psy-1-0025/online
3

Log stub captured when increasing voltage:
$ echo 9100000 > /sys/class/power_supply/tcpm-source-psy-1-0025/voltage_now
$ cat /d/usb/tcpm-1-0025/log

[  632.116714] AMS POWER_NEGOTIATION start
[  632.116728] state change SNK_READY -> AMS_START [rev3 POWER_NEGOTIATION]
[  632.116779] state change AMS_START -> SNK_NEGOTIATE_SPR_AVS_CAPABILITIES [rev3 POWER_NEGOTIATION]
[  632.116798] SPR AVS src_pdo_index:4 snk_pdo_index:2 req_op_curr_ma roundup:2200 req_out_volt_mv roundup:9100
[  632.116811] Requesting APDO SPR AVS 4: 9100 mV, 2200 mA
[  632.117315] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:0 pps_apdo_min_volt:0 ret:0
[  632.117328] PD TX, header: 0x1c82
[  632.121007] PD TX complete, status: 0
[  632.121052] pending state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev3 POWER_NEGOTIATION]
[  632.124572] PD RX, header: 0x5a3 [1]
[  632.124594] state change SNK_NEGOTIATE_SPR_AVS_CAPABILITIES -> SNK_TRANSITION_SINK [rev3 POWER_NEGOTIATION]
[  632.124623] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 700 ms [rev3 POWER_NEGOTIATION]
[  632.149256] PD RX, header: 0x7a6 [1]
[  632.149271] Setting voltage/current limit 9100 mV 2200 mA
[  632.150770] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9100 pps_apdo_min_volt:0 ret:0
[  632.150787] state change SNK_TRANSITION_SINK -> SNK_READY [rev3 POWER_NEGOTIATION]
[  632.150823] AMS POWER_NEGOTIATION finished

$ cat /sys/class/power_supply/tcpm-source-psy-1-0025/voltage_now
9100000

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Amit Sunil Dhamne <amitsd@google.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 611 ++++++++++++++++++++++++++++------
 include/linux/usb/pd.h        |  32 +-
 include/linux/usb/tcpm.h      |   2 +-
 3 files changed, 537 insertions(+), 108 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 63a75b94743d..dfbb94ddc98a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -62,6 +62,7 @@
 	S(SNK_WAIT_CAPABILITIES_TIMEOUT),	\
 	S(SNK_NEGOTIATE_CAPABILITIES),		\
 	S(SNK_NEGOTIATE_PPS_CAPABILITIES),	\
+	S(SNK_NEGOTIATE_SPR_AVS_CAPABILITIES),	\
 	S(SNK_TRANSITION_SINK),			\
 	S(SNK_TRANSITION_SINK_VBUS),		\
 	S(SNK_READY),				\
@@ -308,6 +309,51 @@ struct pd_pps_data {
 	bool active;
 };
 
+enum spr_avs_status {
+	SPR_AVS_UNKNOWN,
+	SPR_AVS_NOT_SUPPORTED,
+	SPR_AVS_SUPPORTED
+};
+
+static const char * const spr_avs_status_strings[] = {
+	[SPR_AVS_UNKNOWN]	= "Unknown",
+	[SPR_AVS_SUPPORTED]	= "Supported",
+	[SPR_AVS_NOT_SUPPORTED]	= "Not Supported",
+};
+
+/*
+ * Standard Power Range Adjustable Voltage Supply (SPR - AVS) data
+ * @max_current_ma_9v_to_15v: Max current for 9V to 15V range derived from
+ *                            source cap & sink cap
+ * @max_current_ma_15v_to_20v: Max current for 15V to 20V range derived from
+ *                             source cap & sink cap
+ * @req_op_curr_ma: Requested operating current to the port partner acting as source
+ * @req_out_volt_mv: Requested output voltage to the port partner acting as source
+ * @max_out_volt_mv: Max SPR voltage supported by the port and the port partner
+ * @max_current_ma; MAX SPR current supported by the port and the port partner
+ * @port_partner_src_status: SPR AVS status of port partner acting as source
+ * @port_partner_src_pdo_index: PDO index of SPR AVS cap of the port partner
+ *                              acting as source. Valid only when
+ *                              port_partner_src_status is SPR_AVS_SUPPORTED.
+ * @port_snk_status: SPR AVS status of the local port acting as sink.
+ * @port_snk_pdo_index: PDO index of SPR AVS cap of local port acting as sink
+ * @active: True when the local port acting as the sink has negotiated SPR AVS
+ *          with the partner acting as source.
+ */
+struct pd_spr_avs_data {
+	u32 max_current_ma_9v_to_15v;
+	u32 max_current_ma_15v_to_20v;
+	u32 req_op_curr_ma;
+	u32 req_out_volt_mv;
+	u32 max_out_volt_mv;
+	u32 max_current_ma;
+	enum spr_avs_status port_partner_src_status;
+	unsigned int port_partner_src_pdo_index;
+	enum spr_avs_status port_snk_status;
+	unsigned int port_snk_pdo_index;
+	bool active;
+};
+
 struct pd_data {
 	struct usb_power_delivery *pd;
 	struct usb_power_delivery_capabilities *source_cap;
@@ -376,6 +422,11 @@ struct sink_caps_ext_data {
 	u8 spr_max_pdp;
 };
 
+enum aug_req_type {
+	PD_PPS,
+	PD_SPR_AVS,
+};
+
 struct tcpm_port {
 	struct device *dev;
 
@@ -538,9 +589,14 @@ struct tcpm_port {
 
 	/* PPS */
 	struct pd_pps_data pps_data;
-	struct completion pps_complete;
-	bool pps_pending;
-	int pps_status;
+
+	/* SPR AVS */
+	struct pd_spr_avs_data spr_avs_data;
+
+	/* Augmented supply request - PPS; SPR_AVS */
+	struct completion aug_supply_req_complete;
+	bool aug_supply_req_pending;
+	int aug_supply_req_status;
 
 	/* Alternate mode data */
 	struct pd_mode_data mode_data;
@@ -3285,6 +3341,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 
 	switch (type) {
 	case PD_DATA_SOURCE_CAP:
+		port->spr_avs_data.port_partner_src_status = SPR_AVS_UNKNOWN;
 		for (i = 0; i < cnt; i++)
 			port->source_caps[i] = le32_to_cpu(msg->payload[i]);
 
@@ -3456,12 +3513,12 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
 	}
 }
 
-static void tcpm_pps_complete(struct tcpm_port *port, int result)
+static void tcpm_aug_supply_req_complete(struct tcpm_port *port, int result)
 {
-	if (port->pps_pending) {
-		port->pps_status = result;
-		port->pps_pending = false;
-		complete(&port->pps_complete);
+	if (port->aug_supply_req_pending) {
+		port->aug_supply_req_status = result;
+		port->aug_supply_req_pending = false;
+		complete(&port->aug_supply_req_complete);
 	}
 }
 
@@ -3559,7 +3616,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			/* Revert data back from any requested PPS updates */
 			port->pps_data.req_out_volt = port->supply_voltage;
 			port->pps_data.req_op_curr = port->current_limit;
-			port->pps_status = (type == PD_CTRL_WAIT ?
+			port->aug_supply_req_status = (type == PD_CTRL_WAIT ?
 					    -EAGAIN : -EOPNOTSUPP);
 
 			/* Threshold was relaxed before sending Request. Restore it back. */
@@ -3567,6 +3624,20 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 							       port->pps_data.active,
 							       port->supply_voltage);
 
+			tcpm_set_state(port, SNK_READY, 0);
+			break;
+		case SNK_NEGOTIATE_SPR_AVS_CAPABILITIES:
+			/* Revert data back from any requested SPR AVS updates */
+			port->spr_avs_data.req_out_volt_mv = port->supply_voltage;
+			port->spr_avs_data.req_op_curr_ma = port->current_limit;
+			port->aug_supply_req_status = (type == PD_CTRL_WAIT ?
+					      -EAGAIN : -EOPNOTSUPP);
+
+			/* Threshold was relaxed before sending Request. Restore it back. */
+			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
+							       port->spr_avs_data.active,
+							       port->supply_voltage);
+
 			tcpm_set_state(port, SNK_READY, 0);
 			break;
 		case DR_SWAP_SEND:
@@ -3621,6 +3692,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 		switch (port->state) {
 		case SNK_NEGOTIATE_CAPABILITIES:
 			port->pps_data.active = false;
+			port->spr_avs_data.active = false;
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
 		case SNK_NEGOTIATE_PPS_CAPABILITIES:
@@ -3633,6 +3705,13 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
 			power_supply_changed(port->psy);
 			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
 			break;
+		case SNK_NEGOTIATE_SPR_AVS_CAPABILITIES:
+			port->spr_avs_data.active = true;
+			port->req_supply_voltage = port->spr_avs_data.req_out_volt_mv;
+			port->req_current_limit = port->spr_avs_data.req_op_curr_ma;
+			power_supply_changed(port->psy);
+			tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
+			break;
 		case SOFT_RESET_SEND:
 			if (port->ams == SOFT_RESET_AMS)
 				tcpm_ams_finish(port);
@@ -4130,9 +4209,9 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 		case PDO_TYPE_APDO:
 			if (pdo_apdo_type(pdo) == APDO_TYPE_PPS) {
 				port->pps_data.supported = true;
-				port->usb_type =
-					POWER_SUPPLY_USB_TYPE_PD_PPS;
-				power_supply_changed(port->psy);
+			} else if (pdo_apdo_type(pdo) == APDO_TYPE_SPR_AVS) {
+				port->spr_avs_data.port_partner_src_status = SPR_AVS_SUPPORTED;
+				port->spr_avs_data.port_partner_src_pdo_index = i;
 			}
 			continue;
 		default:
@@ -4170,6 +4249,10 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 				min_snk_mv = pdo_min_voltage(pdo);
 				break;
 			case PDO_TYPE_APDO:
+				if (pdo_apdo_type(pdo) == APDO_TYPE_SPR_AVS) {
+					port->spr_avs_data.port_snk_status = SPR_AVS_SUPPORTED;
+					port->spr_avs_data.port_snk_pdo_index = j;
+				}
 				continue;
 			default:
 				tcpm_log(port, "Invalid sink PDO type, ignoring");
@@ -4191,6 +4274,23 @@ static int tcpm_pd_select_pdo(struct tcpm_port *port, int *sink_pdo,
 		}
 	}
 
+	if (port->spr_avs_data.port_snk_status == SPR_AVS_UNKNOWN)
+		port->spr_avs_data.port_snk_status = SPR_AVS_NOT_SUPPORTED;
+
+	if (port->spr_avs_data.port_partner_src_status == SPR_AVS_UNKNOWN)
+		port->spr_avs_data.port_partner_src_status = SPR_AVS_NOT_SUPPORTED;
+
+	if (port->pps_data.supported &&
+	    port->spr_avs_data.port_partner_src_status == SPR_AVS_SUPPORTED)
+		port->usb_type = POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS;
+	else if (port->pps_data.supported)
+		port->usb_type = POWER_SUPPLY_USB_TYPE_PD_PPS;
+	else if (port->spr_avs_data.port_partner_src_status == SPR_AVS_SUPPORTED)
+		port->usb_type = POWER_SUPPLY_USB_TYPE_PD_SPR_AVS;
+
+	if (port->usb_type != POWER_SUPPLY_USB_TYPE_PD)
+		power_supply_changed(port->psy);
+
 	return ret;
 }
 
@@ -4241,6 +4341,88 @@ static unsigned int tcpm_pd_select_pps_apdo(struct tcpm_port *port)
 	return src_pdo;
 }
 
+static int tcpm_pd_select_spr_avs_apdo(struct tcpm_port *port)
+{
+	u32 req_out_volt_mv, req_op_curr_ma, src_max_curr_ma = 0, source_cap;
+	u32 snk_max_curr_ma = 0, src_pdo_index, snk_pdo_index, snk_pdo;
+
+	if (port->spr_avs_data.port_snk_status != SPR_AVS_SUPPORTED ||
+	    port->spr_avs_data.port_partner_src_status !=
+	    SPR_AVS_SUPPORTED) {
+		tcpm_log(port, "SPR AVS not supported. port:%s partner:%s",
+			 spr_avs_status_strings[port->spr_avs_data.port_snk_status],
+			 spr_avs_status_strings[port->spr_avs_data.port_partner_src_status]);
+		return -EOPNOTSUPP;
+	}
+
+	/* Round up to SPR_AVS_VOLT_MV_STEP */
+	req_out_volt_mv = port->spr_avs_data.req_out_volt_mv;
+	if (req_out_volt_mv % SPR_AVS_VOLT_MV_STEP) {
+		req_out_volt_mv += SPR_AVS_VOLT_MV_STEP -
+			(req_out_volt_mv % SPR_AVS_VOLT_MV_STEP);
+		port->spr_avs_data.req_out_volt_mv = req_out_volt_mv;
+	}
+
+	/* Round up to RDO_SPR_AVS_CURR_MA_STEP */
+	req_op_curr_ma = port->spr_avs_data.req_op_curr_ma;
+	if (req_op_curr_ma % RDO_SPR_AVS_CURR_MA_STEP) {
+		req_op_curr_ma += RDO_SPR_AVS_CURR_MA_STEP -
+			(req_op_curr_ma % RDO_SPR_AVS_CURR_MA_STEP);
+		port->spr_avs_data.req_op_curr_ma = req_op_curr_ma;
+	}
+
+	src_pdo_index = port->spr_avs_data.port_partner_src_pdo_index;
+	snk_pdo_index = port->spr_avs_data.port_snk_pdo_index;
+	source_cap = port->source_caps[src_pdo_index];
+	snk_pdo = port->snk_pdo[snk_pdo_index];
+	tcpm_log(port,
+		 "SPR AVS src_pdo_index:%d snk_pdo_index:%d req_op_curr_ma roundup:%u req_out_volt_mv roundup:%u",
+		 src_pdo_index, snk_pdo_index, req_op_curr_ma, req_out_volt_mv);
+
+	if (req_out_volt_mv >= SPR_AVS_TIER1_MIN_VOLT_MV &&
+	    req_out_volt_mv <= SPR_AVS_TIER1_MAX_VOLT_MV) {
+		src_max_curr_ma =
+			pdo_spr_avs_apdo_9v_to_15v_max_current_ma(source_cap);
+		snk_max_curr_ma =
+			pdo_spr_avs_apdo_9v_to_15v_max_current_ma(snk_pdo);
+	} else if (req_out_volt_mv > SPR_AVS_TIER1_MAX_VOLT_MV &&
+		   req_out_volt_mv <= SPR_AVS_TIER2_MAX_VOLT_MV) {
+		src_max_curr_ma =
+			pdo_spr_avs_apdo_15v_to_20v_max_current_ma(source_cap);
+		snk_max_curr_ma =
+			pdo_spr_avs_apdo_15v_to_20v_max_current_ma(snk_pdo);
+	} else {
+		tcpm_log(port, "Invalid SPR AVS req_volt:%umV", req_out_volt_mv);
+		return -EINVAL;
+	}
+
+	if (req_op_curr_ma > src_max_curr_ma ||
+	    req_op_curr_ma > snk_max_curr_ma) {
+		tcpm_log(port,
+			 "Invalid SPR AVS request. req_volt:%umV req_curr:%umA src_max_cur:%umA snk_max_cur:%umA",
+			 req_out_volt_mv, req_op_curr_ma, src_max_curr_ma,
+			 snk_max_curr_ma);
+		return -EINVAL;
+	}
+
+	/* Max SPR voltage based on both the port and the partner caps */
+	if (pdo_spr_avs_apdo_15v_to_20v_max_current_ma(snk_pdo) &&
+	    pdo_spr_avs_apdo_15v_to_20v_max_current_ma(source_cap))
+		port->spr_avs_data.max_out_volt_mv = SPR_AVS_TIER2_MAX_VOLT_MV;
+	else
+		port->spr_avs_data.max_out_volt_mv = SPR_AVS_TIER1_MAX_VOLT_MV;
+
+	/*
+	 * Max SPR AVS curr based on 9V to 15V. This should be higher than or
+	 * equal to 15V to 20V range.
+	 */
+	port->spr_avs_data.max_current_ma =
+		min(pdo_spr_avs_apdo_9v_to_15v_max_current_ma(source_cap),
+		    pdo_spr_avs_apdo_9v_to_15v_max_current_ma(snk_pdo));
+
+	return src_pdo_index;
+}
+
 static int tcpm_pd_build_request(struct tcpm_port *port, u32 *rdo)
 {
 	unsigned int mv, ma, mw, flags;
@@ -4408,13 +4590,74 @@ static int tcpm_pd_build_pps_request(struct tcpm_port *port, u32 *rdo)
 	return 0;
 }
 
-static int tcpm_pd_send_pps_request(struct tcpm_port *port)
+static int tcpm_pd_build_spr_avs_request(struct tcpm_port *port, u32 *rdo)
+{
+	u32 out_mv, op_ma, flags, snk_pdo_index, source_cap;
+	unsigned int src_power_mw, snk_power_mw;
+	int src_pdo_index;
+	u32 snk_pdo;
+
+	src_pdo_index = tcpm_pd_select_spr_avs_apdo(port);
+	if (src_pdo_index < 0)
+		return src_pdo_index;
+	snk_pdo_index = port->spr_avs_data.port_snk_pdo_index;
+	source_cap = port->source_caps[src_pdo_index];
+	snk_pdo = port->snk_pdo[snk_pdo_index];
+	out_mv = port->spr_avs_data.req_out_volt_mv;
+	op_ma = port->spr_avs_data.req_op_curr_ma;
+
+	flags = RDO_USB_COMM | RDO_NO_SUSPEND;
+
+	/*
+	 * Set capability mismatch when the maximum power needs in the current
+	 * requested AVS voltage tier range is greater than
+	 * port->operating_snk_mw, however, the maximum power offered by the
+	 * source at the current requested AVS voltage tier is less than
+	 * port->operating_sink_mw.
+	 */
+	if (out_mv > SPR_AVS_TIER1_MAX_VOLT_MV) {
+		src_power_mw =
+			pdo_spr_avs_apdo_15v_to_20v_max_current_ma(source_cap) *
+			SPR_AVS_TIER2_MAX_VOLT_MV / 1000;
+		snk_power_mw =
+			pdo_spr_avs_apdo_15v_to_20v_max_current_ma(snk_pdo) *
+			SPR_AVS_TIER2_MAX_VOLT_MV / 1000;
+	} else {
+		src_power_mw =
+			pdo_spr_avs_apdo_9v_to_15v_max_current_ma(source_cap) *
+			SPR_AVS_TIER1_MAX_VOLT_MV / 1000;
+		snk_power_mw =
+			pdo_spr_avs_apdo_9v_to_15v_max_current_ma(snk_pdo) *
+			SPR_AVS_TIER1_MAX_VOLT_MV / 1000;
+	}
+
+	if (snk_power_mw >= port->operating_snk_mw &&
+	    src_power_mw < port->operating_snk_mw)
+		flags |= RDO_CAP_MISMATCH;
+
+	*rdo = RDO_AVS(src_pdo_index + 1, out_mv, op_ma, flags);
+
+	tcpm_log(port, "Requesting APDO SPR AVS %d: %u mV, %u mA",
+		 src_pdo_index, out_mv, op_ma);
+
+	return 0;
+}
+
+static int tcpm_pd_send_aug_supply_request(struct tcpm_port *port,
+					   enum aug_req_type type)
 {
 	struct pd_message msg;
 	int ret;
 	u32 rdo;
 
-	ret = tcpm_pd_build_pps_request(port, &rdo);
+	if (type == PD_PPS) {
+		ret = tcpm_pd_build_pps_request(port, &rdo);
+	} else if (type == PD_SPR_AVS) {
+		ret = tcpm_pd_build_spr_avs_request(port, &rdo);
+	} else {
+		tcpm_log(port, "Invalid aug_req_type %d", type);
+		ret = -EOPNOTSUPP;
+	}
 	if (ret < 0)
 		return ret;
 
@@ -4637,6 +4880,14 @@ static void tcpm_set_partner_usb_comm_capable(struct tcpm_port *port, bool capab
 		port->tcpc->set_partner_usb_comm_capable(port->tcpc, capable);
 }
 
+static void tcpm_partner_source_caps_reset(struct tcpm_port *port)
+{
+	usb_power_delivery_unregister_capabilities(port->partner_source_caps);
+	port->partner_source_caps = NULL;
+	port->spr_avs_data.port_partner_src_status = SPR_AVS_UNKNOWN;
+	port->spr_avs_data.active = false;
+}
+
 static void tcpm_reset_port(struct tcpm_port *port)
 {
 	tcpm_enable_auto_vbus_discharge(port, false);
@@ -4676,8 +4927,7 @@ static void tcpm_reset_port(struct tcpm_port *port)
 
 	usb_power_delivery_unregister_capabilities(port->partner_sink_caps);
 	port->partner_sink_caps = NULL;
-	usb_power_delivery_unregister_capabilities(port->partner_source_caps);
-	port->partner_source_caps = NULL;
+	tcpm_partner_source_caps_reset(port);
 	usb_power_delivery_unregister(port->partner_pd);
 	port->partner_pd = NULL;
 }
@@ -5169,7 +5419,7 @@ static void run_state_machine(struct tcpm_port *port)
 	case SNK_UNATTACHED:
 		if (!port->non_pd_role_swap)
 			tcpm_swap_complete(port, -ENOTCONN);
-		tcpm_pps_complete(port, -ENOTCONN);
+		tcpm_aug_supply_req_complete(port, -ENOTCONN);
 		tcpm_snk_detach(port);
 		if (port->potential_contaminant) {
 			tcpm_set_state(port, CHECK_CONTAMINANT, 0);
@@ -5400,13 +5650,16 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case SNK_NEGOTIATE_PPS_CAPABILITIES:
-		ret = tcpm_pd_send_pps_request(port);
+	case SNK_NEGOTIATE_SPR_AVS_CAPABILITIES:
+		ret = tcpm_pd_send_aug_supply_request(port, port->state ==
+						      SNK_NEGOTIATE_PPS_CAPABILITIES ?
+						      PD_PPS : PD_SPR_AVS);
 		if (ret < 0) {
 			/* Restore back to the original state */
 			tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
 							       port->pps_data.active,
 							       port->supply_voltage);
-			port->pps_status = ret;
+			port->aug_supply_req_status = ret;
 			/*
 			 * If this was called due to updates to sink
 			 * capabilities, and pps is no longer valid, we should
@@ -5422,23 +5675,58 @@ static void run_state_machine(struct tcpm_port *port)
 		}
 		break;
 	case SNK_TRANSITION_SINK:
-		/* From the USB PD spec:
-		 * "The Sink Shall transition to Sink Standby before a positive or
-		 * negative voltage transition of VBUS. During Sink Standby
-		 * the Sink Shall reduce its power draw to pSnkStdby."
-		 *
-		 * This is not applicable to PPS though as the port can continue
-		 * to draw negotiated power without switching to standby.
-		 */
-		if (port->supply_voltage != port->req_supply_voltage && !port->pps_data.active &&
-		    port->current_limit * port->supply_voltage / 1000 > PD_P_SNK_STDBY_MW) {
-			u32 stdby_ma = PD_P_SNK_STDBY_MW * 1000 / port->supply_voltage;
+		if (port->spr_avs_data.active) {
+			if (abs(port->req_supply_voltage - port->supply_voltage) >
+			    SPR_AVS_AVS_SMALL_STEP_V * 1000) {
+				/*
+				 * The Sink Shall reduce its current draw to
+				 * iSnkStdby within tSnkStdby. The reduction to
+				 * iSnkStdby is not required if the voltage
+				 * increase is less than or equal to
+				 * vAvsSmallStep.
+				 */
+				tcpm_log(port,
+					 "SPR AVS Setting iSnkstandby. Req vol: %u mV Curr vol: %u mV",
+					 port->req_supply_voltage,
+					 port->supply_voltage);
+				tcpm_set_current_limit(port, PD_I_SNK_STBY_MA,
+						       port->supply_voltage);
+			}
+			/*
+			 * Although tAvsSrcTransSmall is expected to be used
+			 * for voltage transistions smaller than 1V, using
+			 * tAvsSrcTransLarge to be resilient against chargers
+			 * which strictly cannot honor tAvsSrcTransSmall to
+			 * improve interoperability.
+			 */
+			tcpm_set_state(port, hard_reset_state(port),
+				       PD_T_AVS_SRC_TRANS_LARGE);
+			/*
+			 * From the USB PD spec:
+			 * "The Sink Shall transition to Sink Standby before a
+			 * positive ornegative voltage transition of VBUS.
+			 * During Sink Standby the Sink Shall reduce its power
+			 * draw to pSnkStdby."
+			 *
+			 * This is not applicable to PPS though as the port can
+			 * continue to draw negotiated power without switching
+			 * to standby.
+			 */
+		} else if (port->supply_voltage != port->req_supply_voltage &&
+			   !port->pps_data.active &&
+			   (port->current_limit * port->supply_voltage / 1000 >
+			   PD_P_SNK_STDBY_MW)) {
+			u32 stdby_ma = PD_P_SNK_STDBY_MW * 1000 /
+				port->supply_voltage;
 
 			tcpm_log(port, "Setting standby current %u mV @ %u mA",
 				 port->supply_voltage, stdby_ma);
-			tcpm_set_current_limit(port, stdby_ma, port->supply_voltage);
+			tcpm_set_current_limit(port, stdby_ma,
+					       port->supply_voltage);
+			tcpm_set_state(port, hard_reset_state(port),
+				       PD_T_PS_TRANSITION);
 		}
-		fallthrough;
+		break;
 	case SNK_TRANSITION_SINK_VBUS:
 		tcpm_set_state(port, hard_reset_state(port),
 			       PD_T_PS_TRANSITION);
@@ -5458,7 +5746,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_typec_connect(port);
 		if (port->pd_capable && port->source_caps[0] & PDO_FIXED_DUAL_ROLE)
 			mod_enable_frs_delayed_work(port, 0);
-		tcpm_pps_complete(port, port->pps_status);
+		tcpm_aug_supply_req_complete(port, port->aug_supply_req_status);
 
 		if (port->ams != NONE_AMS)
 			tcpm_ams_finish(port);
@@ -5645,8 +5933,7 @@ static void run_state_machine(struct tcpm_port *port)
 		port->message_id = 0;
 		port->rx_msgid = -1;
 		/* remove existing capabilities */
-		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
-		port->partner_source_caps = NULL;
+		tcpm_partner_source_caps_reset(port);
 		tcpm_pd_send_control(port, PD_CTRL_ACCEPT, TCPC_TX_SOP);
 		tcpm_ams_finish(port);
 		if (port->pwr_role == TYPEC_SOURCE) {
@@ -5679,8 +5966,7 @@ static void run_state_machine(struct tcpm_port *port)
 			port->message_id = 0;
 			port->rx_msgid = -1;
 			/* remove existing capabilities */
-			usb_power_delivery_unregister_capabilities(port->partner_source_caps);
-			port->partner_source_caps = NULL;
+			tcpm_partner_source_caps_reset(port);
 			if (tcpm_pd_send_control(port, PD_CTRL_SOFT_RESET, TCPC_TX_SOP))
 				tcpm_set_state_cond(port, hard_reset_state(port), 0);
 			else
@@ -5817,8 +6103,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case PR_SWAP_SNK_SRC_SINK_OFF:
 		/* will be source, remove existing capabilities */
-		usb_power_delivery_unregister_capabilities(port->partner_source_caps);
-		port->partner_source_caps = NULL;
+		tcpm_partner_source_caps_reset(port);
 		/*
 		 * Prevent vbus discharge circuit from turning on during PR_SWAP
 		 * as this is not a disconnect.
@@ -5966,7 +6251,7 @@ static void run_state_machine(struct tcpm_port *port)
 		break;
 	case ERROR_RECOVERY:
 		tcpm_swap_complete(port, -EPROTO);
-		tcpm_pps_complete(port, -EPROTO);
+		tcpm_aug_supply_req_complete(port, -EPROTO);
 		tcpm_set_state(port, PORT_RESET, 0);
 		break;
 	case PORT_RESET:
@@ -6940,7 +7225,7 @@ static int tcpm_try_role(struct typec_port *p, int role)
 	return ret;
 }
 
-static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
+static int tcpm_aug_set_op_curr(struct tcpm_port *port, u16 req_op_curr_ma)
 {
 	unsigned int target_mw;
 	int ret;
@@ -6948,7 +7233,19 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
 	mutex_lock(&port->swap_lock);
 	mutex_lock(&port->lock);
 
-	if (!port->pps_data.active) {
+	if (port->pps_data.active) {
+		req_op_curr_ma = req_op_curr_ma -
+				 (req_op_curr_ma % RDO_PROG_CURR_MA_STEP);
+		if (req_op_curr_ma > port->pps_data.max_curr) {
+			ret = -EINVAL;
+			goto port_unlock;
+		}
+		target_mw = (req_op_curr_ma * port->supply_voltage) / 1000;
+		if (target_mw < port->operating_snk_mw) {
+			ret = -EINVAL;
+			goto port_unlock;
+		}
+	} else if (!port->spr_avs_data.active) {
 		ret = -EOPNOTSUPP;
 		goto port_unlock;
 	}
@@ -6958,38 +7255,31 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
 		goto port_unlock;
 	}
 
-	if (req_op_curr > port->pps_data.max_curr) {
-		ret = -EINVAL;
-		goto port_unlock;
-	}
-
-	target_mw = (req_op_curr * port->supply_voltage) / 1000;
-	if (target_mw < port->operating_snk_mw) {
-		ret = -EINVAL;
-		goto port_unlock;
-	}
+	if (port->pps_data.active)
+		port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	else
+		port->upcoming_state = SNK_NEGOTIATE_SPR_AVS_CAPABILITIES;
 
-	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
 	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
 	if (ret == -EAGAIN) {
 		port->upcoming_state = INVALID_STATE;
 		goto port_unlock;
 	}
 
-	/* Round down operating current to align with PPS valid steps */
-	req_op_curr = req_op_curr - (req_op_curr % RDO_PROG_CURR_MA_STEP);
-
-	reinit_completion(&port->pps_complete);
-	port->pps_data.req_op_curr = req_op_curr;
-	port->pps_status = 0;
-	port->pps_pending = true;
+	reinit_completion(&port->aug_supply_req_complete);
+	if (port->pps_data.active)
+		port->pps_data.req_op_curr = req_op_curr_ma;
+	else
+		port->spr_avs_data.req_op_curr_ma = req_op_curr_ma;
+	port->aug_supply_req_status = 0;
+	port->aug_supply_req_pending = true;
 	mutex_unlock(&port->lock);
 
-	if (!wait_for_completion_timeout(&port->pps_complete,
-				msecs_to_jiffies(PD_PPS_CTRL_TIMEOUT)))
+	if (!wait_for_completion_timeout(&port->aug_supply_req_complete,
+					 msecs_to_jiffies(PD_AUG_PSY_CTRL_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
-		ret = port->pps_status;
+		ret = port->aug_supply_req_status;
 
 	goto swap_unlock;
 
@@ -7001,7 +7291,7 @@ static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
 	return ret;
 }
 
-static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
+static int tcpm_aug_set_out_volt(struct tcpm_port *port, u16 req_out_volt_mv)
 {
 	unsigned int target_mw;
 	int ret;
@@ -7009,7 +7299,16 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
 	mutex_lock(&port->swap_lock);
 	mutex_lock(&port->lock);
 
-	if (!port->pps_data.active) {
+	if (port->pps_data.active) {
+		req_out_volt_mv = req_out_volt_mv - (req_out_volt_mv %
+						     RDO_PROG_VOLT_MV_STEP);
+		/* Round down output voltage to align with PPS valid steps */
+		target_mw = (port->current_limit * req_out_volt_mv) / 1000;
+		if (target_mw < port->operating_snk_mw) {
+			ret = -EINVAL;
+			goto port_unlock;
+		}
+	} else if (!port->spr_avs_data.active) {
 		ret = -EOPNOTSUPP;
 		goto port_unlock;
 	}
@@ -7019,33 +7318,31 @@ static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
 		goto port_unlock;
 	}
 
-	target_mw = (port->current_limit * req_out_volt) / 1000;
-	if (target_mw < port->operating_snk_mw) {
-		ret = -EINVAL;
-		goto port_unlock;
-	}
+	if (port->pps_data.active)
+		port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
+	else
+		port->upcoming_state = SNK_NEGOTIATE_SPR_AVS_CAPABILITIES;
 
-	port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
 	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
 	if (ret == -EAGAIN) {
 		port->upcoming_state = INVALID_STATE;
 		goto port_unlock;
 	}
 
-	/* Round down output voltage to align with PPS valid steps */
-	req_out_volt = req_out_volt - (req_out_volt % RDO_PROG_VOLT_MV_STEP);
-
-	reinit_completion(&port->pps_complete);
-	port->pps_data.req_out_volt = req_out_volt;
-	port->pps_status = 0;
-	port->pps_pending = true;
+	reinit_completion(&port->aug_supply_req_complete);
+	if (port->pps_data.active)
+		port->pps_data.req_out_volt = req_out_volt_mv;
+	else
+		port->spr_avs_data.req_out_volt_mv = req_out_volt_mv;
+	port->aug_supply_req_status = 0;
+	port->aug_supply_req_pending = true;
 	mutex_unlock(&port->lock);
 
-	if (!wait_for_completion_timeout(&port->pps_complete,
-				msecs_to_jiffies(PD_PPS_CTRL_TIMEOUT)))
+	if (!wait_for_completion_timeout(&port->aug_supply_req_complete,
+					 msecs_to_jiffies(PD_AUG_PSY_CTRL_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
-		ret = port->pps_status;
+		ret = port->aug_supply_req_status;
 
 	goto swap_unlock;
 
@@ -7088,9 +7385,9 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 		goto port_unlock;
 	}
 
-	reinit_completion(&port->pps_complete);
-	port->pps_status = 0;
-	port->pps_pending = true;
+	reinit_completion(&port->aug_supply_req_complete);
+	port->aug_supply_req_status = 0;
+	port->aug_supply_req_pending = true;
 
 	/* Trigger PPS request or move back to standard PDO contract */
 	if (activate) {
@@ -7099,11 +7396,75 @@ static int tcpm_pps_activate(struct tcpm_port *port, bool activate)
 	}
 	mutex_unlock(&port->lock);
 
-	if (!wait_for_completion_timeout(&port->pps_complete,
-				msecs_to_jiffies(PD_PPS_CTRL_TIMEOUT)))
+	if (!wait_for_completion_timeout(&port->aug_supply_req_complete,
+					 msecs_to_jiffies(PD_AUG_PSY_CTRL_TIMEOUT)))
+		ret = -ETIMEDOUT;
+	else
+		ret = port->aug_supply_req_status;
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
+static int tcpm_spr_avs_activate(struct tcpm_port *port, bool activate)
+{
+	int ret = 0;
+
+	mutex_lock(&port->swap_lock);
+	mutex_lock(&port->lock);
+
+	if (port->spr_avs_data.port_snk_status == SPR_AVS_NOT_SUPPORTED ||
+	    port->spr_avs_data.port_partner_src_status == SPR_AVS_NOT_SUPPORTED) {
+		tcpm_log(port, "SPR_AVS not supported");
+		ret = -EOPNOTSUPP;
+		goto port_unlock;
+	}
+
+	/* Trying to deactivate SPR AVS when already deactivated so just bail */
+	if (!port->spr_avs_data.active && !activate)
+		goto port_unlock;
+
+	if (port->state != SNK_READY) {
+		tcpm_log(port,
+			 "SPR_AVS cannot be activated. Port not in SNK_READY");
+		ret = -EAGAIN;
+		goto port_unlock;
+	}
+
+	if (activate)
+		port->upcoming_state = SNK_NEGOTIATE_SPR_AVS_CAPABILITIES;
+	else
+		port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
+	ret = tcpm_ams_start(port, POWER_NEGOTIATION);
+	if (ret == -EAGAIN) {
+		tcpm_log(port, "SPR_AVS cannot be %s. AMS start failed",
+			 activate ? "activated" : "deactivated");
+		port->upcoming_state = INVALID_STATE;
+		goto port_unlock;
+	}
+
+	reinit_completion(&port->aug_supply_req_complete);
+	port->aug_supply_req_status = 0;
+	port->aug_supply_req_pending = true;
+
+	/* Trigger AVS request or move back to standard PDO contract */
+	if (activate) {
+		port->spr_avs_data.req_out_volt_mv = port->supply_voltage;
+		port->spr_avs_data.req_op_curr_ma = port->current_limit;
+	}
+	mutex_unlock(&port->lock);
+
+	if (!wait_for_completion_timeout(&port->aug_supply_req_complete,
+					 msecs_to_jiffies(PD_AUG_PSY_CTRL_TIMEOUT)))
 		ret = -ETIMEDOUT;
 	else
-		ret = port->pps_status;
+		ret = port->aug_supply_req_status;
 
 	goto swap_unlock;
 
@@ -7259,16 +7620,26 @@ static int tcpm_pd_set(struct typec_port *p, struct usb_power_delivery *pd)
 		break;
 	case SNK_NEGOTIATE_CAPABILITIES:
 	case SNK_NEGOTIATE_PPS_CAPABILITIES:
+	case SNK_NEGOTIATE_SPR_AVS_CAPABILITIES:
 	case SNK_READY:
 	case SNK_TRANSITION_SINK:
 	case SNK_TRANSITION_SINK_VBUS:
-		if (port->pps_data.active)
+		if (port->pps_data.active) {
 			port->upcoming_state = SNK_NEGOTIATE_PPS_CAPABILITIES;
-		else if (port->pd_capable)
+		} else if (port->pd_capable) {
 			port->upcoming_state = SNK_NEGOTIATE_CAPABILITIES;
-		else
+			if (port->spr_avs_data.active) {
+				/*
+				 * De-activate AVS and fallback to PD to
+				 * re-evaluate whether AVS is supported in the
+				 * current sink cap set.
+				 */
+				port->spr_avs_data.active = false;
+				port->spr_avs_data.port_snk_status = SPR_AVS_UNKNOWN;
+			}
+		} else {
 			break;
-
+		}
 		port->update_sink_caps = true;
 
 		ret = tcpm_ams_start(port, POWER_NEGOTIATION);
@@ -7778,7 +8149,8 @@ static void tcpm_fw_get_pd_revision(struct tcpm_port *port, struct fwnode_handle
 enum tcpm_psy_online_states {
 	TCPM_PSY_OFFLINE = 0,
 	TCPM_PSY_FIXED_ONLINE,
-	TCPM_PSY_PROG_ONLINE,
+	TCPM_PSY_PPS_ONLINE,
+	TCPM_PSY_SPR_AVS_ONLINE,
 };
 
 static enum power_supply_property tcpm_psy_props[] = {
@@ -7796,7 +8168,9 @@ static int tcpm_psy_get_online(struct tcpm_port *port,
 {
 	if (port->vbus_charge) {
 		if (port->pps_data.active)
-			val->intval = TCPM_PSY_PROG_ONLINE;
+			val->intval = TCPM_PSY_PPS_ONLINE;
+		else if (port->spr_avs_data.active)
+			val->intval = TCPM_PSY_SPR_AVS_ONLINE;
 		else
 			val->intval = TCPM_PSY_FIXED_ONLINE;
 	} else {
@@ -7811,6 +8185,8 @@ static int tcpm_psy_get_voltage_min(struct tcpm_port *port,
 {
 	if (port->pps_data.active)
 		val->intval = port->pps_data.min_volt * 1000;
+	else if (port->spr_avs_data.active)
+		val->intval = SPR_AVS_TIER1_MIN_VOLT_MV * 1000;
 	else
 		val->intval = port->supply_voltage * 1000;
 
@@ -7822,6 +8198,8 @@ static int tcpm_psy_get_voltage_max(struct tcpm_port *port,
 {
 	if (port->pps_data.active)
 		val->intval = port->pps_data.max_volt * 1000;
+	else if (port->spr_avs_data.active)
+		val->intval = port->spr_avs_data.max_out_volt_mv * 1000;
 	else
 		val->intval = port->supply_voltage * 1000;
 
@@ -7841,6 +8219,8 @@ static int tcpm_psy_get_current_max(struct tcpm_port *port,
 {
 	if (port->pps_data.active)
 		val->intval = port->pps_data.max_curr * 1000;
+	else if (port->spr_avs_data.active)
+		val->intval = port->spr_avs_data.max_current_ma * 1000;
 	else
 		val->intval = port->current_limit * 1000;
 
@@ -7916,17 +8296,41 @@ static int tcpm_psy_get_prop(struct power_supply *psy,
 	return ret;
 }
 
+static int tcpm_disable_pps_avs(struct tcpm_port *port)
+{
+	int ret = 0;
+
+	if (port->pps_data.active)
+		ret = tcpm_pps_activate(port, false);
+	else if (port->spr_avs_data.active)
+		ret = tcpm_spr_avs_activate(port, false);
+
+	return ret;
+}
+
 static int tcpm_psy_set_online(struct tcpm_port *port,
 			       const union power_supply_propval *val)
 {
-	int ret;
+	int ret = 0;
 
 	switch (val->intval) {
 	case TCPM_PSY_FIXED_ONLINE:
-		ret = tcpm_pps_activate(port, false);
+		ret = tcpm_disable_pps_avs(port);
+		break;
+	case TCPM_PSY_PPS_ONLINE:
+		if (port->spr_avs_data.active)
+			ret = tcpm_spr_avs_activate(port, false);
+		if (!ret)
+			ret = tcpm_pps_activate(port, true);
 		break;
-	case TCPM_PSY_PROG_ONLINE:
-		ret = tcpm_pps_activate(port, true);
+	case TCPM_PSY_SPR_AVS_ONLINE:
+		tcpm_log(port, "request to set AVS online");
+		if (port->spr_avs_data.active)
+			return 0;
+		ret = tcpm_disable_pps_avs(port);
+		if (ret)
+			break;
+		ret = tcpm_spr_avs_activate(port, true);
 		break;
 	default:
 		ret = -EINVAL;
@@ -7955,13 +8359,10 @@ static int tcpm_psy_set_prop(struct power_supply *psy,
 		ret = tcpm_psy_set_online(port, val);
 		break;
 	case POWER_SUPPLY_PROP_VOLTAGE_NOW:
-		ret = tcpm_pps_set_out_volt(port, val->intval / 1000);
+		ret = tcpm_aug_set_out_volt(port, val->intval / 1000);
 		break;
 	case POWER_SUPPLY_PROP_CURRENT_NOW:
-		if (val->intval > port->pps_data.max_curr * 1000)
-			ret = -EINVAL;
-		else
-			ret = tcpm_pps_set_op_curr(port, val->intval / 1000);
+		ret = tcpm_aug_set_op_curr(port, val->intval / 1000);
 		break;
 	default:
 		ret = -EINVAL;
@@ -8006,7 +8407,9 @@ static int devm_tcpm_psy_register(struct tcpm_port *port)
 	port->psy_desc.type = POWER_SUPPLY_TYPE_USB;
 	port->psy_desc.usb_types = BIT(POWER_SUPPLY_USB_TYPE_C)  |
 				   BIT(POWER_SUPPLY_USB_TYPE_PD) |
-				   BIT(POWER_SUPPLY_USB_TYPE_PD_PPS);
+				   BIT(POWER_SUPPLY_USB_TYPE_PD_PPS) |
+				   BIT(POWER_SUPPLY_USB_TYPE_PD_PPS_SPR_AVS) |
+				   BIT(POWER_SUPPLY_USB_TYPE_PD_SPR_AVS);
 	port->psy_desc.properties = tcpm_psy_props;
 	port->psy_desc.num_properties = ARRAY_SIZE(tcpm_psy_props);
 	port->psy_desc.get_property = tcpm_psy_get_prop;
@@ -8101,7 +8504,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
 
 	init_completion(&port->tx_complete);
 	init_completion(&port->swap_complete);
-	init_completion(&port->pps_complete);
+	init_completion(&port->aug_supply_req_complete);
 	tcpm_debugfs_init(port);
 
 	err = tcpm_fw_get_caps(port, tcpc->fwnode);
diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
index 5a98983195cb..337a5485af7c 100644
--- a/include/linux/usb/pd.h
+++ b/include/linux/usb/pd.h
@@ -398,9 +398,30 @@ enum pd_apdo_type {
 #define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR	GENMASK(9, 0)	/* 10mA unit */
 
 /* SPR AVS has two different current ranges 9V - 15V, 15V - 20V */
-#define SPR_AVS_TIER1_MIN_VOLT_MV		9000
-#define SPR_AVS_TIER1_MAX_VOLT_MV		15000
-#define SPR_AVS_TIER2_MAX_VOLT_MV		20000
+#define SPR_AVS_TIER1_MIN_VOLT_MV              9000
+#define SPR_AVS_TIER1_MAX_VOLT_MV              15000
+#define SPR_AVS_TIER2_MAX_VOLT_MV              20000
+
+#define SPR_AVS_AVS_SMALL_STEP_V	1
+/* vAvsStep - 100mv */
+#define SPR_AVS_VOLT_MV_STEP		100
+/* SPR AVS RDO Operating Current is in 50mA step */
+#define RDO_SPR_AVS_CURR_MA_STEP	50
+/* SPR AVS RDO Output voltage is in 25mV step */
+#define RDO_SPR_AVS_OUT_VOLT_MV_STEP	25
+
+#define RDO_SPR_AVS_VOLT	GENMASK(20, 9)
+#define RDO_SPR_AVS_CURR	GENMASK(6, 0)
+
+#define RDO_SPR_AVS_OUT_VOLT(mv)					\
+	FIELD_PREP(RDO_SPR_AVS_VOLT, ((mv) / RDO_SPR_AVS_OUT_VOLT_MV_STEP))
+
+#define RDO_SPR_AVS_OP_CURR(ma)						\
+	FIELD_PREP(RDO_SPR_AVS_CURR, ((ma) / RDO_SPR_AVS_CURR_MA_STEP))
+
+#define RDO_AVS(idx, out_mv, op_ma, flags)				\
+	(RDO_OBJ(idx) | (flags) |					\
+	 RDO_SPR_AVS_OUT_VOLT(out_mv) | RDO_SPR_AVS_OP_CURR(op_ma))
 
 static inline enum pd_pdo_type pdo_type(u32 pdo)
 {
@@ -660,6 +681,11 @@ static inline unsigned int rdo_max_power(u32 rdo)
 
 #define PD_P_SNK_STDBY_MW	2500	/* 2500 mW */
 
+#define PD_I_SNK_STBY_MA		500	/* 500 mA */
+
+#define PD_T_AVS_SRC_TRANS_SMALL	50	/* 50 ms */
+#define PD_T_AVS_SRC_TRANS_LARGE	700	/* 700 ms */
+
 #if IS_ENABLED(CONFIG_TYPEC)
 
 struct usb_power_delivery;
diff --git a/include/linux/usb/tcpm.h b/include/linux/usb/tcpm.h
index b22e659f81ba..93079450bba0 100644
--- a/include/linux/usb/tcpm.h
+++ b/include/linux/usb/tcpm.h
@@ -31,7 +31,7 @@ enum typec_cc_polarity {
 /* Time to wait for TCPC to complete transmit */
 #define PD_T_TCPC_TX_TIMEOUT	100		/* in ms	*/
 #define PD_ROLE_SWAP_TIMEOUT	(MSEC_PER_SEC * 10)
-#define PD_PPS_CTRL_TIMEOUT	(MSEC_PER_SEC * 10)
+#define PD_AUG_PSY_CTRL_TIMEOUT	(MSEC_PER_SEC * 10)
 
 enum tcpm_transmit_status {
 	TCPC_TX_SUCCESS = 0,
-- 
2.53.0.851.ga537e3e6e9-goog

