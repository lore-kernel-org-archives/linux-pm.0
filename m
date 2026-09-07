Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4258041A545
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 07:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788766936; cv=none; b=DttJhrXdoWofEFclKVsWUe8CPt9l4Y91uF8xohbxlKeu/Ig2MmCDhNpnTWwdz22HJZ2Cy8C0EiWqFN0IOwhNtKfCDa8VlSFQ4RNSfoaSbBkHW/gAkGd7Cjm8AWv8hZjV+VPwQFGt2VGhBuHB/azm1hOrik7jOP2CVKDfGJDZq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788766936; c=relaxed/simple;
	bh=4Y5xAsf43glCZh088++ZapXrJHidaLKDLANNbMfpkt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l+gFzpsBvdpokG9BVZM5fWr6oz4aPAcb7EMOxezdTzsmfw0TJ/P4IrhNy0pE3OWxj67t/jySgW0TX/bva4Z2LWgja4V5BQCIa+wBLCC4lEv2u9CRryuiv+nbtr+iLpuNAL8AdbH7172GnMSNg70SIHmdgulTfoXou+XJ6dGZLts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jopQQZsx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LYPMEJ8I; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jopQQZsx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LYPMEJ8I"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777fbi2146295
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 07:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CgvCrmU1Tuvc/GsdKD3kD/Ov677P/v4Ew88GYviJCFo=; b=jopQQZsxm+iSnWzW
	RMVIJKHT4mZ2cZg9oza2yW8NVJ7IQDHeWvBruJL7asOF4HtDxjPnazQdBkgISW1f
	8mZoF178D9/MSJnvJ8cV7euLqZNmnEdyjEIJ3XV26HWLgoHx3wAq1PrWLZU5LBFg
	t8bCzmqSqO4PhlzBqYXcLAPpcCj2ZRB6SBH9jeCSSo1uitBZpFN+XUPwsK8xZgp0
	4baQLhNADbCEVpYdjlA82wnn1LV+eMCHmPhTwnnpdiX3npGIPykwg+6jNAsLGB4h
	0WGVPN+sBcX2PlKPg5j5+GYygnko4sHFCjdAHEjsX75fD0KKPEDAQkAD4PF8rTqD
	GGtAkg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8jdmwx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 07:42:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-52845bd815bso6009991cf.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 00:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788766933; x=1789371733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CgvCrmU1Tuvc/GsdKD3kD/Ov677P/v4Ew88GYviJCFo=;
        b=LYPMEJ8IkxZspK+q7SmU3b+bfqg+MrnAv2ejENAFohPHWbP6UYFxXFsB4LnSdZbRLF
         rrK+7kxyIfFrqleQj7rpCqYGCF+dsxhPkGO+WaM/7nhafxP75npmu11WvFcnV1uRVAih
         kvSWx9FCsPwk90liexhSA761G4xX9hCoeBBuqYo2oVmr4fJ87M3U/GufpQPoucNpxj3X
         dnf/RZkTYdGTXeyKl+pXdRIrX4w3x+kUDaP5dh7ycIaklIQaYOI1CmNei22r4n54Zlm8
         O3JKX8q+wa54OjGjG4e6e8hQezUzTqrQxCO5zolBcsmsWScwFl+fdfPYCgqV2jBl1lr2
         pHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788766933; x=1789371733;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CgvCrmU1Tuvc/GsdKD3kD/Ov677P/v4Ew88GYviJCFo=;
        b=YFOJIU2vdXeEjL3mVenjKKXcZCJF+F1kSF3fGlzK0drhpr/p5FfB7QzOr0vVzw005X
         vikFtk1s8CrnrnbA5mWFJD0UHGBXY69boGbAArfZMCuxk8nwCJBVlbovvQyCI/wLYOmg
         RfsthaC1Kac/2e3R+E7T2oQ9fEc+sqCoyuGI6mVMkH5f/89J1It3H6MpTDjJhq7Ics39
         hYHLGvOHYoNPuflGdcSrBm398J0fYPu2j/GgxcUkcO5CJ+3FmiGoqgOgnvhaumKw8+F/
         WjFKWaWFCBpxkAPLjqWHxG6I137G5KdUpkGgoGOL7fNEvAprblLe2ramvq4+f6QSHTjC
         mnKQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUylqb0ZB8Y/WaV5cyQy+EH88O0yJSfqTIOZPdk32yAP6ZGrVqfk3fmBgyoVvOkcJH+L3dMzJyqg==@vger.kernel.org
X-Gm-Message-State: AFuF++kX9qACZOuGlZdA2pA01cEG9cifznUIPyLtNwx+Q21+/mfILrzb
	IoJIX+/3yX4dKzpBEyKwbKvfDKjw0xD4hSS1UDkQhYce75yygzvZzqVWK1fjEXr0hjFA+hOJx/Z
	R03Yu9qn5tEJP/J6+OpJM9IRjt8dj5+dj+liovNQ6L/hWZq2eKbxf42s2XW+ZCA==
X-Gm-Gg: AYBFou0Fc1v/iXtwDMdJ46cFeNR3K2V9GD5UaSKs3PdkC0eojgHWiDL1KilEJn5C4sJ
	cZFRnD9ydnmI8+xPuASkIunwwwy/s6Vrb7Vx15dNZFVPr0w4ioyPPy53OmW7hqYpuUvQq5Ubm+D
	lUByPTA2qGukOLhnzexBCuCQzLcx61L9frt1NvA1ZZhvHbXBApm3qeRIJyEkF5/a30qOLDvQ91I
	mLbttor7i9G1RLj/IbX97ZOI0OLVjup5w5tYRnTW7jnuLOC+RsK1aI5w/RBtc6EDzJkY+uxMxMZ
	W7Npe9XD5DlbDSk6w1OlaEilk5kq5wslJK6jNyPUfPnzCEKIanH74t0r8S67/V4woWPAdhbcoPZ
	aJsxtLWuPwJMnq94I8sZwjg==
X-Received: by 2002:a05:620a:4008:b0:937:7dc4:d2b3 with SMTP id af79cd13be357-9399184f186mr1035546185a.4.1788766933089;
        Mon, 07 Sep 2026 00:42:13 -0700 (PDT)
X-Received: by 2002:a05:620a:4008:b0:937:7dc4:d2b3 with SMTP id af79cd13be357-9399184f186mr1035543685a.4.1788766932651;
        Mon, 07 Sep 2026 00:42:12 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c262ccca940sm266442166b.18.2026.09.07.00.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 00:42:11 -0700 (PDT)
Message-ID: <66a8275e-451c-4a76-94ec-958f3c0aa6b9@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 09:42:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: fix typo "commited" in comments
To: Hemanth Selam <hemanth.selam@gmail.com>, Georgi Djakov <djakov@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20260904111632.29262-1-hemanth.selam@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260904111632.29262-1-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: dyfQ3cuHdWPZ7BXVRwkOPOHJKqifbBQ_
X-Proofpoint-ORIG-GUID: dyfQ3cuHdWPZ7BXVRwkOPOHJKqifbBQ_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4MiBTYWx0ZWRfXyKiv7oqGfxvG
 9X/BfvHC+Md0aN7nTm1NSyNF+bap8g2KK/I6OIKq9IDvKz30BUrqQe+52bOhAuEsbmJ0ehqIwsr
 w0LfS96ppG4uB7C6kI8tnC+TFm1xywY6i8R+4h5qmIEqviSdFE4dcYI+BtlCiGqR3Vc3D+D4+ZN
 gMDUgM01TlWj/1hDajUb/GvwIFcr9V8TNgsZdC6ylLZb77M5SWUwMZV6XNnhSVvW7V5dc6WlKT0
 51p4DVsjkhJX40G1+kg3mIyr6vSinximWBHjmjwzHRsOgRr1cHksWgA01VyP+Xm412Tly+u3J/A
 fkhGGgV8tTfYYX6ItBP/hf7weuFYfKKQ+Ba59OEj/v17ZpKgpCR11gp6x+wgZna7Xuucj+SvTtp
 zm2Z5sraGweGec0X4KkStTfE52IijNQymKsugPTPYVrIfn3hI69MNgVQM/ACz7pJ/TjGSXtt/aj
 KUik8u0Rg5lyD7R7REQ==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9e6ad6 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=kddr3pe2UqKiqFkHGCYA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4MiBTYWx0ZWRfX7vvSXkc9Kvd5
 F0gQKalCQzYXP+tpVVXBvxDS3/RRHrq9Mzq+Q+GMuR4GcYA6tNKxHBPdK1Ik44kEPDN6fgNwi4M
 DMWbOSIze4x64QYZc4JyWECj4vsM158=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070082

On 9/4/26 1:16 PM, Hemanth Selam wrote:
> Correct "commited" to "committed", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
