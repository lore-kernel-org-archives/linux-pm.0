Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F3144C667
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 04:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792383206; cv=none; b=E4iGHhrstlzb4tr9qxGmY13GHKz33iAZy4EdUpvx2TbRvSHq3ujLCwnAIYx08FxBhdLu73u7pEwfhTHAK5CVL7FxYuH2IfaLlVabd0tsQHI+YSTuKAnyxlrQDuA5Vo1RuyfxmuoHuS/Wk2/fPe6iclhhtzcm1UfXRUzSAAqE0aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792383206; c=relaxed/simple;
	bh=ES5ji0WdaXnaAwJxxt4O8fyzqifCEL4AqEf+CGOUryg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WsohwxL8cmj2FvEqM4hwOKvvKbbDbOd+JfqmCLpZ0hzrHPwsjd2s6Ei1o5QFnY9qGYocTYFVtzFMv8Q6GGD9lvWHfYs8BLw00c2spuK32wfTbnTbrFMNddw1AkhphpY4ckD2ySL3/xYocrc8gSf69FtSfJ8PWqgbcsP8xEPNhks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZA0GSQKP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J7TNpGch; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZA0GSQKP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J7TNpGch"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69J1FvHL1736950
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 04:13:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kEKanjHY6l/702U6B37yrWXtZ9fIf16MotBPMsqJ5hg=; b=ZA0GSQKP6fQ8J3qY
	dY+18NIIF4T2pO3poXKKpy13OTa61xTaadblvWFsIifIGo83ov1IpeNf43DZutG9
	/qbMxQtXCo+Q5OUU5JZZ4GqKctKkAgenpw7vB0wVoinRNQMKWUQfc6JblWLdWcMT
	Qf+OQEzc1W3loudNeyYNLKKdbJDWO2ksNZeBjiFQOYnL4M06js2yaqxvFM7i0qe2
	SPVTg1Pttu2Lh2aa7kKuzga/HxPHkRKX41AKYubq8n+eXaKz6PrZJFL/jUUHdyqv
	qkmbTb8dAUI4G42x/bqlV0yydc3nNzF7Baj/dYvaqc/dl7J4aK+AT1QLcwYRvsfL
	Uzcbcg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hd5u1gv82-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 04:13:21 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac575a9198so3032252a91.3
        for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2026 21:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792383201; x=1792988001; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kEKanjHY6l/702U6B37yrWXtZ9fIf16MotBPMsqJ5hg=;
        b=J7TNpGch0nLD/TV+CVzVd9NYVpIbyJGP85Enk37lAClXUWijxJnu5TYdb67YxvIOh9
         4f6KzdzqXbKTuMfYE72FKHIf98c1sIH/UhI9xrGcDXjjNRWkschYFYhuh3jHCW9YX2HY
         DuOvtbw2WZdMy6ZCBObPj3XmX+pARtLbVcI++Mhk3HkUcyPZ9RtOOxerYzlu0yUZQ1Ro
         aUqBWzXTiE+F6K3kTniM16W+A04Vg+tmc3MajBBT56VinoECSr8UnkAFLc/QTA7E4IL0
         FQ5SGvzoxWWX9CIeZMNqge8o6xggeGnZgvwClh6cG8CCoZtNPjRu1SyrCSIZGbwm+oYN
         iMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792383201; x=1792988001;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kEKanjHY6l/702U6B37yrWXtZ9fIf16MotBPMsqJ5hg=;
        b=Yro0se3Lf1cFyGGRS3MTm9KO4k5rOo17ltUWaMvlAlxXrL3Z7f8O3PGFa615NM+IY+
         w65YxYX9mdVh3dz1UzpTPAg1uTrWnOMnfdUVVILBoAYaW8BSXXkkOPuiuZooWpVGJHhU
         3/lhfGeIwEwaEK3jKipxicfFonnrmxxPp0/4LhBusR4zGb8c15R3xnzliIrpm52B9YmF
         VLySpeCL7/2dnHse9JHJEE6ShlghP3v4vNC/6vdYv/Pz67XmHDkL3/X8s+ngjggH2tkU
         37i3VfHeR0fboVte4Wzezq442/Dw70nigBihNMha2G22cJm0tpBrpicDagx6Q4uoUDPz
         bbPg==
X-Gm-Message-State: AFq9FYIOvm27rZSh4HC68eB+4ar2lfhJjzE01PUTg1GrGzRnWY8og90k
	AgnSjQ0Z9Ldi5hakv1qGs7yZrxvaXmkFUe6wQ571/g7PKerNU4tBZns5Vv/aOhnnye1Exhiwa90
	AYcMhAjQOLRpkEHZ+riCG/4+UcwFNPoqddBqBGE2oEeRJjYn1ovudvRDMwlyjIQ==
X-Gm-Gg: AYBFou0/GPQyob98PURSN53XBi6FxYY/IFY8MTaNNh0Us9u6kgcG9jw8oOmRoWjqzqU
	AqiUVTAq1XviAYSJSKtHyKwN3/3gudOpIBLObFY8rOweYw775GBxZIFe61rg5iwuITwwkuxHPCG
	xNxs4hCyF8cTftcsaE2rq4GMpClYs2HD8mDPg3Ezzz/x4QRFkJjqCszjPnqEV7wrSGE2/6h1e0K
	8llijhBI1fNexjfU2XyCWDr/ZwIM3vNfGgTbewlWjaZ786WUqHtBxJELJsxtxmHf560bmCUyisu
	G+LgSlG7oZXABrESSqDLWGPWvzYL1XWCbKX2kfjZAvMibfVfEcycPhYMss/2Go7ybXwDgZUm4ni
	TJt/h9hCCbyNlUXlYbVw2qDjer8N43PHp00AfaV6OCB1GWecrfAxsoBgtPVUto/uStfdJw+M=
X-Received: by 2002:a17:90b:180b:b0:3ac:9669:845f with SMTP id 98e67ed59e1d1-3acef152d1dmr5908316a91.41.1792383200580;
        Sun, 18 Oct 2026 21:13:20 -0700 (PDT)
X-Received: by 2002:a17:90b:180b:b0:3ac:9669:845f with SMTP id 98e67ed59e1d1-3acef152d1dmr5908298a91.41.1792383200136;
        Sun, 18 Oct 2026 21:13:20 -0700 (PDT)
Received: from [10.133.33.85] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0cde4fdsm7402214a91.4.2026.10.18.21.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 21:13:19 -0700 (PDT)
Message-ID: <4600d9d2-9369-4d9e-afe3-b21aa5f0cb2f@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 12:13:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: cpufreq: fix `undocumented_unsafe_blocks` in
 `PolicyCpu::from_cpu()`
To: Miguel Ojeda <ojeda@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Tamir Duberstein <tamird@kernel.org>,
        Alexandre Courbot
 <acourbot@nvidia.com>,
        =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
        rust-for-linux@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20261018163719.81691-1-ojeda@kernel.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20261018163719.81691-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: SP1TSC63LKADEgKYSmKHlzhTeN088DXR
X-Authority-Analysis: v=2.4 cv=NItAaE6g c=1 sm=1 tr=0 ts=6ad598e1 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=R22tBeTbAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=hdK0H0BEMFwiA4VK1SIA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=71pCXManv-pOE82v44e3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAxNiBTYWx0ZWRfXx9zEBOLqtK8t
 RPJqoY/P6CiHICV5DX7O5QXm4pb7nPDHLTLTF7Bsr1ZeVjCcG5gMys75D41mCIsdAV6jba1ijPk
 B0pldeBH+zY+Gi1XjCYU0Qd6WzowjQQ=
X-Proofpoint-GUID: SP1TSC63LKADEgKYSmKHlzhTeN088DXR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAxNiBTYWx0ZWRfX/srhIQhH7zOG
 Jhgr5XYd2XC9HWu79p7+xWiAdgcCqmlZOH92ABHy5TT2+WYBX1Da4R9KsWcD1kj7ZzoLcgmMesk
 bdPRFYAG5eJLUKVoR6oxSEzQcryNX+iE7VQClOmc5+9im9eEUHflhAE778k8iOkKMNYnhwPbLSd
 QCu1CiAC307O+B1iRh6IlhdTMUc867q+2hYLLyeUtHfF1OSsSDHsQZpG6eCOHSK149vdJNXEtF/
 fI7JhT/ndM1L/NLzPPRzeWUWK8ERNLVAbh+vu/fY7YiPBnM6BFx41bCceQ0Cm8H4+tftEbjDtRY
 lScBFSsvMsHXPNyowZ2v4RJrzJynuitGAjjYUxHiQznBPxlmYtAwXe3qjV/gpDR9M0B4+JiAd38
 gEJ6KjhSj+57V8Gw7BoRHyqDRy4bXMC8eRDlbJlTCZ9J0RJlLiYPvqCc9zq0jqYvs5eoFQ/WErY
 CqnDdd24hXX8/PDI83A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190016

On 10/19/2026 12:37 AM, Miguel Ojeda wrote:
> For Rust <= 1.86, Clippy triggers after commit 02c5d7bfa872 ("rust:
> cpufreq: reject NULL from cpufreq_cpu_get()"):
> 
>      warning: unsafe block missing a safety comment
>         --> rust/kernel/cpufreq.rs:700:26
>          |
>      700 |             NonNull::new(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) }).ok_or(ENODEV)?;
>          |                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>          |
>          = help: consider adding a safety comment on the preceding line
>          = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#undocumented_unsafe_blocks
>          = note: requested on the command line with `-W clippy::undocumented-unsafe-blocks`
> 
> Thus clean it up.
> 
> Fixes: 02c5d7bfa872 ("rust: cpufreq: reject NULL from cpufreq_cpu_get()")
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

FWIW, splitting it into two statements as you mentioned would read 
better to me.


> ---
>   rust/kernel/cpufreq.rs | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index b75d692846a2..5f5beedec88b 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -695,9 +695,11 @@ fn clear_data<T: ForeignOwnable>(&mut self) -> Option<T> {
>   
>   impl<'a> PolicyCpu<'a> {
>       fn from_cpu(cpu: CpuId) -> Result<Self> {
> -        // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
> -        let ptr =
> -            NonNull::new(unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) }).ok_or(ENODEV)?;
> +        let ptr = NonNull::new(
> +            // SAFETY: It is safe to call `cpufreq_cpu_get` for any valid CPU.
> +            unsafe { bindings::cpufreq_cpu_get(u32::from(cpu)) },
> +        )
> +        .ok_or(ENODEV)?;
>   
>           Ok(Self(
>               // SAFETY: `ptr` is non-NULL and `cpufreq_cpu_get()` took a reference on it, so it is
> 
> base-commit: 2efb7a11f1aa4d2dc285fe2680cca22cb9f72f64


-- 
Thx and BRs,
Zhongqiu Han
