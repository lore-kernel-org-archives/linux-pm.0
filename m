Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511220;
	b=3U9zGVNdd4lOg2ouTWGxVxIBgyR7fitRSnA/X5qnRpqpgxJLML4MHz5Gj+NVkA06zxtI
	 hDfasd6jydRY9PO5engweRAgGEEwg9ZBSAsdV5AqjvqXMW60M84akEdGPA/A0WZd+wW1T
	 RveqWOsa8mwGSkq9E/JiYbUXLka4bdxjtqbheGvNsWYNqCYmpxK2eB9dYmyNDn2VsiBBC
	 kDy3OA9HAxBWzc4OVMwse7zQlgpJEjD2ssno0UIjUUm3lmSYGl1q8whUqkj1aQuRdi3LP
	 Nyn4STW9sLQjKSSdAoUs8c86FgFFkgDWj154lhA/Qa9CkFtQxwFgzAz3+SNNIOuMSZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511220;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=If8tsd6wQnBv8MWVV+3NBiUbA95rmarAv+NrsxIV6i0=;
	b=M+WS9ttGaGkwJTDF/gZ+sav8FPxlqY/+vgIzGz+GwBTqKXOd2EDP19yaHWEkAUcmoaPM
	 vzRa+HTbfEcx2Rkh9ooF/zbrzn2KlRomddJMiF8JxyE/3jvDNVKwrxNoYrppYR8H3oOc5
	 llc5ZeQG4V5c0YdPTAVL/SCbsKDU0++DJPouc07Gmg1Ub/dXPkWBS2xpY97qaW5jTn3KN
	 4PypAMFPOZTxlYyWdX6+hTF5Yy+w5QD+es6KUSpscKC47Lif69SA5OiIBXKuzr03FoqnC
	 7nQM81a3S4BL68+1zyYVYMlw0NIcaA6FfsUQreK76A2LmKAseSnACTOmtcdWaNFYkng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dz7YxGw3;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D09606A33D
	for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 19:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52D09606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dz7YxGw3
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-372bdb942dbso264630eec.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 11:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794511219; x=1795116019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=If8tsd6wQnBv8MWVV+3NBiUbA95rmarAv+NrsxIV6i0=;
        b=dz7YxGw3hx7c0iLLnmt6P1PISLbTTG4oH3FWimA8tKEJmbKeR7uJUOk7BEkLhKRhfo
         1sqSAMzBnCHn7NT5tjg7zeGSnkQ9eVYHc/40tMXVQ5WNVYxVlwAovdrfDfnrQpCRr4WA
         IUD3JKPGySyr6uQB/LDX3sqk/Lb5fG4MIOuig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511219; x=1795116019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=If8tsd6wQnBv8MWVV+3NBiUbA95rmarAv+NrsxIV6i0=;
        b=DCotBMD3o4E2boXuEtks0xqzkt+BPln4N9d+3ouXOT/WNEFjd45XBJ5ngqtwIcP8SR
         UcEI7vXQwvpU/Ru37Muv251K2JNEVBMEWLyu2R0EhlIVGU6rUzue6mhv3YSywTEdYD1v
         qJ70ISD59PcNoF98HbNYQWN8mgXr/zqnsY4CZU1QtG3V+zRbgZ9bpWxQizVCZsx0prbd
         LR/kqZCD414WNoMQ+mN+vYQClE9FN3pER4j9EoZL4eVpFEqcdEESZXQYZx1SCjHsvwYB
         w5CWDasZowUHfH1ZadBnQEkQDtCwCD+eumZd9EowoHL3s0XLyUZG+qFBTmRUxMkDfhfC
         5W7Q==
X-Forwarded-Encrypted: i=1; AL+hErEFBaYgzBpAb6VXhXy4R+znGgWk3vhvsY7psi0Ei6uoTMcw+SA1K9143Fg9qeBbAxzxANeQpZU5Cg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+NQbu9EM4fb8V2sTNy6Tgdr29RPWr44EuFqcXHujqL9Fa9ldJX
	/HbTsHYO5VCcDev0SW0ybhI8mitZPEt31tugGdrs8/nS800rgKI6sQk08AG7t0jZUg==
X-Gm-Gg: AYBFou3id+BA4YV3EWculYljOQnIjg7KMMrtDkqsy18tbMpLEPGaYaygEnjx07yyJTc
	7x1dDxsx09XB46l8Kma+HZdSuycsQh19c/EY9hM29FiQJ0fwWKD1l9E+eVKHBCI6D1MCLbDSKnv
	qPZfhR/rhnZEeRR6OVZjcqc3GAfCjgmUE/wBWFaxnsjw+KgK8GADF8ph51O7yGd+TWAPIHrtpor
	izHgzM/UiB7KXG4fj4l7sLV2k2PeHhpzyvr3U+zECl3DFLR+w0XWzHO9INkYkHqiUDKOVBXr+k9
	mPdNBWhaXpSYG2/9oXpw0nNUTEa8GJXwH9yEEFKtXu3ok702YMuFXV8NCaO0ArhQTvwABC4uDN2
	5a7S3uaYJC+S6AzUMY0Gdjlu7T5Gi4wOviDaO4xtaJMAVQ1926q0XHfe90ltXw2uwV5Rq6EehNr
	7gpygKnvJty4jcKc3d3uAY6/5pQNvTka3mh1IEO7jwVNM3QtNS4XtXogBi5FMUIx4vj/aYxAtDE
	kxXYHSOT2RcInqW9Yfiq0ergVt21ixdPj5kaOBQeXyPDOwrRlaBHZ2yefllVEduVKusBAXwAfGC
	n5IdUtG2JkV0wRQcYLgXPczSCz+5ikUC+SMwUSlH4bBXYy0Dv6GeyRvKYnFw0g6usyHk
X-Received: by 2002:a05:7300:e9c5:20b0:361:167c:2364 with SMTP id 5a478bee46e88-37966e3ab7cmr112657eec.8.1794511219406;
        Thu, 12 Nov 2026 11:20:19 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:5446:563c:ac92:43a8])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-37955332a77sm488604eec.4.2026.11.12.11.20.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Nov 2026 11:20:18 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-pm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	Srinivas Kandagatla <srini@kernel.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Brian Norris <briannorris@chromium.org>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [RESEND PATCH 2/3] ASoC: intel: atom: Discard pm_runtime_put_autosuspend() return value
Date: Thu, 12 Nov 2026 11:19:38 -0800
Message-ID: <20261112111937.RESEND.2.Ia8792ce5d04a55522d84afc8e71cc879721a5f49@changeid>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261112111937.RESEND.1.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid>
References: <20261112111937.RESEND.1.I5cd238b1d4516d4d6980565e0a4e1b83d9abce63@changeid>
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

Propagating the pm_runtime_put_autosuspend() return value to callers is
not particularly useful.

Returning an error code from pm_runtime_put_autosuspend() merely means
that it has not queued up a timer or work item to check whether or not
the device can be suspended and there are many perfectly valid
situations in which that can happen, like after writing "on" to the
device's runtime PM "control" attribute in sysfs for one example.

Modify sst_pm_runtime_put() to discard the pm_runtime_put_autosuspend()
return value, change its return type to void, and update its callers in
sst_power_control() accordingly.

Note that in one error path for sst_power_control(), we would previously
overwrite one error code (from "FW download fail") with the return code
from pm_runtime_put_autosuspend(). This was probably an unexpected
behavior, which is now changed to propagate the sst_load_fw() error
code.

This will facilitate a planned change of the
pm_runtime_put_autosuspend() return type to void in the future, similar
to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
type to void").

Signed-off-by: Brian Norris <briannorris@chromium.org>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
This patch was originally sent as part of a larger series here:
https://lore.kernel.org/all/20261006161337.10.Ia8792ce5d04a55522d84afc8e71cc879721a5f49@changeid/

I expect it should be merged by subsystem maintainers, and we can make
the return type change later.

 sound/soc/intel/atom/sst/sst.h               | 2 +-
 sound/soc/intel/atom/sst/sst_drv_interface.c | 4 ++--
 sound/soc/intel/atom/sst/sst_pvt.c           | 9 ++-------
 3 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst.h b/sound/soc/intel/atom/sst/sst.h
index e24d9dad7ef6..90a266431e5f 100644
--- a/sound/soc/intel/atom/sst/sst.h
+++ b/sound/soc/intel/atom/sst/sst.h
@@ -497,7 +497,7 @@ int get_stream_id_mrfld(struct intel_sst_drv *sst_drv_ctx,
 u32 relocate_imr_addr_mrfld(u32 base_addr);
 void sst_add_to_dispatch_list_and_post(struct intel_sst_drv *sst,
 					struct ipc_post *msg);
-int sst_pm_runtime_put(struct intel_sst_drv *sst_drv);
+void sst_pm_runtime_put(struct intel_sst_drv *sst_drv);
 int sst_shim_write(void __iomem *addr, int offset, int value);
 u32 sst_shim_read(void __iomem *addr, int offset);
 u64 sst_reg_read64(void __iomem *addr, int offset);
diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 2646c4632ca1..c99697b975d8 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -135,13 +135,13 @@ static int sst_power_control(struct device *dev, bool state)
 			if (ret) {
 				dev_err(dev, "FW download fail %d\n", ret);
 				sst_set_fw_state_locked(ctx, SST_RESET);
-				ret = sst_pm_runtime_put(ctx);
+				sst_pm_runtime_put(ctx);
 			}
 		}
 	} else {
 		usage_count = GET_USAGE_COUNT(dev);
 		dev_dbg(ctx->dev, "Disable: pm usage count: %d\n", usage_count);
-		return sst_pm_runtime_put(ctx);
+		sst_pm_runtime_put(ctx);
 	}
 	return ret;
 }
diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index 0b0cfd70efbc..913e232bf6ed 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -255,14 +255,9 @@ int sst_prepare_and_post_msg(struct intel_sst_drv *sst,
 	return ret;
 }
 
-int sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
+void sst_pm_runtime_put(struct intel_sst_drv *sst_drv)
 {
-	int ret;
-
-	ret = pm_runtime_put_autosuspend(sst_drv->dev);
-	if (ret < 0)
-		return ret;
-	return 0;
+	pm_runtime_put_autosuspend(sst_drv->dev);
 }
 
 void sst_fill_header_mrfld(union ipc_header_mrfld *header,
-- 
2.56.0.611.g1030f0b940-goog

