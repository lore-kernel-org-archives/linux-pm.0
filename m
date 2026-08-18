Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B48476CFE;
	Tue, 18 Aug 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059184; cv=none; b=REMX3xcZkpX1UVEGoQJN4V6ONLRy2RQLxY2iQqVGp6ue6xfSMaq3Zp9vzhyg6r3faHq/L1xmFE7+PNAMk2kWu+/jf58sXVQ8crmtsZliRAlH3qHer5NfKgts6EuaiXnAjbalrYnuPNuAl6WlWzfKSUDeh79HdxIS1saX08I7lqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059184; c=relaxed/simple;
	bh=raa2KNOPY2mQTdR+iGOkon9LB6rg4uy4ku9Frf+CxxM=;
	h=Message-ID:From:Subject:To:Cc:Date; b=IiwQZCx+IweAzVbKYWYaIvzvXLBmizd8x6r4KSQryCglzS6vi6e/hHYJgtD/PB4UBIgCJpUnoTjnwr2LXUB67SR9xMtS5ebT6MCbUfqYQBkiohFeLqmZPXzpmuJqvssNJtUByPPWrn7J/LSP1kMmusP0Dq4hEpTnHeXbi6CH7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=jjPVkooN; arc=none smtp.client-ip=203.205.221.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="jjPVkooN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1787059179; bh=EnE8Ac80Xeo0YvrWYWO15hMp/yHf4W3nmKkYtcbFD/c=;
	h=From:Subject:To:Cc:Date;
	b=jjPVkooNK06YQy0y7BPHfvu8U0ne6XfYE+jqIRj6tizpgfTTU/ZT/a6bNXCOlP/26
	 WCwnOQMvydCaL2hbo7+By1eZ5t1EMEo0ffDH6rUvUIhdwtGY4ENVw6WUTtdxSwaiZp
	 ocawPQtu/8j6jlMfbRifFgA/T0q/swL3V5vn3lBs=
Received: from [127.0.1.1] ([5.195.0.150])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 1721C6D8; Tue, 18 Aug 2026 21:05:50 +0800
X-QQ-mid: xmsmtpt1787059086trq17d73e
Message-ID: <tencent_405FF24AB67AAAA26BC85ADD092710C0BB07@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X2uROP3QJmhslvlrFV3Golkzi8hDQC5JSUnIFRZvFEtlTKN0uff
	 fwGAX66sk+/bbEuY9nihtoVDIwg/tDaJhEtiWgo+tSBG+OQPpDINDA8xgdwMSPyi6IA1K62XAVU7
	 5xNZgeowHG7ThZFJlOyPoaBa3qgzq2Qm48/Kz0o1U3Eis6RK3QBuPBHOrP68dg2l6PK7Vyuh021u
	 wcBTspGMIhDmzVDzhqbfx469+hmQiBMqRiiDCYVTlExQYcVTDyV9R8ebv8d8mCIY01Jj7k+JXRTp
	 +ttl9bZmugcRhiPtN3D6p1Pk0xTbry9uMSOdIt31lqhr1m8WJnqyNpuyxhXA7/cTmXYfszuRZaVe
	 feArIgP43WyxO404ADfM3pZE26jnyw4pDngRDGw3unu/xz0tgj8q/gXPESoUwbCnlKb664Ah/j9a
	 kravXFZUaEoxMha9kg6P7b1C2o0BU+9gfQkESKUWpXiJvlcwWgvl3oKkcdHZZuB4ac+9JGdTyxrw
	 zrlrpQwg34Gw7UF77PML0WDHCmsi3quKUw2Dvv0RHCgtIi2yLsWJdxlSAI5oAC1quwZdRAXUNF2g
	 nUSIYPgbCzjMHtt0U5vWYmPoWHK6Q0wBmgxhP0wGF37Rd06T9MVdCkSPmaBQjpZiNAM7CiCFOWJx
	 QXYO7At16K/P8nPdM3bUItAtpdSvS7ofWVg32Z7v9zJuBz3YuZDskctld19VyUtsW+KJTaQNfYqi
	 +NWy74azsfeNditfQQBfyN2bP699/AylwVYTdfNehPUCB0dB+zJLsC7j0BtdFa4fEeqQd3n5mXIf
	 fp8GsZypT2YuDk0o/KrIJaOMelzIlFQ3gqgVfflualv5SnfiSbjdVYRHJLW6/VtllKz1TDl3STBy
	 vvFPgyHZwvjmq7aK7j71+P3etgjbmeVU9EYq0e0/55WLZpY29507Qh31yDXvbLbSol9JqwG3/JPZ
	 EGSFManxfBoxt8zG/grL++6czZRFHB9ygnYqXSdFfzzYw8sSIylyf57PEdsvsfmp3vWJp5LbmmK3
	 bn+ddeMARkl17idbqgEtw8cUlHOpY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Jiawen Liu <1298662399@qq.com>
Subject: [PATCH] memory: exynos5422-dmc: handle clock enable failures
To: Lukasz Luba <lukasz.luba@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>
Date: Tue, 18 Aug 2026 17:19:36 +0400
X-OQ-MSGID: <178705917686.291840.2383875087169763088@qq.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Check clock-enable failures during probe.

If a later clock cannot be enabled, unwind clocks already enabled on
that path before returning the error.

Signed-off-by: jiawen <1298662399@qq.com>
---
diff --git a/drivers/memory/samsung/exynos5422-dmc.c b/drivers/memory/samsung/exynos5422-dmc.c
--- a/drivers/memory/samsung/exynos5422-dmc.c
+++ b/drivers/memory/samsung/exynos5422-dmc.c
@@ -1297,8 +1297,15 @@
 	if (ret)
 		return ret;
 
-	clk_prepare_enable(dmc->fout_bpll);
-	clk_prepare_enable(dmc->mout_bpll);
+	ret = clk_prepare_enable(dmc->fout_bpll);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(dmc->mout_bpll);
+	if (ret) {
+		clk_disable_unprepare(dmc->fout_bpll);
+		return ret;
+	}
 
 	/*
 	 * Some bootloaders do not set clock routes correctly.

