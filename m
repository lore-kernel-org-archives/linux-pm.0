Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD52F8EA6
	for <linux-pm@vger.kernel.org>; Sun,  5 Jul 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783270471; cv=none; b=CwpBaEZxrW1AZlm0bXS9i6Pg/K51Ad9FgnNmSGC2XvxaPCHF65gqsmr2pMWG9bBGtzewcKvcwT+NHKGZQ5CQPCut2FQFHGq8UMz5AzbFs9q0+zMsHjb/hfCt0E+H7ETHWGLzlQOjPgiTQ0z8UGBCAgVPuHdwvaaTSB8y95cpaT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783270471; c=relaxed/simple;
	bh=+7wdWExKan4dBAAPMYMsUwIGbTDsI54vr+pKiGN8FWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PA5ikLPWsvrNcqOnWsOh4NXV9RRR/eYa8M8Qdihv5n9s5LUTc7On4UwtJu6p3OwP3332BzVgfY2j4fd0jwcurpubj05GVRnRbVizKItnHyPBDvnkADrJafrUPXNg7R/OfLXVC9lzDQNnY3/y79G3Bo5yAUf9Pg4WCIHypM3Dln4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SVBzlSZP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AZ3JA5ed; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SVBzlSZP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AZ3JA5ed"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665FAAcJ2030334
	for <linux-pm@vger.kernel.org>; Sun, 5 Jul 2026 16:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bcGL98DuA12zHO/juB09q70kHJyhbbXB7bS1RIzVhwo=; b=SVBzlSZPcHJtmA2h
	AXMDPJYu8HggWxUlwWr2KkcOV6S7y3kvSfoEgHhfxY/X3z0KJnYAIlIM2eAh62Fn
	Xv9Yrli4ZSmuxnN5D5cbWxjh7IVieA9BL5IqxIdoRyQ3pKq7RYm/iJchmWyb9Mgd
	LdfmJpY8GQ7TLUk/k/eVKaPwA5frKL8ZxVYpCBLvRgP0UdK9EA9p+bNkTRE0C2C3
	iHM5XYRo738p0w2cj5O5AWXdbBxSYtIR3q4QHy/6V6hco1HoXNvp6XvjHQekEEov
	iPFXuPfTtC2xibb6MyCPqLRfKWoSvCstLjeKX0ULg6T0IAtLNpju/dPofHJfTRL9
	kRET6w==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3b1t8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 16:54:29 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c8894570b58so1528611a12.3
        for <linux-pm@vger.kernel.org>; Sun, 05 Jul 2026 09:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783270469; x=1783875269; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bcGL98DuA12zHO/juB09q70kHJyhbbXB7bS1RIzVhwo=;
        b=AZ3JA5ed+MU7w0AfLQsTN8I5N8CcK0pKWMOE7TsD2pq59e5rs/s7PK9o9vckmbb0UE
         XPjafU6q1J0VL9sQz7p8KEv7FxvasBCKqMADhxjdc2eyf8wKcM+8i5NqV+twZmnq/QD/
         u3R9eYwM3AR27e5fsNfKU5cZDBd7mgwkJF8QD3SzQ5xu0GCImDQFpLnwUplxDKHrl29z
         ccfk5pf5lcPGkEJkBr/khHFLtjBuMlziWprfpZV387crSE2J6eqMgWw5sU206ef7YwvG
         et1jITqf10yaLS2SkWckfkX9IasinI2WVfdEXgRnvjABU+2AHbeZ7UfbLc7E2GM5njlv
         cICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783270469; x=1783875269;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bcGL98DuA12zHO/juB09q70kHJyhbbXB7bS1RIzVhwo=;
        b=Q1mnYUKMYiFTX+kIenNpWEX4wNNjhmh3hwHrNWLmBZeSpHRiXL8tJCmi5G9o3rEoAQ
         mUTk9FA18bizkYQ6OOdHG80Red32PzRFY+p7hfSjGKuNvmK/6YUvjlTykBWC63bA8ccm
         654v7wrLg6mDEKkBmzKu7CGh/b9VXJTGlVNbx6APjXJjrc0/gAQbSmaOSW9iOiuDoWnJ
         +YCiqdk3CATZnGyAO36riMWlSjBg6o0B5iTqVjx10byedfSUBNJTOrivScaTIlTYIkxa
         rjnzktoBhpUgVuAoaTqJ8tL55h1PwoczntbPCw79QVDeGkYJo5r7IeTKw4YFqaVt1UPB
         J9sg==
X-Forwarded-Encrypted: i=1; AHgh+RowAKD4QgwS4R5meUxlJFypqHuz4H/swmH520T27Z9g+rawnnpKUTOCHkBWcxa7ra4T/Q8qDPgTJg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0xA/+zYPLU+389W09m1JkH8xpTauBurHudZC2Dnc7+9/IwCIB
	mHp5gTdtOKKjFRhHtq6OYC4uiVjnTNOsj6qsGu+jHezFhp+X/qTMvuctl2xxXPKrsA9sw0Xlyis
	fmRtr+I8L1RpMybrzgUGIp8q3NLvgb7nRaALlzxpeJp3gE8ILbgZpi/Op3NxbVQ==
X-Gm-Gg: AfdE7ckfNAxNghWsUErZYEbbhS15uROkZlZlOOyT0YtQTb/u+AyCOLgHN7hNh8nEgbX
	11z0bWMhdyCoLcddOZOiboYpzVz/7hzOjk1PJGEAhwdH73R/UXk9gEZSOBERFJOgCbByZ8Ris+q
	XIgBklgYXp6lunDh00A2S7h+3xLx5Pj2MbN7dJ95gEz0pb1WGk9KtyDsFCygPxnJRG5qWthGfxE
	fVv1N5vkpKKwAn5UVKCaOCpORnAiBAIz3idLwuN9qHi+NMCDHW1W2rTv4foQ0S97RwGIdTI77lo
	1JEW9hGNFEcduda13nI6qwbKWaNJ8nKjOpo8Xlen7YRNpAK/7y37ty2pZyhM0wpT8xszNWDhVww
	a/5THRFd0GirOA2LKBM7op3eY9SeoqA==
X-Received: by 2002:a05:6a21:4ccc:b0:3b5:52b4:87a7 with SMTP id adf61e73a8af0-3c03e1ff338mr7092195637.6.1783270466152;
        Sun, 05 Jul 2026 09:54:26 -0700 (PDT)
X-Received: by 2002:a05:6a21:4ccc:b0:3b5:52b4:87a7 with SMTP id adf61e73a8af0-3c03e1ff338mr7092182637.6.1783270465702;
        Sun, 05 Jul 2026 09:54:25 -0700 (PDT)
Received: from [10.213.109.130] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f3a9341e0sm38253593eec.12.2026.07.05.09.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 09:54:25 -0700 (PDT)
From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 22:23:34 +0530
Subject: [PATCH v3 2/3] iio: adc: qcom-spmi-adc5-gen3: Remove an
 unnecessary print
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-gen3_adc_tm-v3-2-ac62f387dbce@oss.qualcomm.com>
References: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
In-Reply-To: <20260705-gen3_adc_tm-v3-0-ac62f387dbce@oss.qualcomm.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>,
        Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783270447; l=943;
 i=jishnu.prakash@oss.qualcomm.com; s=20251014; h=from:subject:message-id;
 bh=+7wdWExKan4dBAAPMYMsUwIGbTDsI54vr+pKiGN8FWo=;
 b=3RwmjgkTbbosm+RA9fwHMFB03JeleNEddXPrhgA5fuHKbu69n7qr/zoopsBgm7eXGUOZKOv77
 Mgz/+KLp3BLDgjT06jhQQVsUJ1DnafRaD8IPIxDURVA3RyuIVHh1DeK
X-Developer-Key: i=jishnu.prakash@oss.qualcomm.com; a=ed25519;
 pk=g89pXdLVwRjdTeQ+uX1QzvBO346E3hQAc1N7fcTXgmk=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4MCBTYWx0ZWRfXyh89Hbfx+s0J
 qM3QIp87o1OZpZiHLyUQcTJIkOGjHGERpO1oRifUm/I9S3iDMESTXf1wQBFMxyb+GOaVp2cPeyG
 UTvhpzZ2+XByzCHQV89GQAb0tpaZ3KY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4MCBTYWx0ZWRfX5pIRPngHP0mi
 y3Az2/F+WEkMci64hO82awaJz5v57nG3v7b1igROEPkrOeFQ2C6kVSbcRDhYyuR0wqaaeRgwJoc
 l6B/dNeSKYXPGpWmzzAkdkj9iSdnq/GqlOex4Hoh8z2XuqEuJGkGmhF5N3BcrUZ53m1WWDCGOak
 TvhJ7oolqJthR4/VFTw726nJKgVBDV9KfOt0v+Z0sov1Xct1Qy2ISGGVyCL4C2+1n2cEYuk1jPn
 ibRjeuDyXYL/um1tGuMtOBY1KAoYr6BM7osrKkE7zWUC9WV4XuZ23vh+bME8Id0C1qyCw9YRGZf
 ErkmM/a0Mlt+8T+D11Bu2bO5AvaXVAjJKeANeRZljpT6ArThZtaiWfFV23jE+DAkiAB5QyqKqmV
 rSNrHrb+WOPliaEXuFWueoyvuREBgOs6+pp2LOSZjXsKeSwUQN5uSc+osoFBXzpvsIEu3He0fjs
 FZlQTxgQgk23OO77C5A==
X-Proofpoint-GUID: Ez6R9SieaHF0jWg6oL3ikI4xzip5KX7C
X-Proofpoint-ORIG-GUID: Ez6R9SieaHF0jWg6oL3ikI4xzip5KX7C
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a8c45 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=0GHOkdmGqssP-iJ1QkcA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050180

devm_request_threaded_irq internally prints an error message using
dev_err_probe in case of any errors. Remove the error print in the
devm_request_threaded_irq failure path as it is not needed.

Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
---
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/adc/qcom-spmi-adc5-gen3.c b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
index c1962312afcd..74988040e6e5 100644
--- a/drivers/iio/adc/qcom-spmi-adc5-gen3.c
+++ b/drivers/iio/adc/qcom-spmi-adc5-gen3.c
@@ -793,9 +793,7 @@ static int adc5_gen3_probe(struct platform_device *pdev)
 					adc->dev_data.base[ADC5_GEN3_VADC_SDAM].irq_name,
 					adc);
 	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to request SDAM%d irq\n",
-				     ADC5_GEN3_VADC_SDAM);
+		return ret;
 
 	ret = adc5_get_fw_data(adc);
 	if (ret)

-- 
2.43.0

