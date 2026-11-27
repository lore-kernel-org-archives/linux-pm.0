Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795777534;
	b=5PCEw8iiLXfgVhhChDbb4Xvz7nm1GddB6XUo4vg9wL2XNUwRohAG0rysGO2fRIVC0l1i
	 EJasWarj5S7bBe7/VNFImPlWSGMLsEhEsaKeeaX3Mg+pXk59yeDA+a22hS+0NNtWZ1YoK
	 AGxmRVAp9mNDysJxL8bq69zG3tgMXEkBo/DHY9HUErZSzcbNRJmoXGmHR+PL723Kl4yOH
	 7cM6FuemXlEwMeHd+kzr/KP4W1RBoTHRvXJV46UmgDAU6t1F49XtGFEU4esRL4V5kEdeY
	 7JMKrHgYoa2P2d6BRVR2adNlNl4ikHiM405DFNHHWrTcqVkYNO2/Q1gqaxtXtEsaMFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795777534;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NozXVbWGPEdY7gxHDrA4RR7QdJYSBiFThdLGNmJHqSs=;
	b=zumk0poPkWDVGjcnUb5WIt/wtrDgH9IgV65Jn3sKHDX6vSIpEkKjuj+6IvRB5GpWoair
	 +Agb9OXMV8fNM7S7pyRIHvVPyBHLJLbLTmyyRJp/a29mJjN26PhworAfMGFfV5kQn7Ujb
	 /9kNqj+ie/XT5+3NZZycorS0gZsTC0MhhkxkGmcvYruAxKmrDdyvt+tHqx4rFwgI16mNN
	 KKjfqAIisI+ati4N+oLdkHaW8aXh3L+kFfN0kblTnjow+CK9jmKh0ZIwOBxIZ3O+boE2M
	 llHt1kGkVR2vhgAPPL0bKqw2Qxx4MUsGqjln3i3hnQV5zQv/RuwpMNGVvZBJhvvw7iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O39GFyKj;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Of49x8QG;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D8E606A323
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7D8E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O39GFyKj;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Of49x8QG
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApA7p2677163
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NozXVbWGPEdY7gxHDrA4RR7QdJYSBiFThdLGNmJHqSs=; b=O39GFyKjt6GqYE7+
	bPG3wEAtkP+fq5VkKq1lYvlTzW8q5knyUy3xUYvFoOZXICYA2voBqWiczSJEuNgs
	jKQkIeHsdoVURJVRpbNlQuSgJk9gqFEs4n0o6qtuMnWozTieRz376IQ6JEHnjI9w
	o+bAvIHY2OGbaC2CaNUiRhNlNwI5fLoiFAxSBJ1kX3iD/mto9WrQ+V8xotzq01VF
	GE+JEl4wRx+TBMgfgwMLexyNvgo4l8NemXiX4c2LZhKb881x+6fpMQ5cunLP+5ZG
	fvVk9s/59+D32il3Xm4U/5+mKEqbA6iFf98snlJ5OVpyHmoHhAS9yDYnzOg+e1Ib
	loniLw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gh93te-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 11:05:32 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5476f5bd009so24855441cf.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 03:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795777532; x=1796382332; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NozXVbWGPEdY7gxHDrA4RR7QdJYSBiFThdLGNmJHqSs=;
        b=Of49x8QGVQ7XClZ6t43bAD15h9oT8ziX1Zuv0MJfnn74QeqoiZBiyJeDYZtQjvl+xS
         qb2d+aqSw72YcRKZdFvmRE7vIqW91tFNy8gnqRabD0B6tTaXpS1JFRxlFEB/sjMWeZv3
         JpqeSBXZ/0Y9d2PTeVAb/zFDLFTJPb6iopKuhCXcOZkHfxAPw2ivqo3EMkc5LjMg0gpF
         k56J9/TeBNL0X/x+xzD9NmiVnOQvsJazBJ+MBw8DlbYAmoNvw5e8bR8tHL+PN1skSAon
         JePf8AlN4c98/DbX0yqBITOb9zc2XL0NRhkZT5U4aCMcS5VEeqB5tWMhwBkVAMIYM7R4
         gHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795777532; x=1796382332;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NozXVbWGPEdY7gxHDrA4RR7QdJYSBiFThdLGNmJHqSs=;
        b=kanFsvT73X9sFshvWUU4McOtRms3c1qH28/OU073+E9RvK49XUHjRgywfYZI2GHtcI
         C2q8zlTWzDMOLowSsc89JQLeMcpn3ykWDR4dK+fOAbRdN8IXd0tCQ1bQVLp4eTxVmd3j
         2d//0GD9wwvtSL0YodZ6uZLhrbTGqVPrWj1LRGBTk+kjbN9GKMZ5NNWfrmc95ISty46k
         i8RUzwXCReycpjT9fisd5BYNMUKD6qB1D8YQtxEcDgqjIUAIaABRbfAM3uO/BgksoOLp
         Pk7twszR3mQ5OvBFoREkwTDCZK2f70VGLRkHIsrH6jd0pEo+EYoitDJo6sILNxIVMDTk
         Ot0A==
X-Forwarded-Encrypted: i=1; AL+hErFQg2Zy1kOxyqMGfeikF1OxXenwWuQtsvj5S3hAvlMBCVRu3s/wuz36X/alRxifKKjiAmh0jNfpsA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7ptU/Qq3aHvuzmsQ4bywxT4srZsjDoGd7wkRkR9xxpZZ4W6W9
	Fxe58F46knyiEZ6ctU9eTdp0WfQeQcdf8PLQo6HYhNYajQxrGPVujwS/a2wqBPXaq1Y/FVpNIKC
	TDgJB2wVw063vc8NKby6WLmgHqtCBZm2tC2d05dNiK3dXNc7Ofo9OA11DTAPbYA==
X-Gm-Gg: AZFdTZff2HqMruQC1B4S6nyoNVwkvnaL8GW3T2/h0ZBnF+iBtndS0Gk2xAs0Te+kUMu
	rAA2SHlMuiUctzMEFLY2vLb0TX+Rl6kUpT7rh1x20XHBdBE35HDYUwsRv7kU6zoxePwRaA+029V
	VDAlxoxpKIPefc7HHU1Mz0s5+LJcAoiI2LQ1BW73sbLXLH5JWfgG4hGK70IDVz6HWfYY/euMnvu
	AtMfKpCIcDXnCo/4ZlPc9TDa8+2/He1qMFgHCX/wyxdpw8Iq8BR6QeCeYxOdp0O1k6a4nsVlbyw
	ZNF/AuZOrOhiK69huCtTZ8fFJR18fCCXWSGOuRil5ksHukzQM8U7JQwedI0k7xFSUc6yhHY1AYB
	KuUNptWSUwTVXk9aDPcfEaZrGybrK0WO0glgSyawHNardjAnkwWgbNy550VoJlfG0dkNuybs=
X-Received: by 2002:a05:620a:a801:b0:949:a385:d30e with SMTP id af79cd13be357-949baa12795mr4341419285a.4.1795777531967;
        Fri, 27 Nov 2026 03:05:31 -0800 (PST)
X-Received: by 2002:a05:620a:a801:b0:949:a385:d30e with SMTP id af79cd13be357-949baa12795mr4341414685a.4.1795777531467;
        Fri, 27 Nov 2026 03:05:31 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370e78a7sm10414924a12.16.2026.11.27.03.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 03:05:30 -0800 (PST)
Message-ID: <8184404e-93f9-42c8-b10c-ccd88c7934cd@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 12:05:29 +0100
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
Subject: Re: [PATCH] interconnect: qcom: Don't read back BCMs without an RPMh
 address
To: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261116-icc-bcm-readback-v1-1-36b533d66a69@yahoo.com>
 <68573981-f9a0-480c-806a-0980cfbb6242@oss.qualcomm.com>
 <20261125165310.1409251-1-venkat.yadlapati@yahoo.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125165310.1409251-1-venkat.yadlapati@yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MyBTYWx0ZWRfX38jZ9nlnuqEz
 Ms3TTAFTjoT8WNLPoHqh7gnmNYYjfqIZDa+DVtJxeSX3B76kU0liLvGCim0f7zFPbY251cWAP27
 H9Kh6CHrDcK7xvuWb9BP9cq/t8c6gy8=
X-Proofpoint-GUID: 4hKqR0ScSEGb_jSJ2EASHJKb96J9aiih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MyBTYWx0ZWRfX4U9SpKdHsP3W
 WtZgvvi9wq7yNrpZLhxuXGre4gVFRWrdQsRUZdd1GlLdFmXOS/SDuqyfl78TZ0MukY8kHgspKSt
 T+WhceaOJD1AbmB4FX3LXlh37SoQ8Q0Fo9MYrPj/xFtsiYmkxiVFK4AMjOa2mk0uooG4YRNv4M8
 7az5S5JSeXazPzsw0A6RLbEYz6ukEPemLNuatsPWCWYC5Jm+0sTR7Pq5sb5hn6x/e7zntdNKPlx
 HI7TMwpm5xLg2l3CS16CdfGbIh094i92ScFv22I+GjUBVbhDkF9n4ndn4ZOAIzmaYGGuthh6rZv
 bgXTtf0CFtA1aKRvJohB2ThkQ6zN2MDLD8iUr/pKWogpAQ3UUyA6fhN2MQ6H741KYG+73N3O9Cg
 AnY3iU35gAD7NXBZwfWMeanm4TiTjSgJca49vZtmFoN4IZzqYPkci67ZQmop2O8MhsL/zlMjR/Q
 utTXlG9FFqPFfxRZuxQ==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b0963fc cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=1c4igp43OoxjrLkunPQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 4hKqR0ScSEGb_jSJ2EASHJKb96J9aiih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270043

On 11/25/26 5:53 PM, Venkat Yadlapati wrote:
> On Wed, Nov 25, 2026 at 10:45:29AM +0100, Konrad Dybcio wrote:
>> Fix the driver instead, please.
> 
> You mean a separate Molokai icc driver instead of reusing the
> Kaanapali one? Molokai also lacks QUP4, splits aggre_noc into
> aggre1/aggre2 and has different QoS offsets, so that would be a new
> binding + driver rather than just dropping QPC0.

Well, you made a great case for it being separate!

Konrad
