Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D23E556D
	for <linux-pm@vger.kernel.org>; Tue,  7 Jul 2026 16:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783441743; cv=none; b=WqbzDX7OS3/NW5iw6TotUQ+G1kOgeRfOaLmT+2at69Q4zrEvmjnGQcnaKkSXcuN/ImwB1S8aLNzx2z93aNkSxWXEMPDEuMwGxQiA+w0t3xMPYFICmEXQdKoY3bxJ2X84Ku44QNtZ/Yp/iljDneFqSJ/9NdpZ2jBoCZL/xE8qVZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783441743; c=relaxed/simple;
	bh=Pp0qV7iJIGkD8ZERgGG/7U3fATFccP86iCdQdnb7Zpc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLkx3OI9TQkl4znyfSIq9z6hmqGHA2BC5ZpQ1FoST9VevXpxPi++ggXsT50S2H/4L/kxTDua6QvS2ZYB9He/aLYn1G8vBqmaB4psjS1Y3Ch0lnFMvKJNrK/inEilYiQfAg6rEL+rF81d0s2r5iBlnNvdgExCv7hDbIafl1V5Rek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wvz2IrxG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wvz2IrxG"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84783bce476so3465295b3a.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Jul 2026 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783441741; x=1784046541; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VJProD775f7GM7y2FjSY8FM8VOVcRqvrm4F2UEaScV0=;
        b=Wvz2IrxGPFtvzddAJipVNPs0MlqWwyhPq8trufh5nCP0xZ712kJmXrQH7mu2FHdh/A
         dOqxPvYjqiV6StT8u/Bzz59x2LbJ9KBGs1tTvBTTJkdWMj+TR1lI/QzTM0Ei8jJBJlPj
         UNn6Hy+nzpid2Apfhk4WIpQWkgPCACffBW0aNG1lYyjCJB4JTvk3FmubLCW8oNIbbO9b
         Foo7bxstQYBKWgvQtjreBdqaQsmjZEOKrR5wogH3oKGxVKVH/tHhN5S88zWLwVXhwIxM
         JGuA4/DBRxWVXW75ctQCB42zG3WuosCXg4PyJq8l2Q47H1Si+BJDt7LhVZDECBMuYFXQ
         bm+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783441741; x=1784046541;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VJProD775f7GM7y2FjSY8FM8VOVcRqvrm4F2UEaScV0=;
        b=JGwAeIGjUhCxguOdw5TWWgnsi1ITStCJb1jj1Tlo3XS0nOUjZ1GUSJ0mWz4bPB68qZ
         5mwGcRPK3h/lM0xHJlS5o5cHw5QX9OJUrRTsxmXQYynd0Aq1gG07JQHd0zYuO6y5oOUO
         tw3GhOqIprRQ2wrE663Qc2Cjg1Ah7LXz5BFAhzI84HKBqBCIyzijlKPuAu+fIikBCuMi
         oCuazsx7M4ENeAUawQJh/wxVSCzrPj6jHWFfJO9zjUUa4Xa3opMx6hbg6bloH9IAP0im
         1ciTznHKCwkOpAzM/HnqIlG31I0bJZZ+A3hMWNPL8Bb40SPYaPUFpa935baEM5CTsDEc
         E9Sw==
X-Forwarded-Encrypted: i=1; AHgh+RpuSi1wsawd6qYYl6LoiHcyrBzSzPX+PhzUdHwX0herF9UCfHQoAsmdDsiGWxZUJ5baht3v/6nlUg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPm7h/YJSwGVaoctF3xWG+pADyXAd/0gS5KSnVY10uM+1t4ePh
	W/Ktb6URrbgmlyqlruJpRIGjzrc6H59Zv8h6f9XS0ecTWgqEaHIk7Dcj
X-Gm-Gg: AfdE7cl1/yi+dNYRHW5gvPUlJrNKx66L3Ooxcxg0/yxk4OIZaw4vV0KOMDgTnKMqNAt
	xG48k/V/HFEHYjWLa7ge9aIj3hzPZm5NrXzXqp98+BsXTZhFo+fae29PlCz9eGctIwDFzHgF/Cn
	9sGjH4gr30jAeq+3Y5vpzBlMtjNrVXTos01hrlqU/7e1tKaF/ienB1kbJHsSSF5X1+rlr9/papy
	r7JcVeAilW5QeYO9FFxvn92d+M1QGZA2NPtLGEp+Zk/tjxuzlfS7FcXbohTMaqEbhfWXePFfUtT
	PG0zUL2qZOsKzti5+WOKZ3tLUkpJh2aQ4sqd7u4I+i0M6OVVh4nQB0L0gtl6lN6yAhgerlurL4Q
	5Dxgzwax+TjWvZT8p8DaIW6mN4g3w9lI1lzDikjAOs40/zeI3iMe+0rIX8huqTvFs87aq49o+j8
	zWXh+13LLB05pTy7sbP+YswAj0dmmXbS8kx/T86raYkIgmH9TDLtJGNRyqsL8HXnHE4+0onwVZa
	oFMCfgSwCREZQpxB0iYPS+aIpYdMONXXBHBbPIlKPdyxazsvv99ga6cK0BH9Y38ZfAPzQ==
X-Received: by 2002:aa7:88ce:0:b0:845:36a0:9eb2 with SMTP id d2e1a72fcca58-84826e83e79mr5520232b3a.34.1783441741256;
        Tue, 07 Jul 2026 09:29:01 -0700 (PDT)
Received: from ?IPV6:2001:b011:2005:986c:7892:641c:1789:73b1? (2001-b011-2005-986c-7892-641c-1789-73b1.dynamic-ip6.hinet.net. [2001:b011:2005:986c:7892:641c:1789:73b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d49614sm5741332b3a.35.2026.07.07.09.28.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2026 09:29:00 -0700 (PDT)
Message-ID: <e51399ad-c604-47db-bee4-fa61302f59dd@gmail.com>
Date: Wed, 8 Jul 2026 00:28:58 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kselftest: cpufreq: Backup and restore governor for
 sptests
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260706161430.16949-1-s921975628@gmail.com>
 <qtcyti7hqhr5sgzkhp2rt6h4kh3lfxmgjx5spi4nn7il63ckvl@woiclsimqqqh>
From: Yiwei Lin <s921975628@gmail.com>
Content-Language: en-US
In-Reply-To: <qtcyti7hqhr5sgzkhp2rt6h4kh3lfxmgjx5spi4nn7il63ckvl@woiclsimqqqh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/7/2026 1:19 PM, Viresh Kumar wrote:
> On 07-07-26, 00:14, Yiwei Lin wrote:
>> After executing cpufreq sptest, the system governor
>> will be overwritten with the governor switched
>> during the test. Restore this setting to maintain
>> consistency before and after the test.
>>
>> Signed-off-by: Yiwei Lin <s921975628@gmail.com>
>> ---
>>   tools/testing/selftests/cpufreq/governor.sh   | 21 +++++++++++++++++++
>>   .../selftests/cpufreq/special-tests.sh        | 13 ++++++++++++
>>   2 files changed, 34 insertions(+)
>>
>> diff --git a/tools/testing/selftests/cpufreq/governor.sh b/tools/testing/selftests/cpufreq/governor.sh
>> index fe37df79c0871..5d105ab9c9222 100755
>> --- a/tools/testing/selftests/cpufreq/governor.sh
>> +++ b/tools/testing/selftests/cpufreq/governor.sh
>> @@ -16,6 +16,12 @@ source cpufreq.sh
>>   CUR_GOV=
>>   CUR_FREQ=
>>   
>> +# Per-policy backup, keyed by policy so multiple policies can be saved at once
>> +# (backup_governor/restore_governor also keep CUR_GOV/CUR_FREQ for callers that
>> +# read them directly).
>> +declare -A SAVED_GOVERNORS
>> +declare -A SAVED_FREQS
>> +
>>   # Find governor's directory path
>>   # $1: policy, $2: governor
>>   find_gov_directory()
>> @@ -39,11 +45,13 @@ find_current_governor()
>>   backup_governor()
>>   {
>>   	CUR_GOV=$(find_current_governor $1)
>> +	SAVED_GOVERNORS[$1]=$CUR_GOV
>>   
>>   	printf "Governor backup done for $1: $CUR_GOV\n"
>>   
>>   	if [ $CUR_GOV == "userspace" ]; then
>>   		CUR_FREQ=$(find_current_freq $1)
>> +		SAVED_FREQS[$1]=$CUR_FREQ
>>   		printf "Governor frequency backup done for $1: $CUR_FREQ\n"
>>   	fi
>>   
>> @@ -53,11 +61,13 @@ backup_governor()
>>   # $1: policy
>>   restore_governor()
>>   {
>> +	CUR_GOV=${SAVED_GOVERNORS[$1]}
>>   	__switch_governor $1 $CUR_GOV
>>   
>>   	printf "Governor restored for $1 to $CUR_GOV\n"
>>   
>>   	if [ $CUR_GOV == "userspace" ]; then
>> +		CUR_FREQ=${SAVED_FREQS[$1]}
>>   		set_cpu_frequency $1 $CUR_FREQ
>>   		printf "Governor frequency restored for $1: $CUR_FREQ\n"
>>   	fi
>> @@ -65,6 +75,17 @@ restore_governor()
>>   	printf "\n"
>>   }
>>   
>> +# Save/restore governors for every policy at once
>> +save_all_governors()
>> +{
>> +	for_each_policy backup_governor
>> +}
>> +
>> +restore_all_governors()
>> +{
>> +	for_each_policy restore_governor
>> +}
>> +
>>   # param:
>>   # $1: policy, $2: governor
>>   __switch_governor()
>> diff --git a/tools/testing/selftests/cpufreq/special-tests.sh b/tools/testing/selftests/cpufreq/special-tests.sh
>> index 8d40505dc4682..c7eddadd047d1 100755
>> --- a/tools/testing/selftests/cpufreq/special-tests.sh
>> +++ b/tools/testing/selftests/cpufreq/special-tests.sh
>> @@ -40,7 +40,9 @@ simple_lockdep()
>>   {
>>   	printf "** Test: Running ${FUNCNAME[0]} **\n"
>>   
>> +	save_all_governors
>>   	for_each_policy __simple_lockdep
>> +	restore_all_governors
>>   }
>>   
>>   # Test 2
>> @@ -56,7 +58,10 @@ concurrent_lockdep()
>>   {
>>   	printf "** Test: Running ${FUNCNAME[0]} **\n"
>>   
>> +	save_all_governors
>>   	for_each_policy_concurrent __concurrent_lockdep
>> +	wait
>> +	restore_all_governors
>>   }
>>   
>>   # Test 3
>> @@ -68,17 +73,23 @@ quick_shuffle()
>>   		echo ondemand | sudo tee $CPUFREQROOT/policy*/scaling_governor &
>>   		echo userspace | sudo tee $CPUFREQROOT/policy*/scaling_governor &
>>   	done
>> +	wait
>>   }
>>   
>>   governor_race()
>>   {
>>   	printf "** Test: Running ${FUNCNAME[0]} **\n"
>>   
>> +	save_all_governors
>> +
>>   	# run 8 concurrent instances
>>   	for I in `seq 8`
>>   	do
>>   		quick_shuffle &
>>   	done
>> +	wait
>> +
>> +	restore_all_governors
>>   }
>>   
>>   # Test 4
>> @@ -112,5 +123,7 @@ hotplug_with_updates_cpu()
>>   
>>   hotplug_with_updates()
>>   {
>> +	save_all_governors
>>   	for_each_non_boot_cpu hotplug_with_updates_cpu
> Don't you need wait here too ?
Right. Sorry for missing that there are processes running in the 
background for sptest4. I'll submit the fix for this.
>> +	restore_all_governors
>>   }
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
