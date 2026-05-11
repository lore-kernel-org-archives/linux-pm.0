Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD873A5E95
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778485999; cv=none; b=RUZF03B2jpezvhWp/i0KtR1z71+d+t9tXUyJUwW0I+jcsr1Yc28+ozLj2JYyjeRpxcruVmBHf+FvMJvSv2S5puQhAlnwQvTTHhHEXlDXDM2cXIdlkgJe4pesgS/60xFb90ft+z+xj/WdvSQ2To0Tic78kuTQKSmU1He4B0r8RQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778485999; c=relaxed/simple;
	bh=1OeXBGxf9Na3ADUvI4Lr8USZ9Rc/+mQIRAj+uO9lNhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKUR/crSRByL1j46yvp5YrBdmu5p4biU1jSc7sG0OiyDQeegWf7jLdvHnc4kM3SOaToMckPk5e0zQmW0dXrY7E7w+UWwPhADf3Og4n01f+HsUKfHjCeFN7kNpK0F4FNZRC5cSq7BumFeZVcbFym6fUQgQ8iFwCi+7RSkzm4SxCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JifEBrIz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JzKRagCx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JifEBrIz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JzKRagCx"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64B45iqq2923123
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 07:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TLY2VCjl8g6bhxiEibkpJCM0BlQlq6ryQ2kEFOn+kbg=; b=JifEBrIzkipipDVM
	vOdwPd+19TTH/aPFCB/TmNf3idgFu/+QlJTBbS7agfLKl5VAFBheqKW41VxLxANM
	ALKs2jsDK32H8AKLEvNpWIwKw3UdopATmlVasOb44fqiVdFTmH2rpCPuxjD899FA
	zBWbSkeuO1plmSxi9hMWUzGAscpudUZpkloXMf9PcbxGH821H85Br3rpF3VGDZ8I
	J+p4MQFsd8rK1H9y2eJLERcDV2rbfCe3fAvJ4SdLsLEd6DoTKqDRDhbuChQWkg2z
	qsF8VP/+2p9hu3D/x3M9ZpJmr7Z/ZMMdCkqvXqDj/E1fjEhOY9c2Nk6SH9aamQBw
	OTMTOg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1wped05q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 07:53:13 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-50faf575af4so93719441cf.0
        for <linux-pm@vger.kernel.org>; Mon, 11 May 2026 00:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778485992; x=1779090792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLY2VCjl8g6bhxiEibkpJCM0BlQlq6ryQ2kEFOn+kbg=;
        b=JzKRagCx/cvlbLBLHeoALkiJHO90t3dNmcQ15o1ZjVzi2VhXTk24PGkTYxfCS23ONZ
         eHRlRY/eeVUCitR4u7hdPZ1xf6M+z+CGEvsHcuxamnBHSvEhntUyPL+64LiufgqlgQee
         OwaezdQDKkqgzlRcAUZY+dZMGLPoHSkdNkqvfXfxyoQ6ojR3hFJQmaYPJZiauLy2CsUX
         zFzYy4NCv4+D+m2mzG23vIlSVTQPM8Ie2V+VNchdEbqKrnZ0yYM+OFenAbRKsO/2A3Bg
         Mv97oFd07x3REJVW5PdsjRsBbJ7o6kXy0uchy86DYKHFawf1BsDLsX9jxLRyxDerOok3
         dw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778485992; x=1779090792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TLY2VCjl8g6bhxiEibkpJCM0BlQlq6ryQ2kEFOn+kbg=;
        b=ZRtGDOEV7iDSHgCvZUODcK7h0PIwE6XB5cCnFJ9OSJhyohxgwkQlykd3OlmSdYpWAg
         j6GVSLYJiNkF1ptWIfUGlz/DaVS6WcK3le7R5yt1buVH22xUEWksgjItPh18jaLZ1oaW
         gPdUR00mdqpNGeO+nn+iYKiDCFZP5Qc6iJWLeWkzvsnyXmbcA/S4RBa9fmIhM21ow5sg
         pnndMb3t7vCe/ZzLiIN5hxWe1LRwrOCM6TzYsqOqQ4s1Om3pDOypOAqda73T/WsspXI7
         +LB5WH9EQnskTC63yHiSaQHqmZUX1YHhmn7nPvMojYCZwfGakhaBtemfnpRdnzch9566
         QKOw==
X-Forwarded-Encrypted: i=1; AFNElJ9MAo02ISRQ93iLMyUHNlk7g8ONbwHBYF7UuuTo2vAYYwXQp5Q0eSSbITMhOoz3Of6XF5foxGlOWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXsMf3OL/sfFgciIbo3uCzqQqlIta4iAouXx2iow94sJWfkVK
	3LZ/5B7L/V8rDyBakxXdkiJRdALg/hvOtoPGE+u0a4BF2Tj/dKSCsQvFsZwbHDUZZwR5ZM9q3k1
	6OZPwzaRg1oPTLOuZw6zQcw/SAzLBKwt5pnntEzWChh4blEOk1a8HrGsRMbe+5A==
X-Gm-Gg: Acq92OHpEeyruGEmU7Lap26rBedMSt6h3GytHPmlF2aTLDvw//F72vTKHQuNElmuNSS
	Ja07+IE1LTRrw4wa3oRrg6wqtitA/8Te7eJmGB0lqqHp6vUC0DjOCTej6Pywmp/MrxChv5WoCOM
	O654/bP4bsXE8XncKPC+1v+lEfOVpBYqRcLJ1BBcNP7wm3QrsND1K2YVws6xILvsIRR4VgcU6jI
	I9XJYxITw2pUFOJ333MpMGQQ0FhmWSbCZjNn5RhLwk5g+vqqTDhuH5XrrtyKJ4BvoqpBKZ/rkwy
	vb5wJn5NlqEDlV8yUTGLV26WSEUA9jiXwtTVK3zlnu5L1+6fmwiVqYrz0SQ8HDD1uSEIvcJ5uZq
	cWFoPW6Gl7o2ifNneCdZq2dCD1tJ/mxTMTPJRFZ9+46btCpMqcQ==
X-Received: by 2002:a05:622a:24e:b0:50e:a1ab:67e4 with SMTP id d75a77b69052e-514a0b6daf5mr125359811cf.40.1778485992204;
        Mon, 11 May 2026 00:53:12 -0700 (PDT)
X-Received: by 2002:a05:622a:24e:b0:50e:a1ab:67e4 with SMTP id d75a77b69052e-514a0b6daf5mr125359541cf.40.1778485991680;
        Mon, 11 May 2026 00:53:11 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:63bd:c2f9:cedb:aa32])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db01122sm78830735e9.6.2026.05.11.00.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 00:53:10 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: print power sequencing device parent in debugfs
Date: Mon, 11 May 2026 09:53:08 +0200
Message-ID: <177848598595.10009.16977098777521143132.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260507052943.3133349-1-wenst@chromium.org>
References: <20260507052943.3133349-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Ytds4lfKIacpDjO7vg4039CYtvAlrc6A
X-Proofpoint-ORIG-GUID: Ytds4lfKIacpDjO7vg4039CYtvAlrc6A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDA4NSBTYWx0ZWRfX3Df1p4RCW0FM
 145TONmA/4JZSOc5eFoZqITUkI7jmgyMhY7oAn44zUwKGVd2OYPRtN0G539wS5wG0vycmKdU0+Y
 SpTMYiAPje9BrHQg7CNrfPWroSho2uTFmmqiTmP2AYF7DoFn1TKkfxTtsaS6UZ7wgIwFvF5pR9x
 VT70hSTaFd1Dsry3aaY/8eNHxwsn3YgIqXzPEvfivMDzFOup0LtfO9C2G0uNbZAa7oCbTAiJbKQ
 pJfcm6f6zaP3quz9kROeh780d02gGgG1652Bi9nr3SoqxYTod+E/rGvl2kBIpy424iWivlwCaZZ
 JvPf97bPaBI0JU8Yh50DyOEdVFxx1znoHn5sqGzu3sgDrpdxatIStxettlDWXx7vv587uCGYVXb
 JUxNuC45t0exxRYts6WnB+TD8GQErVd9D+x3C1T7PdePWwqN6qytoHJtWdu5IN2zGlBSWqV4g+4
 H/3aVpMrvUspZlGyfew==
X-Authority-Analysis: v=2.4 cv=EeD4hvmC c=1 sm=1 tr=0 ts=6a018ae9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=v-dYCw11OgI39_w18cIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110085


On Thu, 07 May 2026 13:29:41 +0800, Chen-Yu Tsai wrote:
> The debugfs summary currently shows the power sequencing device's name.
> This is not really helpful since the device name is always "pwrseq.N".
> 
> Also print the parent device's name. This would likely be the device
> node name from the device tree, something like "nvme-connector". This
> would make it much easier for the developer to associate the summary
> with a certain device.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: print power sequencing device parent in debugfs
      https://git.kernel.org/brgl/c/513f49c33e91e58975ada7967b44512179f0e703

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
