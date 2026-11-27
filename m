Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772102;
	b=tzqN9nmX3erlg4/kRKhGyVbyCYSsLU1mMPBAL0f5dQpO8QPOJe2B1LRcJ7jmgKiiM56o
	 GQMdUYXAXrylZZ0+tIsrywL35a3QAJkhwwVz2GxVCfL7sa1TeOotZ4R5nrHVBf3p/uY/Q
	 ZwOM4/d6EWSh805Hm9BL/zcwSxRljUdpi0rT/DgutlDg0A/9QEqufyAfRewjPVm7y/jLV
	 Y4amq0EKibkLgcsKCxaS9WO7dE8NXGQXMvYvO7GayFsZIjFHyzPDO1l4sVbJl7fpVUFpm
	 5zCkJ9nNPxsEQ15J/U6vFW+TZF5AkjRrWWk40wafZS9NUJ3YZQKAhAzEnWYNbJ4GpNQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772102;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=xWsRCnyfIIh6p0qTAnuMX+kvCKkdDMmnnoWpEqJrMZw=;
	b=tenYw7YN4J+xnsl8Y/txb/XjOxOTTjjZQLFNCDLCDrpR5y8Lip16SyKiwJJLoYSe45ZJ
	 3mfn4k3Ks0Af2flzZgL7GzLtS2Ddmep5o3Sjr50aG/HP0OBoeqAK5083aR6aq7rly8u3q
	 4b6GSQUpam7X2OaIcvHyQuupYjN5J/Yq187O+2npjecNxjZnKwn7iK1TukjsdPjXYnUcj
	 HI5MgAlaq4gkcfuE2DpqcT1v1T0DDBM65ea7oGQxMPN4f34Id9/Mgjwl6YydvSIiWuzAk
	 fgJbdfVSRgV3zthbmR+1fwB2xRKZpEN1aTLxdp3H09l2OQjDwxpl7dx/FOvBvGZiz5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fK1lch4e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.42
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB048606A326
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 09:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB048606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fK1lch4e
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6b1afdf5196so3023264eaf.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 01:35:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795772101; cv=none;
        d=google.com; s=arc-20260327;
        b=jXE2YqH9HJhz2bdLNlgP+W37gV75CH9roN0pfoMS8jnRBHrc5rsrO4etFtKzlbLw9r
         HPAK89a2tHTaRMV/elRT4un12BzKFunPEeJFbvWbuOLdGoPXOKg/TD1DMB3YjVAiaZsX
         lesajfhkVYq9PCDD9sCayAATNVVGm9+EEgBkN8an/gIgjhRX1+tZUTtv2Lc2L+IKjicr
         Dbpy04xMtK+idDf5mtWqeGWLIm280wJ1RzaxZ8wSFPsLmeyMGHCwpEPFG0DpJ5T5X6x/
         LIu5LhyfjwoUvAKO7k38Lsd6NnvPKeeLuFGZZGnvZ45OrxXx9pEA3ktCCLl3GuRBTmn6
         k49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=xWsRCnyfIIh6p0qTAnuMX+kvCKkdDMmnnoWpEqJrMZw=;
        fh=UJp/l6qKSd3IhX5Z7z07hMGK8Y20APpv9cOPcWrouOQ=;
        b=gE5vtyzfn32ocoG/HCxFdrWeC/0wLaAsBUCsYJFJM2Hjn293y7/2XCn9aQQsNU4tdX
         rb/QyiKjZ6iNFP41H2Hx3C5RwsFQrj+kRLYXe0RChsW+lw6apHhNnbCF9Tass79ZuMP2
         aapoy5B1hCLLGfI+EFt1WScSlfYTlSgEq19UV6xtRJJLMUQ4luX4Eem9Ikjpp+3SsrXi
         DHUQ048uODlsn0A+itNbdN9Cr6Tr36qf+AOAPVYwYEJghdZvadq1MmU531XubP0dznCk
         /lWlsptswSarUadxXM8SM66a9Qr0wdFxxFH1JZGVtIFA0jMl3zoQjSbpL6FiW8nEsm5j
         cj3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795772100; x=1796376900; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xWsRCnyfIIh6p0qTAnuMX+kvCKkdDMmnnoWpEqJrMZw=;
        b=fK1lch4evMT7fYBb0a0Xv/I9W06+pl+girdVpojSEAhq9HO8hYFAzqtCD43rewsdlN
         ZBtdN+jgSoJEDpmQmV5HG9YS5jeIzq9fiuf9dIm7mLLqiegZvdiRnme7+7Wk5GdGJIUG
         rKwpKyR9NYCQVDpHGu/2ZmrhEzqpUmQjXWQugNy8cMgkQobsuRM2KXc9fNO3tg4AdbP9
         Kz2p8+mvLKy3EChZl4/Q86dTSmlZ1RV67qk4X3RnjXstNA7E2l3by+4oia0z7FjqK0s0
         gWJmDW3d40ET3iYFwHmQ2HPulcLd7oWZKgyxhj1WIUp6fKM2niZvxFnE1CeBi3TOOh52
         xHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772101; x=1796376901;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xWsRCnyfIIh6p0qTAnuMX+kvCKkdDMmnnoWpEqJrMZw=;
        b=ybHM9Aj+k1IxDUHdantTWYv55SD0MEXBIgCpjo9GMS8pdOfd2WEEJcnkDXX7ArvRCb
         lQ+GL0gV32j0DAOwg+alEk2gepnpvDFzylT9MpdRZfjuJ9qZEHn3s1mSjTNkgxJkqiIV
         AbYfpLljOxP3J8b2AplJ6g/pzXKbyjIWq7qovcugj3wrcVLhi6txljuuN2ZMBtEFK6tt
         hc+D2BqqvsZqlQ3VolZArFqib2SUy6HfoveTiwlL5u+mw6jdwoFTgIbbtYX3+r8pwSWb
         dIxaUzCWNSudykkOfqDfOh3PC5DmZYV36qbVCVffCyZ7IgFeZZnZ0HtC07KHorB66DZ8
         p7Ig==
X-Gm-Message-State: APuU4Z9p+4/MfYYsJyiUxzdY7nGpp9oBPbmTN9wo8dgCgThuRHSb69UE
	VsREU8JyRNlWwIaZuU8BAnzXy8dqBtwl5L+bz6vxSr+U67X2OmtElFT4xi0oHwmxR9r3yOfDmwi
	QZK2eBKJJcJb5NNImkab51oZZfOsWM2UmHXWPC9I=
X-Gm-Gg: AZFdTZduL3f4E1e20o3a+kINdUZndmyZ0ZbSc719TChKU8byQ/vTBLKrn3XjyQiMC1Y
	MFAY51bwJflBU6nhLsLkwYqkbtjyGGqFU2OMn0BiA4N/EPB0HAc2KTnzNHGK4AhPVDGbUzRNqaK
	AoN2beMaNZzlw8b6EVsiJ6xOvXcKN5MT4khkAeMa+YHfz0tck4pThcj8MLR6jmXdld0Th44J9IN
	FFARKgeSFBpSw1MmrPi/pRgfV7x847TjFJPQlaqx19J0ZYsulJGD2ulNkcR/tKolkVkbp7/qRlo
	kerqbKWWe6HTQVqqQReEIEcMjsiHVU2cNsPHSmp3AmrV+rdAndlvfISJY4ZplWOwcN9Vbe5oyp4
	BHU4PCeKGDM9iV7jRUGqgbfW36SRsGv5QmWcgFk40ouLqRzTPbaYxAUR7PqVbRR4+ZQ==
X-Received: by 2002:a05:6820:1502:b0:71b:85a5:c1cf with SMTP id
 006d021491bc7-71b85a5cc2fmr4351963eaf.26.1795772100658; Fri, 27 Nov 2026
 01:35:00 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 27 Nov 2026 04:34:59 -0500
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: getfeus@gmail.com
Date: Fri, 27 Nov 2026 04:34:59 -0500
X-Gm-Features: Aa3M54pOAqrag9P8DyluBCoyp9_znpRQFot40rVo9WjESeWPqoyH3kr_Zbfl6Ks
Message-ID: <CA+m4KrCGfS46jvTdXiYorW=rFg4wOKJ=UHKDXq1a4qfN0r5x_g@mail.gmail.com>
Subject: [PATCH] interconnect: qcom: Propagate BCM vote commit errors
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

qcom_icc_set() discards the return value from
qcom_icc_bcm_voter_commit(). If the commit fails, icc_set_bw() sees
success and skips its rollback of the previous bandwidth request.

Return the commit result so the interconnect core can restore the
previous request, attempt to reapply it and report the original error.

Verified with a mocked commit failure through icc_set_bw() and on a
Huawei MateBook E Go using a one-shot -ENOMEM injection in the BCM
voter. The caller received -ENOMEM, and the previous bandwidth request
was reapplied successfully. The ARM64 kernel and modules also build
successfully.

Signed-off-by: Lee Youngjoon <getfeus@gmail.com>
---
--- a/drivers/interconnect/qcom/icc-rpmh.c
+++ b/drivers/interconnect/qcom/icc-rpmh.c
@@ -130,9 +130,7 @@

 	qp = to_qcom_provider(node->provider);

-	qcom_icc_bcm_voter_commit(qp->voter);
-
-	return 0;
+	return qcom_icc_bcm_voter_commit(qp->voter);
 }
 EXPORT_SYMBOL_GPL(qcom_icc_set);
