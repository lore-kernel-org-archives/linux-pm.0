Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B234A64E0
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789476558; cv=none; b=oh2YhFWl/dG1Y69D0/fsqdm1atzQVOwl+gDzIkflzCfBBCfiBFBB33wDTS+6MlVRYWLGePqgwA3+XGnPSV1YkquZE2Lbpe5wWFTQDLAKV25tEkg4PeZCUMSO55ggddfiVffDHP+T5w9Vq/C8UEnjW2PqjXD+z+/pDFnjhf093Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789476558; c=relaxed/simple;
	bh=fIAisb9Ef8EnJfagA8Uwkzg8Nx6okL33AKeNqRsgj74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QlyPWPDVxgf9wE1IS1RlnUCrJcKM8g0Wmn8DtVvP7//cYFYblQlrt1Lm2Lj0ZBTX4oq6zQrp5f8AZEKZ+BSjm7nXsZEcRQIOkT4wghqVOnuPXS6JGdleacG5xOkODrdlYVlvbTVcFWqHlN44HJjAvQFAE8G9G90nwRl6yKxlnx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dM2mj3XX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fQV3AMMT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dM2mj3XX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQV3AMMT"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F9hBxs3217667
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aYjUtVfkuu2mjvRNXERbcbQF
	PHzdPQHxPaUZ5w86/OI=; b=dM2mj3XXB+VhBTSco4W/wKBQPZz0Ejk2nFaPvRMU
	6YpPkDoGCuC+1+9OwO0j6Rx6A1vR4RraCVgm0nFTDfiVus4bLow+ol51GJX4rkmv
	7UgpHLbGaUSH5dZj6bI9G5haDD5pjz26xEJh2eWOPcy0YzfIYIjJdExH1MtNmqoL
	nQBdl0L18pX7TqrV62OBIXbZUQ8aYEAvcwcd5d+Hq6q4ukxA2h+VPiX9x4rkNEJ8
	XCNBL/jHJCNfIJGi0ezUPe1Lwzz7QmmpKF8Bc+pQzJBSsuW9/G9HKzo6XU+xKTtL
	h+gXCXFGIy+odZ9HvUGhMdnXgoCAC6jTS62mcFSTlEZAig==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq2y2gxux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 12:49:15 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-939f925ba4eso840695685a.3
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 05:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789476555; x=1790081355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aYjUtVfkuu2mjvRNXERbcbQFPHzdPQHxPaUZ5w86/OI=;
        b=fQV3AMMTj3ABNgN7ocXryXaO9sdmn4KgHVhem+Co+8docaOH1beMQjXbp69mM520cx
         jMpUid7sfHOj7Z2uQqJ7Ds5ZBGb0cTRtVLaxD3jV3VrMKM4LHXXzxQoJvW+gAzd4Y3ay
         JeJCzUHNzDsrxBgBwbiqfqT1W5KzB99U+a4SRE1E7E4A7/ZuCnc9xQTQ50MqJjo78Vxn
         ZFFdy7NYkhMvNar/KAebADFHDPdWMOp6Ed7mfN/Boevh2F4K6R4SPXoNoP6HqiZPJza4
         wLtEGFhPNwVAARYDhJWDT94NKAltltoqzRWXxoVGrsgwiV8tEwcl1kbNXXSo2aaQPjIK
         aw6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789476555; x=1790081355;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aYjUtVfkuu2mjvRNXERbcbQFPHzdPQHxPaUZ5w86/OI=;
        b=HruD7L08ckWd/8ljH8ApUrnxKflyfFt3ST6NS0FPSITJZ7QL6ZMV58Euz6dLXQiQyn
         BelijSyXNS2bC2cfnfmD7kNnXDUOfii0V3tUrvf6J/POS0GkfhO7mcHbw/S6u4wEA0mN
         KQfIK6DclaxJd4nvhGlOj5p5UlBuyQRTTc8KsaEKF6hWAlIPKmYpanF/0qCEabavTYEW
         sJlCtodeyKBJp/zNzBUNcpzmmNDq6RKxfei7xKUrzRwFJpoK5fWKw4VaV9SL21Vo5v8e
         uBGBS5FnVCASVLBo1bA8JQqiyUiA/Ic8qN6OLqhJpbQ4gfiPsLs8ilj0Q6idSjCx5hK+
         tH0A==
X-Forwarded-Encrypted: i=1; AKwUvBxQiwNztICS1WpIkeSO2787wnXuIXx4QHUpnLgZjCQN2oflaaIfpaOQytuGSujEt1637J94n4jSuA==@vger.kernel.org
X-Gm-Message-State: AFuF++kYxGickmkdNaxKDcZavLU5OnSe35bixKy8uejYCBQV8vcICgK4
	GBy23HuSLDGspmSmRfo+P/3FQtB4Xqm1OT7C5DRxdMzggCveZrJwEKOH9iDWx5ciA4uEOLSPkLM
	0ZylApYITjQW4y7mjvg+nDqvAl82NqsAqq3i0kMvX8/mbPuZb9xkWJTP2gMcvGg==
X-Gm-Gg: AYBFou20j514VODnd02HTpl7stB4EqiYiIVDBR0Q+WwH1yX4aXwn8nl2/npERCfqDT1
	Ix36RE/cTYKDwLh48mMhq0AiaSJ0jHIXUd7UaTV7yuwz2uaoCMQ8WKc/R7OjanzqC7CrWo+4GgK
	BwfrMB2Lav4wZQDT1WMi/k0A89zcEPBBTZUp15ZqpOWyp5/WDkUtGVPKrQufnrlOGCh+OaUTIQg
	qFCn3unLyH9WrCFmuypn9KeyudGFMtYmeYQLRzwRDZCyuETSwjVLAjgh7cD9PM1Ya7sBjfxIf+K
	OCvswcIkrS13yvZheMHAyyU7X0kPYz8za3zBPuBl0Wg2U1YtN7EHjYt9/47xfGhoZW9faNnMTx6
	seBCqO5IUValL4w==
X-Received: by 2002:a05:620a:4886:b0:93a:21d3:f4c6 with SMTP id af79cd13be357-93a299f5cd4mr1017828885a.25.1789476554918;
        Tue, 15 Sep 2026 05:49:14 -0700 (PDT)
X-Received: by 2002:a05:620a:4886:b0:93a:21d3:f4c6 with SMTP id af79cd13be357-93a299f5cd4mr1017772485a.25.1789476549687;
        Tue, 15 Sep 2026 05:49:09 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7ef28e6asm59986355e9.1.2026.09.15.05.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 05:49:08 -0700 (PDT)
Date: Tue, 15 Sep 2026 15:49:06 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Mostafa Saleh <smostafa@google.com>, Marc Zyngier <maz@kernel.org>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "interconnect: qcom: x1e80100: enable QoS
 configuration"
Message-ID: <2vvtep7kqrdgbtj4hgogvbnpmfl6m3zxciqju5igo5csz4sphf@kmou5iidw7wx>
References: <20260915-icc-qcom-x1e80100-revert-qos-enabling-v1-1-cc4ba943bd9d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915-icc-qcom-x1e80100-revert-qos-enabling-v1-1-cc4ba943bd9d@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: Lkdg3j5HVQcROKDXSPEeLo8Co7EorUZG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE4NiBTYWx0ZWRfX6dCcnV5isHUB
 bsX9MnieXe73sq3Pq02Dw3KqnkV0aAqFfwXkuqFIaFjeYkrJ/YQFyaesaIJ+yuV6qLrPqTyLu4F
 rPTcGuBWcmjFqpvGh8uyA8MCnnql+K6IR4qrmjCAQ9EelRXajGgfYbtYCP0MHro6wLOLRGKjzoA
 6pDpTs8UKmt4nhORPH6Ucz8jcTSx7AQ2fqI5EZXTuG0EE9h5oCGGxjK/gjO2jbTnk+dOji8pQtH
 mvcVrYNLNScrqyQmBdpaak0avu9J4HJinOoVuLaXBJwvh7KiSx20Qw9Eko5Eta9JMYBEbqclMwr
 lR9IjVuYcS2OSZh/3pXpLJ9qdYcu/n8yfD0XOkAYFwPzzw5cFSeG7uKUi8yPbBIvBZ6xgucN78j
 j7m0mNykMoa8wDLVs7Cc4u01m7yB4uFd9HJyu8KL++gw9WUo38lpIqyZbECqS6MEJHFGCoXYESK
 FtaLhfQkS7kHvO0YvWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE4NiBTYWx0ZWRfX9beVuzFrSxMx
 S3ZFID85idobDjfrvfZLqrFaGU0/SFca8XkR89NT0CaU9teJ7ABszEYKx8/0LS46Agfps5MOud7
 Gd5LcAAfh/ojHmesePQrQ+N9yAdv+x4=
X-Proofpoint-GUID: Lkdg3j5HVQcROKDXSPEeLo8Co7EorUZG
X-Authority-Analysis: v=2.4 cv=IcISymqa c=1 sm=1 tr=0 ts=6aa93ecb cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=lUHfYzHv343R4ZC3hUsA:9
 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150186

On 26-09-15 15:44:50, Abel Vesa wrote:
> This reverts commit 5a8b2cc36e796d595c9d97eab23c2be22805cc1c.
> 
> Some Hamoa- and Purwa-based machines fail to boot after this change.
> Attempts to resolve the issue have not been successful, so revert the
> change for now.
> 
> Reported-by: Mostafa Saleh <smostafa@google.com>
> Link: https://lore.kernel.org/all/apgeBNSiP01YfNcs@google.com/
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>

To be ignored.

Marc already sent one here:
https://lore.kernel.org/all/20260915123703.3228329-1-maz@kernel.org/
