Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64E83B9956
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779352687; cv=none; b=Nu5JR3OiTalbbp5o2yeqB8e1nAkB4RGWkbvobCtoWx41jqfVPiLnPJhbpNo7hnQAAjQBT5XeOcAK6kbt4/D9cFcziKiwxA7K45eh8JYcquOhqAXrvBi2u1zzcuO3hVIJg9Cp/vL9s/2g5QWaSPPBVgWYeWBcR4cqMDYY91tqzaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779352687; c=relaxed/simple;
	bh=WNjV02xlopOt/yCOR6c1PBVV+f9PcccL6Myit6QlqNg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NBRyzdMm6JvW6fTVJjx2jg3ZYxNGuT57ngdMNoR8RoJ5qvKH6ME6RS8mkbx1aovelWoolEvoR0GrI7Rl4pzo15xJIKnOmzeMyj5qyKyd3y0Zoc2mQsY1KTPjFVVn0hgZd+4e3IgnoJAmHe3E3YYcQqgYN1N9ArKD8wHJa7wXCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fw8QZ03A; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bP6LEPs2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fw8QZ03A";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bP6LEPs2"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64L7qqSc748495
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=; b=fw8QZ03AavUTjU4Q
	S3ZEST3b2vZi66clxpJ7YbdOzT1lEy0sb6r2I1Ck3VOlZOg4M2Mztk6W82f4Kvvs
	jZLIPlVuoO4nlh7Wqs+/c66Ab49g+3nB89mZqp1gAF8ahSngzWbMG+7on0fZ9YlP
	96r5mc8tTOfipeRDNZsYPXCC8PdK+rWZbnqbtYn/5kAO/MBO4CryrO30EAeszdvq
	4MNvuFSZwHrrLa7k/HvIZsKbSBTRGeglcQQwOd4iQ34Ehsq+6T3FuycqAhEzco02
	gXt4uUtg8e4RrxkRcrjBU9zhs3CpOqq7eZvJiw0NZKgu57dsDcb83OskcsFqwSkK
	FOUi9g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9fb6kjcs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 08:37:56 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50d890580e1so127512991cf.3
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 01:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779352675; x=1779957475; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=;
        b=bP6LEPs2cDIGtqG+FemFkQMBJm/9AG7Vu4ly6PbFxB8HlFhZPJG0fUcQQsFv7wJrqV
         VczONhrbLdc48UaJ2V//XurPxAIBGDmeWrvPvut6S3Pxt8c20F6/Km3y/gBPWLe6RGBl
         rt84ryhVklL/eb2pcTV08DpNIOAQyp+BZhruYdLSSJFZoj0qbso309o3Z7d2RCm0Di/G
         U7nY9jUMaqYz0tcYTzPzz77BBRy8qHWSK4m/2W2G9LqbBAprHM7UnyVI0a3HSbK4rGGY
         oOFiNul5q2L1vDyeacC0Tq9cXdIbwviumoyHfk1j8yt4oUxZpB/iqMVgU7BSkPk1QD7B
         lzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779352675; x=1779957475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JM5WrS8FsL7s/NkKefUF2OuGPRtsF5B5mOOL733hTA0=;
        b=qC/tLhk6rovRzAJVxhnYguv6Dxm5YimFnUOZbxVSNIBcHjmhD9e8P44G7dsuVUN6Vn
         L/oeMsh3/3mABTkryviIOzcR1Agp+OtmiNQnHBZH/i4gjjQvEfgV28XxDQP9mui9MzlF
         OiFcXqkm3W25EMmDHP+7KUPP4PEkeJH9WWO+MIiBJvdNjqj7jnmAcQRwckbBpFEyRfec
         vVNu23wRTm40vwF8fp+Ppgj6NSeiu5A7FXCdyyj717h90Tvl6D27D8GG6vzDUjsfBg1g
         PayyxY4EPVjcEzjAhpt8ytzW2FqJ4noEksjgEVJ/OHwpcq1/xoiiu+KNiga4wSOSzQZk
         IYDg==
X-Forwarded-Encrypted: i=1; AFNElJ91iKYXg7spGefErhdoxMVUzW7kKBUTjsBsJRMJFpvDP0jCchjtNiZJKx7VvxyVWtophwJgNk6r3A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0adIC1Qv7nUbjzNm8htwLFz09UpDkzizaZCUU5sAgLFhup6XG
	9896qfQ38dADSPGDJBSVXs8jsBM/FHwAH7YECopS0MHKT3FZUy0M/xfMHpZzpPHrSXIstNx7ZPg
	7fKvIsWEDHFTBc8mqj4x63VzrsBJjq6OjDqD33Ezh23dt8E0L7R9KqYxQsXv5hA==
X-Gm-Gg: Acq92OGXG7b7xay41s+eZxRCxY4pPc5p+PB+Pi05Yjy6393eq2BdZJM4lsbjEawWq9X
	c64w1o8yA6bmDbcvuDxoiG71EUw48krQ/ZDjMw8HaIayYHoa7R/cAFtYDJcMRjADgE5oSVERV4R
	3IZ6WUZdHmOii9sQt9Qpbe06EGw/boEkKzszVK3lBhHJwRWnfp7fVGG5A39YNT5+pmQq2hVzPqP
	Er1UwQldPANg0dk5wwMVg7OD13FvP8xvXv42SaCjD8wVb/CwupQjNIYatuxKSMBPBVHOutRZ+EL
	BJ/xPlVdsCKIrJNr9RsdIke01gqpuN2qk7FTZkNl8xFPtKjA3+TWG+4cAuLozO2wMZ7dUdkJxi8
	9ysxWl98IWXV7QRtnRJvoks1mmxUpJvh2seNa6buXCJ9cucNq1zM=
X-Received: by 2002:a05:622a:8418:10b0:516:c92e:68a0 with SMTP id d75a77b69052e-516c92e6b34mr7156521cf.60.1779352675177;
        Thu, 21 May 2026 01:37:55 -0700 (PDT)
X-Received: by 2002:a05:622a:8418:10b0:516:c92e:68a0 with SMTP id d75a77b69052e-516c92e6b34mr7155691cf.60.1779352674619;
        Thu, 21 May 2026 01:37:54 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:bb10:ae82:b7c3:d15a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4903caede9fsm10502405e9.14.2026.05.21.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 01:37:53 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 21 May 2026 10:36:39 +0200
Subject: [PATCH 16/23] slimbus: qcom-ngd-ctrl: use
 platform_device_set_of_node()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-pdev-fwnode-ref-v1-16-88c324a1b8d2@oss.qualcomm.com>
References: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
In-Reply-To: <20260521-pdev-fwnode-ref-v1-0-88c324a1b8d2@oss.qualcomm.com>
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
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WNjV02xlopOt/yCOR6c1PBVV+f9PcccL6Myit6QlqNg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqDsQraq494NpNjsZdM6B5yhOMPpc0+cpQHRIzk
 BziCgGQMEmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCag7EKwAKCRAFnS7L/zaE
 w4jTD/4l8BoivhRf297UcPlBF2FNgHn3SoPDZT2tcoCJ4pwYH2iOy+vtLErAAScTa0i+1UqBq12
 r/vnG58789VM/bZsVlX58HBBULss6RrXsI0b1xw8EkCBAbZgWviONlZkPl0INnnV/NQary8Ou61
 HS+Z9Bx2tUipQMxu1TR8k81/EnWgFAvXN2yn6rGm6KlEZGdPPoy+xyAPIudQCSPKNiItdIQy4UW
 L69otnhA4ShEQ1sNMuTK8FbfYGh60eKt7KSdIYr0joMsQqIDzR9lXGYSWsm6AkMFlZSeSDfPzec
 cbKOHBaPD/LZwggKavKmoyvpCN4R/mhifGK8vPPc+GHXXtl4NtFIzFPGDF+P09BUDdBTekpHXKF
 QdwNV1cr2r5NDEAGEz3fzJwU8AlGjoP67Fs3SG1KKOHS6JGuLDV5XEoMu2ujeF9D0wftPdbBnXE
 0XaON/q+Bo68CpJTJ/AKWzJGEasq8K8q/cZQtsbgg5p4M4Mc+Lh2mtvDp4O5yiWshRKBIKs5vvC
 P1+9Sr7JULlC9oNSLKd3qQazCwSqYr8qkLS4hpmeKs22LIastCqlnU5Icf8DpLIDThbnJftTd8D
 mlxLqdCStPGfHY0hJWWilamRC/5mefu2XlUg8HkNToEyOLkmMsb2VNO04VxVf3nl2joirLMPZcg
 tH1KDuWnTXUMHCQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=do/rzVg4 c=1 sm=1 tr=0 ts=6a0ec464 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=zjndn8kAT0tTeq3eajEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: pReeONUEroNrAn7RheB3zS5Y_a8fldlO
X-Proofpoint-GUID: pReeONUEroNrAn7RheB3zS5Y_a8fldlO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIxMDA4MyBTYWx0ZWRfX2149ZUVw0m51
 f8dP0ZFPf9PEd+HTRJfEV5+qJzCfnqpjolgROi8v83mtQF4dIM40F79Fl+O2kS6Fy7dqxxoOwed
 CoImxpYNH/7GJNd43tWBgjD58YljcRtGf9rx1eRHy1xf0Z5YKWEjqVa9nhHO8ybm1k6MdKb4aSQ
 LPBs1jNaAwa30OsfF9SIP8Iwb4dyndhmorE2lLPMXGe7+ISs2swXmGQIOuzavSpNG8qivbO4iLy
 eM+jbH/DZQJDYCIj24eJaLfRXF/xqeAlAsnK9th8XBTO9917U3Bkkf94K2VY2iv5+yAQS47zzk+
 xTWd4M6aBDmeRW/4SZg0PRpweDiyMyfjpoPSn0KLLX/V5O1K5FIDJdRt546wM6d8SNkNKSG8W+c
 gxz6fj6D6WIbvjeei4v9S1Xd5UA7roBBLHoUlCzsHatiMKUcyZj9b1MxfCqRoXQcvNABzaCetgQ
 mvElA+K3wS7HnJN0OAw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-21_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605210083

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 428266949fdd07ac13c5553bded891225c6e1a16..70f06981533237cb5de47a855462220050f6d82b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1542,7 +1542,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 			kfree(ngd);
 			return ret;
 		}
-		ngd->pdev->dev.of_node = of_node_get(node);
+		platform_device_set_of_node(ngd->pdev, node);
 		ctrl->ngd = ngd;
 
 		ret = platform_device_add(ngd->pdev);

-- 
2.47.3

