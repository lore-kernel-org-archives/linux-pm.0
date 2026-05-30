Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A334CFD1
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780148467; cv=none; b=qPaV6UeB21oYZrWP2g7eOPwFeAzs4EhhRY1FiD9YJMicUDNpqOMAqeg0IKhAGyszCIMRqRaHHWbeLb1yg9Bro1ENlqY8WdugjqZXHiJoI0bErwuiSbcRPrzcRd1xHPlGqAE4rb4/musBBUn/6LiRm72/jgpu6/inXe8/tWlpdGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780148467; c=relaxed/simple;
	bh=tW2CMdXFT9AuTtzCZ3CRjgagQnl9KlmnYdX4+oulx+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SE3pPEmGz5I4dZDT9rosJuCGPAjR31eS42VORWQLjtqDXP3XHJdQ84VsTOeERq+0knorSPNJDdmT55jAkPo7mc0yUqHwLQcGHBcpjcePCEAXR3vrXFKYa8g8SN9g0Vq4lbJxyLMFBCMXPeLLBLRcA5v4uWItJERwYfIG/lw1q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oFkajicP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MiDVwFa7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oFkajicP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MiDVwFa7"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64U3jf861756017
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 13:41:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kPfckcKTHLkm+2MBzGyKAZ6/OFkCiOtt/xJcMW2k0zE=; b=oFkajicPppxbRMoW
	fmnP4yKYDPBktloJaWJVH/GYy9qc9kveFQYY5eH8gdk6jCAi1GOiPGXftGq4Gfy3
	Frn1xvgxGYV8lKM4WrMMPlpZtmpqFMfJ4aI4c0X6uqwJq7EVTA0nHcH5j9Vp+6t9
	qvfgHtga0EGd7CRAQYq2cZSAOyXG4QhbyItOkE8lGYJk14x4AdGFAdRdn03tpF4G
	OJRuu7ccsY/aOGgX7F3miGdyGv0hf4thY73sWVq5g2bPsCtdDV6V7ev9tGZ9SJej
	xdI6VicllCs5j46lOgapJmgKT7sA6DHINRFRbee96mGMc4gddLt0fTDqrknIChB8
	EmdA+Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efr98903y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 13:41:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-36bc54005a7so1945394a91.0
        for <linux-pm@vger.kernel.org>; Sat, 30 May 2026 06:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780148465; x=1780753265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kPfckcKTHLkm+2MBzGyKAZ6/OFkCiOtt/xJcMW2k0zE=;
        b=MiDVwFa7sr2BEBjSovxvPl2l3B/oaooP/f3+8bHPI8VocFcV3UZdBv2bnukYKKe1e+
         B1IgKMH2zTuoJqk+gA0qv0oHW2w2SGbZ0mfC222o5rPPPlBY4MDwzdTEhSx7NNu3Q1pO
         Qn1qbmJPZgfh6XbOpacX7HGiVtG1jm3RJ83yT+3eP92D6g9XQx34YfCd9/qDysSBf3xn
         upW9BEC3W8eC51UkGZnGlwntr9dk1VWRr9R77LP75WJ5ih07LC/0cLbPBQHeKyRIsdcj
         fLSUgNHXYbUBSXoeXImnraQEq9gwmZZBnnoC4vESbb3fVM3t74GBVwUqW8NrEyaHDdm+
         usYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780148465; x=1780753265;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kPfckcKTHLkm+2MBzGyKAZ6/OFkCiOtt/xJcMW2k0zE=;
        b=hC2ppNwaKf26XjkiFyPBKqowKB0NsiWbrpxZveKj7E7Az71otcXMZtzwqabBTZzP44
         ZiXnV2GfJYQAYy7OFxTC/TJv4yb9O0FR3G4XlV4QroggHqzTfl5xlpQH/3U4JsGriVsH
         hTxixUfcO5QNy6yElTGKcC7I6sUM4bd23+xYBzzpPhPojSSXkJCGvXIp5BFbU9mSqFl3
         3ddrE6UI2qMYPv67Pyy8oH/5g4H/mJgTeOpxthLSM65b77pmOd7MSeYsZb/zxAGQ6Z6f
         9a05VeL/3RFZJKRRxT3zHYV2UpuPvEWTaBN040u9He18rxboaxGnOE6w3K93yWml9VQi
         QxkQ==
X-Gm-Message-State: AOJu0YwIXfXrouzGT0+qOq63WyekV38yTCtbUnZfP1s+n3sIphRyY3m3
	5Kq7O9mIgGt4uNNf36uVWkPrYzA8C9e7M2ndN5AenpWrrncJqBOP05bfIeMh6OPf7AQ3ByX1g5d
	j3oHSI1mKPTPacVNlez/5B7dKgRpB3GPjo9dflYrxJoqFo8CuLldVz+HJFhkwiA==
X-Gm-Gg: Acq92OGxFo/+ZiNBGXu2iZ83BV7yNs24lZEteFDpQBNGLqL5eHu6E5OYSHFE0eL2YTA
	3bo0zzx8WdTJzXWMyVduTOU7U+u+xuObBv5iLbw3bheqHeFOtYp0FJZGRyqmPYmi+OLAcSDeptk
	GXs/AUbHu+ciVh4MaroWs4GHyaArpaRqjALRBTKZqgx4BAn43NuHg1sb6LXgtLabGW1BCFrwcC7
	W1neFB2pZHNcxmLZqiKZXD+O160BLR2BZRhs6uIgaxqbdaykmQL0LOTrfVUndDHctsYoY9L/kRW
	w5ShIptkFM/YGLaUnk2k3yvezdE7u8JqHbpX0EnJjKx3xMXjunGQYCYnw2215phIngEHbbuDYut
	/oR7QEc1iXUo1QzUsiEwYtKKOWI9Do/oYKX2TKiHZDYG6Drr+LXAv7oG9sfcwr+UFCotSQO2SgN
	ZqDkNSY4qnEJukKTslyugWLiV2X88=
X-Received: by 2002:a17:90b:28c3:b0:36b:bec8:94cf with SMTP id 98e67ed59e1d1-36c4ff34042mr3494620a91.9.1780148464578;
        Sat, 30 May 2026 06:41:04 -0700 (PDT)
X-Received: by 2002:a17:90b:28c3:b0:36b:bec8:94cf with SMTP id 98e67ed59e1d1-36c4ff34042mr3494579a91.9.1780148463920;
        Sat, 30 May 2026 06:41:03 -0700 (PDT)
Received: from [10.133.33.29] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfc9831csm6617531a91.1.2026.05.30.06.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2026 06:41:03 -0700 (PDT)
Message-ID: <1ba14321-bea9-4fdd-9f8e-87e31d034de8@oss.qualcomm.com>
Date: Sat, 30 May 2026 21:40:35 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
To: Miguel Ojeda <ojeda@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, Boqun Feng <boqun@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
        Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org,
        stable@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260530095809.213611-1-ojeda@kernel.org>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=BaDoFLt2 c=1 sm=1 tr=0 ts=6a1ae8f1 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=R22tBeTbAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=BzWTF2Su1jj-Cm_4THoA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=71pCXManv-pOE82v44e3:22
X-Proofpoint-GUID: h72M774Jb0BZ69OOe7dPz9v3I416Ylhr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTMwMDE0NiBTYWx0ZWRfX/iydTTyKYxYJ
 MUYX9IuUOE/ZNZHmXv+GTwLG5IiCGazzIEHCtprcvofIz5cl9ej2GWj88bjF82ortYV8HbYh1mC
 LsUPxDLEGOw1JsSl2GZtoBIAewMyngG0PqaiXeiLbG/g3blonAddiTx5gY9mEHnsORusHTlMXz5
 9hCwf9FvpQjZ0hkD48dONUTXE5DK6L9vwO7Y+9PvZuBN/3ax7XUFs1g2p5dq9pstAfq0HRLEupV
 7KZJR9LmddHmiRiwHRy4xaCkd61Q97QyJCIZAhSpAJWGgna7RQKfED2MVPfEoLBPWjyjElHjZJg
 BEP1vUu2SBvkfU6O4SKxPU/O8ofEfy+t3ZbMHPOuYiHNUxU1imvWTqAg6oiQPnJHrdKEEPmsjVD
 Zr0Hufa1knp51y5G+K3OsgJhbz7KAf+AZAKoEXk0ktk3fRZx7TVBY/mbc8cOyQkpReent7J0HOO
 26NdTQsxLj+QzoHwV/A==
X-Proofpoint-ORIG-GUID: h72M774Jb0BZ69OOe7dPz9v3I416Ylhr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-30_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605300146

On 5/30/2026 5:58 PM, Miguel Ojeda wrote:
> Starting with Rust 1.98.0 (expected 2026-08-20), Clippy is likely
> introducing a new lint `clippy::map_or_identity` [1][2], which currently
> triggers in a single case:
> 
>      warning: expression can be simplified using `Result::unwrap_or()`
>          --> rust/kernel/cpufreq.rs:1326:60
>           |
>      1326 |         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
>           |                                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>           |
>           = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#map_or_identity
>           = note: `-W clippy::map-or-identity` implied by `-W clippy::all`
>           = help: to override `-W clippy::all` add `#[allow(clippy::map_or_identity)]`
>      help: consider using `unwrap_or`
>           |
>      1326 -         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
>      1326 +         PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
>           |
> 
> The suggestion is valid, thus clean it up.
> 
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned in older LTSs).
> Link: https://github.com/rust-lang/rust-clippy/issues/15801 [1]
> Link: https://github.com/rust-lang/rust-clippy/pull/16052 [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>


Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>


> ---
>   rust/kernel/cpufreq.rs | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/cpufreq.rs b/rust/kernel/cpufreq.rs
> index d8d26870bea2..a20bd5006f38 100644
> --- a/rust/kernel/cpufreq.rs
> +++ b/rust/kernel/cpufreq.rs
> @@ -1323,7 +1323,7 @@ impl<T: Driver> Registration<T> {
>           // SAFETY: The C API guarantees that `cpu` refers to a valid CPU number.
>           let cpu_id = unsafe { CpuId::from_u32_unchecked(cpu) };
>   
> -        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).map_or(0, |f| f))
> +        PolicyCpu::from_cpu(cpu_id).map_or(0, |mut policy| T::get(&mut policy).unwrap_or(0))
>       }
>   
>       /// Driver's `update_limit` callback.
> 
> base-commit: 420dd187e1572bb7e232781bc4377a80c8eb64fb


-- 
Thx and BRs,
Zhongqiu Han
