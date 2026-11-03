Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744596;
	b=gEamXUBiXjRCiDuabUxtMN/ybFrvr0sDsFb/Occnb22xZGhNv7J1jgIYRNhU8TTamV5Q
	 t/QZdGzYDj37z8EwUlRXEAWNZDnTWCF801IfmpfpY1qzeaU6S3LIUqSItlMeZXHlq8Vgy
	 +mexi6dnxAorAckyN4UUv9Qr12t53/VkHMkQCFMVuNqAyBt7wdo1JksJugnQpkP+IB+mC
	 04UCcdfvCTHMkK1SBCrol7GpvHjUYrlDYGhkgl33R1lJgYx8jvcGaHHNAFKBjmDQODfna
	 6iE2Wmgv4dSNARr+9GJDmPdHJiDn1Tgy5/cSm8MAevZ55CWoOoS2bFn08cOVXROLIGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744596;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mtVdxBGNK8oHTFOTDJC4ciOsojwKNf2YHH+u+jkXh8g=;
	b=vkf36gTKvB88Xi0CVEk/hCZmSy07xVooYdL3pvA4RVbYtB8ri9OPGeXrKqJ8ZsPX7ZPW
	 A1QJFt/6ZpflXWpx7KA9VJkBF1ytCgNMOalBLPDaHCUVlo/ykVA/FJ9UMoogNekRgOK0H
	 R0ljjBc5ZFDaZQ5cO7EMSraTYd5rkRSGWouk2iMu6pMxnWmLzlmpoIGqKmlRQJkkeDXTw
	 fOnbzjuFXWZRkaCgpsEBuTrHoPVQSrkjYhZ3mdpOjGdKCldE5486m24RX3/t6sq3gjccg
	 JCoKNnqbQgowPRJVJoOEhsLkllD1GbCDdN/4Xc7YSQxDLS5CHTlqGru3CdGmBjvBoUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WI9KvTyk;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F286606A31B
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 22:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F286606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=WI9KvTyk
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-15943c9c005so312447c88.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 14:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793744595; x=1794349395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mtVdxBGNK8oHTFOTDJC4ciOsojwKNf2YHH+u+jkXh8g=;
        b=WI9KvTykKKOoDsf+ULZVClTlXCFT12vjawevA+tAVPFVxcjA1lb8GA6wFRQW4E1YAr
         nJCH3oRGJdIu6cd4ZfETInJ2MLLkJd0O1DpjV+Ze4JrRG64qzaYEzNVSOJm+Jw6j0piB
         C0T1yd1lHdmh5L3mfpTIiS8wzn1qQTQewEp4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744595; x=1794349395;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mtVdxBGNK8oHTFOTDJC4ciOsojwKNf2YHH+u+jkXh8g=;
        b=NCGK3QXxHvTpXc580+wspDWUq5BpLZbv0/+fNqqOgO73OqVGBmbraINVwMu8mX20yg
         Pbs/pKmgnFrdKWj/OhndFGGty/cuxh9nZ2vgpIR6x04uqnX+aFpKSnZEtJwmZzNeDCR9
         6SN1CShKPE4eTcbsk5jcQHNo4iuwEz6BgWoBrSZ54APSBYsev4X2vHQKawjTb7qzQ0Eq
         yDzYfhngTLy2ozbf997nv3r59uKhZzy12jjQR4C2BfhLGOGHYBtY2I/Kpvw+sP63jL8f
         hNUNum/pRwQtP0o/yNtimt1Lzbudu3SJuDR+1t4Uj3iwQ0dPWUwHZWzWW7s2zFrDoZB8
         71Ug==
X-Forwarded-Encrypted: i=1; AKwUvBz6at5663PsHfA9y81SeLJDXl4Dfx9WipFMdFQiDrH8KfRH2JeOS3+q5Rb7C9k0d0W+XWBES/clAw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/qa+hWcCgpGTGs0lWorT7qNYFhoA+43w8rVk21cPGKYSVZf/Ar
	nue5hFdGqkYarsU7IoG1Bowk8bFHMkGkPbP2EXXwKpcoJaO47xXdFM7KBndEfzlZQg==
X-Gm-Gg: AYBFou3PI+2e+otvVlkmOK9EDCfgwXDgwkczEOcFMpEFnkFCi4mG27UFKAfkPP7Hk9n
	zCQkcqF4/z/jaqryXfjuSjjKbihwbUWPpGYkxxafYiVEH1ITDx1dxElUivnd9mTsfqmZq+nLsff
	FxVhaPa4tFQQQJP0X6a+i7QFMobnCJf921/8ruDitc60VejMnyYt/vKQWG3g981aj/DbYZpSkZT
	XeRjlsGRiw+AoifZPJUuDq/bRLYoZW4ujNgdFZUzeJQiIxPTrB1QYuaJTR6iu6wvV2uhRWswwBq
	ZniprQsRUOSMdwi2JMRVg7rhi4iY3odKmsADCAWMXPxfFuQRFA2J1/R3agp9+OrO/gjMwZcn1lM
	TYsW/BgTDKe0uy0vjoc/TjqvImJrcqdHwy3Ic2W35+QUvLqZmtj8XBLgFP1Qe8r1MPuwi7hiKkb
	xegUC4AjfWbMD76yIY2LbX1s0rvSnItavoQKzsb1Gm7rTMa5+s8Hd2IsleC/SRrMp7cTJUTAWPu
	IKJcRaumgJXgVVI8z3m2yB/fY1Pi1/TmyRnn/gB38ayylO0CvypwgkPw46BybtY3tyNW+4EF+zS
	cx7ywbBRTd5iM8dI/73oiSzBkmp05M7C9KCXpjDmEOZ0kfXaRzjl8EdCbwEsGJKdG193
X-Received: by 2002:a05:7022:e27:b0:14d:cb67:afc4 with SMTP id a92af1059eb24-1ac5e8e1e4bmr29270005c88.41.1793744595232;
        Tue, 03 Nov 2026 14:23:15 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:ab71:b3df:693a:fbf2])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b245b8822fsm2254589c88.2.2026.11.03.14.23.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 14:23:14 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Brian Norris <briannorris@chromium.org>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v2 5/5] iio: adc: stm32-adc: Drop runtime_idle()
Date: Tue,  3 Nov 2026 14:14:43 -0800
Message-ID: <20261103141442.v2.5.Ica1e32ae51d7975844386684d2b6a097f3ca9122@changeid>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261103221717.3840215-1-briannorris@chromium.org>
References: <20261103221717.3840215-1-briannorris@chromium.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This runtime_idle() implementation was added in commit c537d3457542 ("iio:
adc: stm32-adc: fix runtime autosuspend delay when slow polling"), to work
around a suboptimal behavior in the runtime PM core. It should no longer
be necessary as of "PM: runtime: Propagate last_busy from dependent to
dependency".

Signed-off-by: Brian Norris <briannorris@chromium.org>
Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
I do not have these devices to test. I have tested other drivers, and I've
verified this behavior in unit tests as well.

(no changes since v1)

 drivers/iio/adc/stm32-adc-core.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index c409edd3a827..0193db7a2a7f 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -873,17 +873,10 @@ static int stm32_adc_core_runtime_resume(struct device *dev)
 	return stm32_adc_core_hw_start(dev);
 }
 
-static int stm32_adc_core_runtime_idle(struct device *dev)
-{
-	pm_runtime_mark_last_busy(dev);
-
-	return 0;
-}
-
 static DEFINE_RUNTIME_DEV_PM_OPS(stm32_adc_core_pm_ops,
 				stm32_adc_core_runtime_suspend,
 				stm32_adc_core_runtime_resume,
-				stm32_adc_core_runtime_idle);
+				NULL);
 
 static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
 	.regs = &stm32f4_adc_common_regs,
-- 
2.56.0.398.g882cbad275-goog

