Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE3055D867
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 12:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957448; cv=none; b=Pxx56HkGaz9d1aehrACB3QIkDOKXowHuaZfQR0RvE+wpgkfnvXU3X+fcgtj7qQ6lYOjmx176R/LDI3nqwCme35q90LqeHHqOarzBtWkTszWtahhY72heD2tnN5SB4zic01Y391T/UtIzUjK1J+mLNn82b4MNqVWdZKuACbpuI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957448; c=relaxed/simple;
	bh=Qv2lflH6YpMRmCWBAa2RN4e8yD7dg6y3jZkOloHx9hc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FJ+XIld74jd7RKdonHbNUVr+sDUGwCebkCkAVHJscJntABCElOxt1NKD/GCQEalgBnoLWBF0NYNbHgT0TH4uap1pQarduvy9Bjp98hrYiXOvGAD/iGM5R9zmP98S8Ou+qSm8qS2QONrnuKjomiC7T6CD+kolmAm5d0PZiQk69nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Dwm9N7Hg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dO8gM31U; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dwm9N7Hg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dO8gM31U"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CAUvZ1233139
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 12:37:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ffE7yM+yBd+rWRItDOzR+dZhkdj1+8iczv8XL0VmG2Y=; b=Dwm9N7Hg36zec/+W
	7oFEqtFHu6E3zU62Bl4C2shKxe4e9bRAlxnnyEfT5264LOWIXQHQUYhuADAbRvWR
	XEarkoeTSUogn2UMTxcwLg3980to6OuI4GY9ztz2cytBGAMtE+dzrR2P58OHQrOd
	/QFmBg1tz9NksbPjvYQtAUVIQimwvDNGqvXsw0WBNEBdksXuWifvH5wZ+AW7dHW6
	z2/LA7s5P5dNckLYrNvkMCq05kH0HWiWL2w9ebXfwCQvwO6ntIfx9KgGN/rWjjw8
	E+L/kx3UaOJurUel40qO+/KHCSMMENH2SRMY064WFGCE7YQ2FgeSEaEq5XhX6KRE
	vkqDnQ==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk77vg2ra-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:37:26 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-980c5766c74so278301241.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957446; x=1789562246; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ffE7yM+yBd+rWRItDOzR+dZhkdj1+8iczv8XL0VmG2Y=;
        b=dO8gM31UBsXSLyp0AFKdY5TvhR+e3nw28vXrxnXkllrAPxlUPtnQcizHq0Jxyuzqzb
         J+SL/IRC9HkAqTPJYG/+Iap2V72m9JvV6aIqv6SYwq3G2IyfzyEVOAA0ljqcO/CR/HvW
         7BS+ZFuPerSypCVsrHlXowFMzCK6CSP3B/fOU0HymOWcFqMXgPHpNyYGhOfMJ04zrHAg
         K2vtLGMsFpryxfLuU2Uk7fm8mT0x8zZIVojOnGMr6Pa655a/4/70SiOnOctYdTUFLoyP
         QDHONM6eieD9v7zVPYayhuUUfbvvaS80wfgPnKtrFNB6zy5qEXqHT+yNtwUSaGimth36
         lbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957446; x=1789562246;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ffE7yM+yBd+rWRItDOzR+dZhkdj1+8iczv8XL0VmG2Y=;
        b=DkUgzTMnjE3VFNF8NvFQCvEWHlrCl/jbiAcAahZgaVA0Q2Cw0jZp+8Dm30KHMGsopN
         pAPW227B6By6eQnALMR02lgHohqX/jji8UKCSr00qSnhGcASA4xa/oIKNJw8V9RMcHym
         yIecLkUlI65AwczAxf1Qle809fbz+jaIJpxDMFXStgEYgsU2yRhVHX079gZI+G/ASotU
         mDplWEeJeo+DroMXS5VnwK3crDH10l+udHh1eDdMTCydaMs/E3wdok39Yyxc6ezCpnHa
         53ihc1CR40jgfWRBuzNQ0XI1Poj6hEA42/XHHe7IQ66GxHHJSXnUxkuIDuVmDeCWBLSm
         NAdQ==
X-Gm-Message-State: AFuF++lJxLZTl4oECgE+y1mmFTnOLGmh+6GpjoUFqQ+nSdZsLw3n7R5I
	BkhYodXcFU/oWUd/tuLaH/MTCfv1US2nw01tpAJ9a6fHDDQ+dlkaQsA52cc3bsmg5BwlSYkQb0J
	0Q5OM7eHkuAcud9X53P/23mmF2d3md6K45JEGIQy+uzYsNMg48YfsGyWs00KwTQ==
X-Gm-Gg: AYBFou2yNLvVlAw057j4hsOe+SKgBnLqZ7EcG2vI+TAY4r+6+zawFWf84uPgjOhvNhT
	agnmZUVQCdGY+IiAcaWCTXA0BSOgTdBxmmFxQXcp2hjl7EhU5vxr1keCvqUp+ZUJtPQRHbPT27X
	3xu+zNKnZlUuJXVR6+ZB8v+im4EC6R65kukZ9mGNBHQl2NL5SiYtnFE+sAiAp+kxMFoh9S66+zg
	5JcJbWNxXWfEWfefbKpcxhkhSxk7ir3p6jyNcWVmAGPz216SMdUm+eVyPPtEpog24zI720s7YzV
	zJ25hGhdUiEB99AW7dEPAT/7xs6gWzy4acWwZx5c7UnSFM8v9jsvwYhBSmmMc4xPnITl1gUyBZG
	7GcsjPCLuNrbfQcVVHYgEB5GlFZx8
X-Received: by 2002:a05:6102:8309:b0:790:322:8a36 with SMTP id ada2fe7eead31-7900331d5c6mr736915137.8.1788957445750;
        Wed, 09 Sep 2026 05:37:25 -0700 (PDT)
X-Received: by 2002:a05:6102:8309:b0:790:322:8a36 with SMTP id ada2fe7eead31-7900331d5c6mr736889137.8.1788957445220;
        Wed, 09 Sep 2026 05:37:25 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:de8b:7fd5:2738:cc2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm36317328f8f.20.2026.09.09.05.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:37:24 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 14:37:07 +0200
Subject: [PATCH v2 1/4] power: sequencing: don't call .post_enable() if
 pwrseq_unit_enable() failed
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pwrseq-kunit-v2-1-ef496afc89d2@oss.qualcomm.com>
References: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
In-Reply-To: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=908;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Qv2lflH6YpMRmCWBAa2RN4e8yD7dg6y3jZkOloHx9hc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoVL8+nCqtB133ENfnVlGNNxCsHBQMrD5YTEX5
 axDTV5SkNGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqFS/AAKCRAFnS7L/zaE
 w+fjD/9GSPt2ty3DyQWiuSJkVfBGl03keOCQsVxAgXFij3/47xs+tjLSWP5cb2ZIjCY+mX04tM2
 2R9/vHZRV/zsuqoWBnCQUk7lyATOXqq42Nf+zjzshhY5pv3W55QlbYg2Y7Eu/+Y3z9sRJj7OXEl
 4fWFDJNVCYzCYSi8pws5daTYzRTU6wqw6P6jRk/IcxhAUH8yuwVNJTrxoGf8YVJX7DFoVBIqXn1
 RLKTgvtoH4ItoCFMNbLNN9OGDAvjl2xv/xakoqgUjZRXJhzpLscqExTDXM343IwNC0xM01sdseB
 d+0UhK/c84fV4eQe6zWRziRCZObpU3eAZFcXoDaVR3Fon7hoFOi9YRI1Uw3LO0NeVZt8WGBI6iS
 H9DQvmgKXsOY8glC+HrakrJdBmjPaCtnYJBIAPStaGgsuskm7sywSr/pwZN6pUATnVQ11yIunKY
 w1Mfp8DIxE/cSmWRxMVXT2h2/zN0zFvUZdEnGrAyNY+HMWPH7HrP+dii9Reyi4Pm+yk5DW9yp7B
 LL4fjUJdrvUyF9gtFX9JC1C1ismDI+fIr/9tAonDZMMb/9vdPc/UnLZV9eYSI4pH1CYNQwveLJn
 OwNTut3BGNgIGvxqpwuhWEp5zz1ErgwobeHBr1ggylfVobJvaELTA6uktNaZac8F+OZCw9Ff3cR
 bmZgMoj3fJaJtnQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=GKk41ONK c=1 sm=1 tr=0 ts=6aa15306 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Trbc2l1I1fXLbfWOQTAA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-ORIG-GUID: ehi1YbPAoqE1WQBj1hGLWM6vMvwGtUsq
X-Proofpoint-GUID: ehi1YbPAoqE1WQBj1hGLWM6vMvwGtUsq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX4/hJtp/pGrpd
 pikAngdja6PRJZtpR9DYTFdFUcRRBXgpMZFZQJrwrN4R9lHNF3SrEg99FhdLQLlHEe/sLEYLb9P
 EVE0yKsTdZToS8VulzPw0yMJOIqn9yQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfXxc8vri7HVvJ2
 ct+A+shOQob0rmVjH4KVICTjdwuVTEvurTuTvxuzIRMLuxpZKbDo9HF4JHlHfuNwMK4Q5l/WMQS
 PLcAo6iA/j9guiHU8hPuYJd6XLWiLgpi0feZgPD6D7Oe95XkGZHAm6bDsOqNMNwBUmRPf5Kf0gb
 mv8WvxQ03un1sgaw+AATPve+fxpUnX4DFPJTR7b7zv/VnOIJOrtkBRrNA6AF314TRh6BsvoRRyE
 tyOp/E2AdOR+BrM0KGMQ8xcDHCfqR4lrp2tBvzkE50R3sn/IRM6hsGxcMAMyeHfSF9fJ/Jjv3zB
 tImc+nAXx/HAORqQw0m1Q2+QNpouNglUcqATdUHo2BgCB4OdOeH9TYzLi8MJ429q72iX2F1S6W9
 fvYP49fcHFUsCNlVulRkcaPUsO7tD2LgvNRWBxEivzozZ04r1kTzuO7uZki4QsqkZdSwIjD6DsH
 XoN5/sj0fdohkuLtgtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 suspectscore=0 phishscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090141

If the call to pwrseq_unit_enable() failed in pwrseq_enable(), bail out
instead of calling target->post_enable() which assumes the target was
successfully enabled.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Cc: stable@vger.kernel.org
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index 0cb71efbb268b351607ccf610cbf0315f35eb3b7..a26615b727f6fe8e7cdc3ab1d3f362ba2f1c5684 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -912,6 +912,8 @@ int pwrseq_enable(struct pwrseq_desc *desc)
 		if (!ret)
 			desc->powered_on = true;
 	}
+	if (ret)
+		return ret;
 
 	if (target->post_enable) {
 		ret = target->post_enable(pwrseq);

-- 
2.47.3

