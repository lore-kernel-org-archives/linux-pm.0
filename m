Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302276;
	b=lwuX2UzvrC7LYZt9QTT2Vj7EbGJ2U6nie+pp7TNtQeR8NgH5vqLCfj/LE4QhyAk+vknq
	 L4tBts3Npy06Q5gdN+nefeZS2YvAlwl/d9DRGtFdkF5BriuBqSCSEq7VFrdufYp7/hmlv
	 Akjrh6v3druha3sIfuDWChxXFwvmT+rPBQUsSq3exevOKqbVoYiG8D3ERgEzg+tfDcX86
	 5h/lYBF7VkcScFI+fQny5OAgrC0BOqkZlm2LnDB8ueWkE/mtIgdEqy7okTue60RmPHMQP
	 JchCH46gcVuGhsxqeBa+hK+d2Ps+BAdpwCLZmM42qOIK6evqJDedVSdK+S8054JwYTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302276;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=R9Lda//rck6/AmcSNg1JTbogjOzB20ak4vlHDRi4RyY=;
	b=jIh5nO+LVik8yAbQTZxO80myGL+sKlFLr9z/ZdOpf4nGorsXCSxIGl+FQT8W7s4r/DuU
	 cmg+UVPo/tQD0lAo0JyBnz1RAvKcZ5WQUkvrfj56FOOwg+pfmmv067RQh1ri6AnTMpzpA
	 fENMakFeEZWK8gyTDJVXHpXPP6SOf6l3DOnc8xB3TdGmG7S/fWDcubhvA8JeoPbVTt5a6
	 UaDXgYISoDhnVm2kFTbsgmoZaq49Zz0yYKAchyFq9OEA2OrT/6mbDN1edBBBjna9fhseK
	 FDIA2GbeyO3211fNk57k9DYwcnA85AC/ISduJBt1UhupRF8YLbwy/5jiz3KK7XT3urw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jlryqgtw;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oym50KAI;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144236070B03
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 144236070B03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Jlryqgtw;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oym50KAI
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7l7el3392351
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R9Lda//rck6/AmcSNg1JTbogjOzB20ak4vlHDRi4RyY=; b=JlryqgtwdVv51kWK
	DE64SC9Chu8745Wkx4DntTxnT1QrDFIcMAbHANQDuItMW9YHFzzbqB23JiNtR/ui
	ZQgN2nVM20POUjcrFgm50hsOTgGiQQGZWC8Fu9n7Kf0xNkE0W8eI9vPxX7AZkNwP
	luGv2JASjQiCg94atfZH5/HJL8PH4+YzHIc/H/IHeaWMxklPQxfDxSO1RrbocaX3
	z7+WDFCokvgaxO2kW/fXbdWzTo9h2gZ4q0VJZOhmKJmMHxBULFAT7gYRRSHylu/r
	oNvGy3kZ/4ujC61JtNxac4Wohi3b4EgjvJ7SdYcsgLO+mei+jkei4EXCruDKV0/l
	9RYVZQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg2s29-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:17:54 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93e49a1d3b1so440210085a.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 01:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794302274; x=1794907074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R9Lda//rck6/AmcSNg1JTbogjOzB20ak4vlHDRi4RyY=;
        b=Oym50KAILC4JIMXZn8yz758Lj2P86XVtWzjk3Tzns6/SEE+yichkVyoe4KyO9/vvW5
         d37g8e71D+ClUrylQC7PsgdmXnJbxu771U6OMGNGN5aHwCE3Cxpuox/0Nl3cWCr7BdgS
         o3HXCP/gdElraqp2GUANboqtZleDSIsqYgfneWa5Gz7435V5RyjLGkps3DK+z7wMm+cg
         1yoONNLQqeCxDENjMr5TDyu3p9Ch/Fjes+vrYF8728+DJR2bcYpWbgh/F9b7Gi5RrREI
         z8Dk3216PRv4L5Iuf4MKDBKapYtyMmYi10xQ1jdhgUZm7++BeHhh0IPIvBKWGrztlKki
         Q2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302274; x=1794907074;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R9Lda//rck6/AmcSNg1JTbogjOzB20ak4vlHDRi4RyY=;
        b=xTm7yOFx85XCcgrVvTZV3vrOOBCBMyd4Akhqb7vJztnpWJwhNzo5i4oogb+Khm2uOX
         +KpDA0yfEjpbtzep5f/J3jYNYb+cTtEm+kKlxWe0Xwtpjv5Qu3Phe1xZ46vSNrgmiKlB
         FwO4ss7VMZ30IVzd/ASpS5Hz4glD7m9nJefua6JHANb1gDgoQcbfOAzQB+5HBKFwUokV
         sJTi3n9szRdcHPBelo7XjzTofdJOgpLPHMGTiUyNTzxSZAhgdcZBzHVj3/7kw/295+pt
         LSRmKFFiGnLtokBHEOy3bgCqpJkgjS/T645mwb2d03rK7bpBPpS4RBJZgvxAZ2qAmH99
         qGHA==
X-Gm-Message-State: APuU4Z9WSvzIZ8z8riUM9k0P6eeE3+Wvf2DJMvsYZjEyFJsAr+v9kEEt
	ah8PEe5wRtXp98S3aQLpqbHqhQCvhYcERLR4tSJA+sbemvQqRAzA7SY+ni86+EHx8GtfbsxsKO4
	5+zVy66Hiq6O6mUkfyqcbSpZukAI+XEYxcH0U5TvHjGBfBNVMbddbE2s29uvvlA==
X-Gm-Gg: AYBFou09HhwU1tUzAVjl0KixMcMUSLXX1jYTQaKtHsealyTNx86wbXgspyJe1UWv5ug
	SCkSdR+DGMQAEbxWLjcSPC1THvRUgFi/0uDLNyU5yq3NMh57bPbshXmD5COSFtwduunWyRQFO8d
	mTqoYMYbGTOUQOLg4BL3SLEA3Bp+ApQ9Gf/hY5MkO5jwUiHwhHAFGMl54Df+RpIen2FwPAkbXNE
	Zn9XH+z3umUDQBPvytJKJxRGmQHXPzORR1m1KiyF4R5t9cYStvbpckJMdhEAxWU8uOpj7OjstDh
	evkghYg9FaygGf/FzX/ZAOeILgEcuvqyMZoVObzUPfYmsIck4an/11kAOdmy+d3BZeeLcahQRWD
	/wAEBDo1OXooyIEI27WDZU8CQ20XzI9MAbyBCtMWG9wlOiFiHThfPgguLeDBNSHsrGk0tqEutOr
	hAJcF/51Jf305Z/5m229Vh8VWLt7dwr9CDr/QEfD7H8S39C18a7V+sDy4SdZQYYg==
X-Received: by 2002:a05:620a:640d:b0:93e:7834:3940 with SMTP id af79cd13be357-9479f31ba9emr287110785a.18.1794302274346;
        Tue, 10 Nov 2026 01:17:54 -0800 (PST)
X-Received: by 2002:a05:620a:640d:b0:93e:7834:3940 with SMTP id af79cd13be357-9479f31ba9emr287108385a.18.1794302273938;
        Tue, 10 Nov 2026 01:17:53 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498365ccbccsm3840315f8f.44.2026.11.10.01.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:17:53 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] power: sequencing: core: add a note on descriptor serialization
Date: Tue, 10 Nov 2026 10:17:51 +0100
Message-ID: <179430226873.6222.11263289504342915586.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109-pwrseq-core-desc-kerneldoc-v2-1-653e6b2749f1@oss.qualcomm.com>
References: <20261109-pwrseq-core-desc-kerneldoc-v2-1-653e6b2749f1@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX1KD5uHuoalI2
 Q5Hwp7AwiBK9pzUW5Qe7MNOV7VY5GT5h90yqdoratGN4eKaMDOW1U9HhZyoVfRkW83EzVMzAkSb
 8kpVxNE5Ri1q1tqMAakbCgS40z0GmT09DDyJnuNi8AxgaxZ4J9CZdvCodaiZ8XKpmBrfb2MTFCX
 Uca1obBos0ve5w/QRjNSe+/vrBSLaNFirUsMYTytHI4NTGXuJlBHUrLIUZIQJD5C5OnrLCGXf2W
 qx6yJQxx99kbqOExMvUhDQ8jvzXsa0Z7wvxPzuarGP/FR6Vu/LmrVzQGW3pThSf4r2KgUjpKxIk
 IAbk5uSJEpGMbGxUWkXuibYbEQSAJPCHJx7vB2h1gtUwapg4SBCSGUKmikxvnWZzeSoZDp99wEU
 u9SgBzFQibFAf3TbbmsjSiWWl+/fg6XDK1xSn4wlLRiiUiw1ko8opGSUOJr73zKXBB/kKBHX7PU
 vCE4kinSKQo9fqgk5oQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNiBTYWx0ZWRfX2ATkicLh4Bpz
 wAgyCNfTm+ztOdisxnGWSHzCVLyWkXBulcT2ITeS6uhJAE0YsmFsMiL+FCUo/Q9/99+lAxzlRrM
 nt4D/ybF0ss+CrYAkEbmTWmRlf+Ckzo=
X-Proofpoint-GUID: qpV1qUO99XnAT_tc2Cqd0TbZIMggASks
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af2e142 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7jyIIPOaxoYB-dx8Qf4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=zZCYzV9kfG8A:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: qpV1qUO99XnAT_tc2Cqd0TbZIMggASks
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611100036


On Mon, 09 Nov 2026 16:19:00 +0100, Bartosz Golaszewski wrote:
> Sashiko reported a race in pwrseq_enable/disable() which is a false
> positive. The descriptor structures are not synchronized by power
> sequencing core. Instead: the user that requested a descriptor is
> responsible for serializing access to it. Add a note to the kerneldoc.
> 
> 

Applied, thanks!

[1/1] power: sequencing: core: add a note on descriptor serialization
      https://git.kernel.org/brgl/c/af805a1d3d3740b25ba4558d6273cbf65752c19f

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
