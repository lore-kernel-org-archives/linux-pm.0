Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3973F99FB
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782724385; cv=none; b=pWa1tNfWCoZrMd2WLtixqsfjqcKEPjE5iGSBtnTVxr9LCIYMDw+tz25z07mwzT1uYuBLH890w0nDlAXeClTF3DB0SaWZ0vKMOaGt+sYdVkWdyq6a2N8R6/fQytcgb4z+jrvriIPQZ4pk3v1APBoiNMGxmIspqiy7GKshxULTFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782724385; c=relaxed/simple;
	bh=d5jcui5x9J+nHSVyJps5DuSu5oenM0O/Al9uUGEdnso=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rFIzgzfGnbMDH95j/UTP4MuOdKpDF6B3hO03Mi+7UMXA/4BImxIBsd9Lp+3CxzBQTzIXy6peX/R/1swjVcpv2eQ08q1xoIjs/DWdmRmy/L6bDZ+STPq/jLEI+jv/DmfUSHuuLbXCDolspoKUpHbRQDH88JXHL2kuyu+TpbUEBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=isT3VW3/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Nm1M/j00; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="isT3VW3/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nm1M/j00"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8OO462349158
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=; b=isT3VW3/K/PEvzSt
	0eA9gwQkZ8kGNcHXyYP/wm8BjPG1k2/0bZmE8+1VRn8sVkzUKeHuemwQ+7Q6iNaW
	g4hP1vbZNgohSVU4LwijTPFCUGCwC334q+d9wkz+u/1W3s3Bry317p/IMW2eXaNo
	9/dY+oE+w3vrNs078sXFz/YBaNmRtbCOJkQ2fp5B6/B4hLkNSvAr9oFxQwffENlu
	187qH7MGU2hi/VBn4z3yehsAJt2rFyyiXaSj7y0CPtxHy89C8wPDdEAt0M9nidlf
	qeXHCGlQa05Wx+S79iWEve+eNIoqX2EK+5eUadVOBM8IH25kg/oxZwFqn2kJRM7x
	vK+4Gw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s078x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 09:13:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-915d3261c5cso640516785a.3
        for <linux-pm@vger.kernel.org>; Mon, 29 Jun 2026 02:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782724381; x=1783329181; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=Nm1M/j00x+GSslrZ0r2S5xS8MhdjTHtS4uNEQRdyBi0eEndmZ8vS6jCNwSddHolKWB
         NBpXGcsWflaCjhCQHPaw2k09pL0egkHwxGR5bSD6vzCqNRtZqalHw/DdWiC8ScFX7dIs
         HoLIsyD+zoEawia7qqoxSzwYRTyeTXejmVzMpnxPRI1/WKuvUwDndtbkT9Nv8NmfiVII
         8SzCocI7Yajd79gU8jsHFvGGOps+gbxn7sROrwiqnxRQP5E/9X3IbH+TNBSSO3PZMt24
         NdOeR1bZTwSmje9ve8pOD0ba557Ei5SgwJYyjyf977gKEunOOUjhctIZpnvmMvXvOYPa
         c0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782724381; x=1783329181;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4jemJMg1mPxTimQgHduXv2Tk1YXpvQTVBHPayB9K7NY=;
        b=W569S+C+/Wk6+R61tg452yz/Afw7A5Qwa5LIcF+3Eywa2AVSLoqQKtnbnZDNM241Ao
         ZNug40rfWER/iUc1xtb6p2YTtyz+7OqvPzHS1zMXqX8wevsevQfXDkSJFBNzBDCuOlKR
         KVqGWgDFa7Gka3oqbwx7Yuu5mSNLNNMOLxTz/Mw3tEa90y93HdB07q1kjNu7+i4MvN4H
         Sq2GrR6f6Y3HTN2OgEbJo2sXyS3bjQjgamV70dyFh0k0zydtwGIP4SNlwzeNz/zrEp75
         RM3EN9TzqHx5pWbQHSQARHVA61w7wXDfdasSEprx15P7uxrwac3cuogH25rwPujmS90y
         oDLA==
X-Forwarded-Encrypted: i=1; AFNElJ8BGRwewxMu24WvUO52S2RTcJXJu/XK69Adqx74KlaWMFueEc6vvkm70wSIhBQOYWMDVfTC9F16AA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzUoyUIu9GXP2npYTmI3rK3Jk3RexXJXpjhVvZkuIHxj1ltYAOY
	3NRf09OQjueQAEXiB0bB8poZ7xQYR0qBjmQQtXqpfZQkwEw7WAzYG0dkzamBVRXw3WfjDSzx+D7
	xVdq3ykQO8k3fFuwijAlEfLhdvkUx9/ZKsHOSer9nf9yFL0ZXcIdXZlXDMyT6cw==
X-Gm-Gg: AfdE7cmdssMraV3FGO50MhW6axo+ezuEKgPiLgUJB8sX64WslJdWNh/uo9IveT5oORI
	kt8fnn9Pg/USqxn2SMrA7ZQHDbPuBN2S1nTKd+vi24fZvwuf9dFiHqNyuGOXvL52d6iAR0MP3/5
	80/TUHDaydn+VnVsLg5AZcPmWon6Xxx7u6eAVb8qUe/4Fz4+GByMQZvWupoP7Pz2orXSsRW6kur
	I4muJKQIJjcbfJKTCKgMeXBER5T8/adShCucO49+Bc4+T9E/5M3wvh83O7mxjuT2xsG/7DmNKxN
	wLZf6DsInB9FMY10pvoP+qX+Q+K2OxYGMUYo1Pj6Oo9s2nb32JdchfRbzwspF4TwgwadPkWyiR0
	Ejnv3CyCjk4lITMzWiCA7uvpGCN0F9zwjhM87E0qh
X-Received: by 2002:a05:620a:29d5:b0:92e:46e7:79a with SMTP id af79cd13be357-92e46e70a7emr695283985a.2.1782724381047;
        Mon, 29 Jun 2026 02:13:01 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:92e:46e7:79a with SMTP id af79cd13be357-92e46e70a7emr695281985a.2.1782724380556;
        Mon, 29 Jun 2026 02:13:00 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-470f55acda0sm20109240f8f.23.2026.06.29.02.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:12:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 11:12:24 +0200
Subject: [PATCH v2 01/19] powerpc/powermac: fix OF node refcount
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-pdev-fwnode-ref-v2-1-8abe2513f96e@oss.qualcomm.com>
References: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
In-Reply-To: <20260629-pdev-fwnode-ref-v2-0-8abe2513f96e@oss.qualcomm.com>
To: Lee Jones <lee@kernel.org>,
        Mark Brown <broonie@opensource.wolfsonmicro.com>,
        Thierry Reding <thierry.reding@avionic-design.de>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>,
        Saravana Kannan <saravanak@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Ulf Hansson <ulfh@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Matthew Brost <matthew.brost@intel.com>,
        =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Peter Chen <peter.chen@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>, Bin Liu <b-liu@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hansg@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: brgl@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
        driver-core@lists.linux.dev, devicetree@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, intel-xe@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
        linux-mips@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1407;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=d5jcui5x9J+nHSVyJps5DuSu5oenM0O/Al9uUGEdnso=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQjcGKkeSuvIIpV/DPVwpxHoLTRKrAfS3RpiE8
 glH24pgdmqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakI3BgAKCRAFnS7L/zaE
 wyj8EACLmIPboyJTTr0o6LOahtd8r1OD1ezaEmjdr9MNJUTSB3k2wDSW0EQmYLVfEyIxWFqTHHQ
 5em3qpvbnfRXSUTJK47zbWG9K/UnsiqlMpjX5BO2mxMlnhYLAFPyVULoWSYAo4JfO2VgNDIxVPQ
 NYJNAPo4fTyS1JEL+okr8KZYFPtT3oUZ1JPZCcrrYlcxTh/PMXG6kxw61fR5aPve3RlVUy4q+cu
 xDHqpPRq9+YS5DOUYpIJ9ufFDc4vabR3feAsDHsFOQqyqXY7sjjr90XFN2LLwl+PI1CIDGSY6L3
 whzLq2A4djBjppjKi4TTwI+3zzMKrtFDRigP4zS5NmCdTy6qGYl7JwcDlQbluwfgemH2ry9a+3M
 3z5f+rfhXQNTX8/esd9xzkVFTaPeL8ICuj1FxrYaxXoeTFqeyiIketmNBN3700viVsmhjoRgbe1
 9wSaJr2PxNmod6oepFw5/rlmqPndAgbwuSsvgexu2OziA4AgA/oltqCHu0SanP3qC5pEAy/c1du
 cr70pKyU3od2xGUpnPOkWsxtWotnF3EVvY5Lm2TcMNoj4uQLY+ursm0qNcqoGpJc5ct99YHcLF2
 tuTPMUvUHkuoWGpprlKF8rxr/TJgkGTao/Eah0YjzNcsNjZCXfJn95wN7lxX4tVoQLUtvLmUYCv
 b4yTpi6iddu/94g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXwJ6a/yro5hdr
 v6TEROGxBMv5avYToZr4TYl0BYvgR59UGbMRanP3pljWHBROH04JWu8thfwbV1Eo+hClRbPcHzh
 ug2U3bUkMl337+OehZ3n/1Wfw8RwSzY=
X-Proofpoint-ORIG-GUID: lWV9fn9BqBePro2DwjMVZAI_UkeOCWCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA3NCBTYWx0ZWRfXyoWghn73PXii
 1cNQKWw6Sv+fDLQeDSYVjmRttDt/qejww/AWpUI6shBT/cqtNxrqVVbXUhE+mxr7qTZJyy/IU7H
 kl27/YEdBI/z5WazS+PF8IBbPC90IsnfEiJpQexuBvVFsZJDpaIGDYrtAm2hXpOrVy8A7QVxpCW
 lqeClh9OQ0tnjMYgPHvR6YMaHqHgWueZN4hyt+ZLMfCLEfErTvrMfhUcjRMuZl42RUbFkW/Zxtm
 NM/0gYiAJkBlTxJ7XkVQ+sddlRlpihAMo46exMsXvilNDzwUzH5sFTPHV9A+U7C4ismfmbZa+M4
 qpDpyE8o+qyex9/cw1ETz3OLMgvwqIvrkBm46832zCDs2HeMDieKo/LwF/gtT+Q+I3ekeP5il+v
 3Yn4zr0jqwAYaExVl6WR5jAKdwB/0Isz2PAL7kITDmOqPHEsfI/xQdnj1nN0NcyyBfK54kT7Rdz
 aIfgbRZoIWsFFwiiJzA==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a42371e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=lFaTzyIiLygvDfm8gxsA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: lWV9fn9BqBePro2DwjMVZAI_UkeOCWCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290074

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 81e5d8646ff6 ("i2c/powermac: Register i2c devices from device-tree")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 arch/powerpc/platforms/powermac/low_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/low_i2c.c b/arch/powerpc/platforms/powermac/low_i2c.c
index da72a30ab8657e6dc7e6f3437af612155783d8f9..973f58771d9636605ed5d3e91b45008543b584d3 100644
--- a/arch/powerpc/platforms/powermac/low_i2c.c
+++ b/arch/powerpc/platforms/powermac/low_i2c.c
@@ -1471,7 +1471,7 @@ static int __init pmac_i2c_create_platform_devices(void)
 		if (bus->platform_dev == NULL)
 			return -ENOMEM;
 		bus->platform_dev->dev.platform_data = bus;
-		bus->platform_dev->dev.of_node = bus->busnode;
+		bus->platform_dev->dev.of_node = of_node_get(bus->busnode);
 		platform_device_add(bus->platform_dev);
 	}
 

-- 
2.47.3

