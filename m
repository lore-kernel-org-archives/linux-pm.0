Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF54B04B7
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 02:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786069460; cv=none; b=CEAcQjfeVR9tmHlku1SvYJZVwmwB+3HJ3Mr+4kf+6s0GFtPfd93MB7MP7wGjr/aXudA7eaZP2P2dvVDMbt9T4U7OiPZrJRlkulCkHhaCUHDkfpFhwGEQgGy2ZAPeHBnaACtjotnxnE7rxhgPcAIb0Smey8bjK9LbqqieqMjvpGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786069460; c=relaxed/simple;
	bh=O/9+0V6P3F6VPV4jw/yqyPGxbORmVFL9TDOKpRE1Za8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=un5SSNZdG0GwJ5ssLUcwXKe4Z+MBSTtWkHnusteIDVOdkK6L22HPfidry5AqfpbweHoXdUCi0htywubLkBCfuw6lJwCj+XKtK4OgSp75RulRLukzqGHsGeE2P1tRgm7Nc7GuLlmGYAoU41UR2bVpxvSchY08mAtsJHOdDMiLslk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KM18Yvhk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Acqg/9SA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KM18Yvhk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Acqg/9SA"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770Gnu43822033
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 02:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	r7EeMfnGJgYu1ydDTKLTNwHg6eNEirbplHnWuDVF2TI=; b=KM18YvhkYhOnqo6V
	I/13GO4+hJo3hhoxMerDxY2iuZp3ZfNfxLKs/xsNQlogMlTTMjXmHHPru28Ma/wA
	L/LgR52H4Jzkyc2E+aGAlnwnI2QsqHNj3dCr+LqgowODxXu47/l2tBC2wugAJv5i
	ra/L6ULbrh6zHa2+za71YOCbeW3VBWqYID84WafmH0eOYi4Zcbzdntrg4Qqn3+R2
	3PeaaR0b6El+goTVCF9YEOPIy2XBHH2rM7iLijRRZqlfEHe4uv+aQaFwQxQEH6M4
	GlY/zcHlaDSywviiV4jG3Ah2As7IZD2Dpx2JTLgfCxu4HMc8/6S+pobScdDN6AQi
	bOrQ0w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gsu2n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 02:24:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so33907131cf.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Aug 2026 19:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786069458; x=1786674258; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=r7EeMfnGJgYu1ydDTKLTNwHg6eNEirbplHnWuDVF2TI=;
        b=Acqg/9SAlUgPne0AmTMHYNX7Dc2i+d1qvmkfkaQuwrO1Pp2qHHZtOvNlAYwekXaa/P
         Xa2GeSwhugMOcYje+2DcdFmXYKWQ+zCc05vzt1jBDw79jPtPu3SqRoQBBl9ICnzuVCHh
         LZLqHcKFZc5dBH4rrmJMBBuQZ0j3uF1EGbyvHPmLj7tFNztIk3cILL79v+OcChL/bDls
         uU8YlldUMEQuSoAD0YXnUVNK6KeugNTn/3yTCLmdVO4XfxMYuiPD+OatFhkJQCIOuUPM
         UovgUhPc0On+g9o6NSCshfp1SxRDBA9Q9zopn4FWptycbUZiB3CBSyOXz7Can2a4Pbzj
         Sfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786069458; x=1786674258;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r7EeMfnGJgYu1ydDTKLTNwHg6eNEirbplHnWuDVF2TI=;
        b=QdzcWyPinD6epQqCiXah2+mwvLn54amJYJ6qWwSZVTxWxkLeZLNc0gRbhV8LxC2r7a
         bWqjaqyp/7qlkQ4n5tarcskPc28Ga/+ln1bgxCxdfXsPUv1w7N44Mz2KNYDX8oiMyHoH
         F/X38N9GhgrjVkPka5XcikUskL4I3QWD+yuwpq8WafERDAwHPFoIYZOv/Ecwh7HEQLK5
         HSwQ5sSclsIAbBjBn4hNm7qteIkSYeqwXhsYnlx5IsJ1Shl+ve+52Mh0nzXUzfMYts9O
         Ms6gb9c/HKaXu0E4reIUVvbhSXX6CfSmCtAB/IjgXssfuX3XVv8ncVSJ2gT23a+X75nl
         TgJg==
X-Forwarded-Encrypted: i=1; AHgh+Ro+izKOrl0ZbFap+Y4SXCJoPdtL9yr6uPcO8Q+yvOnzhs972GuR1ZZ0d6Y9W+mCQn98hshXNJ7Y6w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7b425xx74kCVVyVPfa3ht3d4pbTQw2YxQsZD4oHOiJqdaJw2t
	vKwc1O0TxxWjz7Ti/XZ/xqZPkJeoyFRhRdU0zK9uzm/GsQ2EzaLrrxIsDc7+niSrT25DrvXErzd
	4QVpYn6QRyjgOnrrUGkKOzCJvOvCRh6koIh8EgqQLkaZ8EuMencGHZuAw6Gd91Q==
X-Gm-Gg: AR+sD104i9K60DimtSjMTKLDj4w4Sn/kVK+goFuqZs/A7RmUC2GtE6q2+lDrcaNh+pf
	YYM0rQMBz709M6tv9stCUo530/ypDtoS1gWCYMILzqbbPMMzGHisewPj79N2TxrXbSk+pk0t+qP
	6fXUCRMt4WBLkmN6Ra9eItfIyrp60nCXpkj7Xz4KWJR90p3oR7XHhOFA1nEMYhZIG2q9ViNrWOy
	LfmEj6MhkJdo3yEq6lsysWyJ4Kp5h1pZpM+D1coY4wHhUw4jlPY9pit5umypUzV6JCDpAzBlkmX
	DPB9WgXUkJlt+8oz6OSbx+knQtrcXRhMBSLoxc4Qf9tPf7uVKdy7cx+zKxzmdjO1RvH2lzmjdRr
	BXeA2/eKJfBwlqbtwrohDXNpFEQEu2np42RqxFI7SQ8KLgQ==
X-Received: by 2002:ac8:5e4c:0:b0:528:3216:b802 with SMTP id d75a77b69052e-52d18e6ebebmr1312761cf.15.1786069457741;
        Thu, 06 Aug 2026 19:24:17 -0700 (PDT)
X-Received: by 2002:ac8:5e4c:0:b0:528:3216:b802 with SMTP id d75a77b69052e-52d18e6ebebmr1312411cf.15.1786069457293;
        Thu, 06 Aug 2026 19:24:17 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499541b86f5sm104816915e9.0.2026.08.06.19.24.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 19:24:16 -0700 (PDT)
Message-ID: <c4eab752-86e2-4c4d-b994-6dd61ad2cc64@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 04:24:11 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/of: Fix trivial enabled typo
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, linux-pm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Lukasz Luba
 <lukasz.luba@arm.com>, Zhang Rui <rui.zhang@intel.com>
References: <20260804213738.287818-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260804213738.287818-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a7541d2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=b3CbU_ItAAAA:8 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8
 a=HkZXE4YukUnMknDyX60A:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Rv2g8BkzVjQTVhhssdqe:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: D8rOg_jXpoPt2HRYHt4kWBM6MBj30Ius
X-Proofpoint-GUID: D8rOg_jXpoPt2HRYHt4kWBM6MBj30Ius
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDAxNCBTYWx0ZWRfX7D+j3s8Rybu0
 XwkD5jFHnD09ttUBgTYKA96o49kg/8GN8Pd00zYIUam3RT3mIvkVLQdA3p9ITlViShBQZVdIX7Z
 dgMcUpHRGU0/K4RfRlJc+u3QrLf6w9g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDAxNCBTYWx0ZWRfX55vF3PoWSiVP
 N+SP9mvH5sfW28ULCmMJz9Cv4BRx5TkXemKQLXXG7golb113JjMMzlMQ3q+JCjqESOpIHge2DXv
 PqVPf2QdABImqCdeKHJ97GPNSG4pookie+2G+K6x7FJIEIYnoQO5yV3f5FPzS3oR/uTBwQJAlMh
 k88XN/XKG8J84Pe5oZLEYd/H5W/6YevVJ9T2wmJCyQ4M1Kt4erf/4rMCVHwh/xlfSJHNCeP5nJS
 lpYqMGWWKaLgyQJp41Bb48mqvidTKLM5awB9I/yuOUaVO1in9baLWhUADq2iRXnfuja5REs2HWo
 L/29Bz+KNjb0KN6Hch1S1b/vgZFLo2fhtJeSv1sHMVz+8sg233TCgSWuMxMdJ5J3Lh2HhP6kwwL
 Nt6iabkhg7qu5xJkS3ETZ3j0poCVcgmCt2BP+lFnEXvWC7+19NiaRi48wwOlULqF8epXmer1MJN
 EbcMGjzUmX46TOOhP2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070014

On 8/4/26 23:37, Marek Vasut wrote:
> Fix trivial typo, s@enabled@enable@. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@kernel.org>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-pm@vger.kernel.org
> ---

Applied, thanks
