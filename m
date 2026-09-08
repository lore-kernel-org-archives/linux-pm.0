Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379891D5CFB;
	Tue,  8 Sep 2026 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788896311; cv=none; b=u/7gLLuZPYewAJhYW8QkP2qaXHcmZM0zQyjr9ABb0LQFrOWmfB8fxL6m06i3gWVlmbeLbL2SJAEomZr3SQazjFqMPg+RfS9uR1Izw36IZBtipCdNlS4M8gwvHgiyZRZAX50p/C+FW6t3HG8n7PoSz74W9zgEWQXyv+6eSigBia8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788896311; c=relaxed/simple;
	bh=nebzUuDzwWlSkWDjmxglydZ/iE1cCqonv6be/vzfcd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o81QqeuLJjsx0fM4SeM5M1KO0GClj0iv/X2V7Kcu2vr5636Ft2y2nSpcrqQ/aG7bUvT25wDiMZVindQOEKyeAKFYp9Nuf7L/7z9v52wZzWFNsN6liRwq3Qlvp7H/o3VvHh9bW0LMFEjo6t0XFPp7W9bmbQKeIJyUAUb1Bhf9iHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ke6+4GeI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ke6+4GeI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611281F00A3D;
	Tue,  8 Sep 2026 19:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788896309;
	bh=Wa2S6ywXs5rxw/DefoWb0fUXn2TeZIFZy7WPNNpM8tw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ke6+4GeIX0ADJGuAmByfoniVKtspSyHKi05GpYIrORNgIn8Jh0Gq8ezN9JbUsRgYb
	 HvCh78Fs6zdU/2h+Zt1TKs3a1ykzgGHpGPQQVV8grFU4aiWvSGTBh2wFlTKLQHlNp7
	 11AHJBMHvNtomvoasS/f9WfWcMyfOPp+zJ/QVC+FG3oXB1eyUjlmZmEsBeRCQko7Rv
	 WJ/wQrRNXRORIoQ90qKFGSaEl2zR0fTbPZkUf19TDv+Y9MoB8qqojxWTn7HEreuabS
	 O+vYx6TuXREp5z1wxD4b2KQDCbrfxaJosmWOElwbxQ0IvPiwDhSK0Q40OsjTRlRV1/
	 A1YxJ/2rSD2qA==
Message-ID: <7c542079-3933-4a51-9845-a0c205dda931@kernel.org>
Date: Tue, 8 Sep 2026 14:38:27 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 1/3] cpufreq/amd-pstate: Add per SoC and per core type
 EPP tuning values
Content-Language: en-US
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>,
 "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
 <linux-kernel@vger.kernel.org>,
 "open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
 Vishal Badole <Vishal.Badole@amd.com>, Richard Gong <Richard.Gong@amd.com>
References: <20260908041935.402116-1-superm1@kernel.org>
 <20260908041935.402116-2-superm1@kernel.org>
 <eadc9b88-534c-4a49-b2a5-c2d9ffcf569a@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <eadc9b88-534c-4a49-b2a5-c2d9ffcf569a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/26 01:19, K Prateek Nayak wrote:
> Hello Mario,
> 
> On 9/8/2026 9:49 AM, Mario Limonciello (AMD) wrote:
>> +/*
>> + * The numeric EPP value programmed for each named preference. First dimension
>> + * is CPU type (TOPO_CPU_TYPE_ANY for non-hybrid, TOPO_CPU_TYPE_PERFORMANCE/
>> + * EFFICIENCY/LOW_POWER for hybrid). The initializer holds the legacy values
>> + * used as the fallback on any platform not listed in amd_pstate_epp_soc_ids[];
>> + * amd_pstate_init_epp_values() overwrites slots at boot when the running SoC
>> + * has a per-SoC (and potentially per-CPU-type) override.
>> + */
>> +static u8 epp_values[][EPP_INDEX_MAX] = {
>> +	[TOPO_CPU_TYPE_ANY] = {
>> +		[EPP_INDEX_DEFAULT] = 0,
>> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
>> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
>> +	},
>> +	[TOPO_CPU_TYPE_PERFORMANCE] = {
>> +		[EPP_INDEX_DEFAULT] = 0,
>> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
>> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
>> +	},
>> +	[TOPO_CPU_TYPE_EFFICIENCY] = {
>> +		[EPP_INDEX_DEFAULT] = 0,
>> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
>> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
>> +	},
>> +	[TOPO_CPU_TYPE_LOW_POWER] = {
>> +		[EPP_INDEX_DEFAULT] = 0,
>> +		[EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
>> +		[EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
>> +		[EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
>> +	},
>> +};
> 
> If my eyes aren't decieveing me, all the indices are initialized to same
> value so we can perhaps do:
> 
>      static u8 epp_values[][EPP_INDEX_MAX] = {
>          /*
>           * Initialize all CPU types to legacy defaults.
>           * amd_pstate_init_epp_values() will fix these up
>           * based on the platform during boot.
> 	 */
>          [TOPO_CPU_TYPE_ANY ... TOPO_CPU_TYPE_LOW_POWER] = {

Woah!  I didn't realize that kind of initalizer was valid!

Yeah will adjust to this.

>              [EPP_INDEX_DEFAULT] = 0,
>              [EPP_INDEX_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_PERFORMANCE,
>              [EPP_INDEX_BALANCE_PERFORMANCE] = AMD_CPPC_EPP_LEGACY_BALANCE_PERFORMANCE,
>              [EPP_INDEX_BALANCE_POWERSAVE] = AMD_CPPC_EPP_LEGACY_BALANCE_POWERSAVE,
>              [EPP_INDEX_POWERSAVE] = AMD_CPPC_EPP_LEGACY_POWERSAVE,
>          },
>      };
> 
>> +static_assert(ARRAY_SIZE(epp_values) == TOPO_CPU_TYPE_LOW_POWER + 1,
>> +	      "epp_values must have entries for all CPU types up to TOPO_CPU_TYPE_LOW_POWER");
>> +
>> +/*
>> + * Get the EPP value row for a given CPU, accounting for hybrid CPU types.
>> + * Non-hybrid systems use TOPO_CPU_TYPE_ANY; hybrid systems use the CPU's
>> + * actual type (PERFORMANCE/EFFICIENCY/LOW_POWER).
>> + */
>> +static inline u8 *amd_pstate_cpu_epp_values(int cpu)
>> +{
>> +	enum x86_topology_cpu_type type = cpu_data(cpu).topo.cpu_type;
> 
> Can we cache this in cpudata to avoid an additional dereference?

OK.

> 
>> +
> 
> I would prefer a:
> 
>      if (!cpu_feature_enabled(X86_FEATURE_AMD_HTR_CORES))
>          return epp_values[TOPO_CPU_TYPE_ANY];
> 
> here to avoid the branches for non-heterogenoeus platforms.
> 
>> +	if (type == TOPO_CPU_TYPE_PERFORMANCE ||
>> +	    type == TOPO_CPU_TYPE_EFFICIENCY ||
>> +	    type == TOPO_CPU_TYPE_LOW_POWER)
>> +		return epp_values[type];
>> +
>> +	return epp_values[TOPO_CPU_TYPE_ANY];
> 
> A switch case might look prettier ;-)

Sure will change it.

> 
>> +}

