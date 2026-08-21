Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5DA3B1EE2
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787301286; cv=none; b=uQmQ0mESMnIjdTYDFcqdaU4aS8jE59WR2K/UOkl5M2eXjzefRHfW47fCjsaHp+YcE9si7fyl+lwZaHRQsXFbcIW7Xi5TOSYYUPtk9GelkQ95ZiAN7FU8J2Q/HkL2vAovoj/oc2B0c/WrWIEqVVfhkNGjmM1z3RZYMXrOH2i7yxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787301286; c=relaxed/simple;
	bh=DZgjw3xXltTcaSFcPUclcnFO3sSrn3L3nD5iXwkHSjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MpjixZQjePXszg/t6q5W/F+fvVOZO/r8aerjwzifuhg3XSonOJf5TZBUaJV/yx3oOQVXlA5Zh3ewD9SZ5jb6p0Va524uw9Vmp8Xa5EoBwzyIncNjFXdpUYsQhYpXvBZSv3+nCBKhAlfhx7Z6QtPxgGpisVqncFkwbz+0Wa7fseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mPpYrNOl; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KQ6xGp4J; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mPpYrNOl";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KQ6xGp4J"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L8WPPw1688533
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:34:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9PjhwOraLF4jwKhPLpSZiMqtcMCNemKIlbmfB/PjLmA=; b=mPpYrNOlTYxkxiPl
	16K9SyQedHYjRBMCfkeBTt687fH7UMJurE6Uc7yTiOKmkYe9KpUBCD9kbWUHojrD
	rcZybT6Q1tstEpCv4JSOpQeKSPMJuUS8/XqQI76SAV9s+auh4Qz+2rvV8GyIbtXQ
	BVO+HcjW5GaNeFrah9YVkKjak6I90FfWe5JhB2EXTPQZBBGVjXiOyt69cdgUVyMr
	HybLJUbBuzTFtGWVlCGnItni36/2ibj/DQtvOiCyzBwHJqiMvPhv64r+vDzuj5iD
	aEmt8iAbzXQfNOhhAdRXyjbcx653oMRVMzRPGnIZQ8oCnAzD6uyLbqtKDdgVFkI6
	kgAFWA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6ecb92x5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:34:44 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso806484a12.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787301283; x=1787906083; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9PjhwOraLF4jwKhPLpSZiMqtcMCNemKIlbmfB/PjLmA=;
        b=KQ6xGp4JgEruIIyXWNuinnyWCrZRfB+wK7cCYn6V6Xom27q6YI4h5HPS4tY7Ln8fGl
         AyokqfYetVET0Z+Vd9+KouwebOYNWuSvjvrPrY76hy7iGOEl/tUfU2ddzv9w9kSvgfNr
         zzwVD3goEDWd7XDOinhYbKswwL56+0+YI9zPezmX1xyggTmoKfIPNsK4oRXmAQrfCpHs
         beD2JUd9VoNi7oFLAbq4NRlHcYT3M6c2agZk9y6LsQbKEY6930vf2U9Ys0icLmfMkjpb
         Ne3g9IOxIxMRzVNBzpmlVgaqOzLsl3jJnUkjD4M543zvxJHRARUQ4WYI/xskKby0y4NS
         IJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787301283; x=1787906083;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9PjhwOraLF4jwKhPLpSZiMqtcMCNemKIlbmfB/PjLmA=;
        b=ki0ncZ6xS+71zJJvDYQGE0V1OY6uqawv7Z6JkAuzGuA7jeedpdm/9qsrkJ2GcP/giv
         v+O0SRCSthj4/ZFyCuRG8xSX8L+Glk4kE8OfrsWxsoQmQ+qBpuiyL0rkIcxdqxW9l25L
         3qaRmpJlIE9aMZ7F4hCDThvoLwJeEplqW0Vy1Hjk9h6qJ9nN+WtUlZRHcyntW+7YoyfS
         PiOVVnPgEMX0xe6R3tMRNyUwcLqVao9rcygeyapwQW7pe3woFNVYTbxkdXwSjiAoySXb
         Bl5DmkvUr0CQ4hJYYEtyeAAemOfTcohscXBVo4EDc80nPTvJAQLudfydyWVsDHUa25Ax
         EcVw==
X-Forwarded-Encrypted: i=1; AHgh+RpjQCsOR/jN4lmx8/Tz2lz1+QMHN0DxuPwQWnyqf3JXOhdjWN+Cj7R0erVzHS/f59z18wdgAuz3Cg==@vger.kernel.org
X-Gm-Message-State: AFuF++kFr2//D6hIqZadwk2bZV3LxkYEA0ubCOndpga1lwnpSnI1qirK
	N3F08JR1yrNw4rd42ScVoFQpsxzO8/77t4rOotwq68++G19N3aSKpc4hVaOAZrEcqp/zG91G/3h
	h4HlPtIFiqYo89cFsZ9k4v8v2P6ms+Lv13omaiM1aiTpMUeJvjGm2Qt9YyO4ErA==
X-Gm-Gg: AR+sD12JHXWaTlbJGYRuQh2oPrYejbI/jXEWaALwPG3/NqiGHwyVNSdlKGb2AT7VuPV
	qygI6a2gJ6DBC63E/CDUPQlirbV0r/bW3DsXLexYOA2qRNP2fbG6UPG1qvlh1xRtjig0kmyHVMS
	B42RRfzGMu1hCtuIay3L3M52B1f9pM50SFeAM4U/qFRXVjsNSYtTZskQGIcMbTDUyFPfEadjhvN
	e6WMS9J9kvnFjeF/GDATWgCGSlKyoJ/w3AGWvdoLxK07zokgvykPAc/tGH6EJqAyziDcSZRaT6O
	wSkg3Wf9Arouz8P4jPul/6d5D+tcUd0SZdxIS5OXBtWG8RW47IvUYd58cC8GFksGnHRmFd1pBLW
	g9yC0961WrtK+g6Ix40v6oeBpSmyoPwqkVMA79GF2+Smjl8lxIHxOIakzGaYZt3RvpwHvJ+M=
X-Received: by 2002:a05:6a00:174b:b0:851:c1d2:c48d with SMTP id d2e1a72fcca58-851f9884ce7mr6941130b3a.8.1787301283117;
        Fri, 21 Aug 2026 01:34:43 -0700 (PDT)
X-Received: by 2002:a05:6a00:174b:b0:851:c1d2:c48d with SMTP id d2e1a72fcca58-851f9884ce7mr6941059b3a.8.1787301282551;
        Fri, 21 Aug 2026 01:34:42 -0700 (PDT)
Received: from [10.133.33.51] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d36185c8sm2610296b3a.38.2026.08.21.01.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2026 01:34:41 -0700 (PDT)
Message-ID: <3d3f8a94-7184-459a-b6b8-3f9afc43ebc8@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 16:34:38 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] cpufreq: acpi-cpufreq: fix P-state index mismatch
 in extract_io()
To: lirongqing <lirongqing@baidu.com>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
References: <20260820020715.2344-1-lirongqing@baidu.com>
 <20260820020715.2344-2-lirongqing@baidu.com>
Content-Language: en-US
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
In-Reply-To: <20260820020715.2344-2-lirongqing@baidu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX9itFfkRDnsrd
 rymu5PjMqnYlaBJJhuF1+PKh0ofM1l/gMqfhHZ7Nj54FfnhWIYfj58G99obiWMHa/9TrsyL4K1m
 8Gwr2+Gj0efJXJlDxprsl7dyq2xE1k6f2bCSXekfioNyJ1thLsguINdl5bvAZE4o5PirHwhozd3
 9Nq7FN7oqtdXrpefNHpX3jd9TCaopSIxeyGMPyCrRzRmy5jkwRjiZHb4AVqCM19fqi/28whF10n
 AEj+ckYJFTDYs1j3qdftscqsx+s6NEPq6b8Ox1GmSp2Bcd4X6hwReWul/uaItpO+CUj+coN9cHq
 5bvsDtb+Y92omK89zDhP1knpGE099+QLZZ+1LqF3etrc6r9kiuxtEr/fAHPFAM+i77sUgR9oDZx
 Vc0PWTkdPsTBoOBzKT5yE3J4F1PlBFtrGB34KDPSXclUcioL93vKI9cXHIfw+XIt12M0kT3tBQY
 asht/AQ7UWPgw7IiLWA==
X-Authority-Analysis: v=2.4 cv=e/s2j6p/ c=1 sm=1 tr=0 ts=6a880da4 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=zuLzuavZAAAA:8 a=EUspDBNiAAAA:8 a=859UagAclvumeDjhmZYA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: Th7UD0Tss4DKJYCzh6AOoXgyALgq7Mpf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA2MSBTYWx0ZWRfX5uBLqsInigAN
 9IgB7WFPeP44igrAD8v2/zKXXveYXkIiFqzo9HkHEfWIj+DYnvbFcU8gFMV3nHSe6vf036MdF3b
 Aso+j3jCwL7ga54RHELfq0kCh0CJWCw=
X-Proofpoint-ORIG-GUID: Th7UD0Tss4DKJYCzh6AOoXgyALgq7Mpf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210061

On 8/20/2026 10:07 AM, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> When policy->freq_table is built in acpi_cpufreq_cpu_init(), entries
> with duplicate frequencies are skipped. For each remaining entry,

To be precise for applying if needed.

"entries with duplicate frequencies are skipped.

-->

entries that are not lower in frequency than the previous one are
skipped."


> freq_table[].driver_data stores the original ACPI P-state index, so the
> index space of freq_table no longer matches perf->states[].
> 
> extract_io() currently walks perf->states[] with index i and uses the
> same i to index policy->freq_table[i]. When duplicate frequencies
> exist, this can associate a P-state status with the frequency of a
> different P-state. It can also access an invalid or sentinel entry in
> freq_table when the number of entries in perf->states[] is greater than
> the number of entries remaining in the frequency table.
> 
> extract_io() is used on ACPI_ADR_SPACE_SYSTEM_IO platforms by the
> frequency verification path, which is enabled by the
> acpi_pstate_strict module parameter. With the mismatched lookup,
> check_freqs() can fail to match the frequency of the P-state that
> drv_write() has already programmed. It then retries the check for all
> iterations before returning -EAGAIN, 

Small nit, just for applying if needed.

"It then retries the check for all iterations before returning -EAGAIN,"

-->

"It then sleeps through all 100 iterations - at least
~1 ms of usleep_range() plus 100 cross-CPU calls and I/O port reads, all
with policy->rwsem held, and .target_index() returns -EAGAIN,"


leaving perf->state at its
> previous value while the hardware is running at the newly requested
> P-state.
> 
> The cpufreq core consequently keeps policy->cur at the old frequency.
> Since __cpufreq_driver_target() returns early when the requested
> frequency equals policy->cur, the driver is not called again for that
> frequency and the control register is not rewritten. The hardware can
> therefore remain at a frequency that differs from the frequency known
> to the cpufreq core.
> 
> Fix this by iterating over policy->freq_table and using
> pos->driver_data as the original ACPI P-state index when accessing
> perf->states[], as extract_msr() already does.
> 
> Fixes: fe27cb358835 ("[CPUFREQ][2/8] acpi: reorganize code to make MSR support addition easier")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

> ---
>   drivers/cpufreq/acpi-cpufreq.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 10ea603..a797bb2 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -197,14 +197,13 @@ static unsigned extract_io(struct cpufreq_policy *policy, u32 value)
>   {
>   	struct acpi_cpufreq_data *data = policy->driver_data;
>   	struct acpi_processor_performance *perf;
> -	int i;
> +	struct cpufreq_frequency_table *pos;
>   
>   	perf = to_perf_data(data);
>   
> -	for (i = 0; i < perf->state_count; i++) {
> -		if (value == perf->states[i].status)
> -			return policy->freq_table[i].frequency;
> -	}
> +	cpufreq_for_each_entry(pos, policy->freq_table)
> +		if (value == perf->states[pos->driver_data].status)
> +			return pos->frequency;
>   	return 0;
>   }
>   


-- 
Thx and BRs,
Zhongqiu Han
