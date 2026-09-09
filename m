Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33214377AB3;
	Wed,  9 Sep 2026 04:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788928921; cv=none; b=Oaa6ihlBNBq0QP5KhjAq+igDnDzqa7DiXqZiZ6inbtWj/35wKzv9E4tbZOWlLYkYAhDBUBClcbtw4LSzNO59aC1C0BWKqOTBEzPAzth9h8oS3opwhKV3z2hfDrNd/MH9mQbbHmgDYRBInmArBuzkbKLwfvCJ8+2L5FXKiRS+vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788928921; c=relaxed/simple;
	bh=s2yjAHNDLB07BSbJc/coYe6HeRmtC7vzriPhUyytqgA=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=K3hVQkffCV4nhDYDMN911t7i5aHaq5uRWfu5DQmKyo0NNUoOwVZzUNFz3xfITRr212pxC7eP7jJXHUjbU6PF9Gt4BTuiNhmefbStBoCxKiE+eO8AO8VW7J+ChMFYrILSSBfzDnRyTpmIWBr3lkOmgtW7KyWGJSDrrPfXB3feGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=umtfwx0S; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="umtfwx0S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788928906; bh=le3zYg6i/W0Zm1Onw0+jhfRKYIZSerIckXAnh81wAOM=;
	h=From:To:Cc:Subject:Date;
	b=umtfwx0SC5Hz3kwXYWhUlA0o6k01JyNb1laPl9AEEY2teAp3dTWE5eJEERS85Fh1K
	 uMCsm+kFyz2eWMngXwpTq3aYyVw2kbAMJWmV19gbPGI4gOudSZ7Vepg8BJdN/bry77
	 f3twmHObAqSVkqOvP5A37haYDVz6xWuMOwpZES64=
Received: from LAPTOP-7R15B00L ([183.220.99.26])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A62234DC; Wed, 09 Sep 2026 12:41:34 +0800
X-QQ-mid: xmsmtpt1788928894tzy5gfg8b
Message-ID: <tencent_60DAC4127B362B6743CB0BFA2C31982FD807@qq.com>
X-QQ-XMAILINFO: OOkYTTCdPTHEL0tyowzprNb+00H3pepti5SuKBNYCQP6ylu0888z0KX5tbrHFK
	 j4pH/GHyei2fwVyplYm2Rdb8+nU9IhR5DuxvML88DMtsdoliKo1yr9o5LfoV6KxIPHzaFO9CtWSB
	 ZhLcM347YpPNW2D0KPwZdyYYZtFRM5UYOmgheb77sjXvpu8W0ljsQtL3BBXdH5JhPz8mXyY5Rbb3
	 XnB6zh5IYK30MN7YcPf09UZEtP44ElxQbUNjO4aDXyj8S2pUT4OEGaA7vTY2NtBuRDc6c0ZXz2fY
	 nfSPYOfFvjvFdrpMksy7CY+p6WhmcT73Bw6moyfnFJiN0xgK/kvhTcl7oh+eB3LJgxznam4QMDGt
	 eYUU/fFLpIBQdsj4E2WObbyonhjwooD46rkW8gv8UqBBNtRmhU6c108FVwn+acly6r5O/VTy0WGV
	 EQOTY11Grlf0er18BuISjBsHJEGyteO3/QHmNH1TG8eXNuRHCGtPf8iYtcuBwTgS54L1GjO7TBO5
	 9FN2re0AGtq5gB2Soo3wVRadZmIHpcfJXHcr8V1rDMcdubiiRkjf9j/+e/qLD1vU98uuU0VEG1oz
	 c0a9/iYBIFkPTtbh8F9o+DNMvZwnw7JGnkq4R3/iFK7RVINB37ftZQWNdTsuRCFBjtlgvGkdbdx1
	 HU8wC8YlK496N1F8PhWgtLnDdSv0AzNW/celRoOluJ/bBwaaPp8sTka2x92E9xJX8evn6oKJOFYQ
	 3o/kfpP2wG29Pd5N3OK4psfftrRrZtMd0O0GvVujuJKKEsC20joq/UXs6Ot41zR4Jjo33LiHrT0W
	 p/8gFywv82XEX9UdjNlEpANplQ0jIIeBFklk9o0Wle7ZWzQio2pI61vveGj2E157v9j2rnoyQKGc
	 KN+FC6L+s4UQimi13XNYmGj9wEajQu22iToQXXikIHii2Xn7f0BZknlhrKwFuTOPsdbMJCGHWgA2
	 L5VQmrs1EOVPciXBxAvMrcZAMiidrQ8hivODdKUXVLjFB2qR2eugcJOSC3FGViwQx7J1KhQoYUXs
	 9ODciX4F6gTOvQKTFXNQxy2hCaosP1pG9BvKvEEPqvELGm6SEJ
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: blaze <1466528493@qq.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	blaze <1466528493@qq.com>
Subject: [PATCH] cpufreq: qoriq: Fix clk reference leak in get_bus_freq()
Date: Wed,  9 Sep 2026 12:41:22 +0800
X-OQ-MSGID: <20260909044122.1880-1-1466528493@qq.com>
X-Mailer: git-send-email 2.53.0.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clk_get() acquires a reference to the clock which must be released with
clk_put() when no longer needed. In get_bus_freq(), the clock reference
obtained by clk_get() is used only to read the frequency via
clk_get_rate(), but clk_put() is never called, causing a clock reference
count leak on every invocation.

Fix this by calling clk_put() before returning the frequency.

Fixes: 1b6f255990ae ("cpufreq: qoriq: Enhance the support of clock from DTS")
Signed-off-by: blaze <1466528493@qq.com>
---
 drivers/cpufreq/qoriq-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 0000000..1111111 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -62,7 +62,9 @@ static u32 get_bus_freq(void)
 			       __func__, PTR_ERR(pltclk));
 		return PTR_ERR(pltclk);
 	}

-	return clk_get_rate(pltclk);
+	sysfreq = clk_get_rate(pltclk);
+	clk_put(pltclk);
+	return sysfreq;
 }

 static struct qoriq_cpu_data *qoriq_cpu_data;
--
2.43.0

