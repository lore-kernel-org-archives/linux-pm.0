Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793051114;
	b=IDrw5s61US1DPm/rwSVv/M5kBRMkD0spM5rmwIbT/gwHL1kRy/Aucwittoae8GzkojeF
	 5P+VtFM10IBo5j5dSkM1YyfWAyJBCIhC8U9/6xvzQZ7Gtu7rXHzC/YXRVkyLW5jbAODkk
	 dXGVUN5chqLTjXZ7NVDjNH9LD9ljGj5oYtSlVDq3MhDIYlZY81FHip1DpYIB9eB+MKTli
	 Kk8SYpYezjfn8wnvgfXwx7OS5lVhiBPGhmkqUZYpInqrmb3Ne8XKQDsc0HZYRE4wwfVuo
	 VuP3i/hjhHEOnqxlih+jUyiEF30L6b+eWSl/GrRGXfzeGWK1aBwrmhw4omGEOWoUk4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793051114;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=PgsvjDUbnWS9QUhLLUSpL3kYkuj7C6kPZAZRitggftk=;
	b=Eb3CyZGtymGOyoqHkYFGA8rM0+SWEXJdk7tutFfKyxyHaIiIRZfQTx0t0Cfj8UV73YFV
	 p3p5QKmBQakojRzDtvc5mJmZobD1DIlZD3cdc/xHNMdUrP253MXdd91AIPo1pUfRC1hdX
	 j+T6sNp7JW2YmW8ec2zeZmyiLF3kMDH7k0iEu+lfkMT38gxadskhsqQQ9BI8yO8mgMSDZ
	 OtHqhnDv9I/fdntE2XBCFbSAjUY+gVCRGwAGNTDri2OH68AfaH7ytmz/j8J22ZT8VOaUg
	 SV6TJn7jYgwgUCMTQj18wTDaf/ByuegnoQjyor/QUVIIzIyoFCYbfbtNWOB3dXHhJ5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b="QTbV8/qk";
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31C260A260D
	for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 21:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D31C260A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=QTbV8/qk
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35f1f76ea84so5834977eec.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Oct 2026 14:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793051112; x=1793655912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PgsvjDUbnWS9QUhLLUSpL3kYkuj7C6kPZAZRitggftk=;
        b=QTbV8/qkDE53S0Dv417snDrXxhtkovA3YEtATrOx/6hSXPuBUGcaNkiq+WeHuesH+M
         ta3ar12RrjR7K18vGYYWdS7CRGeOmVyI3fhKKSZxverXNSclsMOG7H/CuqUn8tIMQEb2
         uXwgHJjARfyFHhSeUb7URjoDYuoBoV1s/wvbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793051112; x=1793655912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PgsvjDUbnWS9QUhLLUSpL3kYkuj7C6kPZAZRitggftk=;
        b=sRQDH6OnxsprI6W8npW17/MMnNxsFbBNcgAo0GPspo7VnOPnMA8yejC5E+7JTMqUTC
         D56W07QnjqUPEhi/uRYskQFOBEl7X6tGF6YC2qA/lTqNOSap+MpbmuSYtNdoCBQigsks
         1ZDP5laMtAs3cM2V/jCvAvf977P56sXQ58YlvTlGLLZXgy+rXEQfFqL6pk/3uejlNEWi
         FVmIyyj9x9SYvei55urgr8WTzkt6ylC8U8TnFMr2swvs6qusZdDrDPSF+HZQZkZB6txT
         kHSEi2mIoLPemuxa1DzG70S2uYNEjPKJ3AQkAsGlFcFWgiramuLpFycifPEKAP80BJNi
         nUXQ==
X-Forwarded-Encrypted: i=1; AKwUvByb3O31fQrbdG1g7pBtoMSAf39uqly6IAZ6Od5cQko/tiCJVag8vdOewBb1PJvyB2H4hpM4c3CwLQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYI/T0Ie4Jhy2xCb1KlkwRI9AvRgUYYAvsrbfP/oaWkS8QVBS7+l
	+5rUexC5OI1Drhqu6gb1d1nsqSICDJ1ZWRvIv9tDbKtl7Aro7MZoPY/xziyM6Cq/0Q==
X-Gm-Gg: AYBFou09wa4K5mURX3tPZg7MM2frUZVtU+/nRY+6U4y/yfs+Wjz/lH8f2IgPkA1F+Bm
	KuXpbmIKPqCeUMB0sm0JJJ+FXBa7anQgWM5Nn+3mUGa8wsJ3FnJYYGp88q6tmUHLkd7lY4cn30T
	pA0FSC8VrLcgOYbG8nTKkCsVpzJVhBIMPbZDbjVNrwqW2Jy9bNLmWZQBP2DtmgQnDSo67Y1TjVk
	Scykar9RHeqxYRk6a5oJ/uXbtDAmgmnZETGo/CniGPZiDW9NaKxyAuBSYgJ7Qr4rjFvNrc2PlBP
	qWDTgvu+CmKQwdOKcnugv1k/sbDcuiwCrPiW5xDM+n7bGGI728CThLOQHrSniEis6CpYFECFds4
	tv3VwmCQkCDK2D4SR4ghPxLm0XezZLx84sRpexaBJN1OvndSCWuCz4Od1qSFhFcJi/KEYdO+9JQ
	DjHP6hMtP26rjNwpfaS7dduIla3xFh7AEhW2PXZqIrUVKnKAurENojzquFsDdR6k9dvc2wP0tJg
	0qyHLSs5RD/BD8S09GfWDpW6qnDZTcR7TFrF5ZAYkRXtEiI3mMgmBPksFDQ9xW4wU+2Pf/pzXE2
	R0M11h4d5pSJPBbJvAc=
X-Received: by 2002:a05:693c:3944:b0:369:ec31:8fd5 with SMTP id 5a478bee46e88-369ec31a168mr16635741eec.3.1793051111553;
        Mon, 26 Oct 2026 14:45:11 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:79c5:9cd3:db14:7468])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-369e8ee71f5sm35739862eec.28.2026.10.26.14.45.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 14:45:10 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Griffin <peter.griffin@linaro.org>,
	devicetree@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	linux-arm-kernel@lists.infradead.org,
	Mariano Marciello <mmarciello@google.com>,
	Douglas Anderson <dianders@chromium.org>,
	linux-clk@vger.kernel.org,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/9] soc: google: Add CPM over MailBox Array driver
Date: Mon, 26 Oct 2026 14:43:41 -0700
Message-ID: <20261026144346.3.I7bc547c83b7bf677a62670099f481a91ac737073@changeid>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261026214359.3122870-1-briannorris@chromium.org>
References: <20261026214359.3122870-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Central Power Manager (CPM) is a co-processor on the Google Tensor
SoCs, as used on Pixel phones. CPM supports power-management and a
number of other features.

The Application Processor communicates with CPM over a pair of mailbox
channels (the "MailBox Array" (MBA)). CPM provides clock, power-domain,
reset, interrupt services, and more.

It's difficult to support all of these services within a single driver,
in part because it's a lot of code to manage, but also because there can
be complex relationships between the individual services. For example,
clocks may have dependencies on power-domains. Instead, the CPM driver
only handles some basic initialization, and otherwise creates child
auxiliary_bus devices to handle each service. It also provides an API
wrapper around the mailbox protocol, so clients don't have to worry
about some of the details. This API assumes all users are children of
the CPM device.

Implementation note about the "session" handling: the mailbox API
doesn't provide any timeouts or guarantees about a response message, but
CPM clients would like an (optional) timeout. So there's a little bit of
complexity around reference-counting a "session" (i.e., outstanding
request still waiting on a response), as that session may outlive the
client's timeout.

Quick note about hardware queueing: this is implemented in our mailbox
driver by allowing clients to request the "same" channel multiple times.
A client is expected to keep requesting the channel until it sees
-EBUSY, meaning we've requested all of them. We then utilize those
channels in a round-robin fashion.

Because it may be useful both for reviewers familiar with the downstream
Linux support for these devices, or for future developers looking at
adapting/improving/adding further features later on, it's worth noting
some major deviations from the downstream drivers:

 * This driver doesn't contain much of the queueing complexity from the
   downstream driver. The mailbox driver was significantly rewritten
   beneath us, to support most of the queueing there, and thus exposes a
   simpler API to us.

 * No session pool; we just allocate sessions on-demand, enough to
   handle timeouts while a response is still pending.

 * Use auxiliary_bus, with CPM services represented as child devices on
   this bus. Downstream services tended to be a bunch of artificial
   platform devices, with fake-mailbox phandles to the CPM "interface"
   node. This is an atypical device tree structure, and most of those
   platform devices came from device nodes that were less for describing
   the hardware, and more for describing how we wanted software to look.
   So far, I haven't found services that don't work as child auxiliary
   devices. If we later have examples that need some combination of both
   iomem resources and CPM resources (and so may need to live on the
   platform bus), I'm sure we can add support for non-child (e.g.,
   phandle) interface methods.

 * Add devm_* client helpers, to make it easier for clients to clean up
   properly. (Hint: most downstream clients did not clean up properly.)

 * Reduce the surface area of exposed (EXPORTed, or header definitions)
   protocol details, such as goog_mba_q_*() methods. Many such details
   aren't used outside the CPM driver, so it's probably best to keep
   them local until proven otherwise.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---
Based on a WIP mailbox API from:

  https://lore.kernel.org/all/20261023165211.v2.4.I5cef580a62c86ba6c3465ad336fa509afbdf1476@changeid/
  [PATCH v2 4/4] mailbox: goog-mba: Introduce the goog-mba mailbox driver

which is part of this series:

  https://lore.kernel.org/all/20261023235408.3063350-1-dianders@chromium.org/
  [PATCH v2 0/4] mailbox: Improve the mbox core then introduce the goog-mba driver

That API consists of:

 1) a header (<linux/mailbox/goog-mba-message.h>), which so far seems
    typical and uncontroversial and

 2) a strategy for supporting hardware queueing -- where the current
    proposal is described in the commit message. I suppose this strategy
    could still change, although it was discussed at length in v1 of
    that series.

Anyway, this patch should not be accepted until the above series is
settled.

 drivers/soc/Kconfig                       |   1 +
 drivers/soc/Makefile                      |   1 +
 drivers/soc/google/Kconfig                |  13 +
 drivers/soc/google/Makefile               |   3 +
 drivers/soc/google/google-cpm-mba-trace.h | 214 +++++
 drivers/soc/google/google-cpm-mba.c       | 964 ++++++++++++++++++++++
 drivers/soc/google/google-cpm-mba.h       |  30 +
 include/soc/google/goog_cpm_service_ids.h |  84 ++
 include/soc/google/google-cpm-mba.h       | 147 ++++
 9 files changed, 1457 insertions(+)
 create mode 100644 drivers/soc/google/Kconfig
 create mode 100644 drivers/soc/google/Makefile
 create mode 100644 drivers/soc/google/google-cpm-mba-trace.h
 create mode 100644 drivers/soc/google/google-cpm-mba.c
 create mode 100644 drivers/soc/google/google-cpm-mba.h
 create mode 100644 include/soc/google/goog_cpm_service_ids.h
 create mode 100644 include/soc/google/google-cpm-mba.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 483cbdcae153..fbe6460424c7 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -10,6 +10,7 @@ source "drivers/soc/canaan/Kconfig"
 source "drivers/soc/cirrus/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fujitsu/Kconfig"
+source "drivers/soc/google/Kconfig"
 source "drivers/soc/hisilicon/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 5a3efd68355c..6241e543dad7 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-y				+= fujitsu/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
+obj-y				+= google/
 obj-y				+= hisilicon/
 obj-y				+= imx/
 obj-y				+= ixp4xx/
diff --git a/drivers/soc/google/Kconfig b/drivers/soc/google/Kconfig
new file mode 100644
index 000000000000..9cd04be63b23
--- /dev/null
+++ b/drivers/soc/google/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+config GOOGLE_CPM_MBA
+	tristate "Google Tensor CPM MailBox Array Interface"
+	depends on ARCH_GOOGLE || COMPILE_TEST
+	depends on MAILBOX
+	select AUXILIARY_BUS
+	help
+	  Driver for interfacing with the Central Power Manager (CPM) MailBox
+	  Array (MBA) found on Google Tensor SoCs. The driver provides APIs for
+	  communication between the Application Processor and the CPM, and
+	  is required by CPM client drivers such as clock, reset, power
+	  domain, and more.
diff --git a/drivers/soc/google/Makefile b/drivers/soc/google/Makefile
new file mode 100644
index 000000000000..78f69932a377
--- /dev/null
+++ b/drivers/soc/google/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_GOOGLE_CPM_MBA) += google-cpm-mba.o
diff --git a/drivers/soc/google/google-cpm-mba-trace.h b/drivers/soc/google/google-cpm-mba-trace.h
new file mode 100644
index 000000000000..a10687d0b83e
--- /dev/null
+++ b/drivers/soc/google/google-cpm-mba-trace.h
@@ -0,0 +1,214 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2025-2026 Google LLC
+ */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM google_cpm_mba
+
+#if !defined(_GOOGLE_CPM_MBA_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _GOOGLE_CPM_MBA_TRACE_H
+
+#include <linux/tracepoint.h>
+#include <soc/google/google-cpm-mba.h>
+
+#include "google-cpm-mba.h"
+
+#define MAX_DEV_NAME 32
+
+#ifdef CREATE_TRACE_POINTS
+static inline void cpm_trace_clone_payload(u32 *header, u32 *payloads,
+					   const struct cpm_payload *payload)
+{
+	*header = payload->header;
+	memcpy(payloads, payload->payload, GOOG_MBA_PAYLOAD_SIZE * sizeof(*payloads));
+}
+#endif
+
+TRACE_EVENT(
+	cpm_request_client,
+
+	TP_PROTO(struct cpm_client *client),
+
+	TP_ARGS(client),
+
+	TP_STRUCT__entry(
+		__field(int, src_id)
+		__field(void *, host_tx_cb)
+		__array(char, dev_name, MAX_DEV_NAME)
+	),
+
+	TP_fast_assign(
+		scnprintf(__entry->dev_name, MAX_DEV_NAME, "%s", dev_name(client->dev));
+		__entry->src_id = client->src_id;
+		__entry->host_tx_cb = (void *)client->host_tx_cb;
+	),
+
+	TP_printk("dev=%s src_id=%d host_tx_cb=%ps", __entry->dev_name, __entry->src_id,
+		  __entry->host_tx_cb)
+);
+
+TRACE_EVENT(
+	cpm_free_client,
+
+	TP_PROTO(struct cpm_client *client),
+
+	TP_ARGS(client),
+
+	TP_STRUCT__entry(
+		__field(int, src_id)
+		__array(char, dev_name, MAX_DEV_NAME)
+	),
+
+	TP_fast_assign(
+		__entry->src_id = client->src_id;
+		scnprintf(__entry->dev_name, MAX_DEV_NAME, "%s", dev_name(client->dev));
+	),
+
+	TP_printk("dev=%s src_id=%d", __entry->dev_name, __entry->src_id)
+);
+
+TRACE_EVENT(
+	cpm_req_enqueue,
+
+	TP_PROTO(struct cpm_session *session, const struct cpm_request *req, int src_id),
+
+	TP_ARGS(session, req, src_id),
+
+	TP_STRUCT__entry(
+		__field(void *, session)
+		__field(unsigned long, tout_ms)
+		__field(u32, resp_context)
+		__field(int, src_id)
+	),
+
+	TP_fast_assign(
+		__entry->tout_ms = req->tout_ms;
+		__entry->resp_context = req->resp_context;
+		__entry->session = session;
+		__entry->src_id = src_id;
+	),
+
+	TP_printk("session=%p src_id=%d tout_ms=%lu resp_ctx=%#x",
+		  __entry->session, __entry->src_id, __entry->tout_ms,
+		  __entry->resp_context)
+);
+
+TRACE_EVENT(
+	cpm_submit_msg,
+
+	TP_PROTO(struct cpm_session *session, const struct cpm_payload *payload),
+
+	TP_ARGS(session, payload),
+
+	TP_STRUCT__entry(
+		__field(void *, session)
+		__field(u32, header)
+		__array(u32, payloads, GOOG_MBA_PAYLOAD_SIZE)
+	),
+
+	TP_fast_assign(
+		__entry->session = session;
+		cpm_trace_clone_payload(&__entry->header, __entry->payloads, payload);
+	),
+
+	TP_printk("session=%p: %#010x %#010x %#010x %#010x",
+		  __entry->session, __entry->header,
+		  __entry->payloads[0], __entry->payloads[1], __entry->payloads[2])
+);
+
+TRACE_EVENT(
+	cpm_req_tx_done,
+
+	TP_PROTO(struct cpm_session *session),
+
+	TP_ARGS(session),
+
+	TP_STRUCT__entry(
+		__field(void *, session)
+	),
+
+	TP_fast_assign(
+		__entry->session = session;
+	),
+
+	TP_printk("session=%p", __entry->session)
+);
+
+TRACE_EVENT(
+	cpm_resp_cb,
+
+	TP_PROTO(struct cpm_session *session, const struct cpm_payload *payload),
+
+	TP_ARGS(session, payload),
+
+	TP_STRUCT__entry(
+		__field(void *, session)
+		__field(u32, header)
+		__array(u32, payloads, GOOG_MBA_PAYLOAD_SIZE)
+	),
+
+	TP_fast_assign(
+		__entry->session = session;
+		cpm_trace_clone_payload(&__entry->header, __entry->payloads, payload);
+	),
+
+	TP_printk("session=%p: %#010x %#010x %#010x %#010x",
+		  __entry->session, __entry->header,
+		  __entry->payloads[0], __entry->payloads[1], __entry->payloads[2])
+);
+
+TRACE_EVENT(
+	cpm_send_message,
+
+	TP_PROTO(struct cpm_session *session, int ret),
+
+	TP_ARGS(session, ret),
+
+	TP_STRUCT__entry(
+		__field(void *, session)
+		__field(int, ret)
+	),
+
+	TP_fast_assign(
+		__entry->session = session;
+		__entry->ret = ret;
+	),
+
+	TP_printk("session=%p ret=%d",
+		  __entry->session, __entry->ret)
+);
+
+TRACE_EVENT(
+	cpm_handle_host_tx,
+
+	TP_PROTO(int dst_id, u32 resp_context, const struct cpm_payload *payload),
+
+	TP_ARGS(dst_id, resp_context, payload),
+
+	TP_STRUCT__entry(
+		__field(int, dst_id)
+		__field(u32, resp_context)
+		__field(u32, header)
+		__array(u32, payloads, GOOG_MBA_PAYLOAD_SIZE)
+	),
+
+	TP_fast_assign(
+		__entry->dst_id = dst_id;
+		__entry->resp_context = resp_context;
+		cpm_trace_clone_payload(&__entry->header, __entry->payloads, payload);
+	),
+
+	TP_printk("dst_id=%d resp_context=%#x: %#010x %#010x %#010x %#010x",
+		  __entry->dst_id, __entry->resp_context,
+		  __entry->header, __entry->payloads[0],
+		  __entry->payloads[1], __entry->payloads[2])
+);
+
+#endif /* _GOOGLE_CPM_MBA_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../drivers/soc/google/
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE google-cpm-mba-trace
+#include <trace/define_trace.h>
diff --git a/drivers/soc/google/google-cpm-mba.c b/drivers/soc/google/google-cpm-mba.c
new file mode 100644
index 000000000000..629a071e202c
--- /dev/null
+++ b/drivers/soc/google/google-cpm-mba.c
@@ -0,0 +1,964 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Google MailBox Array (MBA) CPM Interface
+ *
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/mailbox/goog-mba-message.h>
+#include <linux/mailbox_client.h>
+#include <linux/mailbox_controller.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+#include <soc/google/google-cpm-mba.h>
+
+#include "google-cpm-mba.h"
+
+/*
+ * Header of queue mode message defines fields for type, src_id and dst_id.
+ *
+ *  31 30     29  24      20    16     8     0
+ *  +---+------+---+-------+-----+-----+-----+
+ *  | V | Type | R | Token | Seq | Src | Dst |
+ *  +---+------+---+-------+-----+-----+-----+
+ *
+ *  Bit 31 is valid bit:	Must be 1.
+ *  Bits 30-29 are type:	The message type can be one of the following values:
+ *				0x0 One-way message
+ *				0x1 Requests (expect response)
+ *				0x2 Response (to a previous request)
+ *  Bits 28-24 are reserved.
+ *  Bits 23-20 are token:	Reserved for transport layer module.
+ *  Bits 19-16 are seq:		Reserved for transport layer module.
+ *  Bits 15-8 are source id.
+ *  Bits 7-0 are destination id.
+ */
+
+#define GOOG_MBA_Q_DST_ID_MASK		GENMASK(7, 0)
+#define GOOG_MBA_Q_SRC_ID_MASK		GENMASK(15, 8)
+#define GOOG_MBA_Q_SEQ_MASK		GENMASK(19, 16)
+#define GOOG_MBA_Q_TOKEN_MASK		GENMASK(23, 20)
+#define GOOG_MBA_Q_TYPE_MASK		GENMASK(30, 29)
+#define GOOG_MBA_Q_VALID_MASK		GENMASK(31, 31)
+
+#define GOOG_MBA_Q_MAX_SRC_ID_VAL	0xff
+#define GOOG_MBA_Q_MIN_SEQ_VAL		1
+#define GOOG_MBA_Q_MAX_SEQ_VAL		13
+#define GOOG_MBA_Q_MAX_TOKEN_VAL	16
+
+#define GOOG_MBA_Q_INIT_PROTO_VAL	0x100
+
+#define GOOG_MBA_Q_TYPE_ONEWAY		0x0
+#define GOOG_MBA_Q_TYPE_REQUEST		0x1
+#define GOOG_MBA_Q_TYPE_RESPONSE	0x2
+
+static inline u32 goog_mba_q_get_dst_id(const u32 *msg)
+{
+	return FIELD_GET(GOOG_MBA_Q_DST_ID_MASK, *msg);
+}
+
+static inline u32 goog_mba_q_get_src_id(const u32 *msg)
+{
+	return FIELD_GET(GOOG_MBA_Q_SRC_ID_MASK, *msg);
+}
+
+static inline u32 goog_mba_q_get_seq(const u32 *msg)
+{
+	return FIELD_GET(GOOG_MBA_Q_SEQ_MASK, *msg);
+}
+
+static inline u32 goog_mba_q_get_token(const u32 *msg)
+{
+	return FIELD_GET(GOOG_MBA_Q_TOKEN_MASK, *msg);
+}
+
+static inline u32 goog_mba_q_get_type(const u32 *msg)
+{
+	return FIELD_GET(GOOG_MBA_Q_TYPE_MASK, *msg);
+}
+
+static inline u32 goog_mba_q_get_valid(const u32 *msg)
+{
+	return FIELD_GET(GOOG_MBA_Q_VALID_MASK, *msg);
+}
+
+static inline void goog_mba_q_set_dst_id(u32 *msg, u32 dst_id)
+{
+	*msg &= ~GOOG_MBA_Q_DST_ID_MASK;
+	*msg |= FIELD_PREP(GOOG_MBA_Q_DST_ID_MASK, dst_id);
+}
+
+static inline void goog_mba_q_set_src_id(u32 *msg, u32 src_id)
+{
+	*msg &= ~GOOG_MBA_Q_SRC_ID_MASK;
+	*msg |= FIELD_PREP(GOOG_MBA_Q_SRC_ID_MASK, src_id);
+}
+
+static inline void goog_mba_q_set_seq(u32 *msg, u32 seq)
+{
+	*msg &= ~GOOG_MBA_Q_SEQ_MASK;
+	*msg |= FIELD_PREP(GOOG_MBA_Q_SEQ_MASK, seq);
+}
+
+static inline void goog_mba_q_set_token(u32 *msg, u32 token)
+{
+	*msg &= ~GOOG_MBA_Q_TOKEN_MASK;
+	*msg |= FIELD_PREP(GOOG_MBA_Q_TOKEN_MASK, token);
+}
+
+static inline void goog_mba_q_set_type(u32 *msg, u32 type)
+{
+	*msg &= ~GOOG_MBA_Q_TYPE_MASK;
+	*msg |= FIELD_PREP(GOOG_MBA_Q_TYPE_MASK, type);
+}
+
+static inline void goog_mba_q_set_valid(u32 *msg, bool is_valid)
+{
+	u32 val = is_valid ? 1 : 0;
+	*msg &= ~GOOG_MBA_Q_VALID_MASK;
+	*msg |= FIELD_PREP(GOOG_MBA_Q_VALID_MASK, val);
+}
+
+static inline u32 goog_mba_q_create_hdr(u32 src_id, u32 dst_id, u32 seq,
+					u32 token, u32 type)
+{
+	return FIELD_PREP(GOOG_MBA_Q_SRC_ID_MASK, src_id) |
+	       FIELD_PREP(GOOG_MBA_Q_DST_ID_MASK, dst_id) |
+	       FIELD_PREP(GOOG_MBA_Q_SEQ_MASK, seq) |
+	       FIELD_PREP(GOOG_MBA_Q_TOKEN_MASK, token) |
+	       FIELD_PREP(GOOG_MBA_Q_TYPE_MASK, type) |
+	       FIELD_PREP(GOOG_MBA_Q_VALID_MASK, 1);
+}
+
+struct cpm_session {
+	struct kref refcount;
+	struct completion complete;
+	struct cpm_payload req_msg;
+	struct cpm_payload resp_msg;
+	struct goog_mba_tx_msg req_mba_msg;
+};
+
+#define CREATE_TRACE_POINTS
+#include "google-cpm-mba-trace.h"
+
+#define MBOX_IDX_REQ			0
+#define MBOX_IDX_RESP			1
+
+struct cpm_mbox_chan_info {
+	struct mbox_client client;
+	struct mbox_chan *chan;
+	struct list_head entry;
+};
+
+/**
+ * struct cpm_data - Core data for the CPM interface module
+ * @dev: The device structure associated with this CPM interface.
+ * @client_list_head: List of registered client handles.
+ * @lock: Spinlock for protecting critical sections.
+ * @seq_num: Sequence number for debugging.
+ * @resp_pending: Array for sessions awaiting responses from the CPM host.
+ * @resp_pending_size: Number of @resp_pending entries in use.
+ * @req_chans: Circular list of request mailbox channels (rotated round-robin).
+ * @resp_chan: Response mailbox channel.
+ */
+struct cpm_data {
+	struct device *dev;
+	struct list_head client_list_head;
+
+	/*
+	 * Protect queue operations including token, resp_pending, req_chans,
+	 * and resp_chan.
+	 */
+	spinlock_t lock;
+	int seq_num;
+	struct cpm_session *resp_pending[GOOG_MBA_Q_MAX_TOKEN_VAL];
+	int resp_pending_size;
+	struct list_head req_chans;
+	struct cpm_mbox_chan_info resp_chan;
+};
+
+static const struct of_device_id cpm_of_match_table[] = {
+	{ .compatible = "google,lga-cpm" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, cpm_of_match_table);
+
+static inline bool cpm_is_request_msg(const struct cpm_request *req)
+{
+	return req->msg_type == REQUEST_MSG;
+}
+
+static inline bool cpm_is_oneway_msg(const struct cpm_request *req)
+{
+	return req->msg_type == ONEWAY_MSG;
+}
+
+static inline bool cpm_is_response_msg(const struct cpm_request *req)
+{
+	return req->msg_type == RESPONSE_MSG;
+}
+
+static inline bool cpm_is_request_header(const void *msg)
+{
+	return goog_mba_q_get_type(msg) == GOOG_MBA_Q_TYPE_REQUEST;
+}
+
+static inline bool cpm_is_oneway_header(const void *msg)
+{
+	return goog_mba_q_get_type(msg) == GOOG_MBA_Q_TYPE_ONEWAY;
+}
+
+static inline bool cpm_is_response_header(const void *msg)
+{
+	return goog_mba_q_get_type(msg) == GOOG_MBA_Q_TYPE_RESPONSE;
+}
+
+static inline bool cpm_is_init_header(const void *msg)
+{
+	return *(const u32 *)msg == GOOG_MBA_Q_INIT_PROTO_VAL;
+}
+
+static void cpm_session_release(struct kref *kref)
+{
+	struct cpm_session *session = container_of(kref, struct cpm_session, refcount);
+
+	kfree(session);
+}
+
+DEFINE_FREE(session_put, struct cpm_session *, if (_T) kref_put(&_T->refcount, cpm_session_release))
+
+/**
+ * cpm_add_pending_resp - add session to pending table to wait for host response
+ * @cpm: Core driver data.
+ * @session: Client's session waiting for response.
+ *
+ * Return: 0 on success, -EBUSY if no token is available.
+ */
+static int cpm_add_pending_resp(struct cpm_data *cpm, struct cpm_session *session)
+{
+	struct device *dev = cpm->dev;
+	int token;
+
+	lockdep_assert_held(&cpm->lock);
+
+	for (token = 0; token < GOOG_MBA_Q_MAX_TOKEN_VAL; token++) {
+		if (!cpm->resp_pending[token]) {
+			goog_mba_q_set_token(&session->req_msg.header, token);
+			kref_get(&session->refcount);
+			cpm->resp_pending[token] = session;
+			cpm->resp_pending_size++;
+			return 0;
+		}
+	}
+
+	dev_err(dev, "Failed to find available entries in resp_pending (size:%d)\n",
+		cpm->resp_pending_size);
+
+	return -EBUSY;
+}
+
+/**
+ * cpm_remove_pending_resp - remove session entry from pending table after received response
+ * @cpm: Core driver data.
+ * @msg_payload: Used to resolve embedded token value to remove corresponding
+ *	entry of pending table.
+ *
+ * Return: True if a matching session was found and removed, false otherwise.
+ */
+static bool
+cpm_remove_pending_resp(struct cpm_data *cpm,
+			const struct cpm_payload *msg_payload)
+{
+	struct cpm_session *session;
+	int token = goog_mba_q_get_token(&msg_payload->header);
+
+	lockdep_assert_held(&cpm->lock);
+
+	session = cpm->resp_pending[token];
+	if (!session)
+		return false;
+
+	cpm->resp_pending[token] = NULL;
+	cpm->resp_pending_size--;
+
+	if (cpm_is_response_header(msg_payload)) {
+		trace_cpm_resp_cb(session, msg_payload);
+		session->resp_msg = *msg_payload;
+		complete(&session->complete);
+	}
+
+	kref_put(&session->refcount, cpm_session_release);
+
+	return true;
+}
+
+static void
+cpm_remove_pending_by_session(struct cpm_data *cpm,
+			      struct cpm_session *session)
+{
+	int token;
+
+	lockdep_assert_held(&cpm->lock);
+
+	for (token = 0; token < GOOG_MBA_Q_MAX_TOKEN_VAL; token++) {
+		if (cpm->resp_pending[token] == session) {
+			cpm->resp_pending[token] = NULL;
+			cpm->resp_pending_size--;
+			kref_put(&session->refcount, cpm_session_release);
+			return;
+		}
+	}
+}
+
+/**
+ * cpm_set_seq_number - assign sequential number in valid range
+ * @cpm: Core driver data.
+ * @req_msg: Request payload to write sequence number to.
+ */
+static inline void cpm_set_seq_number(struct cpm_data *cpm,
+				      struct cpm_payload *req_msg)
+{
+	int seq_num;
+
+	seq_num = cpm->seq_num;
+	goog_mba_q_set_seq(&req_msg->header, seq_num);
+	if (seq_num == GOOG_MBA_Q_MAX_SEQ_VAL)
+		cpm->seq_num = GOOG_MBA_Q_MIN_SEQ_VAL;
+	else
+		cpm->seq_num++;
+}
+
+static struct cpm_client *
+cpm_search_client_by_id(struct cpm_data *cpm, int id)
+{
+	struct cpm_client *client;
+
+	if (id < 0 || id > GOOG_MBA_Q_MAX_SRC_ID_VAL)
+		return ERR_PTR(-EINVAL);
+
+	list_for_each_entry(client, &cpm->client_list_head, entry) {
+		if (client->src_id == id)
+			return client;
+	}
+
+	return NULL;
+}
+
+struct cpm_client *cpm_request_client(struct device *dev,
+				      int src_id,
+				      cpm_cb_t cpm_cb,
+				      void *priv)
+{
+	struct cpm_client *client;
+	struct cpm_data *cpm;
+
+	if (!dev_is_auxiliary(dev)) {
+		dev_err(dev, "Device is not an auxiliary device\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	if (WARN_ON(!of_match_node(cpm_of_match_table, dev->parent->of_node))) {
+		dev_err(dev, "Parent device is not CPM: %s\n", dev_name(dev->parent));
+		return ERR_PTR(-EINVAL);
+	}
+
+	cpm = dev_get_drvdata(dev->parent);
+	if (WARN_ON(!cpm))
+		return ERR_PTR(-ENODEV);
+
+	client = kzalloc_obj(*client, GFP_KERNEL);
+	if (!client)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&client->entry);
+	client->dev = dev;
+	client->src_id = src_id;
+	client->host_tx_cb = cpm_cb;
+	client->priv = priv;
+
+	scoped_guard(spinlock_irqsave, &cpm->lock) {
+		if (src_id) {
+			struct cpm_client *existing;
+
+			existing = cpm_search_client_by_id(cpm, src_id);
+			if (IS_ERR(existing)) {
+				dev_err(dev, "src_id(%d) out of valid range\n", src_id);
+				kfree(client);
+				return existing;
+			}
+
+			if (existing) {
+				kfree(client);
+				return ERR_PTR(-EBUSY);
+			}
+		}
+		list_add(&client->entry, &cpm->client_list_head);
+	}
+
+	trace_cpm_request_client(client);
+
+	return client;
+}
+EXPORT_SYMBOL_GPL(cpm_request_client);
+
+void cpm_free_client(struct cpm_client *client)
+{
+	struct cpm_data *cpm = dev_get_drvdata(client->dev->parent);
+
+	trace_cpm_free_client(client);
+
+	scoped_guard(spinlock_irqsave, &cpm->lock)
+		list_del(&client->entry);
+
+	kfree(client);
+}
+EXPORT_SYMBOL_GPL(cpm_free_client);
+
+static void devm_cpm_client_release(void *data)
+{
+	struct cpm_client *client = data;
+
+	cpm_free_client(client);
+}
+
+struct cpm_client *devm_cpm_request_client(struct device *dev,
+					   int src_id,
+					   cpm_cb_t cpm_cb,
+					   void *priv)
+{
+	struct cpm_client *client;
+	int ret;
+
+	client = cpm_request_client(dev, src_id, cpm_cb, priv);
+	if (IS_ERR(client))
+		return client;
+
+	ret = devm_add_action_or_reset(dev, devm_cpm_client_release, client);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return client;
+}
+EXPORT_SYMBOL_GPL(devm_cpm_request_client);
+
+static u32 cpm_req_get_header(struct cpm_client *client, struct cpm_request *cpm_req)
+{
+	u32 header = 0;
+
+	if (cpm_is_oneway_msg(cpm_req)) {
+		header = goog_mba_q_create_hdr(client->src_id, cpm_req->dst_id,
+					       0, 0, GOOG_MBA_Q_TYPE_ONEWAY);
+	} else if (cpm_is_request_msg(cpm_req)) {
+		header = goog_mba_q_create_hdr(client->src_id, cpm_req->dst_id,
+					       0, 0, GOOG_MBA_Q_TYPE_REQUEST);
+	} else if (cpm_is_response_msg(cpm_req)) {
+		goog_mba_q_set_type(&cpm_req->resp_context,
+				    GOOG_MBA_Q_TYPE_RESPONSE);
+		header = cpm_req->resp_context;
+	}
+
+	return header;
+}
+
+static int cpm_try_submit(struct cpm_data *cpm, struct cpm_session *session)
+{
+	struct device *dev = cpm->dev;
+	struct cpm_payload *req_msg = &session->req_msg;
+	struct cpm_mbox_chan_info *mbox_chan_info;
+	int ret;
+
+	lockdep_assert_held(&cpm->lock);
+
+	if (!cpm_is_init_header(req_msg)) {
+		session->req_mba_msg.init = false;
+		if (cpm_is_request_header(req_msg)) {
+			ret = cpm_add_pending_resp(cpm, session);
+			if (ret < 0)
+				return ret;
+		}
+		cpm_set_seq_number(cpm, req_msg);
+	} else {
+		session->req_mba_msg.init = true;
+	}
+
+	mbox_chan_info = list_first_entry(&cpm->req_chans,
+					  struct cpm_mbox_chan_info, entry);
+
+	/* Get ref for request channel TX completion before submit */
+	kref_get(&session->refcount);
+
+	session->req_mba_msg.payload = (u32 *)req_msg;
+	session->req_mba_msg.payload_words =
+		sizeof(*req_msg) / sizeof(*session->req_mba_msg.payload);
+
+	ret = mbox_send_message(mbox_chan_info->chan, &session->req_mba_msg);
+	trace_cpm_submit_msg(session, req_msg);
+	if (ret < 0) {
+		dev_err(dev, "mbox_send_message failed to send (ret:%d)\n", ret);
+		dev_err(dev, "header: %#x, payload: [%#x, %#x, %#x]\n",
+			req_msg->header, req_msg->payload[0],
+			req_msg->payload[1], req_msg->payload[2]);
+		dev_err(dev, "[mbox_chan] msg_count:%u, msg_free:%u\n",
+			mbox_chan_info->chan->msg_count,
+			mbox_chan_info->chan->msg_free);
+		if (!cpm_is_init_header(req_msg) && cpm_is_request_header(req_msg))
+			cpm_remove_pending_resp(cpm, req_msg);
+		/* Put ref for request channel since submit failed */
+		kref_put(&session->refcount, cpm_session_release);
+
+		return ret;
+	}
+
+	list_rotate_left(&cpm->req_chans);
+
+	return 0;
+}
+
+static int __cpm_send_message(struct cpm_data *cpm,
+			      struct cpm_request *cpm_req,
+			      u32 header, int src_id)
+{
+	unsigned long wait = MAX_SCHEDULE_TIMEOUT;
+	int ret;
+
+	struct cpm_session *session __free(session_put) = kzalloc_obj(*session, GFP_KERNEL);
+	if (!session)
+		return -ENOMEM;
+
+	cpm_req->req_msg->header = header;
+
+	/* Initialize session */
+	kref_init(&session->refcount);
+	init_completion(&session->complete);
+
+	session->req_msg = *cpm_req->req_msg;
+
+	trace_cpm_req_enqueue(session, cpm_req, src_id);
+
+	scoped_guard(spinlock_irqsave, &cpm->lock) {
+		ret = cpm_try_submit(cpm, session);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (cpm_req->tout_ms)
+		wait = msecs_to_jiffies(cpm_req->tout_ms);
+
+	if (wait_for_completion_timeout(&session->complete, wait) == 0) {
+		ret = -ETIMEDOUT;
+		/* Clean up pending response mapping on timeout */
+		scoped_guard(spinlock_irqsave, &cpm->lock)
+			cpm_remove_pending_by_session(cpm, session);
+	} else if (cpm_is_request_msg(cpm_req) && cpm_req->resp_msg) {
+		*cpm_req->resp_msg = session->resp_msg;
+	}
+	trace_cpm_send_message(session, ret);
+
+	return ret;
+}
+
+static bool cpm_iface_is_valid_req(struct cpm_data *cpm,
+				   struct cpm_request *cpm_req)
+{
+	struct device *dev = cpm->dev;
+
+	if (!cpm_req) {
+		dev_err(dev, "cpm_req is NULL\n");
+		return false;
+	}
+
+	if (!cpm_req->req_msg) {
+		dev_err(dev, "cpm_req->req_msg is NULL\n");
+		return false;
+	}
+
+	if (cpm_req->msg_type > RESPONSE_MSG || cpm_req->msg_type < ONEWAY_MSG) {
+		dev_err(dev, "Invalid msg_type: %d\n", cpm_req->msg_type);
+		return false;
+	}
+
+	if (cpm_is_request_msg(cpm_req) && !cpm_req->resp_msg) {
+		dev_err(dev, "cpm_req->resp_msg is NULL when msg_type is REQUEST_MSG\n");
+		return false;
+	}
+
+	if (cpm_is_response_msg(cpm_req)) {
+		if (!goog_mba_q_get_valid(&cpm_req->resp_context)) {
+			dev_err(dev, "Invalid valid bit in resp_context: %#x\n",
+				cpm_req->resp_context);
+			return false;
+		}
+
+		if (!cpm_is_response_header(&cpm_req->resp_context)) {
+			dev_err(dev, "Invalid response type in resp_context: %#x\n",
+				cpm_req->resp_context);
+			return false;
+		}
+	}
+
+	return true;
+}
+
+int cpm_send_message(struct cpm_client *client, struct cpm_request *cpm_req)
+{
+	struct cpm_data *cpm;
+	u32 header;
+
+	if (!client)
+		return -EINVAL;
+
+	cpm = dev_get_drvdata(client->dev->parent);
+	if (!cpm)
+		return -ENODEV;
+
+	if (!cpm_iface_is_valid_req(cpm, cpm_req))
+		return -EINVAL;
+
+	header = cpm_req_get_header(client, cpm_req);
+	if (!header)
+		return -EINVAL;
+
+	return __cpm_send_message(cpm, cpm_req, header, client->src_id);
+}
+EXPORT_SYMBOL_GPL(cpm_send_message);
+
+/**
+ * cpm_req_tx_done - callback function from request channels
+ * @client: Pointer to the mailbox client structure.
+ * @msg: Pointer to the transmitted mailbox message.
+ * @r: Status of the transmission.
+ */
+static void cpm_req_tx_done(struct mbox_client *client, void *msg, int r)
+{
+	struct cpm_session *session;
+
+	if (!msg)
+		return;
+
+	session = container_of(msg, struct cpm_session, req_mba_msg);
+
+	trace_cpm_req_tx_done(session);
+
+	if (cpm_is_oneway_header(&session->req_msg) ||
+	    cpm_is_response_header(&session->req_msg))
+		complete(&session->complete);
+
+	kref_put(&session->refcount, cpm_session_release);
+}
+
+static inline u32 cpm_iface_prepare_resp_context(u32 header)
+{
+	u32 src_id = goog_mba_q_get_dst_id(&header);
+	u32 dst_id = goog_mba_q_get_src_id(&header);
+	u32 token = goog_mba_q_get_token(&header);
+
+	return goog_mba_q_create_hdr(src_id, dst_id, 0, token,
+				     GOOG_MBA_Q_TYPE_RESPONSE);
+}
+
+static void cpm_handle_host_tx(struct cpm_data *cpm, const void *msg)
+{
+	struct device *dev = cpm->dev;
+	const struct cpm_payload *msg_payload = msg;
+	struct cpm_client *client;
+	int dst_id = goog_mba_q_get_dst_id(msg);
+	u32 resp_context = 0;
+
+	if (cpm_is_request_header(msg))
+		resp_context = cpm_iface_prepare_resp_context(msg_payload->header);
+
+	scoped_guard(spinlock_irqsave, &cpm->lock) {
+		client = cpm_search_client_by_id(cpm, dst_id);
+		if (IS_ERR_OR_NULL(client) || !client->host_tx_cb) {
+			dev_err(dev, "No available client callback (id:%d).\n Payload Info:\n",
+				dst_id);
+			print_hex_dump(KERN_ERR, dev_name(dev), DUMP_PREFIX_NONE, 16, 4,
+				       msg_payload, sizeof(*msg_payload), false);
+			return;
+		}
+
+		client->host_tx_cb(resp_context, msg_payload, client->priv);
+	}
+
+	trace_cpm_handle_host_tx(dst_id, resp_context, msg_payload);
+}
+
+/**
+ * cpm_resp_cb - Handles incoming messages on response channels
+ * @mbox_client: Pointer to the mailbox client structure.
+ * @param: Pointer to the received mailbox message (&struct goog_mba_rx_msg).
+ *
+ * This callback is invoked when a message arrives on a response channel. It
+ * handles the following scenarios:
+ *
+ * 1. CPM Response to Client Request: Processes a response from the CPM to a
+ *    previously issued client request.
+ * 2. CPM-Initiated Request: Processes a new request initiated by the CPM and
+ *    dispatches it to the appropriate client handler.
+ * 3. Invalid Message Type: Handles unexpected message types.
+ */
+static void cpm_resp_cb(struct mbox_client *mbox_client, void *param)
+{
+	struct goog_mba_rx_msg *rx_msg = param;
+	const void *msg = rx_msg->payload;
+	struct cpm_mbox_chan_info *chan_info =
+		container_of(mbox_client, struct cpm_mbox_chan_info, client);
+	struct cpm_data *cpm = container_of(chan_info, struct cpm_data, resp_chan);
+	struct device *dev = cpm->dev;
+
+	if (cpm_is_init_header(msg)) {
+		/*
+		 * This is unexpected. If we see this, we may need to initiate
+		 * our own (re)init message -- cpm_init_q_mode().
+		 */
+		dev_err(dev, "Reset message received from the remote\n");
+		return;
+	}
+
+	if (cpm_is_response_header(msg)) {
+		const struct cpm_payload *msg_payload = msg;
+		bool found;
+
+		scoped_guard(spinlock_irqsave, &cpm->lock)
+			found = cpm_remove_pending_resp(cpm, msg_payload);
+		if (!found)
+			dev_err(dev,
+				"No token:%u found for response payload: %#10x %#10x %#10x %#10x\n",
+				goog_mba_q_get_token(&msg_payload->header),
+				msg_payload->header, msg_payload->payload[0],
+				msg_payload->payload[1], msg_payload->payload[2]);
+	} else if (cpm_is_request_header(msg) || cpm_is_oneway_header(msg)) {
+		cpm_handle_host_tx(cpm, msg);
+	} else {
+		dev_err(dev, "Unknown message type: %u\n", goog_mba_q_get_type(msg));
+	}
+}
+
+static void cpm_iface_free_chan_action(void *data)
+{
+	struct cpm_mbox_chan_info *chan = data;
+
+	mbox_free_channel(chan->chan);
+}
+
+static int
+cpm_init_channel(struct cpm_data *cpm,
+		 struct cpm_mbox_chan_info *chan_info,
+		 int idx,
+		 void (*txdone_callback)(struct mbox_client *client, void *msg, int r),
+		 void (*rx_callback)(struct mbox_client *client, void *msg))
+{
+	struct device *dev = cpm->dev;
+	struct mbox_client *client;
+
+	client = &chan_info->client;
+	client->dev = dev;
+	client->rx_callback = rx_callback;
+	client->tx_done = txdone_callback;
+
+	chan_info->chan = mbox_request_channel(client, idx);
+	if (IS_ERR(chan_info->chan))
+		return PTR_ERR(chan_info->chan);
+
+	return devm_add_action_or_reset(dev, cpm_iface_free_chan_action, chan_info);
+}
+
+/**
+ * cpm_init_req_channels - Request all available TX mailbox channels
+ * @cpm: Core driver data.
+ *
+ * The Linux mailbox core only allows a single in-flight message per channel.
+ * To utilize the underlying mailbox controller's hardware queue, the
+ * controller exposes one mailbox channel per hardware queue slot (N channels
+ * total) for the same devicetree node (with #mbox-cells = <0>) and hands out
+ * the next unbound channel on each mbox_request_channel() call. Repeatedly
+ * request MBOX_IDX_REQ until all hardware queue slots have been claimed
+ * (-EBUSY).
+ *
+ * cpm_try_submit() then rotates through @cpm->req_chans round-robin under
+ * @cpm->lock. Because the hardware queue is strictly FIFO, the m-th message is
+ * always assigned to channel (m mod N):
+ * - When fewer than N messages are in flight in hardware, the next channel in
+ *   the rotation is guaranteed to already be idle and submits straight to
+ *   hardware.
+ * - When all N hardware slots are busy, the next channel in the rotation holds
+ *   the oldest in-flight message and will be the first to complete, so
+ *   queuing into that channel's mailbox-core software queue drains messages
+ *   into hardware in FIFO order.
+ *
+ * Return: 0 on success, negative error code on failure.
+ */
+static int cpm_init_req_channels(struct cpm_data *cpm)
+{
+	struct device *dev = cpm->dev;
+	int ret;
+
+	while (true) {
+		struct cpm_mbox_chan_info *chan_info;
+
+		chan_info = devm_kzalloc(dev, sizeof(*chan_info), GFP_KERNEL);
+		if (!chan_info)
+			return -ENOMEM;
+
+		ret = cpm_init_channel(cpm, chan_info, MBOX_IDX_REQ,
+				       cpm_req_tx_done, NULL);
+		if (ret) {
+			devm_kfree(dev, chan_info);
+			if (ret == -EBUSY && !list_empty(&cpm->req_chans))
+				return 0;
+			return dev_err_probe(dev, ret,
+					     "Failed to request TX mailbox channel\n");
+		}
+
+		list_add_tail(&chan_info->entry, &cpm->req_chans);
+	}
+}
+
+static int cpm_init_q_mode_proto(struct cpm_data *cpm)
+{
+	struct cpm_payload msg_payload = {};
+	struct cpm_request req = {
+		.msg_type = ONEWAY_MSG,
+		.req_msg = &msg_payload,
+	};
+
+	return __cpm_send_message(cpm, &req, GOOG_MBA_Q_INIT_PROTO_VAL, 0);
+}
+
+static int cpm_init_q_mode(struct cpm_data *cpm)
+{
+	int ret;
+
+	ret = cpm_init_q_mode_proto(cpm);
+	if (ret < 0)
+		return ret;
+
+	cpm->seq_num = GOOG_MBA_Q_MIN_SEQ_VAL;
+
+	return 0;
+}
+
+static void cpm_adev_release(struct device *dev)
+{
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+
+	of_node_put(dev->of_node);
+	kfree(adev);
+}
+
+static void cpm_unregister_adev_action(void *data)
+{
+	struct auxiliary_device *adev = data;
+
+	auxiliary_device_delete(adev);
+	auxiliary_device_uninit(adev);
+}
+
+static int cpm_register_adev(struct cpm_data *cpm, const char *name)
+{
+	struct auxiliary_device *adev;
+	int ret;
+
+	adev = kzalloc_obj(*adev, GFP_KERNEL);
+	if (!adev)
+		return -ENOMEM;
+
+	adev->name = name;
+	adev->id = 0;
+	adev->dev.parent = cpm->dev;
+	adev->dev.release = cpm_adev_release;
+	device_set_of_node_from_dev(&adev->dev, cpm->dev);
+
+	ret = auxiliary_device_init(adev);
+	if (ret) {
+		of_node_put(adev->dev.of_node);
+		kfree(adev);
+		return ret;
+	}
+
+	ret = auxiliary_device_add(adev);
+	if (ret) {
+		auxiliary_device_uninit(adev);
+		return ret;
+	}
+
+	return devm_add_action_or_reset(cpm->dev, cpm_unregister_adev_action, adev);
+}
+
+static const char * const cpm_adev_names[] = {
+	"reset",
+	"power-controller",
+	"clk",
+	"irq",
+};
+
+static int cpm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cpm_data *cpm;
+	int ret;
+
+	cpm = devm_kzalloc(dev, sizeof(*cpm), GFP_KERNEL);
+	if (!cpm)
+		return -ENOMEM;
+
+	cpm->dev = dev;
+	platform_set_drvdata(pdev, cpm);
+
+	spin_lock_init(&cpm->lock);
+	INIT_LIST_HEAD(&cpm->client_list_head);
+	INIT_LIST_HEAD(&cpm->req_chans);
+
+	ret = cpm_init_req_channels(cpm);
+	if (ret)
+		return ret;
+
+	ret = cpm_init_channel(cpm, &cpm->resp_chan, MBOX_IDX_RESP,
+			       NULL, cpm_resp_cb);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to request RX mailbox channel\n");
+
+	ret = cpm_init_q_mode(cpm);
+	if (ret < 0)
+		return ret;
+
+	for (int i = 0; i < ARRAY_SIZE(cpm_adev_names); i++) {
+		ret = cpm_register_adev(cpm, cpm_adev_names[i]);
+		if (ret) {
+			dev_err(dev, "failed to register %s auxiliary device: %d\n",
+				cpm_adev_names[i], ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static struct platform_driver cpm_driver = {
+	.probe = cpm_probe,
+	.driver = {
+		.name = "google-cpm-mba",
+		.of_match_table = cpm_of_match_table,
+	},
+};
+
+module_platform_driver(cpm_driver);
+
+MODULE_DESCRIPTION("Google MBA CPM interface");
+MODULE_AUTHOR("Lucas Wei <lucaswei@google.com>");
+MODULE_LICENSE("GPL");
diff --git a/drivers/soc/google/google-cpm-mba.h b/drivers/soc/google/google-cpm-mba.h
new file mode 100644
index 000000000000..425fe3171085
--- /dev/null
+++ b/drivers/soc/google/google-cpm-mba.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#ifndef _GOOGLE_CPM_MBA_PRIV_H_
+#define _GOOGLE_CPM_MBA_PRIV_H_
+
+#include <linux/device.h>
+#include <linux/list.h>
+#include <linux/types.h>
+#include <soc/google/google-cpm-mba.h>
+
+/**
+ * struct cpm_client - Represents a registered CPM interface client
+ * @dev: The client's associated device.
+ * @src_id: The client's source ID within the CPM system.
+ * @host_tx_cb: Callback function invoked for CPM-initiated transactions.
+ * @entry: Internal field for managing the list of active clients.
+ * @priv: Client-specific data passed to the @host_tx_cb callback.
+ */
+struct cpm_client {
+	struct device *dev;
+	int src_id;
+	cpm_cb_t host_tx_cb;
+	struct list_head entry;
+	void *priv;
+};
+
+#endif /* _GOOGLE_CPM_MBA_PRIV_H_ */
diff --git a/include/soc/google/goog_cpm_service_ids.h b/include/soc/google/goog_cpm_service_ids.h
new file mode 100644
index 000000000000..c28766fe6ba8
--- /dev/null
+++ b/include/soc/google/goog_cpm_service_ids.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2022-2026 Google LLC
+ */
+
+#ifndef __GOOG_CPM_SERVICE_ID_H
+#define __GOOG_CPM_SERVICE_ID_H
+
+enum apc_common_mba_service_id {
+	APC_COMMON_SERVICE_FIRST		= 0x0,
+	APC_COMMON_SERVICE_ID_RESERVED		= 0x0,
+	APC_COMMON_SERVICE_ID_PING		= 0x1,
+	APC_COMMON_SERVICE_ID_CPMLOG		= 0x2,
+	APC_COMMON_SERVICE_ID_GMC		= 0x3,
+	APC_COMMON_SERVICE_ID_GSLC		= 0x4,
+	APC_COMMON_SERVICE_ID_CPM_TRACEPOINT	= 0x5,
+	APC_COMMON_SERVICE_ID_PF_STATE_CPM	= 0x6,
+	APC_COMMON_SERVICE_ID_POWER_CONTROLLER	= 0x7,
+	APC_COMMON_SERVICE_ID_MIPM		= 0x8,
+	APC_COMMON_SERVICE_LAST			= 0x37,
+};
+
+#define MBA_COMMON_MIN_SERVICE_ID		0x38
+#define MBA_COMMON_MAX_SERVICE_ID		0x70
+
+enum cpm_common_mba_service_id {
+	CPM_COMMON_SERVICE_FIRST		= 0x0,
+	/* Test service */
+	CPM_COMMON_PING_SERVICE			= 0x0,
+	/* Used for extracting logs */
+	CPM_AP_COMMON_LOG_SERVICE		= 0x1,
+	/* Interact with tracepoint library */
+	CPM_AP_COMMON_TRACEPOINT_SERVICE	= 0x2,
+	/* Control GSLC CPM functions */
+	CPM_AP_COMMON_GSLC_MB_SERVICE		= 0x3,
+	/* Control GMCCPM functions */
+	CPM_AP_COMMON_GMC_MB_SERVICE		= 0x4,
+	/* Control LPB peripheral */
+	CPM_COMMON_LPB_SERVICE			= 0x5,
+	/* System reset service */
+	CPM_COMMON_RESET_SERVICE		= 0x6,
+	/* ODPM API service for AP */
+	CPM_AP_COMMON_ODPM_MB_SERVICE		= 0x7,
+	/* LPCM service. */
+	CPM_COMMON_LPCM_SERVICE			= 0x8,
+	/* Control and modify SoC power states */
+	CPM_COMMON_POWER_STATE_SERVICE		= 0x9,
+	/* PMIC related services */
+	CPM_COMMON_PMIC_SERVICE			= 0xA,
+	/* MIPM interface */
+	CPM_COMMON_MIPM_SERVICE			= 0xB,
+	/* Thermal services - emul temps, loops, config, etc */
+	CPM_COMMON_THERMAL_SERVICE		= 0xC,
+	/* Pull PIF history status over LMF. */
+	CPM_COMMON_PIF_HISTORY_SERVICE		= 0xD,
+	/* Pwrblk/SSWRP based service */
+	CPM_COMMON_PWRBLK_SERVICE		= 0xE,
+	/* CPM command line service */
+	CPM_COMMON_COMMAND_LINE_SERVICE		= 0xF,
+	/* GDMC->CPM special message */
+	CPM_GDMC_PMIC_SERVICE			= 0x10,
+	/* SMMU initial register configuration service */
+	CPM_SMMU_SERVICE			= 0x11,
+	/* BCL service */
+	CPM_COMMON_BCL_SERVICE			= 0x12,
+	CPM_COMMON_THERMAL_V2_SERVICE		= 0x15,
+	/* Pixel firmware tracepoint service */
+	CPM_COMMON_FWTP_SERVICE			= 0x17,
+	CPM_COMMON_SERVICE_LAST			= 0x37,
+};
+
+enum cpm_ap_ns_mba_service_id {
+	CPM_AP_NS_MAILBOX_SERVICE_LAST		= 0x38,
+	CPM_AP_NS_SSRAM_SERVICE			= 0x66,
+	CPM_AP_NS_SPMI_SERVICE			= 0x67,
+	CPM_AP_NS_POWER_DASH_MB_SERVICE		= 0x68,
+	CPM_AP_NS_ODPM_MB_SERVICE		= 0x69,
+	CPM_AP_NS_IRQ_SERVICE			= 0x6E,
+	/* Control latency library CPM functions */
+	CPM_AP_NS_LTC_MB_SERVICE		= 0x70,
+	CPM_AP_NS_MAILBOX_SERVICE_FIRST		= 0x70,
+};
+
+#endif /* __GOOG_CPM_SERVICE_ID_H */
diff --git a/include/soc/google/google-cpm-mba.h b/include/soc/google/google-cpm-mba.h
new file mode 100644
index 000000000000..16789f71a624
--- /dev/null
+++ b/include/soc/google/google-cpm-mba.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023-2026 Google LLC
+ */
+
+#ifndef _GOOGLE_CPM_MBA_H_
+#define _GOOGLE_CPM_MBA_H_
+
+#include <linux/types.h>
+
+struct cpm_client;
+
+/**
+ * enum cpm_msg_type - Specifies the type of message for CPM interface transactions
+ * @ONEWAY_MSG:   A one-way message that does not expect a response. The @resp_msg
+ *                field in &struct cpm_request is ignored.
+ * @REQUEST_MSG:  A request message that expects a response.
+ * @RESPONSE_MSG: A response message to a previous request.
+ */
+enum cpm_msg_type {
+	ONEWAY_MSG,
+	REQUEST_MSG,
+	RESPONSE_MSG,
+};
+
+#define GOOG_MBA_PAYLOAD_SIZE 3
+
+/**
+ * struct cpm_payload - Represents a payload for CPM messages
+ * @header:  A header containing message metadata (e.g., type, destination).
+ *           Client shouldn't fill the header.
+ * @payload: An array of 32-bit words representing the actual payload data.
+ */
+struct cpm_payload {
+	u32 header;
+	u32 payload[GOOG_MBA_PAYLOAD_SIZE];
+};
+
+/**
+ * struct cpm_request - Represents a request within the CPM interface
+ * @msg_type:     Specifies the message type (see &enum cpm_msg_type).
+ * @req_msg:      The request message payload.
+ * @resp_msg:     Buffer to receive a response (effective when @msg_type is REQUEST_MSG).
+ * @dst_id:       Destination service ID within the CPM host.
+ * @tout_ms:      Request timeout in milliseconds (0 indicates no timeout).
+ * @resp_context: Context for responding to CPM-initiated messages (used when
+ *                @msg_type is RESPONSE_MSG).
+ */
+struct cpm_request {
+	enum cpm_msg_type msg_type;
+	struct cpm_payload *req_msg;
+	struct cpm_payload *resp_msg;
+	int dst_id;
+	unsigned long tout_ms;
+	u32 resp_context;
+};
+
+/**
+ * typedef cpm_cb_t - Callback invoked for CPM-initiated transactions
+ * @context:   Context value provided by the CPM host.
+ *             0 for oneway request, otherwise client need to respond.
+ * @msg:       Pointer to the message payload received from the CPM host.
+ * @priv:      Client's private data (registered via cpm_request_client()).
+ *
+ * A client may register a callback while calling cpm_request_client(). Clients
+ * will be notified for CPM initiated request that match their src_id. @context
+ * indicates whether clients need to respond to CPM's request: ONEWAY_MSG for
+ * one-way requests from CPM; otherwise, clients needs to respond with msg_type
+ * assigned to RESPONSE_MSG.
+ *
+ * Callbacks may be called in an atomic context.
+ */
+typedef void (*cpm_cb_t)(u32 context, const struct cpm_payload *msg, void *priv);
+
+/**
+ * cpm_request_client() - Registers a client with the CPM interface
+ * @dev:       Client's device structure.
+ * @src_id:    Client's service ID for identification by CPM (optional).
+ *             Register client's service ID (1 to 255)
+ *             with callback in @cpm_cb to handle CPM initiated request.
+ *             Otherwise, specify 0.
+ * @cpm_cb:    Callback function invoked for CPM-initiated requests (optional).
+ * @priv:      Private data passed to the callback function (optional).
+ *
+ * This function initializes a CPM interface handle for the client, allowing the
+ * client to interact with the CPM. The handle encapsulates client-specific
+ * information for use by the CPM interface.
+ *
+ * Requirements:
+ *  * The client device must be an auxiliary_device child of the CPM device.
+ *  * Call cpm_free_client() when the handle is no longer needed, or just use
+ *    the devm_* variant.
+ *
+ * Return: A &struct cpm_client handle on success, or an ERR_PTR() on failure.
+ *         -ENODEV: invalid device structure (see details in kernel log).
+ *         -EBUSY: client has registered with the same @src_id.
+ *         -EINVAL: client bind to wrong phandle that CPM interface don't support.
+ *         -ENOMEM: memory allocation failed.
+ */
+struct cpm_client *cpm_request_client(struct device *dev,
+				      int src_id,
+				      cpm_cb_t cpm_cb,
+				      void *priv);
+
+/**
+ * devm_cpm_request_client() - Managed version of cpm_request_client()
+ * @dev:       Client's device structure.
+ * @src_id:    Client's service ID for identification by CPM (optional).
+ * @cpm_cb:    Callback function invoked for CPM-initiated requests (optional).
+ * @priv:  Private data passed to the callback function (optional).
+ *
+ * Return: A &struct cpm_client handle on success, or an ERR_PTR() on failure.
+ *         See cpm_request_client() for details.
+ */
+struct cpm_client *devm_cpm_request_client(struct device *dev,
+					   int src_id,
+					   cpm_cb_t cpm_cb,
+					   void *priv);
+
+/**
+ * cpm_free_client() - Free resources and refcount from CPM interface device
+ * @client: Handle of &struct cpm_client used for CPM message operations.
+ */
+void cpm_free_client(struct cpm_client *client);
+
+/**
+ * cpm_send_message() - Send a payload to CPM host
+ * @client:      Client handle obtained from cpm_request_client().
+ * @cpm_req:     Request structure containing message parameters.
+ *
+ * This function enables clients to transmit messages to the CPM host. It handles
+ * the following scenarios:
+ *
+ * * **One-way Messages:**        Returns after Tx done or timeout.
+ * * **Request Messages:**        Returns after receiving a response or timeout.
+ * * **CPM-Initiated Responses:** Transmits a response using the provided `resp_context`.
+ *
+ * Important Notes:
+ * * The first word of the request payload is used by the transport layer.
+ * * For request messages, the `resp_msg` field will hold the CPM host's response.
+ * * Do not call this function from atomic contexts due to potential blocking.
+ *
+ * Return: 0 on success; negative error code on failure.
+ */
+int cpm_send_message(struct cpm_client *client, struct cpm_request *cpm_req);
+
+#endif /* _GOOGLE_CPM_MBA_H_ */
-- 
2.56.0.307.g5fe7bd680c-goog

