Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CD138E108
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773654347; cv=none; b=uX6MNAALXKawZn1V8/vs4bHqOX11ypmeZ9lSBVD7FM77XIoBblN0wuiZ+WHBOoD1UHLp9syI4SC62HnunQCeiDxPin1BFhysqh41g6AaQm+OjnVTuEakVM0NbEMndTxcQE0Zbdy0l0pXedWFfJ2w/+qqYNx6P2X8dRDycMhUeqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773654347; c=relaxed/simple;
	bh=Et22qRZo4fsW5XM2dyTAA1YIF7lG8E4lUkHkWMi4kdA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FUpV1X/ufoYkATkM1tMIi/0v/+jV+04svA8v/mG0j1QK/tjhc3MznHcJBKtov16KNbc0/CQBt/QVmBf9ayX4dYVccpgHfBe6MfJKwOaaV7B/61t4fJsekp65Q5MhixZt9fdblpOkDajX/f9EdcxTS7FStGjQYbIUlgiIPYT4Klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JG5AnnE/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q7hqEiSU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JG5AnnE/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q7hqEiSU"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G64adU3777541
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fKMv0mITquv44pXV22U/DAysZwknoanpdVPJIYszFak=; b=JG5AnnE/nAF8d/x5
	VNIZyMN8e+o8g6YrZNC+gLTWBEM1Xas+ZiKr89y/CXRTT4bT9RPPldEQ88BRua6G
	jrREyefTSQ9osqzwq9nJXafRLSdTWwTTp0QhGgPD+7YAzotryVWhbDWkRKnVvEs2
	aD9wb14V/8Q4yyCj9c047R9SfGoH81QjdHcH9MiA0ebcqJSUqpU79HIveU04njFU
	SpDqFhUq1HxphOPBVQ+ccAQ3+1o6zsHcrGy9uNTdoh4OcfMkTQpPHjnuf+XlkSt9
	pvq6nWtzXYYLT5syRvp3D+wxegyORD1kIWzYT10ntFCvBbF8BCXFkmEVH/mZRxYU
	QGl6pg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cw0y7vyx5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 09:45:45 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8cd773dd409so565903785a.1
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2026 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773654344; x=1774259144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKMv0mITquv44pXV22U/DAysZwknoanpdVPJIYszFak=;
        b=Q7hqEiSUp5DnsGH3MFybGnH9GOdc7QSurgFSALV92gx+B3e+65py2pmc5p4aNIKCEc
         UecO27lJOt+8Ub7cc4buqfWZxh7UsCPemFxgCzfYU/RZ35E7odg5FdaKh6UhKVwUlURl
         JQlHN2H5WKZu0vHegTgUr90HWT62TKBJbPTrc4pShNcho9M76Wap+p9d9uVVy7WwNAkw
         o6W+dXFlkkjtytTqPRX1lEbHwoAzxEu4vy0AQ0cFL4Oxc9sdE9WapUMvOAFE8tZUQMYL
         puLVraS0Z6C4s26wkkYHF5z4jshul1n7C52Cbs9J1JKmaHoaHoj24zooTQKy9F4Dn+Ry
         8aOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773654344; x=1774259144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fKMv0mITquv44pXV22U/DAysZwknoanpdVPJIYszFak=;
        b=Id8phW9V9tRmzMdGCH9utLJIRMWQB0mksKhkvL81uGXX0Bumt7Ca+SrJj/FCbxfAH0
         y47uHSbdUA8ylGbQeV0PG4LmkaBvrNKlV5wxtinc2A+AuuZNCTA7ReBjNeIJ+Vg832W1
         VK6bcUUy3uR115a0VkskI3L5V8vi0z8Ae5wSDYlZ/eCU2Hdh0l78GULyym7dE0owq9w7
         84vK/s9HS4yd3Rb7mS1J5CXcUAd7qMRQFWyeNoWxT+cU9+Hd7tB78KYyCRyl5cKSkm7f
         cj1z916FWK++dHh8gzkUh3AfbNg17LYuvlnIWhYT1QrK2XVxjw9RfY2vYbdAVojIXnCA
         muMg==
X-Forwarded-Encrypted: i=1; AJvYcCVEYSAP5dBqva1PdcA2TGx6HxNaVjz0ecT9dq2Zuf0xkb66MctEWJOFAHCEFI/wCqky2OWIyprBZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwwdfVyGuTMqbV8sABPMXo3kTiJUD74nNvQP7HcLYSuoSN8mKQf
	XlT0MQm8Xoc26DgYNs6H5hXFB/nxU23x9z5gd+IR3RXGFl+jMPBwJmqpGwXNtYaIvftPtm7HIln
	81UgxlGWJJEt7Wrd1u/9JvZFfrYe3JGipFpY2J5vFtxfyO+y2hbbFUEsUumuRPA==
X-Gm-Gg: ATEYQzyh67HO7yIaozPmzeayIPpGEeu7R/gdLiC00wi7tJlTLopnYidOYjvSvKNm90l
	17CVmR/5gTpDk44weh263U5d97nHZxRkVh/V2/2DShSrzn/ZPkJVg6Cwf4ITTk7g6TkeJZyPikO
	R0fOAHisOYuZM/iHxuEsbZqekn9rxhw9GktBjTxfnNEd1+wD58/pLWmsZh9jfi9sLqllkjOvLtW
	L4Zafw+KjVR4zmaNMXG8C1Fxpva6+9tUIb2oAuOKQJGlqrE1qQLeYXSWXZkxqXKcNrDbp3gNhRX
	S5UVGQRKqz5AlIz1QBlwjl5KKGpRg1GwYoQJfdnjtucJCC8txu8AJ4gT0lAYSwBSH8qDK3YTldr
	c5zXfLiWyXwkMoKMWGkJHJ+3mDYjq1IVDVK1KdmaOYAOJK1g50g5V
X-Received: by 2002:a05:620a:4488:b0:8cd:9a1d:507 with SMTP id af79cd13be357-8cdb5b05cbbmr1541325385a.53.1773654344084;
        Mon, 16 Mar 2026 02:45:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4488:b0:8cd:9a1d:507 with SMTP id af79cd13be357-8cdb5b05cbbmr1541321485a.53.1773654343591;
        Mon, 16 Mar 2026 02:45:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:ba9e:e504:fb0b:f1f3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ab9f9esm503138755e9.4.2026.03.16.02.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:45:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 16 Mar 2026 10:45:21 +0100
Subject: [PATCH v2 1/9] arm64: Kconfig: drop unneeded dependency on OF_GPIO
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260316-gpio-of-kconfig-v2-1-de2f4b00a0e4@oss.qualcomm.com>
References: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
In-Reply-To: <20260316-gpio-of-kconfig-v2-0-de2f4b00a0e4@oss.qualcomm.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Linus Walleij <linusw@kernel.org>,
        Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Reichel <sre@kernel.org>
Cc: brgl@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=760;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Et22qRZo4fsW5XM2dyTAA1YIF7lG8E4lUkHkWMi4kdA=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpt9E50k0Yyy71AuZlT8Wc65mGgqmwiMHz+yTE9
 mBP//nBbEmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCabfROQAKCRAFnS7L/zaE
 wzh0EAC3O+9SFE3V6nL0tyeLcO0MhgOELnTHnumU0Trq6qxKGHWv2wW6+NzHZXi3AfchBdL0E51
 n/t4F7uCATqYUI7vKH8azhV/4lPHX8SmA3OVwnPbYWk9V2Dn/gnAev750KpWQtwnf9PSrz5Tjft
 DvYivEJMrr2Bliop6ub+CP/OkgFZ9/3ZNwVjGtd2wrTScmGg/p5AXyj9l+6kivWIxz7s6OmwV9k
 lK2dxVVy3J0Tsrz1TaQMYfulx+Yy8aom9UeRNHPlgdSokyA01eHQ7eLRtEhXFREQvZdRBh8+dGn
 NBiSftUMD81V/Oc9dB6rHXafNgk71B8rq8TYqW/mse/eywvTtgYkkrdKfD7dBktZM/sGCXcYyl/
 oKaPUBa/CQhpNu2cwQS5ono7MSRaKGG4sOdpQW0U8iuRuuMJSRCm5VLyD3rV85UFvLRoILKK+bc
 npCLMn6s60pbCe53JNECxMlnR31Q90oI/0aXVK28IFcM0xM4FTQnVVm7RqnDlyJHvB7V2CKNUUi
 lhEtZHCoAmOqaIiZyeTGFqYFKryUZNA7fNS/h59H42ZU5oFk0BoVvDfIkrx4+MjEOo9QzKMuAe3
 UN1ji24LppAAKJPaYClbLqeKvGJlGjbvOHxIcXPYqYmvb4EVe/30U2+xg/BDS8rFMEFj/re88ci
 MvP1Pmh1dsosBvA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: a4jcrwGmAfVIQ_KPrM1aXVNMd3LkuXbC
X-Proofpoint-ORIG-GUID: a4jcrwGmAfVIQ_KPrM1aXVNMd3LkuXbC
X-Authority-Analysis: v=2.4 cv=D9xK6/Rj c=1 sm=1 tr=0 ts=69b7d149 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=nExzm2HfQztilrPChXAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA3NSBTYWx0ZWRfX1EoWIviTnb76
 qceMAxLEnYW0SqbJ/+W9ZAWKDXfvqKPBde5kdhvEc1dzbkkdclqHZ10JFrs3s6T+STC3DPlgP6i
 vB0CR1O4iQHRgERGuB5o+8RI/D+RYtiMtFg/ViRtLn1dGyYXUmbpKKPFvWIsWq9tT6c5cMctti/
 iAh1AWkofJ0a+qBimPgSu/WEeXI+2f9vNcra+zZSJvjj3jP2Kxn6wQpm+volg3ip8UbKQ/03hTN
 ODMiniPkDechIB/aKwEkdP7D1MKb+fEziXvmnMjiNznX12vMmulcv/7yoEOyUmJTBP81le2ovtC
 9CbJmY+7G/KRBWh8Ybb2SK4UkcZY/cOxetKQal5KSeyIKPDueLkoR8+/5ShhVCYQthkAYWOjXeD
 jY69wM8lVs7X92UyzAajSN4VLcG8zuD4HACfSH1as1X/bfw4fd+6X1Yom9mJWf7jdGk1hi2hRzG
 Ex7QgghQ9MQ/rdntZ6Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_03,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160075

OF_GPIO is selected automatically on all OF systems. Any symbols it
controls also provide stubs so there's really no reason to select it
explicitly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/arm64/Kconfig.platforms | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 54eb1d7fd419b4249a6860357da8b3dce2e2146d..9441ea827524df368f5aa1304b0122bebac3d245 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -245,7 +245,6 @@ config ARCH_MVEBU
 	select MVEBU_ODMI
 	select MVEBU_PIC
 	select MVEBU_SEI
-	select OF_GPIO
 	select PINCTRL
 	select PINCTRL_ARMADA_37XX
 	select PINCTRL_ARMADA_AP806

-- 
2.47.3

