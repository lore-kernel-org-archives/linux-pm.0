Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795565189;
	b=XljxPQ8DhwDm57/+EVZCqUpoTMASVJswnnDxa42JIqNeET5oJ0j+vAHwEl7SCdOJW+kZ
	 DkN79H4unW+Pi+MWwpqYvjeEtlJ1d1J6u/E1d59loD2G7I3z6NuZZBCWQRb70yK1EuGyn
	 1X+DHrEZfjw0tqCrTIHfDfLo11FQkNw17ffUWAjvvU25EBrAcV9lQWlLWsD1JsLr1fvA6
	 fmTkQDs1QCpzz2s9MNWLv9QNmUKKUGqmugA4D91noSfa43w/bWC5wZ7UEx3t3LdVh5Lyr
	 XfbP4oriwe65f32kV+HGmvposL6CbL5T/XK1VChwxSB8A4ICcV/t5ypPIP/8osqiaUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795565189;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uHqHxoS2B26QlIZ8Qrv4axQmf6K/tTOTwQOcwu191tM=;
	b=NyhhLQufobmrN1J83hxTjO9ZZrgsiQ5PdW5ONFbGMswqLLQYATeP88VjYbTrGl29e4Ov
	 1aynx2l8O8I57icBXBEQSc3nfSvYbrLfVP2gsNmKwXJIZEDBiM86MKz79LFozqgTLZr0R
	 2KMHQGMvh8DgW/7rqq2Pw1S+T1UgCwkr7jdnzsXqxJ6HYJYypDjk+ZQ54LI7zGP4Qt9Wf
	 LMEU+c5O7Axp19WWRNd9K85ICrJWJeVNxAozrYoYjtCNPXk/YTgxbYSKkord5rkcD3RJz
	 sdxxveEYfOPrRE+tC6vK1m8ScdVn4KP7/E1PXcyqi1adTA6V3BQyAJIA2vQKl/IIlEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ATQpYPLk;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24041606A681
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 00:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24041606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=ATQpYPLk
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-386ab9ab619so5828239eec.1
        for <linux-pm@vger.kernel.org>; Tue, 24 Nov 2026 16:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795565187; x=1796169987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uHqHxoS2B26QlIZ8Qrv4axQmf6K/tTOTwQOcwu191tM=;
        b=ATQpYPLk+S86kW1KOrkyz/4/DXNt9rbq5uC+IB92fJMO2x0d628sJVNXhvRJUszvdS
         ddh9kRl9N5bADuRdUruowaKLmsEoc1ZkS2Z3h+XLs8+8IZPtPbvDiXOVw5ynUhDJ1h/K
         QG54yftDW/Rz3a3ts04J5u5kEzc/bqLYcIa9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795565187; x=1796169987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uHqHxoS2B26QlIZ8Qrv4axQmf6K/tTOTwQOcwu191tM=;
        b=Hwx1EbQ1ppxdJvS2CftKto5+iBL7lA8KXzmUmjyfYEyVGY4v1bnKr/utZFM8tDgn1Z
         s/xkdWMTeHCHUlw9f3ifmlcydJ4Cg5cgNXOqU97jksREBJ/01U8cqSN5JDFclSzjgjnP
         dp0Kq2m1fez7nR4GZrsC6lCwyINJqwnTNP3/Y0I7Qtnd05tbQ6j0DRjVlBL+jRtk2DME
         oShrI4ccMjggtu2iPIxHKapeE+6nrCzySs0IXoa9JGNUxQlPeI06pqtKeEq4tsMpPEKk
         IRoo9Q6rld+2LRxJSuF75tkJNbkKumdP0E+2GvoUkoYEysVtLse6UVXtJb66kgQX1VaO
         rF5Q==
X-Forwarded-Encrypted: i=1; AL+hErGGEQFbLUp975QyOn82fh7j5+qofVqyPxDAKidz5uRkatMrQlnibHxdF8CHEcz4+QuVtkdlR8a9cA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+hzAVk3asX67rxEAISVViUeo+MAmyM16hXfeHBzFS4CIJjWzqU
	GmLPLclLrF714Q+g8YuAyiAqMyyX/LbZQ30Ir+HllgHKsULyD7U+hCb2UVwFwbPJfw==
X-Gm-Gg: AZFdTZfB6zmb2Y6q5O9GcqtlOSzneUqAoleOGqd3XI7/KA1DC5zpcrZjHwi1saLA7YZ
	nFy4GNDU55c4HAbIlkisM7BGef62zfcdmWFm4B2c2vHc+qL4tY/YUmuuoFGM7hrdIcICJWeGg1c
	MHFqLXV2rIIGOear9CEVCUY4z9vqzL0tmy54kL425HiFKbGoU4Fh+Lx7z0HTFQYPdiVkdjFMzRP
	l2uP6A9Qf/5m4OicQK9Cpb6ndlBP8JoDMxALdZaDj+dhixJp0x1ZononZn9e1W0fvHFkm3LoBYn
	tOlMITktGC6SUIhXoYElc2HrSDyCwkeBGvW7hHXrXePlHJxN8gcFSGLiwLKGAdstnRYyliYGlSE
	LFZA3pEhymiIgquImdN9wZW6D5MBW2cmBzSxEGCWH8GQJZCxyKFqXR1jz++oEPn6MMHffWt+YBa
	Ddn0Hyky72gFJYg1p6H3e4avLtUG6AhWyxAvGM6jxPUaDxeUpImCKPF38if7NL4C2zgAS8rtsQO
	UyXx4qhvZqg54CJyAFEFeLnU0sDU8wf4UHserGyniTnLaUrwZ5+qoBtNo3pk3ECKGbAp0wBaSjL
	VOXlS8r1UEAlJfVAfABsjM8nb7BDMijgR/D9OPi8jQYIiF2vZNQpy4y2fATuTAorPyntH0k+WLf
	Yr47//NBriUzApw==
X-Received: by 2002:a05:693c:88d0:10b0:386:b894:f6dc with SMTP id 5a478bee46e88-386b894f8c8mr6151351eec.2.1795565186668;
        Tue, 24 Nov 2026 16:06:26 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ea9b:d8a3:ba44:2d0a])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-386c7c62a91sm6351052eec.17.2026.11.24.16.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 16:06:26 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Radu Rendec <radu@rendec.net>,
	=?UTF-8?q?Jakub=20G=C5=82owacki?= <jglow@google.com>,
	linux-clk@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Mariano Marciello <mmarciello@google.com>,
	google-soc@lists.linux.dev,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 2/9] soc: google: Add CPM over MailBox Array driver
Date: Tue, 24 Nov 2026 16:03:36 -0800
Message-ID: <20261124160343.v2.2.I7bc547c83b7bf677a62670099f481a91ac737073@changeid>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261125000349.3385325-1-briannorris@chromium.org>
References: <20261125000349.3385325-1-briannorris@chromium.org>
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

From: Lucas Wei <lucaswei@google.com>

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
auxiliary_bus devices to handle each service. It also provides API
wrappers around the mailbox protocol, so clients don't have to worry
about most of the details. This API assumes all users are children of
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

 * Drop RESPONSE_MSG; this is entirely unused on the Application
   Processor side, and simply adds complexity and dead code.

 * Separate transmit-only client handling from receive-support APIs.
   Most clients only need a stateless handle for transmission; it
   provides better clarity to keep these separate.

Signed-off-by: Lucas Wei <lucaswei@google.com>
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

Changes in v2:
 * Move more protocol details from client drivers (reset, clock,
   pmdomain) into core CPM driver
 * Simplify to a thin 'cpm_handle' for transmit-only clients
 * Support separate API to register a receive-enabled client
 * Update author/SoB to retain downstream heritage
 * Add initialization timeout

 drivers/soc/Kconfig                       |   1 +
 drivers/soc/Makefile                      |   1 +
 drivers/soc/google/Kconfig                |  13 +
 drivers/soc/google/Makefile               |   3 +
 drivers/soc/google/google-cpm-mba-trace.h | 163 ++++
 drivers/soc/google/google-cpm-mba.c       | 956 ++++++++++++++++++++++
 include/soc/google/cpm-service-ids.h      |  84 ++
 include/soc/google/google-cpm-mba.h       | 168 ++++
 include/soc/google/lga-lpcm-ids.h         |  54 ++
 9 files changed, 1443 insertions(+)
 create mode 100644 drivers/soc/google/Kconfig
 create mode 100644 drivers/soc/google/Makefile
 create mode 100644 drivers/soc/google/google-cpm-mba-trace.h
 create mode 100644 drivers/soc/google/google-cpm-mba.c
 create mode 100644 include/soc/google/cpm-service-ids.h
 create mode 100644 include/soc/google/google-cpm-mba.h
 create mode 100644 include/soc/google/lga-lpcm-ids.h

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
index 000000000000..0e643d2894be
--- /dev/null
+++ b/drivers/soc/google/google-cpm-mba-trace.h
@@ -0,0 +1,163 @@
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
+#include <linux/string.h>
+#include <linux/tracepoint.h>
+#include <linux/types.h>
+#include <soc/google/google-cpm-mba.h>
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
+	cpm_req_enqueue,
+
+	TP_PROTO(struct cpm_session *session, const struct cpm_request *req),
+
+	TP_ARGS(session, req),
+
+	TP_STRUCT__entry(
+		__field(void *, session)
+		__field(unsigned long, tout_ms)
+		__field(u8, src_id)
+	),
+
+	TP_fast_assign(
+		__entry->tout_ms = req->tout_ms;
+		__entry->session = session;
+		__entry->src_id = req->src_id;
+	),
+
+	TP_printk("session=%p src_id=%u tout_ms=%lu",
+		  __entry->session, __entry->src_id, __entry->tout_ms)
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
+	TP_PROTO(u8 dst_id, const struct cpm_payload *payload),
+
+	TP_ARGS(dst_id, payload),
+
+	TP_STRUCT__entry(
+		__field(u8, dst_id)
+		__field(u32, header)
+		__array(u32, payloads, GOOG_MBA_PAYLOAD_SIZE)
+	),
+
+	TP_fast_assign(
+		__entry->dst_id = dst_id;
+		cpm_trace_clone_payload(&__entry->header, __entry->payloads, payload);
+	),
+
+	TP_printk("dst_id=%u: %#010x %#010x %#010x %#010x",
+		  __entry->dst_id, __entry->header, __entry->payloads[0],
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
index 000000000000..432f0da0cd99
--- /dev/null
+++ b/drivers/soc/google/google-cpm-mba.c
@@ -0,0 +1,956 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Google MailBox Array (MBA) CPM Interface
+ *
+ * Copyright 2023-2026 Google LLC
+ */
+
+#include <linux/array_size.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
+#include <linux/export.h>
+#include <linux/gfp_types.h>
+#include <linux/jiffies.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/lockdep.h>
+#include <linux/mailbox/goog-mba-message.h>
+#include <linux/mailbox_client.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <soc/google/cpm-service-ids.h>
+#include <soc/google/google-cpm-mba.h>
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
+#define CPM_SEND_TIMEOUT_MS		3000
+
+/* CPM_COMMON_LPCM_SERVICE */
+#define LPCM_OP_ID_MASK			GENMASK(31, 24)
+#define LPCM_OBJ_ID_MASK		GENMASK(23, 16)
+#define LPCM_ID_MASK			GENMASK(15, 8)
+#define LPCM_REQ_ID_MASK		GENMASK(7, 0)
+
+#define LK_NO_ERROR			0
+#define LK_ERR_GENERIC			(-1)
+#define LK_ERR_UNAVAILABLE		(-3)
+#define LK_ERR_INVALID_ARGS		(-8)
+#define LK_ERR_TIMED_OUT		(-13)
+#define LK_ERR_NOT_SUPPORTED		(-24)
+
+/* CPM_COMMON_LPB_SERVICE */
+#define CPM_COMMON_PROT_NO_ERR		0xf
+
+static inline u32 goog_mba_q_get_dst_id(const u32 *msg)
+{
+	return FIELD_GET(GOOG_MBA_Q_DST_ID_MASK, *msg);
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
+static inline u32 goog_mba_q_create_hdr(u8 src_id, u8 dst_id, u8 seq, u8 token, u8 type)
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
+struct cpm_rx_client {
+	struct cpm_handle *cpm;
+	u8 src_id;
+	cpm_rx_cb_t cb;
+	void *priv;
+	struct list_head entry;
+};
+
+/**
+ * struct cpm_handle - Core handle and state for the CPM interface
+ * @dev: The device structure associated with this CPM interface.
+ * @rx_clients: List of registered RX callback clients.
+ * @lock: Spinlock for protecting critical sections.
+ * @seq_num: Sequence number for debugging.
+ * @resp_pending: Array for sessions awaiting responses from the CPM host.
+ * @req_chans: Circular list of request mailbox channels (rotated round-robin).
+ * @resp_chan: Response mailbox channel.
+ */
+struct cpm_handle {
+	struct device *dev;
+	struct list_head rx_clients;
+
+	/*
+	 * Protect queue operations including rx_clients, token, resp_pending,
+	 * req_chans, and resp_chan.
+	 */
+	spinlock_t lock;
+	int seq_num;
+	struct cpm_session *resp_pending[GOOG_MBA_Q_MAX_TOKEN_VAL];
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
+static int cpm_add_pending_resp(struct cpm_handle *cpm, struct cpm_session *session)
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
+			return 0;
+		}
+	}
+
+	dev_err_ratelimited(dev, "Failed to find available entries in resp_pending (header=%#010x)\n",
+			    session->req_msg.header);
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
+cpm_remove_pending_resp(struct cpm_handle *cpm,
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
+cpm_remove_pending_by_session(struct cpm_handle *cpm,
+			      struct cpm_session *session)
+{
+	int token;
+
+	lockdep_assert_held(&cpm->lock);
+
+	for (token = 0; token < GOOG_MBA_Q_MAX_TOKEN_VAL; token++) {
+		if (cpm->resp_pending[token] == session) {
+			cpm->resp_pending[token] = NULL;
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
+static inline void cpm_set_seq_number(struct cpm_handle *cpm,
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
+static struct cpm_rx_client *
+cpm_search_rx_client(struct cpm_handle *cpm, u8 src_id)
+{
+	struct cpm_rx_client *rx_client;
+
+	list_for_each_entry(rx_client, &cpm->rx_clients, entry) {
+		if (rx_client->src_id == src_id)
+			return rx_client;
+	}
+
+	return NULL;
+}
+
+static void cpm_put_dev(void *data)
+{
+	struct device *cpm_dev = data;
+
+	put_device(cpm_dev);
+}
+
+struct cpm_handle *devm_cpm_get_handle(struct device *dev)
+{
+	struct device *cpm_dev = dev->parent;
+	struct cpm_handle *cpm;
+	int ret;
+
+	if (!cpm_dev ||
+	    WARN_ON(!of_match_node(cpm_of_match_table, cpm_dev->of_node))) {
+		dev_err(dev, "Parent device is not CPM: %s\n",
+			cpm_dev ? dev_name(cpm_dev) : "(none)");
+		return ERR_PTR(-EINVAL);
+	}
+
+	cpm = dev_get_drvdata(cpm_dev);
+	if (WARN_ON(!cpm))
+		return ERR_PTR(-ENODEV);
+
+	get_device(cpm_dev);
+	ret = devm_add_action_or_reset(dev, cpm_put_dev, cpm_dev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return cpm;
+}
+EXPORT_SYMBOL_GPL(devm_cpm_get_handle);
+
+static void cpm_unregister_rx_callback(void *data)
+{
+	struct cpm_rx_client *rx_client = data;
+	struct cpm_handle *cpm = rx_client->cpm;
+
+	scoped_guard(spinlock_irqsave, &cpm->lock)
+		list_del(&rx_client->entry);
+
+	kfree(rx_client);
+}
+
+int devm_cpm_register_rx_callback(struct device *dev,
+				  struct cpm_handle *handle, u8 src_id,
+				  cpm_rx_cb_t cb, void *priv)
+{
+	struct cpm_rx_client *rx_client;
+
+	if (!src_id || !cb)
+		return -EINVAL;
+
+	rx_client = kzalloc_obj(*rx_client, GFP_KERNEL);
+	if (!rx_client)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&rx_client->entry);
+	rx_client->cpm = handle;
+	rx_client->src_id = src_id;
+	rx_client->cb = cb;
+	rx_client->priv = priv;
+
+	scoped_guard(spinlock_irqsave, &handle->lock) {
+		if (cpm_search_rx_client(handle, src_id)) {
+			kfree(rx_client);
+			return -EBUSY;
+		}
+
+		list_add(&rx_client->entry, &handle->rx_clients);
+	}
+
+	return devm_add_action_or_reset(dev, cpm_unregister_rx_callback,
+					rx_client);
+}
+EXPORT_SYMBOL_GPL(devm_cpm_register_rx_callback);
+
+static u32 cpm_req_get_header(const struct cpm_request *cpm_req)
+{
+	if (cpm_is_oneway_msg(cpm_req))
+		return goog_mba_q_create_hdr(cpm_req->src_id, cpm_req->dst_id,
+					     0, 0, GOOG_MBA_Q_TYPE_ONEWAY);
+	if (cpm_is_request_msg(cpm_req))
+		return goog_mba_q_create_hdr(cpm_req->src_id, cpm_req->dst_id,
+					     0, 0, GOOG_MBA_Q_TYPE_REQUEST);
+
+	return 0;
+}
+
+static int cpm_try_submit(struct cpm_handle *cpm, struct cpm_session *session)
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
+	if (ret < 0) {
+		dev_err_ratelimited(dev,
+				    "Failed to send mailbox message (header=%#010x, payload=[%#010x, %#010x, %#010x]): %d\n",
+				    req_msg->header, req_msg->payload[0],
+				    req_msg->payload[1], req_msg->payload[2],
+				    ret);
+		if (!cpm_is_init_header(req_msg) && cpm_is_request_header(req_msg))
+			cpm_remove_pending_resp(cpm, req_msg);
+		/* Put ref for request channel since submit failed */
+		kref_put(&session->refcount, cpm_session_release);
+
+		return ret;
+	}
+
+	trace_cpm_submit_msg(session, req_msg);
+	list_rotate_left(&cpm->req_chans);
+
+	return 0;
+}
+
+static int __cpm_send_message(struct cpm_handle *cpm,
+			      struct cpm_request *cpm_req,
+			      u32 header)
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
+	trace_cpm_req_enqueue(session, cpm_req);
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
+static bool cpm_iface_is_valid_req(struct cpm_handle *cpm,
+				   const struct cpm_request *cpm_req)
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
+	if (cpm_req->msg_type != ONEWAY_MSG &&
+	    cpm_req->msg_type != REQUEST_MSG) {
+		dev_err(dev, "Invalid msg_type: %d\n", cpm_req->msg_type);
+		return false;
+	}
+
+	if (cpm_is_request_msg(cpm_req) && !cpm_req->resp_msg) {
+		dev_err(dev, "cpm_req->resp_msg is NULL when msg_type is REQUEST_MSG\n");
+		return false;
+	}
+
+	return true;
+}
+
+int cpm_send_message(struct cpm_handle *handle, struct cpm_request *cpm_req)
+{
+	u32 header;
+
+	if (!cpm_iface_is_valid_req(handle, cpm_req))
+		return -EINVAL;
+
+	header = cpm_req_get_header(cpm_req);
+	if (!header)
+		return -EINVAL;
+
+	return __cpm_send_message(handle, cpm_req, header);
+}
+EXPORT_SYMBOL_GPL(cpm_send_message);
+
+/* Translate Little Kernel error codes to Linux errno */
+static int cpm_lk_error_to_errno(int err)
+{
+	switch (err) {
+	case LK_NO_ERROR:
+		return 0;
+	case LK_ERR_GENERIC:
+		return -EREMOTEIO;
+	case LK_ERR_UNAVAILABLE:
+		return -ENODATA;
+	case LK_ERR_INVALID_ARGS:
+		return -EINVAL;
+	case LK_ERR_TIMED_OUT:
+		return -ETIMEDOUT;
+	case LK_ERR_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+	default:
+		return -EPROTO;
+	}
+}
+
+int cpm_send_lpcm_message(struct cpm_handle *handle,
+			  const struct cpm_lpcm_message *msg)
+{
+	struct device *dev = handle->dev;
+	struct cpm_payload resp_msg;
+	struct cpm_payload req_msg = {};
+	struct cpm_request cpm_req = {
+		.msg_type = REQUEST_MSG,
+		.req_msg = &req_msg,
+		.resp_msg = &resp_msg,
+		.dst_id = CPM_COMMON_LPCM_SERVICE,
+		.tout_ms = CPM_SEND_TIMEOUT_MS,
+	};
+	s32 result;
+	int ret;
+
+	req_msg.payload[0] = FIELD_PREP(LPCM_REQ_ID_MASK, msg->cmd) |
+			     FIELD_PREP(LPCM_ID_MASK, msg->lpcm_id) |
+			     FIELD_PREP(LPCM_OBJ_ID_MASK, msg->obj_id) |
+			     FIELD_PREP(LPCM_OP_ID_MASK, msg->opcode);
+	req_msg.payload[1] = msg->payload;
+
+	dev_dbg(dev, "lpcm_id %u, obj_id %u, cmd %u, opcode %u: send mba mail: [%#010x, %#010x, %#010x]\n",
+		msg->lpcm_id, msg->obj_id, msg->cmd, msg->opcode,
+		req_msg.payload[0], req_msg.payload[1], req_msg.payload[2]);
+
+	ret = cpm_send_message(handle, &cpm_req);
+	if (ret < 0) {
+		dev_err(dev, "lpcm_id %u, obj_id %u: failed to send request to CPM, ret=%d\n",
+			msg->lpcm_id, msg->obj_id, ret);
+		return ret;
+	}
+
+	result = resp_msg.payload[0];
+	if (result < 0) {
+		ret = cpm_lk_error_to_errno(result);
+		dev_err(dev, "lpcm_id %u, obj_id %u: error response from CPM: %pe\n",
+			msg->lpcm_id, msg->obj_id, ERR_PTR(ret));
+		return ret;
+	}
+
+	dev_dbg(dev, "got resp from %u, data %d\n", cpm_req.dst_id, result);
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(cpm_send_lpcm_message);
+
+int cpm_send_lpb_message(struct cpm_handle *handle,
+			 const struct cpm_lpb_message *msg)
+{
+	struct device *dev = handle->dev;
+	struct cpm_payload resp_msg;
+	struct cpm_payload req_msg = {};
+	struct cpm_request cpm_req = {
+		.msg_type = REQUEST_MSG,
+		.req_msg = &req_msg,
+		.resp_msg = &resp_msg,
+		.src_id = APC_COMMON_SERVICE_ID_POWER_CONTROLLER,
+		.dst_id = CPM_COMMON_LPB_SERVICE,
+		.tout_ms = CPM_SEND_TIMEOUT_MS,
+	};
+	s32 status;
+	int ret;
+
+	req_msg.payload[0] = msg->cmd;
+	req_msg.payload[1] = msg->sswrp_id;
+	req_msg.payload[2] = msg->data;
+
+	dev_dbg(dev, "LPB cmd %u, sswrp_id %u: send mba mail: [%#010x, %#010x, %#010x]\n",
+		msg->cmd, msg->sswrp_id, req_msg.payload[0],
+		req_msg.payload[1], req_msg.payload[2]);
+
+	ret = cpm_send_message(handle, &cpm_req);
+	if (ret < 0) {
+		dev_err(dev, "LPB cmd %u, sswrp_id %u: failed to send request to CPM, ret=%d\n",
+			msg->cmd, msg->sswrp_id, ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "LPB response: [%#010x, %#010x, %#010x]\n",
+		resp_msg.payload[0], resp_msg.payload[1], resp_msg.payload[2]);
+
+	if (resp_msg.payload[0] != CPM_COMMON_PROT_NO_ERR) {
+		dev_err(dev, "LPB cmd %u, sswrp_id %u: error response from CPM: %u\n",
+			msg->cmd, msg->sswrp_id, resp_msg.payload[0]);
+		return -EPROTO;
+	}
+
+	status = resp_msg.payload[1];
+	if (status < 0)
+		return -EPROTO;
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(cpm_send_lpb_message);
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
+	if (cpm_is_oneway_header(&session->req_msg))
+		complete(&session->complete);
+
+	kref_put(&session->refcount, cpm_session_release);
+}
+
+static void cpm_handle_host_tx(struct cpm_handle *cpm, const void *msg)
+{
+	struct device *dev = cpm->dev;
+	const struct cpm_payload *msg_payload = msg;
+	struct cpm_rx_client *rx_client;
+	u8 dst_id = goog_mba_q_get_dst_id(msg);
+
+	scoped_guard(spinlock_irqsave, &cpm->lock) {
+		rx_client = cpm_search_rx_client(cpm, dst_id);
+		if (!rx_client) {
+			dev_err(dev, "No available RX callback (id:%u).\n Payload Info:\n",
+				dst_id);
+			print_hex_dump(KERN_ERR, dev_name(dev), DUMP_PREFIX_NONE, 16, 4,
+				       msg_payload, sizeof(*msg_payload), false);
+			return;
+		}
+
+		rx_client->cb(msg_payload, rx_client->priv);
+	}
+
+	trace_cpm_handle_host_tx(dst_id, msg_payload);
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
+	struct cpm_handle *cpm = container_of(chan_info, struct cpm_handle, resp_chan);
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
+cpm_init_channel(struct cpm_handle *cpm,
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
+static int cpm_init_req_channels(struct cpm_handle *cpm)
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
+static int cpm_init_q_mode_proto(struct cpm_handle *cpm)
+{
+	struct cpm_payload msg_payload = {};
+	struct cpm_request req = {
+		.msg_type = ONEWAY_MSG,
+		.req_msg = &msg_payload,
+		/*
+		 * Include extra-long timeout simply for completeness. If this
+		 * fails, the system is probably in really bad shape.
+		 */
+		.tout_ms = CPM_SEND_TIMEOUT_MS * 10,
+	};
+
+	return __cpm_send_message(cpm, &req, GOOG_MBA_Q_INIT_PROTO_VAL);
+}
+
+static int cpm_init_q_mode(struct cpm_handle *cpm)
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
+	struct cpm_handle *cpm;
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
+	INIT_LIST_HEAD(&cpm->rx_clients);
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
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize queue mode\n");
+
+	for (int i = 0; i < ARRAY_SIZE(cpm_adev_names); i++) {
+		struct auxiliary_device *adev;
+
+		adev = devm_auxiliary_device_create(dev, cpm_adev_names[i], NULL);
+		if (!adev)
+			return dev_err_probe(dev, -ENODEV,
+					     "Failed to create %s auxiliary device\n",
+					     cpm_adev_names[i]);
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
+module_platform_driver(cpm_driver);
+
+MODULE_DESCRIPTION("Google MBA CPM interface");
+MODULE_AUTHOR("Lucas Wei <lucaswei@google.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/soc/google/cpm-service-ids.h b/include/soc/google/cpm-service-ids.h
new file mode 100644
index 000000000000..af90b88b759b
--- /dev/null
+++ b/include/soc/google/cpm-service-ids.h
@@ -0,0 +1,84 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2022-2026 Google LLC
+ */
+
+#ifndef _SOC_GOOGLE_CPM_SERVICE_IDS_H
+#define _SOC_GOOGLE_CPM_SERVICE_IDS_H
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
+#endif /* _SOC_GOOGLE_CPM_SERVICE_IDS_H */
diff --git a/include/soc/google/google-cpm-mba.h b/include/soc/google/google-cpm-mba.h
new file mode 100644
index 000000000000..ce46e6f6b6b8
--- /dev/null
+++ b/include/soc/google/google-cpm-mba.h
@@ -0,0 +1,168 @@
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
+struct cpm_handle;
+struct device;
+
+/**
+ * enum cpm_msg_type - Specifies the type of message for CPM interface transactions
+ * @ONEWAY_MSG:  A one-way message that does not expect a response. The @resp_msg
+ *               field in &struct cpm_request is ignored.
+ * @REQUEST_MSG: A request message that expects a response.
+ */
+enum cpm_msg_type {
+	ONEWAY_MSG,
+	REQUEST_MSG,
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
+ * @msg_type: Specifies the message type (see &enum cpm_msg_type).
+ * @req_msg:  The request message payload.
+ * @resp_msg: Buffer to receive a response (effective when @msg_type is REQUEST_MSG).
+ * @src_id:   Source service ID of the AP caller; typically optional, for use
+ *            when RX callbacks may be needed.
+ * @dst_id:   Destination service ID within the CPM host.
+ * @tout_ms:  Request timeout in milliseconds (0 indicates no timeout).
+ */
+struct cpm_request {
+	enum cpm_msg_type msg_type;
+	struct cpm_payload *req_msg;
+	struct cpm_payload *resp_msg;
+	u8 src_id;
+	u8 dst_id;
+	unsigned long tout_ms;
+};
+
+/**
+ * typedef cpm_rx_cb_t - Callback invoked for CPM-initiated messages
+ * @msg:  Pointer to the message payload received from the CPM host.
+ * @priv: Consumer private data registered via devm_cpm_register_rx_callback().
+ *
+ * Callbacks may be called in an atomic context.
+ */
+typedef void (*cpm_rx_cb_t)(const struct cpm_payload *msg, void *priv);
+
+/**
+ * devm_cpm_get_handle() - Acquire a managed handle to the parent CPM device
+ * @dev: Consumer device structure (must be a child of the CPM device).
+ *
+ * Return: A &struct cpm_handle pointer on success, or an ERR_PTR() on failure.
+ */
+struct cpm_handle *devm_cpm_get_handle(struct device *dev);
+
+/**
+ * devm_cpm_register_rx_callback() - Register a managed callback for CPM-initiated messages
+ * @dev:    Consumer device that owns the callback registration lifetime.
+ * @handle: CPM handle obtained from devm_cpm_get_handle().
+ * @src_id: Consumer service ID (1 to 255) matched against incoming message
+ *          destination IDs.
+ * @cb:     Callback function invoked when CPM sends a message to @src_id.
+ * @priv:   Consumer private data passed to @cb (optional).
+ *
+ * Return: 0 on success, or a negative errno on failure.
+ */
+int devm_cpm_register_rx_callback(struct device *dev,
+				  struct cpm_handle *handle, u8 src_id,
+				  cpm_rx_cb_t cb, void *priv);
+
+/**
+ * cpm_send_message() - Send a payload to CPM host
+ * @handle:  CPM handle obtained from devm_cpm_get_handle().
+ * @cpm_req: Request structure containing message parameters.
+ *
+ * This function enables consumers to transmit messages to the CPM host:
+ *
+ * * **One-way Messages:** Returns after TX done or timeout.
+ * * **Request Messages:** Returns after receiving a response or timeout.
+ *
+ * Important Notes:
+ * * The first word of the request payload is used by the transport layer.
+ * * For request messages, the `resp_msg` field will hold the CPM host's response.
+ * * Do not call this function from atomic contexts due to potential blocking.
+ *
+ * Return: 0 on success; negative error code on failure.
+ */
+int cpm_send_message(struct cpm_handle *handle, struct cpm_request *cpm_req);
+
+#define LPCM_CMD_SET_GEN_PD		0x1
+#define LPCM_CMD_SET_LCM_CLK		0x2
+#define LPCM_CMD_SET_RST		0x4
+
+/**
+ * struct cpm_lpcm_message - Message descriptor for the CPM LPCM service
+ * @cmd:     LPCM command ID (e.g., %LPCM_CMD_SET_GEN_PD, %LPCM_CMD_SET_LCM_CLK,
+ *           %LPCM_CMD_SET_RST).
+ * @opcode:  Command-specific operation ID.
+ * @lpcm_id: Target LPCM domain ID.
+ * @obj_id:  Target object ID within the LPCM domain (e.g., subdomain, clock, or
+ *           reset ID).
+ * @payload: Command parameter word (0 if unused).
+ */
+struct cpm_lpcm_message {
+	u8 cmd;
+	u8 opcode;
+	u8 lpcm_id;
+	u8 obj_id;
+	u32 payload;
+};
+
+/**
+ * cpm_send_lpcm_message() - Send a command to the CPM LPCM service
+ * @handle: CPM handle obtained from devm_cpm_get_handle().
+ * @msg:    LPCM message descriptor.
+ *
+ * Return: Non-negative response value from CPM on success; negative errno on
+ *         transport or remote LPCM error.
+ */
+int cpm_send_lpcm_message(struct cpm_handle *handle,
+			  const struct cpm_lpcm_message *msg);
+
+#define LPB_CMD_SSWRP_STATE_SET		0x2
+#define LPB_CMD_SSWRP_STATE_GET		0x3
+
+/**
+ * struct cpm_lpb_message - Message descriptor for the CPM LPB service
+ * @cmd:      LPB command ID (e.g., %LPB_CMD_SSWRP_STATE_SET,
+ *            %LPB_CMD_SSWRP_STATE_GET).
+ * @sswrp_id: Target LPB SSWRP ID.
+ * @data:     Command parameter word (0 if unused).
+ */
+struct cpm_lpb_message {
+	u32 cmd;
+	u32 sswrp_id;
+	u32 data;
+};
+
+/**
+ * cpm_send_lpb_message() - Send a command to the CPM LPB service
+ * @handle: CPM handle obtained from devm_cpm_get_handle().
+ * @msg:    LPB message descriptor.
+ *
+ * Return: Non-negative command status/state word from CPM on success;
+ *         negative errno on transport or remote LPB protocol error.
+ */
+int cpm_send_lpb_message(struct cpm_handle *handle,
+			 const struct cpm_lpb_message *msg);
+
+#endif /* _GOOGLE_CPM_MBA_H_ */
diff --git a/include/soc/google/lga-lpcm-ids.h b/include/soc/google/lga-lpcm-ids.h
new file mode 100644
index 000000000000..27b8c6cb8e77
--- /dev/null
+++ b/include/soc/google/lga-lpcm-ids.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _SOC_GOOGLE_LGA_LPCM_IDS_H
+#define _SOC_GOOGLE_LGA_LPCM_IDS_H
+
+/*
+ * LPCM IDs of each SSWRP.
+ */
+#define LPCM_CPM		0
+#define LPCM_AOC		1
+#define LPCM_LSIO_E		2
+#define LPCM_LSIO_N		3
+#define LPCM_LSIO_S		4
+#define LPCM_HSIO_N		5
+#define LPCM_HSIO_S		6
+#define LPCM_GPCA		7
+#define LPCM_FABHBW		8
+#define LPCM_MEMSS		9
+#define LPCM_FABMED		10
+#define LPCM_FABRT		11
+#define LPCM_FABSTBY		12
+#define LPCM_FABSYSS		13
+#define LPCM_CPU		14
+#define LPCM_CPU_MAIN		15
+#define LPCM_CPU_CCM0		16
+#define LPCM_CPU_CCM1A		17
+#define LPCM_CPU_CCM1B		18
+#define LPCM_CPU_CCM2		19
+#define LPCM_EH			20
+#define LPCM_AURORA		21
+#define LPCM_CODEC_3P		22
+#define LPCM_G2D		23
+#define LPCM_GSW		24
+#define LPCM_ISPBE		25
+#define LPCM_ISPFE		26
+#define LPCM_INF_TCU		27
+#define LPCM_GPU		28
+#define LPCM_GPU_REMOTE_FLL	29
+#define LPCM_GPU_REMOTE_SENSOR	30
+#define LPCM_TPU		31
+#define LPCM_TPU_REMOTE		32
+#define LPCM_BMSM		33
+#define LPCM_CPUACC		34
+#define LPCM_DPU		35
+#define LPCM_GDMC		36
+#define LPCM_GMC0		37
+#define LPCM_GMC1		38
+#define LPCM_GMC2		39
+#define LPCM_GMC3		40
+#define LPCM_GPCM		41
+#define LPCM_GPDMA		42
+#define LPCM_GSA		43
+
+#endif /* _SOC_GOOGLE_LGA_LPCM_IDS_H */
-- 
2.56.1.831.g720f3f5937-goog

