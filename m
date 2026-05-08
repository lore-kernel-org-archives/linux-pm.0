Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA8C3E122E
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 12:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778243975; cv=none; b=bhqJALbUZM/ffY/SxW9nEluoxNNfSEO/bIHJrOL3czLuCHpKNKy0LICvJ+WVHATjv6cQ8KOex0JgiqU58vnXb2U662uGe45HyoNO8GsogSDfgA16Nm8oHYmKZfxfGvWOmPbP8xSxLC/RlxPdxgSkDcOALgvB22FDnjoIdGWlfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778243975; c=relaxed/simple;
	bh=BACNnnjiA/P+SfyeHJreij3aeGH3ANneoOpU/9hi9p8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+fq9SzicleT1ZZBK84ALQKLRIpT0F94at/j/8+6nvJZRr9gJ/6dVEMyEvhNwbFCarHxAZUHKFUfCwhL+owOKMGQq7Jg4DQYmo2vOATNUS/Sufh5AnXCSUqW0vKQ8hceuoJw7YyxeBk9xpomV0LZ93wHWBX78EnBbvgqhX9tzG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tupEYt65; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tupEYt65"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-392445f11c5so19721811fa.1
        for <linux-pm@vger.kernel.org>; Fri, 08 May 2026 05:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1778243969; x=1778848769; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zspu33ABPqLoZeWdeeV9gEAyKbL26M627IVpZcNoBBI=;
        b=tupEYt65G+TPimCJpbY8aB+jaeC+EjXVZOl+AdxXhqlF3A9dcSUBKb3bGBMcxjPIYT
         Z4DNxL8SueS1ihGah4pG1yCIw61FV0C2zmGrLiKvlZrNVgWB+rJMGS552cY/VSYldVlz
         UodUKTxGPqKDijTus469/gjEsC5Aw1Z6/om3tA5JRSZDq9tEDLje9WseK8YzS+caXak9
         oaSQooQwKDysSwUxW3DDXluezyJIEtNTt9W7+VTvWHihxFqZGujwW/ATEwVqkdH7uAkN
         ieE+6HBi2En3iV4EsxlyqNhZf5e56FQDeABC4wXmE8ww2WNtvNLh+p3FgKV5X1T7Oed5
         BBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778243969; x=1778848769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Zspu33ABPqLoZeWdeeV9gEAyKbL26M627IVpZcNoBBI=;
        b=szd6AVrUvckrrrNTq7xQ5dYtif20SLrQJu9Mnv0qUt1Z9jS3cEFdfOCfkS8LEZMoKL
         8XgS9zcIii9IZOwZ8cL483WiW+j58kvFJ43/zWdoLPqwrqOfut3JCiUtTmODM/BIZt7J
         1qBn387d/P5Rdne7pSd3Ru/KZxFg4DpN0dR0h8HRvT57KJObjux24E5N5EiLlMvAwAa7
         bLOMBiRmlNwjOBemrBjRgbDI/62i9jHxqWjJMKs8v6E7jj0VL3H9+3mDytdfj8ISfdSc
         CR5sful437EyIRDo825epjggOBuSnVdYJ7XvsQSQn/n/xxmC6MxZfJEHv4U8g+hOHHwh
         R7uw==
X-Forwarded-Encrypted: i=1; AFNElJ9sSx7Lv/bxCsVmkxwCXaloU2ntstYeOL/KmqwgZMEH5NKzZ1pTZCZx5AROFwH7KyxqxX/Kl9+s7A==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcGMD5nPkQc0xQtVjuKW6VZTLdhVOGE8NSUW7qf/6XRD9i5AMc
	P7mGNNDHYhAhlLkZa6ZgDzHRUG/7SXLge81iOgmxG2mSMsKEw/JoqgBJqnVSoe/ahOc=
X-Gm-Gg: Acq92OEdqx/CpqDZeNvNHri7T4zMPSVicgCaxKHdI6ts+FBpnKxT7BGdQZVrFbsTXX2
	UbGSjFMOfCTUy6ivURbCF+/iJ9VrkOCcok79PjNiSkxmM5EErTt463A+6roi7mqaLS2hJ8vZyui
	pQwm13H7AYbBcBVWxb+oy5kuBGqImoIHvAhSONRurlinGO9D8l17XLpwcgZhYQJa7uN3DjsOD0a
	a5bEleq8cT3MJZ6u/eqqA9m/GfgQpli38sdoZDMIXeXPbFammERWW43YHnbyR440Kk0cCQQHAjb
	AZCx74WJJ4+9Cjc2Mx08V8FS+MPNSWigxhJvav0BtPMuMx99f6zjkNSwn8ZbtGmge3+HWha3YFd
	gp0lGmZ/bv4A9BbDHV8uZujSdy45APcEBUKdnCtvufLROSp4B2bmfnqkw1Mg9Ek77arYEm0EVrI
	wv9z5D/0MSIcLCPWBcJX2LhiAmFH3osynMda8iZhPbdR5YB2MPWdK/DHBufyhX5o8481M+UUa5
X-Received: by 2002:a2e:a804:0:b0:393:b138:34ac with SMTP id 38308e7fff4ca-393db0526d6mr20975861fa.10.1778243968630;
        Fri, 08 May 2026 05:39:28 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393f5f5fcc7sm4569621fa.18.2026.05.08.05.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 05:39:28 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Peng Fan <peng.fan@oss.nxp.com>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maulik Shah <maulik.shah@oss.qualcomm.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3 09/13] pmdomain: renesas: rcar-gen4-sysc: Drop GENPD_FLAG_NO_STAY_ON
Date: Fri,  8 May 2026 14:38:58 +0200
Message-ID: <20260508123910.114273-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260508123910.114273-1-ulf.hansson@linaro.org>
References: <20260508123910.114273-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the new fine grained sync_state support for onecell genpd provider
drivers, we should no longer need use the legacy behaviour. Therefore,
let's drop GENPD_FLAG_NO_STAY_ON.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- No changes.

---
 drivers/pmdomain/renesas/rcar-gen4-sysc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pmdomain/renesas/rcar-gen4-sysc.c b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
index 0c6c639a91d0..81b154da725f 100644
--- a/drivers/pmdomain/renesas/rcar-gen4-sysc.c
+++ b/drivers/pmdomain/renesas/rcar-gen4-sysc.c
@@ -251,7 +251,6 @@ static int __init rcar_gen4_sysc_pd_setup(struct rcar_gen4_sysc_pd *pd)
 		genpd->detach_dev = cpg_mssr_detach_dev;
 	}
 
-	genpd->flags |= GENPD_FLAG_NO_STAY_ON;
 	genpd->power_off = rcar_gen4_sysc_pd_power_off;
 	genpd->power_on = rcar_gen4_sysc_pd_power_on;
 
-- 
2.43.0

