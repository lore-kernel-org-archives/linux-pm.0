Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794201719;
	b=gDw3T59G3/5cj0sVizF0WLY3DmjpJMVguJbUEygS3fq+8YCkUx1lwUdAZdhTDunXEDTN
	 LPGycDJ7Q7YWD6Jt406Xsn2WjH/ygR45ldsCyz+buDALcVxXhnNWZb8kWXDoRaKhezwKN
	 VQ8APO5bdYsupW0ZztLle3XQ8kFep8R7dNepDBz46uxUrQz9iM2NhfKXmo4TOed9JuNd+
	 kQrvPCNteoToIdVp7ABEialBKFuWavOTBCUt8/xPsiutbqqx/Hb1qjejMDHIRIpTPP7Zu
	 QPJKwgmBSoJvKLRg2CJrceqd8Y+P+GZPfG+Fxs3mjW9G3iIQp/2aEn17PJes8prqnAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794201719;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Fj5sb2gtvT3FWrqFiToHxiIHAqMkz8L6XNg5kh5KYJA=;
	b=DYeO960Wbf0Z6s80NhpHyikWq7P4FayRpleiOy6tREAeJz6z6/b7x1ZtWcKuG/m7kJh7
	 f71yS9f8OxjlGmJEepOjDhZTWzwghY7wObah4Ku7fb7FQCg5BeXchZ9bJBXoq4RyhsbMr
	 ej8VtVwOtz05lzwkAyl5/2sEDfVgfviCYVQMkW/ZbCewElPZPYP/r3HP39PXtS5UWCVrx
	 VwRQSOUlyTsCEj0CPudnw9GXroEz0YiJ6n6TuMPCPvxTocSRhsBog15aoGz9DhtBtTA6y
	 7rjxJ9qsA81d43f4T/g7QVHmhEM7tOeHj+9/kbTG9K0GLH5cTv9v6f/pqY/SLYQxwxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=quora.org;
	spf=pass smtp.mailfrom=quora.org;
	dkim=pass header.d=quora.org header.i=@quora.org header.a=rsa-sha256 header.s=google header.b="TUNZX8D/";
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5D8606A32A
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 05:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC5D8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.a=rsa-sha256 header.s=google header.b=TUNZX8D/
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-372bdb942dbso679424eec.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 21:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1794201718; x=1794806518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fj5sb2gtvT3FWrqFiToHxiIHAqMkz8L6XNg5kh5KYJA=;
        b=TUNZX8D/h32n6wqaHOBBZQWY1dSDOrUoCh6pas82IAmw8UJtmqAgtTRIx40BSiDMUt
         6ujxVpD5gdeAAkrSQNQXUG2qjmoZHmLJp95rRCaZ9THvb04gvSnMPGpiLmDBW/hEr8Si
         ER3fSDmqIuPNB9zgAs6PRS1TRHZKJS07C5uz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794201718; x=1794806518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fj5sb2gtvT3FWrqFiToHxiIHAqMkz8L6XNg5kh5KYJA=;
        b=NiZZd2NiUCJA7uOhgRY3EdUZiaR9jvgaKLAhlxfk2ZVaOcUeVO5l/Q8WosM880Aggc
         K2KOrC7SB/wIuwWf/VV9X+SlsK69AjejX2d7+rJ+Zf8CPD2UtqTkoHCcBNziDJ9HDmwN
         /5xQeJ/SSJTeUU+1J+sl6kVDwdkrO4tp2RF3Cdv6abN1SeAElRvP7ZFAbY9EMkijsiDz
         BB9V/ysXDZC5Xwamv4l9Zv4Y+VLJEJaSdSzCHy81eMBsD7YTCGplUckSIpiC/I3NupKd
         /ANaXjnbiea8TwKDDjImYHawQm1IAnwSPyuUsM64x2wOgEyK2LLrm8XMY1BIG+oodAIt
         fmhA==
X-Forwarded-Encrypted: i=1; AL+hErG4LXKJ/IKKYOfvP4UgyXRj+D4HmBU4LOlyBHcig4nuz+fmV30acqewBETyuZWU9MykB3tCankwBQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/h4j4hndWOC+uqWrTeQcDyhamvtOvt3u59iaoetYdkyW2w9I84
	7AUVUBvsW5rvYLsb2A5WY/f7INFrgzIJLxcmgE4wZXxoh7dXFAAPqPGcnXW3z5HiQ0k=
X-Gm-Gg: AYBFou3fmYMNQO4j36+qGHVcsj60CEZ2DUDU0UMX87PxJPwd82Xo2OLAe5GaaXlpOWx
	P0tcTvfhxoyvX3iYIT7aXgMkBn7dnBhxDvfQQpb9FWeDghEkjSrdESKb8BUu5tjUduf+Uxa9tsK
	qo43/xx4Xgx/ssp4kH4cH9sY1UP3BmXZZeSbzKJxLYUSXCX0ihLddTr1Cf5HI8heK7gjfWDStt2
	go1L60AlAGWdxIS7Sc6C2I6rdVFWo7zFgAqMIALEUdggE6jPqZwEvkH8/IyPTH7UPBg3q8pQK8j
	6/JHL1dkDoNwq+BpUlTGI9XjF10hNdiqIu1ZlOpyd4C5xQK6DGeHHIMz4ht2XFYEP/gHQ8QmvYY
	qN7wswbBvSay+hg//+yROEysHfErMJNB1iXzJzV9TyRAJmPQd5QbVjdBqe5B/pR2kfi9PYIkFLs
	F0HoVpbAgNWF5l8LhW0+qUIL0BkxqPXh6bjYmG2Do/8mKTcGDHyRF472xACMNGV2Shocm3XNq3S
	095oiCYETzVZJduCeBGjo55pHkp2JiY+dXulTzPzYYcvX3g/CFVzcG3nbQMmTBpICgPV18TII7w
	fe/Y1BUNmewTmNNR2RKIgfDnMV3RxAO0DAk/v0qq/n//tU20ErRGDKoOE9cIyIEfmYS+szQZqZ/
	yewQi1L+OsiC4BXbjnS7zfxoybo1Sss2pGQpM2zb+MFrgql8HXL8R+hqniqB3GBH8/3CLiVDthE
	LsQ3ffUk6gedC3tYolx8bdXJWVhARIVlTjCuqrY0jjNOrGQ4+bptjxAb6x64X6GBjW
X-Received: by 2002:a05:693c:6009:b0:36a:43d9:f2a5 with SMTP id 5a478bee46e88-372576c22c7mr5669312eec.32.1794201717818;
        Sun, 08 Nov 2026 21:21:57 -0800 (PST)
Received: from aegis ([216.247.15.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372669d2826sm10638817eec.29.2026.11.08.21.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 21:21:57 -0800 (PST)
From: Daniel J Blueman <daniel@quora.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	linux-pm@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Daniel J Blueman <daniel@quora.org>
Subject: [PATCH] PM: clk: Fix false-positive recursive PM clock mutex locking
Date: Mon,  9 Nov 2026 13:10:05 +0800
Message-ID: <20261109051007.371843-1-daniel@quora.org>
X-Mailer: git-send-email 2.55.0
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

pm_clk_suspend() and pm_clk_resume() hold psd->clock_mutex across
clk_prepare() and clk_unprepare() for sleeping clocks, with every instance
sharing one lockdep class. If a PM clock is provided by a device that also
uses PM clocks, clk_prepare() resumes the provider, which takes its own
clock mutex, triggering a lockdep report.

This shows up on the Qualcomm X1 with the LPASS WSA/RX/TX macros and the
varargs macro providing the "fsgen" clock:

  WARNING: possible recursive locking detected
  ...
   pm_clk_resume
   va_macro_runtime_resume [snd_soc_lpass_va_macro]
   ...
   clk_prepare
   pm_clk_resume
   wsa_macro_runtime_resume [snd_soc_lpass_wsa_macro]

Lock ordering is always consumer -> provider, so this is false-positive,
resulting in lockdep being turned off.

Fix this by giving each pm_clk_create()/devm_pm_clk_create() call site its
own lock class.

Scenario analysis and patch development was assisted by Claude Opus 5.5
under my instruction; detection and validation was performed on my Lenovo
Slim 7x with a X1E80100.

Fixes: eb667d0fbdd3 ("ASoC: codecs: lpass-va-macro: Switch to PM clock framework for runtime PM")
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
 drivers/base/power/clock_ops.c | 23 ++++++++++++++++-------
 include/linux/pm_clock.h       | 19 +++++++++++++++++--
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 3b8ba27802a8..94f2aa090ce1 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -398,17 +398,26 @@ void pm_clk_init(struct device *dev)
 EXPORT_SYMBOL_GPL(pm_clk_init);
 
 /**
- * pm_clk_create - Create and initialize a device's list of PM clocks.
+ * __pm_clk_create - Create and initialize a device's list of PM clocks.
  * @dev: Device to create and initialize the list of PM clocks for.
+ * @key: Lockdep class key for the clock mutex.
  *
  * Allocate a struct pm_subsys_data object, initialize its lock and clock_list
  * members and make the @dev's power.subsys_data field point to it.
  */
-int pm_clk_create(struct device *dev)
+int __pm_clk_create(struct device *dev, struct lock_class_key *key)
 {
-	return dev_pm_get_subsys_data(dev);
+	int ret;
+
+	ret = dev_pm_get_subsys_data(dev);
+	if (ret)
+		return ret;
+
+	lockdep_set_class_and_name(&dev_to_psd(dev)->clock_mutex, key,
+				   "&psd->clock_mutex");
+	return 0;
 }
-EXPORT_SYMBOL_GPL(pm_clk_create);
+EXPORT_SYMBOL_GPL(__pm_clk_create);
 
 /**
  * pm_clk_destroy - Destroy a device's list of power management clocks.
@@ -451,17 +460,17 @@ static void pm_clk_destroy_action(void *data)
 	pm_clk_destroy(data);
 }
 
-int devm_pm_clk_create(struct device *dev)
+int __devm_pm_clk_create(struct device *dev, struct lock_class_key *key)
 {
 	int ret;
 
-	ret = pm_clk_create(dev);
+	ret = __pm_clk_create(dev, key);
 	if (ret)
 		return ret;
 
 	return devm_add_action_or_reset(dev, pm_clk_destroy_action, dev);
 }
-EXPORT_SYMBOL_GPL(devm_pm_clk_create);
+EXPORT_SYMBOL_GPL(__devm_pm_clk_create);
 
 /**
  * pm_clk_suspend - Disable clocks in a device's PM clock list.
diff --git a/include/linux/pm_clock.h b/include/linux/pm_clock.h
index c3b46fa358d3..d54681547f58 100644
--- a/include/linux/pm_clock.h
+++ b/include/linux/pm_clock.h
@@ -37,7 +37,7 @@ static inline bool pm_clk_no_clocks(struct device *dev)
 }
 
 extern void pm_clk_init(struct device *dev);
-extern int pm_clk_create(struct device *dev);
+extern int __pm_clk_create(struct device *dev, struct lock_class_key *key);
 extern void pm_clk_destroy(struct device *dev);
 extern int pm_clk_add(struct device *dev, const char *con_id);
 extern int pm_clk_add_clk(struct device *dev, struct clk *clk);
@@ -45,7 +45,22 @@ extern int of_pm_clk_add_clks(struct device *dev);
 extern void pm_clk_remove_clk(struct device *dev, struct clk *clk);
 extern int pm_clk_suspend(struct device *dev);
 extern int pm_clk_resume(struct device *dev);
-extern int devm_pm_clk_create(struct device *dev);
+extern int __devm_pm_clk_create(struct device *dev, struct lock_class_key *key);
+
+/* Per-call-site lockdep class, as clock mutexes of different devices nest */
+#define pm_clk_create(dev)						\
+({									\
+	static struct lock_class_key __key;				\
+									\
+	__pm_clk_create(dev, &__key);					\
+})
+
+#define devm_pm_clk_create(dev)						\
+({									\
+	static struct lock_class_key __key;				\
+									\
+	__devm_pm_clk_create(dev, &__key);				\
+})
 #else
 static inline bool pm_clk_no_clocks(struct device *dev)
 {
-- 
2.55.0

