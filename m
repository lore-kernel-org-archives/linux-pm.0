Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BDA3DA5D5
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789028833; cv=none; b=sbpDBIs2eCryfEydE+AL2kz4PuI63WP2MJ4NM4XETSGGTAmv/0RjVkAfYPUWttROTW4nrqTC/8TmEgG6z2p85n0w2njdKIoYSBVXOACHL52KJOGBA9VX3jP4Y4eC9XGnVcovpHJgRvYmfoRSo9LosHeCyhVygSLlVXsKM13tiw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789028833; c=relaxed/simple;
	bh=CZumYX9eKEG+3MyRMIeHZ2CqGtJVgd49p+sc5m+sVU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx/YpTQ7UuDA/YoyE2/UZ3PG1s1MOVwbYBSCqVhf3pErgaWYAOhSz9clWzXH3eTsEQkNXlWCEj3sVLCfg1y/Jw44mV4BNyQ8TdI0s5hQ02O33+OzlAjd+Kr21igYBAHpTGQXYbUZgKGtyoGWVMKGDU52tIUlro6/f2dQzt21lbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=crMc8DjE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GB2deC9N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="crMc8DjE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GB2deC9N"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GptX3655281
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=hwsbbABhCqD7YrBomZaCutoK
	KqKwzQ6UY09UG4GpRbY=; b=crMc8DjEAyr6qLp7n/ZagT1LKa3EoT9uF60hbAxz
	PIQXQ8Yf/R9GS34mIsbENDxisrPcNXfC8Ben+LUca0uZgaz1GEy4E5yx56e3ql+r
	Z1S35xt4I0gn3GykQrQmqQIA8e1HQBNK3wLpXX/B0/zrvgxfzzkfy54aAArPAfRh
	GL1CP7YZFOV/ERMKkYfaU3vuGVPYbaxrO7Ziwx5dfK3F3zHwGZ4wuvS/VfJ3xn6T
	Ia80vRTJIkZ6I5pcm2JkJDxYItA0vNe11DCFEasUTu6M5gZTfFkeWF1vuyC32ewP
	7Sz481WZ5i8qpcCXxpKwTdxDmVDEzddpxrx2e02Xr9ATig==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcydtum4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 08:27:11 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-39b6416441eso8682021a91.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 01:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789028826; x=1789633626; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hwsbbABhCqD7YrBomZaCutoKKqKwzQ6UY09UG4GpRbY=;
        b=GB2deC9NtD2vNWDFz6DUqYwxCLLLuECHT8aiZzTeNmV8jossLdOkZ1cC2gcC6ct47T
         zlED5bT1+TRMe1flM0jilUKgS4/fCfpRZsn4Ak3/6lzIqYH8cnr+qK6yB6vd1PZZngNb
         A1PSTDHkTfezJtVo8VWTdR+IU/io1TQ3bQHnQnQn8hB+e+U5EWsSh11JxC8gPp/hkrYN
         zBKrw0HRmFONBDrgUKlqLfJOiBg8U+VOHEdGYTq2XgBuptb/EGK+mSy6TebzwBqJSjcK
         /M6mvCx0vzhqueMGv6J5fqeXFpBhkxPlX7bmyke7cVw0uSxkeF0Tv4m5bXI3Ddi47f/7
         jXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789028826; x=1789633626;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hwsbbABhCqD7YrBomZaCutoKKqKwzQ6UY09UG4GpRbY=;
        b=eJSMPInCNJUnxgOqei2DqeMM08SnNLcyVFUHglyCxAvr94hDAQlOPlQNVdy/2gHC9c
         QlG0xE1Wo9FwjCqchV9PeuKcxaCfFlxJKPATHE5BV/7rMfNS94ALMnW5B7e8nGgYkXoJ
         TsgSGzVPimFWVuOfMGe/LDN833kYfU+Ic4rr3sXaU/CpVMc9uRTIlPTdTq+VRFB8Aq3M
         sQeTEdpheiG3t72/djUytL7NPVaRx3TbkDnMRdHex2SdqF5f0ms+OZZiGVQG10OsYKj4
         WHxGxtN5NDM5k3YZ4lYwgTCRmLwuxxKpgPkD19UM7TBB9KqZN/j2MQ/k1/hTt8DRk1yf
         r8/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxrgxWbQJxPkp6xNARkDWLazT/4I9Ms7DTt7+avLyFealfU5HLus2FBV3u9cu2LTmjGzFAIN4nIDg==@vger.kernel.org
X-Gm-Message-State: AFuF++mgk+wTyE2xIl+KfxYhucEG4Xob7vEjLxdJrqdccuxzLNHHP7Mh
	QAcMoF49uvfgdvgIteyEBIH9xkq8GLrFuTPjFJAK/XotrUFeKKazclBJRkgi/7fFNt1SwzwMt6W
	DaoxvFyjESHZDykkhapBmK0dQUgYaE8xRSA0J3eLSwrn0KAYPyPXcYsffijviZA==
X-Gm-Gg: AYBFou1hQkRrsIbS4D3tR22E8oDf72ePWTzFHOPt699Fk70bHbTJSa2+jYxCx1lVN22
	NjHVDtPu4apyyecYz8yoEldbiVB2cBVEQKftzmMQwiWws1MkfeTzj1j5NxjoX8B29iRJSujw2BL
	FfKxqpC4O/fn1x+ReImWQELt1UplM/ahZqVmRKBN6OfpqMxY7nKH87Aa4OqT1PU88nd4EFTzFTK
	RVWynDsbxa3tmzycqlZgLvkJgijkB1kFZ+24utwoExmNifQQ3eTDHZYvQqjUYSfU2CISgUiuHWU
	64+Wmg0QQw4BF8l2yCeDtJzcf3p9UjRvEzNxebXRmP55utYo6qtUZ1NS5ywAAQ6ckFlrdRzjzvc
	YdVFLEPZdj87bOQegoNvj0VhHr38=
X-Received: by 2002:a17:90b:1a86:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39d709dfda5mr8554920a91.8.1789028825615;
        Thu, 10 Sep 2026 01:27:05 -0700 (PDT)
X-Received: by 2002:a17:90b:1a86:b0:398:ba96:1afd with SMTP id 98e67ed59e1d1-39d709dfda5mr8554868a91.8.1789028825144;
        Thu, 10 Sep 2026 01:27:05 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14340a69666sm27957557c88.9.2026.09.10.01.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 01:27:04 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:56:57 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/3] interconnect: qcom: Some defconfig/defaults
 cleanups and improvements
Message-ID: <20260910082657.4egpdfaaqm3jlroz@hu-mojha-hyd.qualcomm.com>
References: <20260515-interconnect-qcom-clean-arm64-v2-0-adeebc73596d@oss.qualcomm.com>
 <20260909062907.f43ahkic5bnv6qja@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909062907.f43ahkic5bnv6qja@hu-mojha-hyd.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=IfsSymqa c=1 sm=1 tr=0 ts=6aa269df cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=lubSgy31dtm7KxBdwZsA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: Z1FJsHEE8NDyWPdW7K9hwOY2EUwLGnLA
X-Proofpoint-ORIG-GUID: Z1FJsHEE8NDyWPdW7K9hwOY2EUwLGnLA
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA5NCBTYWx0ZWRfX2JNHIaL6BNpc
 +Lk5kMWNkvZ+EbWLdMbQXV87P2qzCm2SgsUpC3yZabnlU7WvolOn5AymqXGd0kmFFIaW6Pqpb9X
 3rr9kxlhlPd2vJPYBp0+2QRJApDlX8o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA5NCBTYWx0ZWRfXyl67kQTK8H6s
 5+R6IEo3YC1km5uD6oGEKsSoIqRXWm/3vOBiuCFIOknC+7mcW922frMgjChFXOA1hn69FdRNrkP
 gtVUkGUShkDNgiISYfrfzJ2hXRGXJmRvJ2uBY3koysllT/N2eqEVqKG0hl5kHNnUt2VE6pcBNVw
 evy5SBRnZk9aD3/GzaYBtrTJIPZDNt8z1V5qlTMdDMYZ/0PcDTZ5jyBtWTmOn7W35M20E0Rvskx
 ab/6Zfxik6bfsw/6SPGNtu3YgB3DbL0JgBpYxYRfcyCpQwIG0MbZWeMjfhJWUqF1AqxSCFdWUQM
 EOa97SWonAv6U0ELyJTsXKsNE8NJVtLzk+EYCpxRJv6l4Ofgq4nu8BEG/LbpQsNtMix3YYddFr+
 j6+qlr3Hqpr6hYAnfvxCl0bubqi9BxA8YatbMYJvz7MhlCPk379rb1WmQtGn1Eix50rwr1QP9yc
 w9SRPdv5lTL7yoN5L+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100094

On Wed, Sep 09, 2026 at 11:59:07AM +0530, Mukesh Ojha wrote:
> On Fri, May 15, 2026 at 02:11:05PM +0200, Krzysztof Kozlowski wrote:
> > Changes in v2:
> > - Patch #3: Switch to built-in for everything, with explanation in
> >   commit msg.
> > - Tags
> > - Link to v1: https://patch.msgid.link/20260428-interconnect-qcom-clean-arm64-v1-0-e6bc3f7832db@oss.qualcomm.com
> > 
> > Similarly to clocks and pinctrl, interconnects should not be a user
> > visible choice.
> 
> Is there a conclusion on this series? As I was depending on this series for
> Hawi interconnect config enablement.

I see this does not apply on linux-next.

@Krzysztof, would you be sending a revision of this ?

-Mukesh Ojha
