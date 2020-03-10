Return-Path: <SRS0=5rfv=43=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E086C10F27
	for <linux-pm@archiver.kernel.org>; Tue, 10 Mar 2020 21:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2E9222D9
	for <linux-pm@archiver.kernel.org>; Tue, 10 Mar 2020 21:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="a5msvmkc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCJVqY (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 10 Mar 2020 17:46:24 -0400
Received: from mx1.riseup.net ([198.252.153.129]:49210 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727551AbgCJVqX (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Mar 2020 17:46:23 -0400
Received: from bell.riseup.net (unknown [10.0.1.178])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "Sectigo RSA Domain Validation Secure Server CA" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 48cTDv1DSDzFf5Q;
        Tue, 10 Mar 2020 14:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1583876783; bh=Em3LQ/i9qE+XviHhjKpHAV1sZpQvpkA6BrliyYuH/uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a5msvmkcIO57AAGJc89+HHSxVg2LIbloDxw/HvHznTUtSxduq7znS+NRbCQzRXf8N
         84+oHm3B93XfbIv96eOdF3rcZDbFi1o3EAXlYfNtyfjQhv69SQRS6BPriZZgiaNjdR
         5TptE3BvJsn21dZ6at3kNt6pbEjeLoAOPwj3pKKA=
X-Riseup-User-ID: 583ABCE62A94267CFC14F2494EA6EFFB9D4D6D5C94C1D8E07D8BB2D22A43EFE3
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by bell.riseup.net (Postfix) with ESMTPSA id 48cTDt6PcMzJrlc;
        Tue, 10 Mar 2020 14:46:22 -0700 (PDT)
From:   Francisco Jerez <currojerez@riseup.net>
To:     linux-pm@vger.kernel.org, intel-gfx@lists.freedesktop.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 03/10] OPTIONAL: drm/i915: Expose PM QoS control parameters via debugfs.
Date:   Tue, 10 Mar 2020 14:41:56 -0700
Message-Id: <20200310214203.26459-4-currojerez@riseup.net>
In-Reply-To: <20200310214203.26459-1-currojerez@riseup.net>
References: <20200310214203.26459-1-currojerez@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Signed-off-by: Francisco Jerez <currojerez@riseup.net>
---
 drivers/gpu/drm/i915/i915_debugfs.c | 69 +++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_debugfs.c b/drivers/gpu/drm/i915/i915_debugfs.c
index 8f2525e4ce0f..e5c27b9302d9 100644
--- a/drivers/gpu/drm/i915/i915_debugfs.c
+++ b/drivers/gpu/drm/i915/i915_debugfs.c
@@ -1745,6 +1745,72 @@ static const struct file_operations i915_guc_log_relay_fops = {
 	.release = i915_guc_log_relay_release,
 };
 
+static int
+i915_rf_qos_delay_max_ns_set(void *data, u64 val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	WRITE_ONCE(dev_priv->gt.rf_qos.delay_max_ns, val);
+	return 0;
+}
+
+static int
+i915_rf_qos_delay_max_ns_get(void *data, u64 *val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	*val = READ_ONCE(dev_priv->gt.rf_qos.delay_max_ns);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(i915_rf_qos_delay_max_ns_fops,
+			i915_rf_qos_delay_max_ns_get,
+			i915_rf_qos_delay_max_ns_set, "%llu\n");
+
+static int
+i915_rf_qos_delay_slope_shift_set(void *data, u64 val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	WRITE_ONCE(dev_priv->gt.rf_qos.delay_slope_shift, val);
+	return 0;
+}
+
+static int
+i915_rf_qos_delay_slope_shift_get(void *data, u64 *val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	*val = READ_ONCE(dev_priv->gt.rf_qos.delay_slope_shift);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(i915_rf_qos_delay_slope_shift_fops,
+			i915_rf_qos_delay_slope_shift_get,
+			i915_rf_qos_delay_slope_shift_set, "%llu\n");
+
+static int
+i915_rf_qos_target_hz_set(void *data, u64 val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	WRITE_ONCE(dev_priv->gt.rf_qos.target_hz, val);
+	return 0;
+}
+
+static int
+i915_rf_qos_target_hz_get(void *data, u64 *val)
+{
+	struct drm_i915_private *dev_priv = data;
+
+	*val = READ_ONCE(dev_priv->gt.rf_qos.target_hz);
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(i915_rf_qos_target_hz_fops,
+			i915_rf_qos_target_hz_get,
+			i915_rf_qos_target_hz_set, "%llu\n");
+
 static int i915_runtime_pm_status(struct seq_file *m, void *unused)
 {
 	struct drm_i915_private *dev_priv = node_to_i915(m->private);
@@ -2390,6 +2456,9 @@ static const struct i915_debugfs_files {
 #endif
 	{"i915_guc_log_level", &i915_guc_log_level_fops},
 	{"i915_guc_log_relay", &i915_guc_log_relay_fops},
+	{"i915_rf_qos_delay_max_ns", &i915_rf_qos_delay_max_ns_fops},
+	{"i915_rf_qos_delay_slope_shift", &i915_rf_qos_delay_slope_shift_fops},
+	{"i915_rf_qos_target_hz", &i915_rf_qos_target_hz_fops}
 };
 
 int i915_debugfs_register(struct drm_i915_private *dev_priv)
-- 
2.22.1

