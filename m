Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792753652;
	b=XsMbx54vSmnz6pNiHugr5RQPW4IpBYpyh6Pvhr362P82i9JO0L71jjwWL+i38MLRmaRZ
	 B5Lo3e528bSsndNfxU9XHiiTa6BLPp8WDI7su7dI4rDx6s/uNCvrJr+eyaDux8sMvOAAa
	 49gCUuaxv+2Edq13PZgmFZ6xZLHti1m2u80jxPEMGn0btPyT4qfp9DafDO0zjsKVMs/QS
	 BCO5o0dJbwKEZ1cLlIKZUPv3w/tfaK7LwQJA+0QHWkA+1zDFNYc2CN2/TPcT24U2+yW5C
	 rKPaAL+zeA/dONY1tQMuOwwm2iXbBtjFon6UhPV0VDLNr2nCzCZuEcqchrEyUtQQXBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753652;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=jSSVqDq+NOelbWUVCaJ+EbCkgRjieJWhS34DS37RQKw=;
	b=Rk6VlWuYNNkHKO+0juRaN5SzLiyue0C3AxUThaFe8ffWyKb7fP9R0WRGsbI3oWs2ign3
	 pGA2/c0LB0vAG5UyVi/mM2k5m+2vnHdB6IvK+yP+o3jRx73XsdRhitzbLAcJXcxKvPXbg
	 cDpoZpAWCK9CuhVHITN/s1tNQEpaFUjrWok4goMR3ixwbDOMDanOWBMGK8bimF5dFGvg0
	 IPBi6n8KP75KpuZdIvAVizojbs3rD4tFKVT8F44ZH9LU28JFrVgCcIb8veHzVkzrXqMGU
	 bU04/7lZmhA8woCTRoZ2sHswQMAO2piw/CvHiJYR3MKC94GGsXXSI3pPiNJlpO3pqLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tqek0Ovm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d5gMHnX+;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA05E606A31B
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 11:07:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA05E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Tqek0Ovm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d5gMHnX+
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69NAAXI52489837
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 11:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jSSVqDq+NOelbWUVCaJ+EbCkgRjieJWhS34DS37RQKw=; b=Tqek0OvmJj+sI9Mc
	evX8s7G4Sp5KK0woDuKgE3OVExVr7iYp2IItDLMb9jrhdlQTgwLBvKubQvTDWRRG
	XG1JkFXxup5+Sfy2U43swlC5Rr6DrpSovN9ryKjXnhC7PdQxuaZHVX/AS4cdJn9e
	jEAxLTad2N+JUUFIcfNx+vRajIoQZekXi4PosnR0xEDlN+PGrEuwoqFZP3Ybbj1W
	DWUod81HOK5eiLosG9h3tbFeRS2lN4KWREZn0nl/d0VtEyRHJ0UHU0sPOGoSB2SC
	RZEHQlJC+i5SS9/Kuc/f7QSQotyAQdTBXqrSg14Z0LkfN5FUy1nx0Zm61RlnEFOs
	pNTaHQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hftygajxg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 11:07:25 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f1f1f2ecfso18970585a.3
        for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2026 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792753645; x=1793358445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSSVqDq+NOelbWUVCaJ+EbCkgRjieJWhS34DS37RQKw=;
        b=d5gMHnX+lN2GfU1/6X8HOVBpA+WX9nM3s0pJsTIQExZr33avwo4WxfaZO3Hk8Wdoyu
         4q3DQ9Qfp+JeDLBIqriUfm3eKDZ7W4WBPRNNX4OfooSOMgDhJ7nawLevCkJTZyuJnumn
         fLC2OxGeCgc4NdWvdZT3WenjgIuh9bV4bwyu2jsOlYTLeSJUlD/KrC/3sK/opew+MDbA
         stDOIvTsOSG1P05t/tLpnukea4+Q1RTqvFZweR1jWw5ItM8l9DCFrvAdvZjtdOfSsv+H
         Mop0Knhoem2sTJv90ZeafUi7KTwuKT3C9JWdn1g6Qos7Jv86GN6nUx0uhgB9gt3gB4v5
         l0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792753645; x=1793358445;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jSSVqDq+NOelbWUVCaJ+EbCkgRjieJWhS34DS37RQKw=;
        b=GtLXtriVKOWd1D9zMh8FIQ17UNOcI1hxJdJ4QfeRY2yjfolfIXtfyKI4HkYwljrX5U
         fB24AZl7SA3Eu2wBojpTZgMTTeX+CTgWmKvFZMXMuhQFrSCAgYLqNPK4lT/LKYUQDAxO
         QKmy643/hsXjYOlRILwP4shFZNDyduYRNlkqkDfOx5Q8+peIjQDnmsaGpoHbmCcBuBGs
         bVv00YRw0A87SoQDVUIm9DfLgMnuoW91ObXb2/jC+OeHHKZ7VqRo5Gw3TbVdeunEdQAk
         fMv27HcMeP5j4ZcZeIZGJABNg04dH3EWQGWohC62QrZwyrLWGOhLdmk0u3pT9XzME8Ey
         H3Ew==
X-Forwarded-Encrypted: i=1; AKwUvBx9BI/hqTEFmqSbRIGkL1mrma84orq+TwDq06D632F/gQDjoFuEvCwQHwDeo/TF+mvch4sYd9EO/g==@vger.kernel.org
X-Gm-Message-State: AFq9FYJRpE94V6boeuJHsLcQQyi7AoEpcD3y4BxAlNcwjDTD4kI+E9hn
	ABFW6q0FErV3mcuMLTs+Vt9/SOyWzPlmsWQLfu0ms+c/ho7gc+FMhNW3eRtBpfNwURGSPO3u2iE
	uR+vfF2r1pfIkbE1dQAVBzpX2Da9oFaof6hwxFp9PUdsDvI45f4uwTexJKKLYrQ==
X-Gm-Gg: AYBFou1MBQvVp97P2JP6Hv09bzp3ETArNadJo9ZNJuoXpEGLJ8CzgEvv4UkeQOMGYsa
	au7qqZOwsrWofmjQUbPAn4282vjJDEOXew8A5SiYWc6R1pF7riEEf9RA01MqkZdd/2IvY/7aVIp
	gTeSt/zjpkPjHCUIZuV5vKz6a6+/JOUJejE2Qoauy1YqlpfifIxQoUmnla4TDIAQUy8/ugltLnt
	3CI9e8kS/gCH66BzP86MhPxou18DNDP9qZ+R+tuHM3j4Z4xhg5L/AimWiWmRGUcvZROFtz02tjZ
	tfDtGP5cG4Qt1FwxFlwJgJdIpgZDCp/1j6knLCAPResyX12728SaEkRvSMRCDwQXnQ5H8+i3lKS
	i3LdOQAcYEBCgkLuvUDNg5Q==
X-Received: by 2002:a05:620a:a182:10b0:93a:ec4:e5f2 with SMTP id af79cd13be357-93f6f9c2625mr321626185a.6.1792753644923;
        Fri, 23 Oct 2026 04:07:24 -0700 (PDT)
X-Received: by 2002:a05:620a:a182:10b0:93a:ec4:e5f2 with SMTP id af79cd13be357-93f6f9c2625mr321621885a.6.1792753644425;
        Fri, 23 Oct 2026 04:07:24 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5a90ac9sm91191866b.6.2026.10.23.04.07.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2026 04:07:23 -0700 (PDT)
Message-ID: <2cef48a1-7efe-4e02-9f8e-7da97cf8eaa8@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 13:07:21 +0200
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_battmgr: do not report power_now on
 SM8750
To: Qianhui Xu <xiaqinghuan@mail.ustc.edu.cn>, linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
References: <20261013002124.332111-1-xiaqinghuan@mail.ustc.edu.cn>
 <179249416915.570120.11194300523322683054@mail.ustc.edu.cn>
 <101257b5-7e43-4cc1-ba17-1507dad27b52@oss.qualcomm.com>
 <179275354818.2172689.9851715727007912571@mail.ustc.edu.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <179275354818.2172689.9851715727007912571@mail.ustc.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cZpHPXDM c=1 sm=1 tr=0 ts=6adb3fed cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=Q0jaTb4i31unmWYDfaUA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0MyBTYWx0ZWRfX13F/o7VEe2C1
 fJ6h22Gd0l/Buwnnf6Mat5lLvTuP2ee+gf1mk9eePeCg1GhApbxTcqYtjO7KzagqOkk+0ovIwvx
 cVAWtu2xc9/EOP8fBsVM35YOl7RduG0=
X-Proofpoint-GUID: VbG5mMZuSxuVDrx88U2EH_xyB2eldbtB
X-Proofpoint-ORIG-GUID: VbG5mMZuSxuVDrx88U2EH_xyB2eldbtB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0MyBTYWx0ZWRfX1SIiouHjU6oa
 0dqKsKnM6d+EEvQ50ZBnTXr1U/26vOJZ7Ah/RveUJ17HnGQuxUlZWDsksEGn03IgRSScVMKLS54
 xsQglyp9CbdCFTAsMkrVnTHfzIM6NbkNl/m76iuCWuP34Hbv5jL7uVKiJr86VhUmRaScDIE2/Ir
 4jps7UxpjJ1g3vFArHKekgsXtlOVwS56/lnQFMmY8e1Lp5Swxi7UmFhYAViRdIgiVPe/auw10Vb
 0Uoo/QGoPNRVpiBolY9I1iIbghFMqZNjixtu+0nk6d2ASF+2wG4hdoDE8Gq7hcGyf0rLrLxgiQH
 weboaNgpOOCqSCIwg6Zw0gnfn1pXAE6Qb4CcmFELeGyXJRinfUHo8ME5QsH1Gzqdf58MAWipemr
 WzVtHAQcKVLVIhPjeq2/MI1nG5ANqLDPrDDK6EXjm+uXF2km3YT/8oqKHAAl074hlM4pQHGC0YM
 j6S8SnfyTy4TsYCmb6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230043

On 10/23/26 1:05 PM, Qianhui Xu wrote:
> Hi Konrad,
> 
> (Sorry for the subject mismatch - this continues your suggestion inside the
> battmgr thread rather than the SM8750 sleep one, since it was your reply in
> this thread that told me what to try. Feel free to re-thread if you prefer.)
> 
> You suggested disabling rpmhpd_driver.sync_state to pin the rails at their
> maximum corner. I ran it, it worked, and I think I now know why. Short
> version: the effect you saw is not specific to sync_state - it is the
> Retention corner, and there is already an upstream commit for it.
> 
> What I observed
> 
> Board: Lenovo Legion Y700 Gen4 (TB322FC, SM8750P, mainline port).
> Symptom: with the camera power domains powered on, turning the display off
> (DPMS off via the compositor) hard-resets the SoC. No panic, empty pstore,
> no userland record - the reset is below the kernel.
> 
> Two kernels, same userspace, same device tree, same module tree:
> 
>   7.2-based tree    6 of 8 runs reset      (your sync_state arm: 0 of 4)
>   7.3-rc7 tree      0 of 41 runs reset

Please ONLY do development on linux-next/master going forward.

Konrad
