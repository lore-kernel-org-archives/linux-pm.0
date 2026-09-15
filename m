Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FA13C3C11
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476958; cv=pass; b=XHyl7CdPfVD2xKrqraPlhc6X+YmTeYXsfbBXtKR7I97F59ff0poJ3QFHxeMv0najSpdKXNJeoXAGCMpE84gc8RHeGp/vgET4LCb9t8W0skNEyd8PVDEFuHHpudmC+nyFdOg13tG7qxwtOzOo3/Bgw/8eoJMct4j+JnJcWBmVPPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476958; c=relaxed/simple;
	bh=QNLVT0oP2XK/ek2y5Ww7AWONy9rCfAsXpg7YlO38MOo=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=qTRiqTBDdG61dqIXRtI6z5gn9U1/SKg4gvay3NenwBhBbtqn8wYYAJsy8xwmmlsLzPoarMDmhKFu0mF4Zk8VTXY2P+OclNNarIv2pSgrJX6XfjxyVP8O7BVfAIdpf/8loKERr+3n4NdfKoTAgSpX7ddSYEboIGYuLCw2rkMc2ks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQIndBio; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQIndBio"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso4024145e9.0
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 05:55:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789476954; cv=none;
        d=google.com; s=arc-20260327;
        b=OwWS6aorE0GgPBuOJ8LqU2OwscXnnu57m6a/ExTw6BwYEaqxe8agrlcL1nxyT92nP+
         Muze0J67VuZp3dZj5Tm9KqupTxVLbdT89YF9HV+KIFPhpiabbA6DmehqM3jrS5TDbw89
         nyLCQaW7Q2m4NOHnJV9vOia5Mxshy7zvR5d4p/bjYxtBjiq90SWEjA7523r8JAQta0mN
         cjQmt1ljMT3+Hi5QAAV+Yfb9WF8gGiM2A/SVnIF/RS+xTqKoQHlxyCX6HEZj9kxCRNsV
         h2d8LWaWfiiBEPiLkqRpRCi/PFgGOUHpmclS3Rh/nLA2kjkUlUYTI0p8r+zumwwmfVLW
         8sOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=0B2kbvWoY49rULeMY8LMPdOtMm83UrayO03xTZCVKW0=;
        fh=BW+cxfc7BgOoglF2v7ToItZ5lR8x/67QWcVPlktdz4M=;
        b=U/ugn+JIsDvlEqY1ykqp3fDFmMkoYg9T8P4URPX64bQQEDW+zdQz1ECSOn8Do6L2Pp
         +H9Y04ZTx5Yo2dUTrzWSUv2ueP8MwqKrlnwK9OJUw3VI53nblZxxnc86IyFyjOqYDQ3J
         ITc3IZXGVqAnUJAZYgMC+yqfsDJQGR34pFvL5VGXhm9e+X2fXE0Y10QO32M9W/MTf74k
         vDfeHjyQPZk0AKHKlhh0gz1F4qt2M9x/utttUE9kA6ddNI3gtPPpcWcrDJNXpsBtokMP
         0lugAWsqILbXI7GQQOy9kcXBrJq1cQPZ6voZtmoNtx2x55gOM8EtXGTV6B1ak0Z/16Z7
         O4Pw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789476954; x=1790081754; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0B2kbvWoY49rULeMY8LMPdOtMm83UrayO03xTZCVKW0=;
        b=WQIndBio/jBhNM+VxJ4j7MAZd1Iiga/K3eYCs01obLDVtEmVCUtqZAJ37Dx9nJL5cj
         c1CWIU9pD1fq/4jPBQ2+0GF81GxPP98QHe/8nJ4weVX2otSpkyoJsBl7RIc5KRv8mIyX
         1LtwEjmpPLX2zXAdzv9XGzeNAw92u8wRPMnjjPs1+g/CCrcR47Fj5V94QCAqV3f6lXKb
         MZuSvxV8/pkCXO3tOwHn16CySudEjaZa3+NKIUrter740gwYLcJ79fKG8LQK9G0wM4NL
         aIuAS24j+qyadMwWXqYlNH0nXjtW+wcJGw+B1XhSU1w+mgZlK9SbLcOJfTB4DigTcCPu
         oxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476954; x=1790081754;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0B2kbvWoY49rULeMY8LMPdOtMm83UrayO03xTZCVKW0=;
        b=O9xmKiUoMvYep8vMjNf2VD7ufv5quP52ORxBBFnhAzL1PYMVWPNL97C08mMjEnGlpw
         KQo5Wq1yQ4SBeVInQaU2yqfBDQfHr3/fx+qe+mA2ZqQbzBa6oaMlImE7OnGS3QeSDYmi
         s/hRYTw/+Wcs0K35G1PgpwUyNSYxDC6xtdZnTMNLknTrWlOVuqwb077KEDD6JwEDeAps
         hqTtBjSHxgj0Ht7F0Ji6s2VWabwWK6rjdOq/vrQ7Pd3x5NYc3EVn4FZVfqlPPKPvdJWE
         IMR1ePSostY8zpRBK4/P+dD8lxMSzjhqfoGO9YQ5WcQT3Xx2iySzPZHToK7MQRW5zESE
         0trw==
X-Gm-Message-State: AFuF++l0rsb9VYohDLUELLq2LwRuGgW4EvzxcqQfjorLJYN4hf6kL85S
	kLRJxOk/Q6JjU1Hqy5+PhjOV54ILJhUjqhCXaNfe2Neh4CvqgkhTUXEB3e4Nn2ex+VmFp65IGOP
	F4+LcfiIFYR7633dI0OBkkcKPYpP3f/s85rfOZ7nTrFf7
X-Gm-Gg: AYBFou20Cf8Monfby6S0yaE4ahxjJHCY+/c/9MPTaEwL9ekKezTMsEydn87i4DzoCbK
	yTo//quic2OyDZsbavYcpZKmXtl62wz3od6h2xTKwGCCWpvPnJ5D6SwvhJp4Oyh3oiIc3xziEHR
	h2BUFKaX5jxVekukgdY1gZDOBcp3Gs4u3/Nlh80xMY8mpGAqDjCkv2Ru+kq7mL+XnjT70aC6Krl
	KLy5wOA0X7a3gNg4Xm6LcwNOob88E+UyFyvWD6PHVMgLp36dKfmI0WPNHEKofzT2am0vStBGITB
	gD8+M2cO1i+gsnnpyfe7f0ILYXwJmIV/ZcGa1F5qoPglXOhswYpWFjX88DywxL/D
X-Received: by 2002:a05:600c:c3dc:10b0:49b:90bc:d4f3 with SMTP id
 5b1f17b1804b1-49e7d71dc27mr44192875e9.4.1789476954170; Tue, 15 Sep 2026
 05:55:54 -0700 (PDT)
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:55:53 -0700
Received: from 830778650420 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Sep 2026 05:55:53 -0700
From: Ruslan Vagner <rusya92266@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Sep 2026 05:55:53 -0700
X-Gm-Features: AcwNN1W4_HL9tAI3HPic6Xct2KFKH9xwFQvZPw5B_AGDBTEmRYeDK7iGigciThE
Message-ID: <CAF9RqJ5b8GKcdQ5JA=2ezF=p5uFXrRRynmMRHtsB8RPEnM1g3A@mail.gmail.com>
Subject: [PATCH] PM: fix comment typos in clock_ops and rk3399_dmc
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org, Ruslan Vagner <rusya92266@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Fix the spelling in comments. No functional change.

Signed-off-by: Ruslan Vagner <rusya92266@gmail.com>
---
 drivers/base/power/clock_ops.c | 2 +-
 drivers/devfreq/rk3399_dmc.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 59bb37e8244c..3b8ba27802a8 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -250,7 +250,7 @@ EXPORT_SYMBOL_GPL(pm_clk_add);
  *
  * Add the clock to the list of clocks used for the power management of @dev.
  * The power-management code will take control of the clock reference, so
- * callers should not call clk_put() on @clk after this function sucessfully
+ * callers should not call clk_put() on @clk after this function successfully
  * returned.
  */
 int pm_clk_add_clk(struct device *dev, struct clk *clk)
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index dbdce7636ca5..2cc753fe30ac 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -189,7 +189,7 @@ static int rk3399_dmcfreq_target(struct device
*dev, unsigned long *freq,
 	 * Check the dpll rate,
 	 * There only two result we will get,
 	 * 1. Ddr frequency scaling fail, we still get the old rate.
-	 * 2. Ddr frequency scaling sucessful, we get the rate we set.
+	 * 2. Ddr frequency scaling successful, we get the rate we set.
 	 */
 	dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);

-- 
2.54.0.windows.1
