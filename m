Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC602FD1C5
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 10:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200860; cv=none; b=RWqn5W50ijRE+utaDUhZb3IEzZTmuUVla3D9zJfmsTtGcKFtvLhYflNhEEbPp3llsDsBy8unbrq8plLy+jzFFx++Z6RJkorQ1xKjdTn0uJIbLman1RmK6LDFKBrSWiYb79ZHMLc7E47shUXRsUgWkmRGHO6fZCoEJ+fknOLEu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200860; c=relaxed/simple;
	bh=S+KGthTfz5wDWSbDCkSNbUaAYp4LdOwYWXEnAlF3OZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5zFe8IrKRa0j5QqQJBFk6YTNbs6UaJQ6/xnih9v9w1xNXsS1KnTYd4yY4+GcsvgiZQCqojjeXBLHwC5dXWMOjowC8SKyBMnfSqmpq2+mPpdMCvgnDjrZIEmgT0QvCoOXQM1Ud1rc4kILU/Ii+bmmrvYBXwj0J1FUt4+6oIKTYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EXHr4Hry; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jIItnNEa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EXHr4Hry";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jIItnNEa"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 614ADOH5628711
	for <linux-pm@vger.kernel.org>; Wed, 4 Feb 2026 10:27:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A+svcbzFMoTD8aVnDmuZAOqmDfW+HkpBaRsZNbPHw+M=; b=EXHr4HrylY9eIsbZ
	IvHFsh/ylVAXqito08h45aiCcIci2SgyxSfNn+UOtGhpWTk6SzBVidG8NHR34aG1
	mpws+YQvlsujkoPAxWXY6SdkAAJjZcunMxBYYQ9X/G2oRHTwmWKCOQ2sUGYWjx+7
	ZaGJblS5+inuMfkrTPqWPKyC6douBhDF+zuOhoGiWxnf4uSax1V8K795iWItqsaS
	PHfK7ShF8xfcnpNzo3BNbTiHyAXdrlM44KOmRhhfEGrPGCVzLRvroVLHmLd0tA5m
	dl3Jzw7QCxoEdd83IUbrZ3JqAKRF2jdqkaGphbNTrlSBGMztklmVOGP6MbrzQqJp
	mNwWUw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c445wg19e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 10:27:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8c70ab7f67fso2905638485a.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 02:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1770200858; x=1770805658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+svcbzFMoTD8aVnDmuZAOqmDfW+HkpBaRsZNbPHw+M=;
        b=jIItnNEap5tr41xiO3S4z2dW4i4xTChqrTDO6hmyOR3vYCWBrA5xZKhIuOoCorAreO
         RcS7vLb2BjW8q1OEnhaXUFAQFf+ROA8g9h8nVfPE8KQxiKqTJsBgfz1N1fAvUVQCyR3Y
         BibP9DzqlcOZTDrjzgUQE3f+ubyniwX3NCdkgLhdBuhcuMTzdUvGWL117LIWWMHD0+MS
         n/vtlnAkObrPUABECPipMN35nV2D7eMfI/53LRw0yw8JvtkCA61ptAEyJL4Yutyjh/ks
         2bZTGUjOOsJJCTkAHt1zWDraLHMh3Jt+tcmIEKK4nEFyBVdNkpIdqzvs9xxL+rArhFn7
         XHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770200858; x=1770805658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A+svcbzFMoTD8aVnDmuZAOqmDfW+HkpBaRsZNbPHw+M=;
        b=OwHl8pQkqluTYRHDDE4ivym24KKUS0xY/sK4pFICdnH8IbIeryAOyHcMYnUH2e+eui
         eakqKMQj1S1xBtp2poSOew9vanLREDYMfJBogNmaWhA+mCVou4dKQf1+ewmTlL2HraQK
         jb74eRd7UlJ35iqPHNWne31oSE0f6XvJ835Ph9o1Qb1L3dNxAyJ4lYt1kyNw/caJpJFH
         825yLToLW0VlYpjvX9YYZQC1hEKEIuwuEiirRSnlgXWO1JxSV2da3dEvGjW9KlYpF1Jr
         /Xzp2lXN/32jvBWO9reDhMaLbRUPe4fKsnj8Mu2ET0VHr7cNhl+hl34CY2pcBV+70sx0
         8sqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWh92fzdp4B51MKfZznmk0OjiTVZAR6BQHxg5x3Y7WHXBTl+U00tcgefpB14LJ/RhAkDL+F+NV+gw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzashx4TJkVgXeULRHqTRX6wqWpzoa0BIbi86s6eMK7RbwKTlq6
	NXX6z9VbXfRVGkI+rvZ6pmUWJoqmHZGIkkIu5QsNAuiBAoOftuNQ9RpWSMZveXwHdKAxJW62Blf
	xtchjVg58mYsqOL8353edzPJHbM9p1i3KYkxxJSZrr56MJ2RM9WfKffPETQ8CGw==
X-Gm-Gg: AZuq6aIQmBdubqxHz1UAjIqgjSD3UEk6i4JJpUIsrnpWDCOnPERw8vTvjq4itavy5ge
	fYHmMJBiYk0kpiOIaVDgTeoMS0Koap6HMicOAPzzk/Ag2erk9RIBvUmayjOgwD8xB4IcFjgwMaS
	hTVAb9OBj4xoFfzuwoTAJl30bR/Cietm5ou+kNq967Gfj1pV8li22o1M6T00gNFy8+Xw7vatPZO
	7CV9KjqhiepAha7TlhCH3QjXeFujhHId6fCjYPRDUzXKUpM58jW6eHZDyY/Ei0aN0X4NNNji8qk
	q0caq9BFAXb4wwUquxTPt8t0NW2UBCeo9uctrPPwn0ngvq2w4sVCfaNrJi8rwSAoxilglU41XlB
	L3cGM9gv9RjZmS2E34aElgtthojufdFHHXbU//Q==
X-Received: by 2002:a05:620a:4506:b0:8bb:1a5b:5a47 with SMTP id af79cd13be357-8ca2f807305mr318679085a.17.1770200858215;
        Wed, 04 Feb 2026 02:27:38 -0800 (PST)
X-Received: by 2002:a05:620a:4506:b0:8bb:1a5b:5a47 with SMTP id af79cd13be357-8ca2f807305mr318676785a.17.1770200857766;
        Wed, 04 Feb 2026 02:27:37 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:fcc2:cae:2a7f:59c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec10577sm17864755e9.0.2026.02.04.02.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 02:27:37 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: pwrseq: fix missing state_lock in pwrseq_power_on() error path
Date: Wed,  4 Feb 2026 11:27:35 +0100
Message-ID: <177020081722.10510.7309384536094598745.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260130182651.1576579-1-n7l8m4@u.northwestern.edu>
References: <20260130182651.1576579-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA0MDA3OSBTYWx0ZWRfX/SIILZYfzE8z
 UGhDKqTRy2s9T4VGiOqHyRYIxpwbOQ6z2D+RL+hYPVeroCYBqoc2cWVQuFFYf8cqFji0uf9shJM
 FW9y95dAI9xATC1bjHBgf9lQeanNdYKebcopKPIljs4GLpjt5AqbPFTanDhZDxCD10iP0HcMeVt
 HEUq5eLHwC/v931FLnJO1566SmuZrVIxKwhnLrSF5sWofFeFVWhm5bXRUsanFpFH5xu/On1+P5t
 KUoClGXKllIUBScusQ8M6/cEhUeKJ+Kib8optFXuYWDEbBOdtt0nSUvsoNCHo++FR1Q/gO6UWtF
 iedmfG+jUWkWKSKZUNDZPucPJ3uc9EnAip9WkLOxozOiZ7UBuar35wfMmKc8j9gNdhIFiJInR3Q
 POvpVypR1ufK5ezvafRjFOjdi0eUblSH2/DLYVqCSa4EvUHW6lwK3U6mZYIDNdcl0+iYMtyMuFh
 gYiK5ndLINVaxI1XPcA==
X-Proofpoint-ORIG-GUID: Lq-V7BlPGEGk2lomgAwgAtmv_CPbWN72
X-Authority-Analysis: v=2.4 cv=GvhPO01C c=1 sm=1 tr=0 ts=69831f1a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XaYrcf60jMxePFmAlXUA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: Lq-V7BlPGEGk2lomgAwgAtmv_CPbWN72
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-04_02,2026-02-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602040079


On Fri, 30 Jan 2026 18:26:51 +0000, Ziyi Guo wrote:
> pwrseq_power_on() calls pwrseq_unit_disable() when the
> post_enable callback fails. However, this call is outside the
> scoped_guard(mutex, &pwrseq->state_lock) block that ends.
> 
> pwrseq_unit_disable() has lockdep_assert_held(&pwrseq->state_lock),
> which will fail when called from this error path.
> 
> [...]

Applied, thanks!

[1/1] power: pwrseq: fix missing state_lock in pwrseq_power_on() error path
      https://git.kernel.org/brgl/c/e1dccb485c2876ac1318f36ccc0155416c633a48

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
