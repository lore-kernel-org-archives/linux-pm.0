Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15774A92CB
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 08:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789718551; cv=none; b=FGSeMZ7sZ8iPj09PQY/O8XA6i/LC5PdlEdjm2zHlzsgZOfg//onQRkgEV5mqKV00ChJaT6V6x2BGNfp59sVyitF+va3l9hVn1SNtXtNcbHXtZK7zluRd6fxC2QN0WUtJvj65was55/wX11LtHeYLpeJlJlCiFeIldOoUKvVdnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789718551; c=relaxed/simple;
	bh=H0JBUe/EMO1jDRgyP3JDlGDtcpO2ZiZNH1bkYAtEw5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uTDpMDx8rl8bgKJE+KOy7/+7evA1IK7gyTeXOP8GNAMh6UDLjWD/BgjaQBGHtVxhHMoKgDZ9AWsY6bVxxvgJ4HdM4MsgkAA1CC7FjrozX+6W+fOnuu1WYy70E6XiMg0N7JAodHma8bywih3x6AKIJLG6S0HBzFgrWWifSUn+KSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EulsZUwO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q6+rbisc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EulsZUwO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q6+rbisc"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I5xxZl2660297
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 08:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	yecFht45A3Z4564vTTjcaZ4Yfxl5AMB1C6lm2vKtsvI=; b=EulsZUwOr1HtmugT
	76JcKklLlxafRkkNiGxkvh1QFsZqImpSCTtX5RbOGBnwErhP2+/jaJylUWMQO1zV
	vw3+Qfz7sjeq5KewahfVEVw9X63m7sZSwHE8ULsI9AuQEPigcwut6kEseF3mJops
	4pBYeVIfyr+3Ucw7klbyFp4yQNDI6Kh75M+rXxP33x96nQFebyH5Eqj9XQGFM5pO
	Kwi2bJz4WiMwgRYAOQtniAFUlQ4bUVZ5ozjTThagXEH51uGmdpsD3rJuR9yEhZHh
	eVoTmUACezDeOuIt5UC+GI8A3mXlJZgP2KQL9wfKlXhb++gmMb3zhGJz2AlH6SgW
	N4Sygg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grjttutjp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 08:02:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-530db5af1dcso1353911cf.3
        for <linux-pm@vger.kernel.org>; Fri, 18 Sep 2026 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789718548; x=1790323348; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yecFht45A3Z4564vTTjcaZ4Yfxl5AMB1C6lm2vKtsvI=;
        b=Q6+rbiscp9z9VLTZ6/uHLpINecuFm4VQ4P3suDYIF2EUHc9bJsWbMVDqQeS/4uS0aG
         Ei/fQSlytOJhxizp5NZZrvRaY9IzeCrvwJI4rv7Udpy2J5KvOSix/YCS0fwtenczcOMi
         eYK+haC9ea+tjAhq1mw8emKjm4eZ6AdzMgUlp2tV0LzDAEPm0nkjy5ctyrtEj+upylUD
         bmcV2mYwRPvZcxG+93MuJ48ld3htQiBCTbRndDoPsaHe+rjKUcUpPRCjvBuu9uwFJALF
         1V0oG390BhWOxK8uqVKfqdwvK5nh6AYb5vnPsoPRctJFS4Xk/IKBFPGFQbDPZJH2Q+Tu
         FjXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789718548; x=1790323348;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yecFht45A3Z4564vTTjcaZ4Yfxl5AMB1C6lm2vKtsvI=;
        b=d3kUCEsSa/6tVzDTcV9713oD6JMFsRnbwk0Q+HzpoWdjNLFKHkXUtda31vdxQyhkhx
         ZvQ4WR9SGHI3cQA0hdD+JWNoXvTKL2CYUkFHQUUtx9YtHyDcxVkwTq9DFnjmiByrvnwf
         VgAU7/cT6uI/k6/hMeKSHPbpNKCcbSwGjltKMO0yipDUQwHcB5FiSt4VFX+QUEKJ0IYB
         uVLlTtysNp9eO7ykD48TGGIwr+NZAUAqTYPjv0LI852QQx1lCz0QvdbwQfdanaxxznMx
         wUxczxheytADGfrYkWcGOI8wCwJ4j0F5sV2MSTczbS7WXZ0WnPK1CGCMIaf7dH1oFMAd
         aGEA==
X-Forwarded-Encrypted: i=1; AKwUvByNGLB2kYXGvrN3tcSbBrh4tj3QJ92v3U362M5ko8aQv0nC10IsNIv6wnMSgOkLBywtVrWNHBhjuw==@vger.kernel.org
X-Gm-Message-State: AFuF++nshqZvgEdR6S2h4THpkxa5jGX/IDcu38XFA59WmVpyefBk0ax/
	TQSd1hjUd7j/9Fpe5BLgtGlLcHWMOJSiHHCjfhimu1S0E4+7f9+lnPITKf/16ns4tEwIx0gcf9X
	mFYfcJVAI3lp9zwiVgUWgAt9CeW6MiQ3c7yBsNJW8c7H6pQg+KN+byPjD9SwKlA==
X-Gm-Gg: AYBFou2CXSqoSI/O2nHQ8DrAjtfZGonQNoOQGZ0U7XImX86+jFWMe/kcDr2tcEtP8W2
	oOnYfO4zaCviLmq+paFnwM0mL9QXJ1TUZKxT2xUXe2dd+xaQNn73ijFEdnK8F4mIRBf1Gi/YZdb
	D+w+fQ6U0U1FysOq8uDvcSnpEmijynAbG+NiKt92YmQ5SX2T/JlRPDUggFBmV3iWoRXiPrl+l/k
	1Nb4cwMZRgO2w2aJAMuGBGDzfH4p5K71h1PJ5YhNn+PR3w0SMVd4ShL2H/7XVKV4BI+flZiBQ2Y
	6CxBb/322m1ULqREDeziKEWDptnj1kLMcZi4r70gcevszggNhN2JRxL3LF4KyKcUce/pk3ZR2cs
	Bb7H4bqbbVX2dlJ9I8YAxjQ==
X-Received: by 2002:a05:6214:e8d:b0:912:16fd:b389 with SMTP id 6a1803df08f44-912570aade9mr19737436d6.5.1789718548080;
        Fri, 18 Sep 2026 01:02:28 -0700 (PDT)
X-Received: by 2002:a05:6214:e8d:b0:912:16fd:b389 with SMTP id 6a1803df08f44-912570aade9mr19736916d6.5.1789718547676;
        Fri, 18 Sep 2026 01:02:27 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aa5975d070sm505624a12.23.2026.09.18.01.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Sep 2026 01:02:26 -0700 (PDT)
Message-ID: <be0e4cf6-f16e-4dbb-a5e4-85760c20f37d@oss.qualcomm.com>
Date: Fri, 18 Sep 2026 10:02:24 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: qcom_smbx: Remove const from desc
 allocation type
To: Kees Cook <kees@kernel.org>, Casey Connolly <casey.connolly@linaro.org>
Cc: Kees Cook <kees+treewide@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20260917211309.i.765-kees@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260917211309.i.765-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX2Sa4dhYxfu7c
 2xrXjYKVVWXmRthwai2Tf2MIDZbIEf0/ke/5T4Y/C4WOLlRA1aKFErEaKHw/DCsYgrhKrRWFvkJ
 qS6jI5TkQVvA0NASFM1ilFdtBbUsnzkm0dyUW27gIjc5BvgOIs1QWsBLLXT/LjeZgwvale4on5k
 2kayr/IocHXeHTtqgrUisl33l5OX9B8i7AKUXFHqmfrbxfUZnKSbjVrhWO1Iw0x+o7wiCZ9WUpX
 Q74P8cNL0kcB9KuVNq5TsDWztGfdlu/t5BB7qQ8F4vQubZHMttjQ6Cb0yoS0vJlKcib13ymRblX
 7gMm8rXwurBfXK7fV9ooOCWtBSqp4IKEXzZiBrL0tt/JxQO8BYGbmAPuNSlQNYzSGXTIbyS2YD/
 5SNvuHUzyWLZWKzMT5EYqK60lYlh7+pqLfanrjxf9wVhXMmAhBWFIMsKMGXyxUw2UOUC0EYyqBS
 5/YCJR3S9cnkkdLiAYw==
X-Proofpoint-ORIG-GUID: JZijiVNgYZOVSddnCBeu9LXCqn88GveV
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEwOSBTYWx0ZWRfX5FUGltyIr2y2
 hC2I4inrixT8WJuz3yrd1TnLFRUOOB7+52ZZbGrE4MWcXWF+wOxwiYWKNtV3iB8hZJOYajLuW7l
 lSUqrPaUX9Nji4fPlf0lmlhgUnf1eQ0=
X-Authority-Analysis: v=2.4 cv=IP2XmQvG c=1 sm=1 tr=0 ts=6aacf015 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SE4sDywN97dQNR5h7vgA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: JZijiVNgYZOVSddnCBeu9LXCqn88GveV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180109

On 9/17/26 11:13 PM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "struct power_supply_desc *", but the converted
> allocation type would be "const struct power_supply_desc *", as the size
> was taken from "smb_psy_desc", which is a
> "static const struct power_supply_desc". As there is no general way to
> remove const qualifiers, take the size from the assignment target
> instead. No change in allocation size results.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> drivers/power/supply/qcom_smbx.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
