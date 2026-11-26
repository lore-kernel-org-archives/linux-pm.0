Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667147;
	b=b5d4PpCp+Ko0i6bWMAFurx4AlKl//+FCRScYfS8D6D1gZCcQAiT1viJ4b99mZ6j04TcJ
	 JYn9jcS35pwsMDFYMDqT/lBdUoyGlsFfjlOFeoNj5qYDti8/OVpzHwh6BEAVluqpXGAr6
	 So3dbE9vhP2twtSkbRbQiH4MkKDwNP9l8W84HF74wyQWIH8RNLdQchINNP+M/zZZ6dR8C
	 PIWE3BofPCm5a+eOBrdbrvuLwwLINTyw/fyHFTfJH6B9XyDpeBQEEH2j1L04tpykntLE9
	 IGp5RY8nQKqEtjNsvu4NEkfdkrz+6kG3jAySlX24mEIGj8nVyOgQxuQhpK5CBbkzTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667147;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EAy5odJxUmWsVwFV/2vgUwhg7YG87ANK0oB0alQGxyQ=;
	b=psB3ln/NlC9GZ8OJw0iCFdBocWgccCGTc3rPvwtKJbbx8QjCrL2n0N/nxn+SCpc9TpMi
	 rM0MyLemOB3J0UsZunmtrRutbplQoeqNcxYcQdv8nbi047ih8VcglD8uji0Eu/cc4LILs
	 MXh1LgNiAmVDq/1c9lTejoxJAB6AO/XcMGS63TF856BpPrAcrtVeSiiXXSEOrz+Ob7b6X
	 VehYkPR6QvJW1VYe6bDklIU4XItHilDjS1xgZ5Xjgtzcolu1+/xLlxLPjaHDfH/3i7R0p
	 mBREnhWqfM0r4lv4TmgCxcOnQQ2vy4cgyVHJkyi8Jo5AZDvZ8R+tUSJWUnQruEi6k4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=sPDKV+iT;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33DA606A31C;
	Thu, 26 Nov 2026 04:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F33DA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=sPDKV+iT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795667140; bh=EAy5odJxUmWsVwFV/2vgUwhg7YG87ANK0oB0alQGxyQ=;
	h=From:To:Cc:Subject:Date;
	b=sPDKV+iTt8//ILSpfTsE51bhO/7s0baTTCeKWuu64guwrzSQ3j2MqaRUGx50r8Ki1
	 9vhG/JumJ5XrgHDHdkg03qg88CaYgo97xLl2Cd9QLEecfD1fodsAMZDW+MPQRLgXrv
	 MSO/EJLvMPFBFqaWy/xbD2gsDxZydE9yXhkRG4h4=
Received: from LAPTOP-A8STVENV ([117.147.100.214])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 665AF093; Thu, 26 Nov 2026 12:25:37 +0800
X-QQ-mid: xmsmtpt1795667137tj3jgb9h6
Message-ID: <tencent_3D56658FAE8FA8158A1175935B194992D907@qq.com>
X-QQ-XMAILINFO: NVJ0hJNx7N5SmnZarTRq6RbSHmOQt16wQiu1L9TiU5Wt3xTca+q2nOnJgjVqJ7
	 2SMHaE4yp/WijRCOVk+uJmHSDyBQdItWX0NbCe3L95OHDrbYOZ9VuzDlRrcEQTHNUtFVo0+Mt8Ex
	 ZkLgXtXLKoj8R5RyIcTsKtmCIhPPm9KlE/kGXwDAPqEnFfyhK4CV1po9UVoZlOrC4jSPI1DNCdKQ
	 NXZw04EIJ/Gs9xRQbh8VFTrdJQUJ+E0SrVb7jcOkxss9dT/f7dA6dwd3kpIA9grDh3E3zUNkS3OL
	 18NRRwLoMDfIJdp2DissuthIZ4R8DCfajvKslm7ZjPlaoNlMY4U/IbL/ATUpnG85KbcHpL8k+TFr
	 zsuT/KcIIUwC4PtLhMw48gXmHP2gHBHB4Fs/f2/AeyE5PMyjRnMiyhMfxlBoF7uGfOyZgAcUDVnu
	 kgBYUUKj1yl2jxT/Zl9JUp7CsuF0sJDsPE4Xq6hdkWauXRZlXLptKJodsuoZXemMjNTwXTCCtxin
	 JXlr6cBT3bhrrr2x3DJ6LXRDslipT5FKbZhBHNrp7lbK1wA67EZHx1M7dN3lRz7Y+cGENYp1EgaJ
	 cIrVrgm5Um+sacy5NPcNUOk5uFPEJECQ1iW6eiWOBuV0V7uQhoRL/fV+KhcSCNNXClW5bujWlLgB
	 YgDKzTwY6UUB6eF3CVrB8UwQvqmNNNtJRbHxCTBwtMHAul/Rc4CQI4tgKEy9HhY2xV3tQSr0D56R
	 F83H52nufOUMQQX6Sx/J/a3kB7aVYQxCE2p9v5NVeIGmA/MjW6uWF//FIIS4o7D5GMN+SoAXBuNt
	 b4HEeiXunNidN4mVJShbNzY03Zx/UxIcMSxSSpMnqUlq4rAK6oM548N455fTNsp9Q9R9AcKi/GrY
	 RwOL8XkFJCC+Whd2MXHMUQgtpO/rxqz0TxHkEt07IzBz0chk6h59m+YbJToU5xM6jiatQLHsLvlk
	 xllO76PfLoWaDue7IS9aB83cG7IEj33wZuFVt+EAL2zuXqh6AR6Jl5Z+mBQnxyx71vaf4tBOSgd5
	 pedWrr7onuG2ZYTxO1
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Yuwei Chen <2522445001@qq.com>
To: Ulf Hansson <ulfh@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] pmdomain: samsung: fix device node leak in exynos_pd_probe()
Date: Thu, 26 Nov 2026 12:25:37 +0800
X-OQ-MSGID: <20261126042537.206-1-2522445001@qq.com>
X-Mailer: git-send-email 2.53.0.windows.2
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

exynos_pd_probe() looks up the parent power domain with
of_parse_phandle_with_args(). The caller must of_node_put() the node
returned in parent.np. of_genpd_add_subdomain() only compares that
pointer, and probe never drops it, so each domain with a parent leaks
one reference. child.np is assigned from dev->of_node and already
belongs to the device.

The lookup runs from core_initcall. The extra reference pins that
static parent node for the rest of the boot.

Drop parent.np after the subdomain is registered and after the
messages that print the node.

Earlier trees keep this driver at drivers/soc/samsung/pm_domains.c, so
this diff does not apply there.

Fixes: c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform driver")
Cc: stable@vger.kernel.org # v6.6+
Signed-off-by: Yuwei Chen <2522445001@qq.com>
---
 drivers/pmdomain/samsung/exynos-pm-domains.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pmdomain/samsung/exynos-pm-domains.c b/drivers/pmdomain/samsung/exynos-pm-domains.c
index c8c2ea06e990..01017c406fe6 100644
--- a/drivers/pmdomain/samsung/exynos-pm-domains.c
+++ b/drivers/pmdomain/samsung/exynos-pm-domains.c
@@ -153,6 +153,7 @@ static int exynos_pd_probe(struct platform_device *pdev)
 		else
 			pr_info("%pOF has as child subdomain: %pOF.\n",
 				parent.np, child.np);
+		of_node_put(parent.np);
 	}
 
 	pm_runtime_enable(dev);

base-commit: 8d7fe9885c62fc9a95bf55d9db244d9672a8aadc
-- 
2.53.0.windows.2

