Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1AD55D888
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957451; cv=none; b=EQnEroXOrjl53otDAieyG1iDxOJ/ecvT4cTETC6/Jeuc/6RCm4wf6wii+R4FQGKqN8dygCsUTqUZKfxl3KSfDg6y9MDTCp/H2wpztxemaUEOa6Wg8THRTOG6nhhKdgzmtDP+vF3B3qiY8WtWHfO0/jvLke0NLYHD7Y38JHHVTnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957451; c=relaxed/simple;
	bh=6repGLUNrgVfsf2TAEMxYryccpKQnbHINlMORO8gKZU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oXKtOkR3xAOxOnP/BqgEZxE6cs0sV7uyIb/v5vx0bcsQszTqkb3eAvPjwUissAtfWFtq0uvKzXyOt+9PQ7/av4NNyZntHXybNnQ52TaQv3yRjU9ZtlSaUYGWCJwib1gFCuZTQer/jlT/Cer5atGtMyPHd6NJi6AenuJmv+9dQQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CabGPaHG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fX/Ze5/H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CabGPaHG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fX/Ze5/H"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689CChSQ1400887
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 12:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	shxfk64WT7DU4wrhJlkTYBHV8dk9ViK4RzFH9GS22IE=; b=CabGPaHGTUDCL3Xz
	cwOBMA8vDb4DOl5l3sjvS4V0uB/57lmLjqf/pi+cD1v2likF2Uk+ECHFHIYo/UdO
	vw1x9gxj3cb4XwnT6XkUPjqQ7IHtC+JhY2qMuVdvFOffwgGvoj4+5vrVPY9NbwKq
	GQfOpcIiSm5fA1KBkiAGGtQcFy3q9iiky9n3DWJWp3ARm89/VpNoxRsR8qzqsfES
	H9urF9qWwjFXpdaXfgAYGKD32HPk+jpAz/Ond8Q6FjNUDvBOsNOmD94sj1Tqv6fM
	sOX8IMzWZzKxXx10er9+dySjWhQz5WYEGnnkN2GQnJx7qmy4HZKUG3LoDKAsGY+q
	+4M3dw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk78x02py-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 12:37:28 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-980c5766c74so278306241.3
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 05:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788957447; x=1789562247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shxfk64WT7DU4wrhJlkTYBHV8dk9ViK4RzFH9GS22IE=;
        b=fX/Ze5/HJsWKSmbLvpNeCPuLMyEDzFqeldYi2PrRALter0Q0tuRXdO57IFp6E1PMmQ
         o6aT248iAbVnSLYOzoGPjchZxII9WoH04HhlFBRJ0JECrxtVBvYPIL1R93F6Ns9PsX/a
         7sM1ttlDh3+weC8UxzSY8DiywLz+7gp7RFzJqHA4lyRy0LusA33HKjfAH59Z4PUopd5P
         slsb/h+ZSxY550hgZZaEfE2r1o/YO3Wwd5y+u+g3Ys2/bGDf3nCmetPIJMrjSbVOa6Rr
         SuyubYCQ0hZtJxnwbzZWlIkvNK8u5CirtKf8JVnKEHRMLAeZbSyx6pZVCu9nQ3aFR8eG
         c0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788957447; x=1789562247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=shxfk64WT7DU4wrhJlkTYBHV8dk9ViK4RzFH9GS22IE=;
        b=k361MNxb8SIzMm8N214VPIgW6Mqx11tnOofP/tR0CDy9TbBiTe5WYzo31tXE7RogF1
         8g0vuUh5C0ZhHtDt2ar6Zxbe6K80bHuvtAXHsLi3SazhYWX2T7ChSQXjhaphUn5b6KEV
         Ede/GojuHm+cSQDeCjbsFPGT7X+Y0pYlfZuObOvhGB3Smlyw3DsTk/rMB0jU38BZ0PlU
         ZXhe/OFf2pYAyNfTTC/iVaoO7U6onIGzXVB1lxMr0F8xvJgsdLGZcRDgSp/8vSHneeVm
         KMu9hBbbyKOvF+wDBAyyFOZ4+qStxVwOTAuql76bdzEsvXFRxG32+dmh1/stOcrPEaUQ
         N+GA==
X-Gm-Message-State: AFuF++n9yGmU89rNgFnto6CC6/KV7MJJJLVsy+wtZ+4c+gFRFQzUsaQj
	JYzA6R9zrxmO7cw3iK0pUKWtfaYoVsMNE2QFWkfCT5igMm5z0un96a1kwUTI7H1c4JNBuobq3o2
	6tdY+fo9OVvOhqVEXQ2N/BSAhO9eq3BF/SO6Wqowz/RWGtVGnkecw3zuQO8d0Vg==
X-Gm-Gg: AYBFou3WkDu3b0C7NN61SjaQ3vg2s49JydFAydpcP0rJqHdRWJAgUAPpEe8aw/I/wId
	+Cet04SjfT83qx1uRjG1RKEtBe6tIVdXW1XobBm0EwDS3OXfWnPTQ2guiN9IBdEs+CrvNXzmnMe
	EWyOxBZWUIBdoWK66efKy8kvzMzxd0IEsrYi7MYhYRZ0eME6uX0OKTmFChlgWZIqcyStvUsTHSw
	kqTCGoAwCuNCdmpZEi6ZXGx+MgNPpUOKTu56vbU0nlqFLR00xP+qebqN7fR3ccJIgHfMc8P/BF0
	c6vdiRHKOwAsrRTAQuiFDOQ5T4eEl5Tyyn5BBr6Y+J2J7yHgVOcv8YeRStdgTVsYPiyWoCmhH/I
	A8APmCfqPAm07DzqldEMlANkLC03B
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id ada2fe7eead31-78a4a7186d7mr13704031137.7.1788957447574;
        Wed, 09 Sep 2026 05:37:27 -0700 (PDT)
X-Received: by 2002:a05:6102:2907:b0:778:9033:e337 with SMTP id ada2fe7eead31-78a4a7186d7mr13704012137.7.1788957447169;
        Wed, 09 Sep 2026 05:37:27 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:de8b:7fd5:2738:cc2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4859162f354sm36317328f8f.20.2026.09.09.05.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 05:37:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 09 Sep 2026 14:37:08 +0200
Subject: [PATCH v2 2/4] power: sequencing: fix NULL-pointer dereference in
 pwrseq_unit_new()
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-pwrseq-kunit-v2-2-ef496afc89d2@oss.qualcomm.com>
References: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
In-Reply-To: <20260909-pwrseq-kunit-v2-0-ef496afc89d2@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Chen-Yu Tsai <wens@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1255;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=6repGLUNrgVfsf2TAEMxYryccpKQnbHINlMORO8gKZU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoVL98WcjgMDeiyBAjzKFCykewD3nYcFjSqF6I
 jnCeCBj9DGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqFS/QAKCRAFnS7L/zaE
 wyxXD/9ml1oNhCbvMnk3AskOyswv+qxkFD8qDg5FTzVRFqdeB1SnzL5dw9ffTRZJESigiwHErkV
 66RtiO1BAPE/WKrnClpD02RbO/y2AncvPDWUqGv90vNhGf9aAnRhAFQ/yoqYZa3INaT7OCL6nHV
 RRCXjUmbHMW1Qk588T+vonQf7Yl3lrsjKp2eB8S5RYOKi4Z0j/KFKEQOk4NYlAldajdaxkqOPBz
 oDtPIaEK3yMFGcxZ/tgBqSlo2vxnSzWHITFjh3EWMf61Tlk4F8c1ycNQNn646PTjYwqPbKuKZSE
 rLh/nIb8l8iUg9zZ7UKLiSqCSCMnJ6rDmCS45TdRtPdOgmm5CeD2EZYOTndRcr00vJnbeCw2jPo
 3i+vTOeyR3Q4xXqfOG7MEeVOZ153dc3nDhYjP4pQ7FFBSmPQMKqvrtKAMoQ0FlfhrQk6MKEQDyB
 sCq4nvTI9elQHG6hGzOAkoTjM9Ag8POO+1U1JWuC0+M4kk/f3N5uZFczTbPbw9VBropVLb1CN5k
 x13LPVrHZjomAxlXGVAwwyqJ3bAl2s3oObKC9UB3RYxEsuMn4RRTmtFDdcArVqAscvU4nvDbH+U
 bGwEY0fwJummPA4UZPjqLRY1kWpV+tYoNfN0YkbMPBW9lRgIGu63xHzXLwHWM/xN9MgskiFDLzT
 GjIuBzXESvbcneQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: If8Pz9QHVaIWfMlwGa0teAfNNkr8UKgP
X-Proofpoint-GUID: If8Pz9QHVaIWfMlwGa0teAfNNkr8UKgP
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfX1Uwmgh7AYBn7
 hF8sItiFoA2LnakjjLyaLtI0nsjZwcj+Yr7eCsM3LaUuSxcYeelKOxBm8WOkQqqWYDIbYOsGR8x
 9V+DyaYBrdldXzvax73a5fiwu8vPSfg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE0MSBTYWx0ZWRfXyFJexAJ5jrfm
 ANvoLTZbcq36aVnz825RVbTzO8C8FOdPREgqV+v5d0vrvtGdjm69CqXgQK8gEasFwiZKRmQSa6e
 gqju5CC1CDBrdbrUPTIe59t3VHxxYEpn9OgYvSPWGyISfFwGqXvXUtjjvB1gNQOtq5x7asVfEve
 Z2fFybU6caYUBofEL4ahnJTmuG+hwg8M2WzG0jAqj4Qp9OMpwJ6TJ0Zm7xNVpLZ/0BiMsEOfO+2
 PySGtacIkWMpOXDmySF2v/mvytDwuRS5KOg9YORhWkGWonPALzAgtSg2amraZn+aSoq9jpKO/JU
 5MNkWH6ggLc6fj2e07Q7suBaIpaPawjAPUIGbMUaFznV3TflD7IudWloYprDQxZbbrHiYEYdGek
 c6K3mv88r9I9wMgcZOCQCLFejI/QDoMu1jlGXzPqA7qkC/QGTgQZVDMLTgwB0PSfgCc0DCWme7v
 vgR0Ga+Eks/7yahUYww==
X-Authority-Analysis: v=2.4 cv=SvWgLvO0 c=1 sm=1 tr=0 ts=6aa15308 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=c92rfblmAAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=LS90zmZLc4-xERvDOr8A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090141

If memory allocation fails in pwrseq_unit_setup_deps(), pwrseq_unit_put()
is called to release the partially initialized unit. However, we've
never initialized unit->list and pwrseq_unit_release() will
unconditionally call list_del() on it. Initialize unit->list right after
allocating the unit struct.

Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
Cc: stable@vger.kernel.org
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260903-pwrseq-kunit-v1-0-1f893d2cabc2%40oss.qualcomm.com?part=1
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/power/sequencing/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/core.c
index a26615b727f6fe8e7cdc3ab1d3f362ba2f1c5684..a092031943397241b2a9970de5793a0bbc8d7ecf 100644
--- a/drivers/power/sequencing/core.c
+++ b/drivers/power/sequencing/core.c
@@ -101,6 +101,7 @@ static struct pwrseq_unit *pwrseq_unit_new(const struct pwrseq_unit_data *data)
 	}
 
 	kref_init(&unit->ref);
+	INIT_LIST_HEAD(&unit->list);
 	INIT_LIST_HEAD(&unit->deps);
 	unit->enable = data->enable;
 	unit->disable = data->disable;

-- 
2.47.3

