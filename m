Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4550E2C0263
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 13:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754801; cv=none; b=O8lg2LnaygqXNHVvmGiuFjy611uZnfYSmWKyxbFGPssgYHbN3EMDEQh/Q4BW+TWFsMx5QHDY9+OpLu9H2H5bqrFKjD4YIBy5KQ+bWleh1RVdyXs/JpcarkHrbOaedZ3OdnhSdtXkoVpyHkbUVfMfK/vUT47Qcvc7I1/8BBfGNJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754801; c=relaxed/simple;
	bh=HunAAgOjoR0JoAyZG9x2HT69RJ/eMoGtrBbZjFlQxe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KJ1Ky/QF6b9mooXqMq8Vib9CXuUA4ksgtW1ywxD4N37HOd1OmwZpOddkxgsS4uqspK3YK0V5xkYlCMe2r4yIxJ6/4PmNGDvelIJHaf8q4Q2BMxKkb+VDyFjnhmlsHpFvOHTzIBte/06wKlLJdffHCCisoeVF14uWGlYcvaxAzhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VzrliR7z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=chPpQy7m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VzrliR7z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="chPpQy7m"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H8TqUq3295927
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 13:39:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nFRMtnZO+13TGvwOg+Z9PNle62EKUwsSYqYDGn5wI1o=; b=VzrliR7zwuWp9n1M
	A22ho/vsmj7IesWHmwG425vIZCcr/FcSlSGb11HXfdUOAufL++f14Ta7Ebp3FVph
	Jcy3Fs+1iCumiRFDd2Pdr6Fb2DXar0cNXQNpBikAfg0WnSJMO5m7TKvv0qEajBzr
	BHEsn0bAdM9Nl8ONOVGD3/p7SW7DIvMxzt+QPlob3meOx0HV9gDXWeO1tHTWH6MI
	czEsmmrMHdyGxyFn+KOZTBfwAGrNkpd/Hlkt5bauKdb+4pFSlRexk+RV+Xjfva1e
	w5qX4m/+PWVjCH2x2stopJGv0W9PDk+GD2Yu034OVOSeeF4iblwrzHT+H7qmYghe
	Mdorew==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cxkuy47nt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 13:39:58 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd722c1a69so461069685a.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 06:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773754798; x=1774359598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFRMtnZO+13TGvwOg+Z9PNle62EKUwsSYqYDGn5wI1o=;
        b=chPpQy7mqPX3GtJUQ8bF15ok0SC6hrFsr/Gf6TPxsWQGCBEqE982h7air0wyhn7iTh
         w048kdDQqSwei2joLOAxg+bCz+R8bvCdd6T8/1cLPJ2R2XVrudwFQRxAKe/HJj79VYQX
         e6YPn3zGcqdfTRW8bNOcjQcZNQrl5Hl8/K1RQew5pXK4aCL3V/9k+Lh1pGSMU29q6A6x
         1F+GN1koYak0254NoQxljPkXLtmHexnh5qRJ4G2vWYUI0LmcVd8hQAWFVvPl+M3LqwIC
         wmV+S7YkXzQ77+8waUi6AS5k7ZxI0h8eFlUsJCQh5hogq5NENFV4XHRiif8nvA0wkbjx
         KbNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754798; x=1774359598;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFRMtnZO+13TGvwOg+Z9PNle62EKUwsSYqYDGn5wI1o=;
        b=FytTIZr0cyw4v/rnH/hvdLvPdZ36+3/wbcSKLImFcr/6qC9gG3Hia9M/1Vwp26tqAh
         EAaNZsT5CYNZuXliUw6rrcOhxEVbWuWFpOWS9kbX6drldz8LqqLuNdVhrofNI9vjeEuz
         j6vLZWBOD5jehtXQfxSIhHFgfzUS79iENaujPGwjD8IaZdq8bo74zyuFAxBnLKcAD9lJ
         BNrKTEUVJNYmA8kq0kmqA1Thg2oOHMzGAAitfXd7sTG6n4g/ctdECNsQSyUpqJMDh9T3
         rlqCl5JoU4A66hn/me8t5uDw7BTHOk622dzAlJe83UKiMPKaSABPipkqqFyYZ2x0qgjU
         5xFA==
X-Forwarded-Encrypted: i=1; AJvYcCVjcmvB5xXFJQ5+Y3WXAgc7ylSQ4lSWUu3ouDW528A2db0dO4dlUrIjG+AW7unLxftTMEi8Sgz1mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwMlVV15aANNobo3jkj9Tzf9WODv7jEwc+cdLTe8sxmoCzXvVtO
	cwp0ygXJebGpesHxYemr0G6TeRZnRtLPKAGS2GP6shoY8JRYE0BDKUCM1aF8PCMs/LmUfyb9KFM
	Zm1PHHf1Vp/nOM1RHZ9zTF0WwCdjxOBvGZxehJOWWGQkvXUhrxwVjCIGRHWaZCQ==
X-Gm-Gg: ATEYQzzZYg2ZWbsN1h0DVUpfzdtovk3JJowIau+d07eBGMR4sUcOMPzZGdA9Kt95GDb
	96p5ulcqEFaLCy+iM1Lwz9h6Y3+LE1hu4PiX6MJQcZ9zAdJl/lW4Wl8ZkGzD82gEUmZmbhkeCfV
	FvKxNpcNWe7manqsYXnoBKcCmNwsZlw6QwMcrhQIc5ed/S9svA7tnt8f5ONlRv3Yu40akzP/ray
	czc3Y4LXsepXQ2UpT6nbXn+JpCzA4X3doJZCibgK6TBtDOFaLQxf1o4Boa7T3ejEHUijGLmydmD
	mPUOayVHKG5ODZ94hkeBdHx7LtTmhI/Y9e3vaO+rNVXXXm2Zb1tt1nCiBMnGPkTgJc5nuvqNHmY
	qN0DJRs6E7vTVmkNIB/oKoOWgIkt5txx80utcEdEDXwkydGX57tOFeVg5rFIXCCoA3wvTeF7hRG
	ZfKfFFNx66
X-Received: by 2002:a05:620a:29d5:b0:8cd:982d:4101 with SMTP id af79cd13be357-8cdb5a6073dmr2130366185a.27.1773754798232;
        Tue, 17 Mar 2026 06:39:58 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:8cd:982d:4101 with SMTP id af79cd13be357-8cdb5a6073dmr2130358985a.27.1773754797576;
        Tue, 17 Mar 2026 06:39:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:67fb:53f6:20ba:ff45? ([2a05:6e02:1041:c10:67fb:53f6:20ba:ff45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4855777bd37sm189801525e9.3.2026.03.17.06.39.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 06:39:56 -0700 (PDT)
Message-ID: <890bc81d-6bff-4e2c-8514-c22c52ddf767@oss.qualcomm.com>
Date: Tue, 17 Mar 2026 14:39:54 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V10 3/4] iio: adc: Add support for QCOM PMIC5 Gen3 ADC
To: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org, lumag@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, konradybcio@kernel.org,
        daniel.lezcano@linaro.org, sboyd@kernel.org, amitk@kernel.org,
        thara.gopinath@gmail.com, lee@kernel.org, rafael@kernel.org,
        subbaraman.narayanamurthy@oss.qualcomm.com,
        david.collins@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        kamal.wadhwa@oss.qualcomm.com, rui.zhang@intel.com,
        lukasz.luba@arm.com, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org, quic_kotarake@quicinc.com,
        neil.armstrong@linaro.org, stephan.gerhold@linaro.org,
        Jonathan Cameron <jic23@kernel.org>
References: <20260130115421.2197892-1-jishnu.prakash@oss.qualcomm.com>
 <20260130115421.2197892-4-jishnu.prakash@oss.qualcomm.com>
 <20260131173941.68b8116d@jic23-huawei>
 <6012ad64-3a10-4f05-9f37-f2d0c36df582@oss.qualcomm.com>
 <20260207165638.0ed27302@jic23-huawei>
 <70b77d54-a6ab-426e-a7e1-3e011adad6d4@oss.qualcomm.com>
 <20260223203145.4a4493a7@jic23-huawei>
 <cb11a2d5-fc4a-4956-91b8-95bcf9e7d7d5@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <cb11a2d5-fc4a-4956-91b8-95bcf9e7d7d5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=br1BxUai c=1 sm=1 tr=0 ts=69b959ae cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=0Zxp68U4Wu1vdwFdiBAA:9 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDEyMCBTYWx0ZWRfX82RsenSVIwEg
 oMMgxD7FN2+HZGiXwrnX4M9OMTg9MM47uqmfZICBvX+ERvnTYkf1lcxvnHuKiYknHrE9cXXqCIw
 nakKrJobj3Ph/GIjHvh8Xe8gWzT5Z8Urj+Hkog49shvKdJjUybo2OO+c0w2rS81gU4JSRe/Dhre
 ys4bCvaRsa8YcIB9pgqcoL4ydKhldz252SdjP3k6zQax5k4Dsyl3h0uBdUXlkRJZTp6tYWonbJ+
 QxNFlxE7XKxRS0ms7iAIcR1kiXJCsdh8FQK2vdmwhRLAUTpLbDZ9TevqbIE/Yrd5UYIzFg3jcfe
 0sXn411WfChofF/elg5cMy/CyvFBo/UbE5LLzcXFxdyZhjU+dC8GF0wBBzYV5j8COlqVdj6MID8
 k85GfEXOtbPOeuFI0ckL4eJxXiQ3KfFt0YQJtjQMk4NxErE1d/eYcQ5spMoshL4dTLIZrGl/BIz
 e+GTwRjNcIKpmonIpLg==
X-Proofpoint-ORIG-GUID: rS-uKjKktYVWYB_e9DhUVElSOTqEmRSP
X-Proofpoint-GUID: rS-uKjKktYVWYB_e9DhUVElSOTqEmRSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0
 suspectscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170120

On 3/17/26 14:33, Jishnu Prakash wrote:
> Hi Daniel,

[ ... ]

>> Sure.  Immutable branch created. However, I'd suggest the thermal folk don't
>> pick this up until it's had a little soak time. Today I've pushed it out for
>> 0-day to have a look (as part of the testing branch of iio.git). Once those
>> results come in I'll push it out as togreg and linux-next will pick it up.
>>
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=ib-iio-thermal-qcom-pmic5
>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git  ib-iio-thermal-qcom-pmic5
>>
> 
> Jonathan has picked patches 1-3 of this series in an immutable branch and I see
> they are also present in linux-next now. Is it possible for you to pick
> patch 4 into the thermal tree?


Yes, sure. Let me have a look before

Thanks

   -- Daniel
