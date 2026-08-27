Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88237347FC0
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853090; cv=none; b=kbtu/TiSTikPMoJpJQY0NAJByZfTNJauf3+hp0nF2NZth/xoJ4ckD3jg3lw833dUVPr/svknKpCZVuSKtswzavEeCJNZcC0iwDRXnWERvAFzTbPSW5hsEZ9soYW+yua7iassSS1rQpxvSvfIAu3jsU+19DNNFvT+N0dSgjCcPu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853090; c=relaxed/simple;
	bh=iY6li1N8aOWymAjX+i7+r5/1IUwgJvmB/19fYvr8jWE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PoYpG/d0/QbfUGTe+qgTrP9QR2/Oz2cfIifdLQs9eZekgirV3pPs5q0M3TVIFuycWvMm4ykWLPq3Tgy5uNd+wKLdtP2/mQ90aUGV/0EuXGYuOOf7Cn4FVRZwO3NDRc6XzlnKlJIq3BGPtofOkR1QcTJojSeXkxg/3RcpHU4Zm20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3AgYA0R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hbd8h9zu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3AgYA0R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hbd8h9zu"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXf6Q1568377
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jxfq3sde3/UWkYHQSyS+xk+eWHWNfmqXAOsgq3B6bQk=; b=Y3AgYA0R+YWLTJHV
	Bq/ckoqpNGdWK2Ttu8lSuK+D7x2nGLU8JKFm/5jeiUrV2rC+YfDU4uJxRmjKaNVJ
	MbszMVA4hRAaycunghcsMHaLCY4MR+h2p6cVlNGQ03+uqFufDXOQILmU+7IRDpWK
	khH+YytFiUZEwBZFpniNS3VvPBCGjDDzUkyCZYaXZpuaCUcdUpqHo9oeqMZKZ8ib
	Rgj9DCHJTe04xo6cwkNxddZgGigGHePjlh9ihRa8ByQJgpTVgM3evALju8FdKczk
	ONfnXDlbU9fvA+kL99Fbc3873D4cG9dNloO34anG4L1wl02axUFC6xegIX/Agi16
	uc9gzw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga8m5m9mw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 17:51:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1d85c012dso233463a12.2
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 10:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853088; x=1788457888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxfq3sde3/UWkYHQSyS+xk+eWHWNfmqXAOsgq3B6bQk=;
        b=hbd8h9zu3Wasj7FUYAhf6DyQiWm3NAhnmGTM4i4BeR6LmsLbbSMmzvXC/eg0ow4/QO
         YfHGpbidXgfkVAWyUMamXOD3/ZtzuHKNqZnzycgUPOAFM/9j4X2hhlGPn56s++le49W4
         /kT2+zGctoBDrJh4sQ8EA1fhHp0Aqomj66rAKam3WHYRSy0FcSD8exVqHoBFC+oc9GXI
         8rMPViY4XGL2TIpn9x1QlJ/yrxF7e/bRxlKeZSAkKqwVal+7eqr+5kXrJsR0ggBNjwA+
         BF3CvrRWfOvVn9AwRwd/oGdwTMSjUeRs7Ja83P8lYfUobzy5R8SLEijyM2gmCHbY9osA
         jrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853088; x=1788457888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxfq3sde3/UWkYHQSyS+xk+eWHWNfmqXAOsgq3B6bQk=;
        b=ELHZfung7vK/F1i4ZbLvnPVLK3wzl8CtvZZ21e8qed97KtcrjtN9iBWYr8X3Rg6PoY
         jVop3b9mRrErWqMTYNu0xGkQDvWQc5nXlhnMc1oZRgyofBF0Xlbo9zknNzyT/GnohLAB
         7AL+XtQKQplEQaxZVTCHhHwu5KxsEn+fm77g6l0lU8Ygaf19/e3vzQ5XfYvUN8yqJhcu
         Fn5ijG8VPJ5y4EwQ2bwmJRRlzmv1rxO1Xb2jic5YU+vUSbkfC8YlfipviVmXT1dgbxPQ
         YB48TY61vqOoC2taKlJkABqR5aTZ/IA/HG8SV8mhrCDSg7MxJx2mWaIJyL3yU5UQncCS
         GiYQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhtvTlC5LD3JDuxahgztCnhnPOHaUtAfNVByvS3KnKGqwnJnZSSnpyF6xIMXFB0AU66ZuObNH+6A==@vger.kernel.org
X-Gm-Message-State: AFuF++my2GkCb65VAquYGWbDOydEJlb2iT6ya0Y6ObvrtWdCrKZhClLK
	5h17C7QKMBPrzgOx+ra5fToJ6j9zIC2WqyTTdYdrRPEsXas4T0kYJi0LKuIX9Wetfe4UN2mZF8R
	1Ecqyk/wIpEwPrmPKyOQlXjjKu8T9cFu5e0q4W3BAeIyuzybNCOrzPEENOseiZA==
X-Gm-Gg: AR+sD1248R3YgA96YMhIbmze0YI+bLpkGOg0EByQ7hCjYp7plLXSwGTEL2FSOr8B8la
	m5BlzBiIl9nXIOAzlQEGwRYgWcQ5i6Kd3UghefOqnLWOHHwTil3kLRYUEN0rk7fBUwOg3GXoSRL
	wWE5PSaqjue0rZBUP8dZAa0iAbhLp8ZdHgEvOsc4/CAobEctHs0lL7xC3XmiD1AF2SqMmqNAEYR
	nj0B2gVUXlZMa5Gg3EbnokYaCjKfp353lOFoTtXwuD2RFCajMVfHKE8kPmqKbjtE6rAFykSpDJk
	3qQ3uB3ZR6iXUKbWU4cix1usysxHNwWJWeVn1eagiRXO0zUjUKEXffhPDAafE/63v9lbkt5Vdhd
	t18EcVRvIfar1em14bFoAo8pxZJRzh1zcTPvjYCQjsiychln0HC1+Yx/hCPgXF1BqnrOoFbDho5
	OUIzFCCvbhdslX4aLU+GMp2u0=
X-Received: by 2002:a05:6300:67c8:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3d269519f70mr1365605637.18.1787853087954;
        Thu, 27 Aug 2026 10:51:27 -0700 (PDT)
X-Received: by 2002:a05:6300:67c8:b0:3b4:7e2d:a3c2 with SMTP id adf61e73a8af0-3d269519f70mr1365493637.18.1787853087471;
        Thu, 27 Aug 2026 10:51:27 -0700 (PDT)
Received: from hu-hardshar-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60d25esm23889316eec.4.2026.08.27.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:51:27 -0700 (PDT)
From: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:21:04 +0530
Subject: [PATCH v5 01/15] soc: qcom: geni-se: allow selection on 32-bit ARM
 Qualcomm SoCs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-kuno-soc-support-v5-1-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853069; l=1026;
 i=hardeep.sharma@oss.qualcomm.com; s=20260204; h=from:subject:message-id;
 bh=iY6li1N8aOWymAjX+i7+r5/1IUwgJvmB/19fYvr8jWE=;
 b=aHAflXlP1yHXGFZJprnZ1WdCMs9h3s8lcsyK93pEvfx6jZpxExN02LtDY/m8J+rWWBNQyfJWV
 Z6kTXnWAb7XD0B7JqZJqGp21mffzM2wgOR4TI10aG/oBKL4c+4jXQ3D
X-Developer-Key: i=hardeep.sharma@oss.qualcomm.com; a=ed25519;
 pk=IvwPDKA2xr6jWaCIBBY2ran/H0124QUzVfun+CtEikM=
X-Proofpoint-ORIG-GUID: 5i9U_otJnoBEsl4HY9pTbbxFGQpBhFXo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX0IeIo7oq+Uef
 zmkcoYBrLGDc+c0hJ9JMd2aqkmvuCoKPh2HGyxLtFX5n62uRoY17yRln27r/FYFvkskx3R4Hpfi
 wmpB/HVaenUX/qCDb9W1H3OD/RkvhoE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX46mqIiaOb74i
 gv92E16i7UH9h+ke01zeDotLfG24o31XuDQRcVX6+ynq7WDo4iBzxKuKuOemEQv8m3q+mYsrkrM
 FEke+zfyH4xxxxr+2vd4uQd9Q+Dwud7NEdkViJoUCRbfLDxaSWjMVQEeocMxXedrWWhH+BWSk5b
 ePiQPRQNVNQNrm+FefWX56IgWkRQRBy1VEdCMwpf82uiKwkOfOG5GQ6sev/o8achinOhuGxi2W/
 Q0+oFrlZbAvr5dixYHzFmGI8rzPefuXiLXf9KkSDTaK8vN4t4eUXvON6ujhazCOP+JxlqJm2TA+
 kaFlXefvzPTGph75nUxb1YbXEoHnGSgz5TJMnuHv9jHcPJjmEx79oTVlY58RmuCBG6lCe7LM9xO
 L0iqEIPbE1/t95xU/LD9hAHnMp7Et94TPc4dhjg9FJkn2712ZRmEyjdcWBis/wSGZWBatnX1RRG
 0UUj5hjiKsAgiiwwGEg==
X-Proofpoint-GUID: 5i9U_otJnoBEsl4HY9pTbbxFGQpBhFXo
X-Authority-Analysis: v=2.4 cv=SomgLvO0 c=1 sm=1 tr=0 ts=6a907920 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=I-wlBW6BsxmxmlAWD-0A:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

Kuno, a 32-bit ARM Cortex-A7 Qualcomm SoC, uses the GENI-based QUP
wrapper for its debug UART. Drop the explicit ARM64 dependency so the
driver can be selected on 32-bit ARM as well; QCOM_GENI_SE already sits
under the QCOM_SOC menuconfig, which is gated by ARCH_QCOM ||
COMPILE_TEST, so no replacement dependency is needed.

Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
---
 drivers/soc/qcom/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 2b524154d9fb..9f703261d7ac 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -39,7 +39,6 @@ config QCOM_COMMAND_DB
 
 config QCOM_GENI_SE
 	tristate "Qualcomm GENI Serial Engine Driver"
-	depends on ARM64 || COMPILE_TEST
 	default ARCH_QCOM
 	help
 	  This driver is used to manage Generic Interface (GENI) firmware based

-- 
2.43.0

