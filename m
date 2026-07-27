Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90C43F12EF
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 09:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785145307; cv=none; b=camAzTZh+7rJ9Rh1wDCPcC12KJQa3WzDZn04/uLZb1PMb2XEtHXYBv96aP+k1xMXcPs8P6ETL5+FE19BmIzVPTy6y/X3ATLLbnnu7R2AUnqBe+CSJqNTaNO0c9X7I/P3Ill90gxF0j0M/Hi3SdusMiGxgP9yzouaQaRZbDEWS5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785145307; c=relaxed/simple;
	bh=Y5Xn8qE7LpNOzTT8++pEzgKR0yaA8en+5bwEYjw3AC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iu4Di/Dfoi21U0NWgnUf/OfQvz5BxlbgmpmVzvj0PnJcGl8BYTIehhyFye/J5YUMkYSDKLFcCAdLwS4rHONZaeFtp2e57XoM/2ebu+Axlhc2ExlWmz2G8xaD8IU66Jjixkwe9myQpW+EWMFvJJElncD7/Lpoe/JipceVAC7zK/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F0FB+cBv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JQkQ4DD7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F0FB+cBv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JQkQ4DD7"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66R9WxoE3481646
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 09:41:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oTc9/pF/S1BGmHsWWo0LXh7x2vLZLHXs+ToLsh0cTy4=; b=F0FB+cBvDbVl2sRz
	hsVrjp8FpZT906w/GYcq7Zr2q3U+nPtPLR6FSBLTo2Vg33LRdSiHVw4T975JUAMQ
	b4Ky1t+JfZgiCxznzezQ8I+nFv+EMLlZswIob2Pb/rpgVBdwTsJMPzclPcejsH0+
	+W3TE+nwGonT/r1+x0aji5mHD2UY88p91SEehOYSEOAVi5sq97mUNx5wPcwDz1e5
	hZaG2cH4tC45sULIrx3yJ6g+Kl7HANQCMAy5Y7O5PgfUfj6MvMKmbF/Czm//3tQW
	7ojcFkQDyCiJL/cX8gMD2C/s69qRA4X/r6p5Q9Td8e27B61vJGX3/t59JnS0oWYD
	me2jlw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp4mq02pp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 09:41:44 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cfbf3e4a63so72716175ad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2026 02:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785145303; x=1785750103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTc9/pF/S1BGmHsWWo0LXh7x2vLZLHXs+ToLsh0cTy4=;
        b=JQkQ4DD7GnSF/BkvUx2tCoOeFT09BP4RAaePfPqLJKJII2OvgZ/VC8rjbwdGWRJwfz
         YOlDfcKte8fQoLoFDzMmeoeN/WX0ua7vnntaRldNR5+zh72nSy5nWaYbNtL0igi4t1yl
         rE/ZHjpoZltYO+mU+uNTidSBEEXnWh2qj7een9PqY/ncjVYui6K22OHj6ynhFiMHi7zZ
         tsZSrNyxOqQXQUyr1RdQeIOf0eH5/XoUNHxSd+ie8ar2u9BIonbH14Qf8UYIaQgKIDgD
         AisqVf4KdiwBTDy9vzgxiiQIjb6i1pIBcBjNkzbR1CxrSbC2FxMNu3pg2mAVHyCwjT9i
         oiOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785145303; x=1785750103;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTc9/pF/S1BGmHsWWo0LXh7x2vLZLHXs+ToLsh0cTy4=;
        b=eRWPDHmCtED2lJJkHN4mmmRdY29p2WZhtYpRcxXfmaM6vsfgtYIe3EntB+WGzs6+7C
         kzeNh9Id1OBYBU6VlImUshrXYZUr5JvMB0A+ECSW4O1vFckFwyreBKuFnBWl6CAH8aIt
         bJco32pP+Nyl++adXhcbF91tztPUQd3IdwbBWNKEcNH0d74jPilmQcjNL67UqJXYpB42
         qFGgILSj6hR7XjQ8TPC6cd5XQ++Ua9E6DdnG7P6N+BOatOhPx7NpBN6SR1zwgp74Z9rl
         neayQfIEoUKcNnMbyO6z47PHiV1lHoUn3z0y42fLrR9v2zy/tjBh66Z1DFzvhMJ3xStI
         eGPQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxadcqjsJI+34gDolRbi+ttzF9McwcbdEcozfaqvxjCC1s2Y7WlU37wlmIK9eMegNmKX1eGWsZ9w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZdlmy0GaEwFjvFSAOjL4djUrvDnTYNsP0oHrYSguKc9hulMg
	JJ1OVtUO6upsX5Ee8EAdppfi5Il3tCek0d/Okg3mlT06XKBP+C/+XFZlxbNfjCULh9qSVDX2Ewt
	LM76Axj6OvSyfkzrnHIleAITZMHvzeSHP8133ieP3Tqn4p2K+SlL7HSL9zp9DJA==
X-Gm-Gg: AR+sD12TNKgDBkDVMq9PdtYVpOUHou6Iz3fdKQuMiB05GHEbAHqfBqKpNBdk9zzAZZ1
	nxsqmaUITqwdXCxRgIhHCws/Wk34Tp5+QZGQMQ8qI+Rez0gIyXdFF4y6Xg1EORKcV9D3uSHMFpS
	9FsV0D3iCxDwF0VIJ9S2OhjN3cZyEWQkjZ8Aa2BKRghjv7O3ls4IBF2enGqFf4tz59A1egDiMGl
	JFR4s7D9q7Jl35yma88GP4Y5nhhY25+F3+Do2+oQMFmXWnBDF4o+TQhMPbvMvk/nS1JV3cFhfSr
	AVSvYkYHAu8BV9V7+CEl9cos3702qUfdv5IP/aKbWfsqGrP4f9JlKqmeoPmfYgvGjPURPPDTEyl
	xPTV5VWQPI3Vt+dv6uSFMLS2RfZVROoY=
X-Received: by 2002:a17:903:1a24:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2cfde795581mr78353495ad.3.1785145303321;
        Mon, 27 Jul 2026 02:41:43 -0700 (PDT)
X-Received: by 2002:a17:903:1a24:b0:2ca:329:3d96 with SMTP id d9443c01a7336-2cfde795581mr78353235ad.3.1785145302847;
        Mon, 27 Jul 2026 02:41:42 -0700 (PDT)
Received: from [10.218.14.97] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc548e29sm30948601eec.15.2026.07.27.02.41.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 02:41:42 -0700 (PDT)
Message-ID: <f4a3c2a7-0732-4d4c-b252-2ac5ea3db35a@oss.qualcomm.com>
Date: Mon, 27 Jul 2026 15:11:35 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] opp: Use clk_get_optional() to avoid leaving
 opp_table->clk as an error pointer
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: bjorn.andersson@oss.qualcomm.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        konrad.dybcio@oss.qualcomm.com, mukesh.savaliya@oss.qualcomm.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandana.chiluveru@oss.qualcomm.com,
        Sebastian Reichel <sre@kernel.org>, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org
References: <20260727-fix_ptr_check_on_clk-v3-1-94629ac7aaae@oss.qualcomm.com>
 <sl7wx7n2bocrfcsqj72vp3snchbgvtkuahq4pjzpor54bg46ek@ar62czwob4j5>
Content-Language: en-US
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
In-Reply-To: <sl7wx7n2bocrfcsqj72vp3snchbgvtkuahq4pjzpor54bg46ek@ar62czwob4j5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA5NSBTYWx0ZWRfX0TEOkcnMErBR
 Zr0luSGnCMKDsfqWBwfYbxAzFuPRYfWxTz3Z1B9V5b78f8Mu4diKjsr2Edu050iUub78OzaeGHB
 gZZGtrZRr3Ne+16JsuHSCRv2EXaBb/g=
X-Proofpoint-ORIG-GUID: 9N7lWf3K7czNOsOr5EmmXl33_lbGQTyt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA5NSBTYWx0ZWRfXzwWTZowr8fn9
 fK8rP2ckhzdF1gMcIwBf6WviXs6Cy6qOXf+WNJiKv3DD5LlZp05/5Y5zjZZg5FuWanB4Dx+ir0U
 mdEobpKtWqbn31fbPaqgGPU8M4bXa3+nDEcLvyP/G0hK0HLAN7n38/OyT4qu/dh73Acxr6ZM5Cl
 65tHHBEpik2rwQDv8IqPblBvchkm1KqDgT8k5Db+OvBF5SDFLYUHbZPCLyIiLvJO8NGUnQYH9Kv
 xvmYolONOfu0bMjybkTjPKeB3wlGP5VS3sSs9dgZDLxpd8Q1tQqMrYXS/EN8nhGjXH2QsapMukg
 4g8PLF7UHWElVmmkHkaTOnJ7CbbPcEny5ZtPqDCMQF9496skKbEisjRfvgzXO02vWXNM2FULLPv
 trYEYcFhtCnspuUTUtxDg5jUcuSOXkl62VehDPJx/C3BqbtvTtHEjBUn4gse+fKHym2ZaYGylXx
 NmXPDdO+IWC+Ck3MVkg==
X-Proofpoint-GUID: 9N7lWf3K7czNOsOr5EmmXl33_lbGQTyt
X-Authority-Analysis: v=2.4 cv=TemmcxQh c=1 sm=1 tr=0 ts=6a6727d8 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=aVMEk7OLGE4JoB244ZkA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270095

Hi viresh

On 27-07-2026 10:44, Viresh Kumar wrote:
> On 27-07-26, 09:46, Praveen Talari wrote:
>> _update_opp_table_clk() uses clk_get(dev, NULL) to acquire the
>> device's clock. On platforms where the perf domain device has no
>> Linux clock and is instead managed entirely by firmware via
>> devm_pm_opp_of_add_table() (through
>> of_genpd_add_provider_simple()/onecell()), clk_get() returns
>> -ENOENT. That case is treated as valid (the OPP table can still
>> have entries sourced from firmware), but opp_table->clk is left
>> holding ERR_PTR(-ENOENT) rather than being reset to NULL:
>>
>> 	opp_table->clk = clk_get(dev, NULL);
>> 	ret = PTR_ERR_OR_ZERO(opp_table->clk);
>> 	...
>> 	if (ret == -ENOENT) {
>> 		opp_table->clk_count = 1;
>> 		return opp_table;   /* opp_table->clk is still ERR_PTR(-ENOENT) */
>> 	}
>>
>> Consumers that only check IS_ERR(opp_table->clk) treat this as a
>> valid clk and pass it straight into the clk consumer API. In
>> particular, dev_pm_opp_set_rate() calls
>> clk_round_rate(opp_table->clk, target_freq), and clk_round_rate()
>> only guards against a NULL clk, so it dereferences the error pointer
>> to read clk->exclusive_count and crashes:
>>
>>    Unable to handle kernel NULL pointer dereference at virtual
>>    address 000000000000002e
>>    ...
>>    pc : clk_round_rate+0x3c/0x188
>>    ...
>>    Call trace:
>>     clk_round_rate+0x3c/0x188 (P)
>>     dev_pm_opp_set_rate+0x114/0x33c
>>
>> Rather than teaching every clk consumer API to special-case
>> ERR_PTR(-ENOENT), fix it at the source: use clk_get_optional()
>> instead of clk_get() in _update_opp_table_clk(), which already
>> translates -ENOENT into a NULL clk. This documents that the clock is
>> genuinely optional for such devices, and keeps opp_table->clk holding
>> either a valid clk or NULL, never a lingering -ENOENT error pointer.
>> _opp_config_clk_single() is only wired up via opp_table->config_clks
>> when a clk was actually found, and every other opp_table->clk
>> consumer already tolerates NULL through the standard clk API (which
>> treats a NULL clk as a no-op), so no other call site needs to change.
>>
>> Suggested-by: Sebastian Reichel <sre@kernel.org>
>> Reviewed-by: Sebastian Reichel <sre@kernel.org>
>> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
>> ---
> I am getting this with git am -3, please rebase over [1].
I have followed below steps but faced conflict while rebasing it.

git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote add viresh 
https://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
git fetch viresh
git rebase viresh/cpufreq/arm/linux-next

$git rebase viresh/cpufreq/arm/linux-next
Auto-merging drivers/gpio/gpio-shared-proxy.c
CONFLICT (content): Merge conflict in drivers/gpio/gpio-shared-proxy.c
error: could not apply efecde8a254d... gpio: shared-proxy: always 
serialize with a sleeping mutex
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
hint: You can instead skip this commit: run "git rebase --skip".
hint: To abort and get back to the state before "git rebase", run "git 
rebase --abort".

Could not apply efecde8a254d... gpio: shared-proxy: always serialize 
with a sleeping mutex

How to proceed further?

>
> Applying: opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer
> error: unrecognized input
> error: could not build fake ancestor
>
>> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> +	opp_table->clk = clk_get_optional(dev, NULL);
>>   
>>   	ret = PTR_ERR_OR_ZERO(opp_table->clk);
>> -	if (!ret) {
>> -		opp_table->config_clks = _opp_config_clk_single;
>> -		opp_table->clk_count = 1;
>> -		return opp_table;
>> +	if (ret) {
> Since `ret` isn't used later anymore, you can instead do this and drop
> `ret` ?
>          if (IS_ERR(opp_table->clk))

Sure, will fix in next patch.


Thanks,

Praveen Talari

>
>> +		dev_pm_opp_put_opp_table(opp_table);
>> +		dev_err_probe(dev, ret, "Couldn't find clock\n");
>> +		return ERR_PTR(ret);
>>   	}
