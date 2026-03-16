Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625623128C9
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 15:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673390; cv=none; b=dety++ki5JmZ3F3wEPFMRwx0x9AvUPLH6batEW4XYJbMGFA5+zrvKyVgI+ZFxi/uOzu2oURmnRQ8WFdDFFRx2162fBGN5quW1O7YGb+tv+4oTNptBP4/isJaB7rbBgh3i67lgrnegIhBM2inOTh0pX/8o4jFq407NFsSiainGwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673390; c=relaxed/simple;
	bh=4emKMQpGnwxg+WazHqPYVUn+OWaTGfYXDzRjRzw8P5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D4efIt3RXWiLYQdTq1uf4TaWH91P/yrMG+5kSmFg7AfnM2oon2mID0e513yDlvBV0gH6wEX1LnAkvRRUhTUyfmcf3qsRYQTU2lj1K7ipm2ldfcnzBKS49QbqrnD0OOc/I07Gi7fGd8BvgOorEp75ycDpc3FyRcxGEdUNO/ti+ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qlBMYJRk; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--badhri.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qlBMYJRk"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-128edc72e5bso3747337c88.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 08:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773673387; x=1774278187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w9RHSlwF1VNunYEv1VCERKRFyFUXQhzCOoRBUszxeFM=;
        b=qlBMYJRkp7a95vHKndyLrVL0mm2L6kf0dgvzHQk9WosJHc4q9/tWyGwVodMuu95Rzc
         BGBHvLEl3ftKHbqj9yoF4bvcNPD3q6ntpObMQwHwsG4SejVq0uqRipzdI0m1BxXEHqvS
         qyRnEycN0W78ld0ETOXyOc5x1MfxCRYgXiwv/WCs7LQ8tG3kbZhEGJ1Pk9MFlWxTyOFE
         fh/Dl2U/O7y0Tkt95DozyX8rD922tFapkvW9zdG5xG8f0vyYemKkbMomdFaNZsKzHYDy
         BFIT1Zra1dprqK6x1kiJYMQa03CkPa4O0rQVDznzo7gjnZ7+nOBVwoVltbpfOxGihZ80
         HEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673387; x=1774278187;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9RHSlwF1VNunYEv1VCERKRFyFUXQhzCOoRBUszxeFM=;
        b=i5N6oXIKotIrwwZDIxqBLuy84RrmXIGl/4n1w5AQ2NFjbUxm9xttflHGF53HzRkKNi
         SOC7r2TCzJ8Ir6mr8D6KV8nZMAqhWpWEl8MmTzfwiriFEVRjq4Xh8Eky+op3Xu8IwqNY
         uExe5Rb35ensSp5ITkCi2LDPke5PumyCbsdKNhXLG6nTZXFjrjOB1CKnWkqqi6GsvWcH
         n4w/L9YF05xxe5tVScaXcwsKXayg28cxs6+f6FIbe1hO2T4lkJMIvLYWoAPzVONqipuH
         dtQ+RiANpJyvcfEAkfdaiU2t2mOjkW7PHLC+SX6k5gGaUHHN8wTQdRcuczGIXPLYKfE8
         bDqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmeXs5/tB8K0+VamZi2jfLITqYLioIDZ2IQT6pIY2YVKt7+QpxIio10DqpnMrkEKZqczxE4fwGHw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5tfthAhsD7nocRv02jRHD5tPTpa9DKKWvqifo8Yt7U51TA5o
	voNbWbQHzd4hCwTqP2rdQQTx3cFDBMOOP3n72Zb12cWVdXW/4eSLQeNC8fy1PcNwLb/t+2WaDE3
	LK1XYsA==
X-Received: from dlbvv17.prod.google.com ([2002:a05:7022:5f11:b0:128:d41f:2c06])
 (user=badhri job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:628b:b0:128:cf5c:5357
 with SMTP id a92af1059eb24-128f3d0dce2mr6738893c88.2.1773673386080; Mon, 16
 Mar 2026 08:03:06 -0700 (PDT)
Date: Mon, 16 Mar 2026 15:02:59 +0000
In-Reply-To: <20260316150301.3892223-1-badhri@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260316150301.3892223-1-badhri@google.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260316150301.3892223-2-badhri@google.com>
Subject: [PATCH v2 1/3] dt-bindings: connector: Add SPR AVS Sink APDO definitions
From: Badhri Jagan Sridharan <badhri@google.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
	Badhri Jagan Sridharan <badhri@google.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Sunil Dhamne <amitsd@google.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

USB Power Delivery 3.2 introduces a new power supply type SPR AVS.
Add macro definitions for the USB Power Delivery (PD)
Standard Power Range (SPR) Adjustable Voltage Supply (AVS) as a
Sink Augmented Power Data Object (APDO) in the device tree bindings.

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/connector/usb-connector.yaml      |  5 +++--
 include/dt-bindings/usb/pd.h                   | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index 901986de3e2b..a00b239960a3 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -364,8 +364,9 @@ $defs:
           "Universal Serial Bus Power Delivery Specification" chapter 6.4.1.3
           Sink Capabilities Message, the order of each entry(PDO) should follow the
           PD spec chapter 6.4.1. Required for power sink and power dual role. User
-          can specify the sink PDO array via PDO_FIXED/BATT/VAR/PPS_APDO() defined
-          in dt-bindings/usb/pd.h.
+          can specify the sink PDO array via
+          PDO_FIXED/BATT/VAR/PPS_APDO/SPR_AVS_SNK_APDO() defined in
+          dt-bindings/usb/pd.h.
         minItems: 1
         maxItems: 7
         $ref: /schemas/types.yaml#/definitions/uint32-array
diff --git a/include/dt-bindings/usb/pd.h b/include/dt-bindings/usb/pd.h
index 6cff2339bda3..1e64a1f563f9 100644
--- a/include/dt-bindings/usb/pd.h
+++ b/include/dt-bindings/usb/pd.h
@@ -60,6 +60,7 @@
 	 PDO_VAR_MAX_VOLT(max_mv) | PDO_VAR_MAX_CURR(max_ma))
 
 #define APDO_TYPE_PPS		0
+#define APDO_TYPE_SPR_AVS	2
 
 #define PDO_APDO_TYPE_SHIFT	28	/* Only valid value currently is 0x0 - PPS */
 #define PDO_APDO_TYPE_MASK	0x3
@@ -85,6 +86,23 @@
 	 PDO_PPS_APDO_MIN_VOLT(min_mv) | PDO_PPS_APDO_MAX_VOLT(max_mv) |	\
 	 PDO_PPS_APDO_MAX_CURR(max_ma))
 
+#define PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR_SHIFT	10	/* 10mA units */
+#define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR_SHIFT	0	/* 10mA units */
+#define PDO_SPR_AVS_APDO_MAX_CURR_MASK			0x3ff
+
+#define PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR(max_cur_9v_to_15v_ma)		\
+	((((max_cur_9v_to_15v_ma) / 10) & PDO_SPR_AVS_APDO_MAX_CURR_MASK) <<	\
+	PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR_SHIFT)
+
+#define PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR(max_cur_15v_to_20v_ma)		\
+	((((max_cur_15v_to_20v_ma) / 10) & PDO_SPR_AVS_APDO_MAX_CURR_MASK) <<	\
+	PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR_SHIFT)
+
+#define PDO_SPR_AVS_SNK_APDO(max_cur_9v_to_15v_ma, max_cur_15v_to_20v_ma)	\
+	(PDO_TYPE(PDO_TYPE_APDO) | PDO_APDO_TYPE(APDO_TYPE_SPR_AVS) |		\
+	PDO_SPR_AVS_APDO_9V_TO_15V_MAX_CURR(max_cur_9v_to_15v_ma) |		\
+	PDO_SPR_AVS_APDO_15V_TO_20V_MAX_CURR(max_cur_15v_to_20v_ma))
+
  /*
   * Based on "Table 6-14 Fixed Supply PDO - Sink" of "USB Power Delivery Specification Revision 3.0,
   * Version 1.2"
-- 
2.53.0.851.ga537e3e6e9-goog

