Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D53A6EF7
	for <linux-pm@vger.kernel.org>; Fri,  8 May 2026 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778232805; cv=none; b=lCWDyVcQezYnK1/+f9xLdl75QiFQqhEDHxpPv0DBRypFlNruveYo3sQSkvTSIa5qSk8HBDUE5k6O4+p8lA2Hu3PKxvUQz3tssrwgqng0e+GmsorTqJsYp9uqA/gW16/wIkYdt82iBf3pl67CaU/U7fiRQFATy7Cpw6epG6IUaqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778232805; c=relaxed/simple;
	bh=jrHIv8pbAuvom0eoLCu6Ib49NlUlLIhhGKXrOnUSO4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M1eIBb0q9z4UGvwtmCS4ikhUVPL/+H6Z86nAoydhkBh5uUpSQUh+dkinGek5NbUblTITtgPCe+qO1KCaTLHVwNAaQDcAZpq8tZKKdiPo4Fgj932tur1yBrSq0vDIoO3ygCnwbTfjN5jj61nB6xiY2Y4A8+nhVYbN2GcVwshqY4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=VaH0IpIC; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="VaH0IpIC"
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gBkQ85ZMsz8vdQ;
	Fri,  8 May 2026 11:31:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778232672;
	bh=jrHIv8pbAuvom0eoLCu6Ib49NlUlLIhhGKXrOnUSO4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VaH0IpICZE8Q5Rv/nYdZKM3a1sqbDZ2NINutSwqr/OkGmnaJO1gBrswHXwPjGpLG8
	 giQfVnSjtS9LszuuXiz/82iUOimzbA2MdXEJ7K1z0u3xhoMKzrgzGcQsQftFhekyzH
	 KfddeUwFZoOXXbqxoyAvatMkzZoubJHB8z34K3XrRUhDOxf4L86zIY8SYnuRzEG0kd
	 hMpS0/WRYmAU9Qj9Ah+geA/v3xa/W3nzhmeqjc4hMk2OGHDEW5/728f1Nffb2qcDQC
	 yT8vHsFYNFUH/rbNhlN9ps/x9x+6Oelt2pMc+KsudonH/crq7qhSwcwoVikmOQp9Ja
	 8FOuqQG8C8BJQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gBkQ84rjhz7v7h;
	Fri,  8 May 2026 11:31:12 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4gBkQ80Xjnz8svb;
	Fri,  8 May 2026 11:31:12 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 8CCC661826;
	Fri,  8 May 2026 11:31:11 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <46eaec7d-a359-40c8-9c5c-57ecc3506805@leemhuis.info>
Date: Fri, 8 May 2026 11:31:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
To: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Huang Rui <ray.huang@amd.com>
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
 <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
 <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
 <f4fd9018-2a05-454b-a887-9b1c9a8a14df@amd.com>
 <33a693a8-a460-49b7-83cb-1ab7b66ce69e@freenet.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <33a693a8-a460-49b7-83cb-1ab7b66ce69e@freenet.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177823267184.2229156.6842960691536307256@mxe9fb.netcup.net>
X-NC-CID: EntAPMf+sMMrKAEy5uYd9HkchARg4dlo6cVSiImGfzayNmRc/AA=

Lo! Mario, what happened to this? This lookes stalled.

Side notes:

* another report about an issue like this was filed here and contains a
patch from Mario for testing:
https://bugzilla.kernel.org/show_bug.cgi?id=221473

* there is a whole patch series with fixes for the culprit:
https://lore.kernel.org/all/20260508051748.10484-1-kprateek.nayak@amd.com/

Ciao, Thorsten

On 4/29/26 20:34, Viktor Jägersküpper wrote:
> Am 29.04.26 um 19:14 schrieb Mario Limonciello:
>>
>>
>> On 4/29/26 11:20, Viktor Jägersküpper wrote:
>>> Am 29.04.26 um 17:54 schrieb Mario Limonciello:
>>>>
>>>>
>>>> On 4/29/26 10:38, Viktor Jägersküpper wrote:
>>>>> Am 29.04.26 um 16:25 schrieb Mario Limonciello:
>>>>>>
>>>>>>
>>>>>> On 4/29/26 08:54, Viktor Jägersküpper wrote:
>>>>>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>>
>>>>>>> Am 29.04.26 um 15:04 schrieb Mario Limonciello:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 4/29/26 07:34, Viktor Jägersküpper wrote:
>>>>>>>>> [You don't often get email from viktor_jaegerskuepper@freenet.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>>>>>
>>>>>>>>> Hi,
>>>>>>>>>
>>>>>>>>> when I boot my desktop system running with an AMD Ryzen 9 5900X using
>>>>>>>>> the kernel 7.1-rc1, all CPU cores seem to run at ~1.7 GHz constantly,
>>>>>>>>> i.e. I don't observe any core frequency boosting under load. This never
>>>>>>>>> happened with older kernel releases, e.g. with 7.0-rc7. I ran
>>>>>>>>> 'git bisect' and found this first bad commit:
>>>>>>>>>
>>>>>>>>> e30ca6dd5345c5b8ba05f346a8e81105352fe571 cpufreq/amd-pstate: Add dynamic energy performance preference
>>>>>>>>
>>>>>>>> If you compile with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=n (instead of using kernel command line to turn it off) does the issue go away?
>>>>>>>>
>>>>>>>
>>>>>>> No, and still nothing about amd-pstate in dmesg.
>>>>>>
>>>>>> Can you turn on dynamic debugging for amd-pstate.c?  Something like this:
>>>>>>
>>>>>> dyndbg='file drivers/cpufreq/amd-pstate.c +p'
>>>>>>
>>>>>
>>>>> Both kernel builds (with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y/n) have the following config:
>>>>> CONFIG_DYNAMIC_DEBUG=y
>>>>> CONFIG_DYNAMIC_DEBUG_CORE=y
>>>>>
>>>>> Booting with the above dyndbg parameter gives me only this line about amd-pstate in dmesg:
>>>>> [    0.844066] amd_pstate: AMD CPPC shared memory based functionality is supported
>>>>>
>>>>> Do I have to do anything else besides booting with the dyndbg parameter? I have tried
>>>>> both builds.
>>>>
>>>> You shouldn't have to.  I think there might be something silently failing in the init path now.  Maybe platform profile registration is failing for your system?  I haven't reproduced this on my side on any of my systems unfortunately.
>>>>
>>>> Do you think you can sprinkle printk()'s around the init to figure it out?  If you need me to write a patch that does this I can try to whip one up.
>>>>
>>>
>>> Please write a patch, I am just a user trying to help.
>>
>> OK thanks.  Here is a debugging patch that should show what's happening in the new paths from e30ca6dd5345c5b8ba05f346a8e81105352fe571 so we can confirm root cause on your system.
> 
> These are the dmesg lines concerning amd-pstate:
> [    0.845044] amd_pstate: amd_pstate: CPU 0: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.845047] amd_pstate: amd_pstate: CPU 0: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.845059] amd_pstate: amd_pstate: CPU 0: platform_profile_register succeeded
> [    0.845060] amd_pstate: amd_pstate: CPU 0: registering power supply notifier
> [    0.849046] amd_pstate: amd_pstate: CPU 1: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.849047] amd_pstate: amd_pstate: CPU 1: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.849058] amd_pstate: amd_pstate: CPU 1: platform_profile_register succeeded
> [    0.849059] amd_pstate: amd_pstate: CPU 1: registering power supply notifier
> [    0.853043] amd_pstate: amd_pstate: CPU 2: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.853044] amd_pstate: amd_pstate: CPU 2: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.853054] amd_pstate: amd_pstate: CPU 2: platform_profile_register succeeded
> [    0.853054] amd_pstate: amd_pstate: CPU 2: registering power supply notifier
> [    0.857043] amd_pstate: amd_pstate: CPU 3: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.857044] amd_pstate: amd_pstate: CPU 3: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.857054] amd_pstate: amd_pstate: CPU 3: platform_profile_register succeeded
> [    0.857054] amd_pstate: amd_pstate: CPU 3: registering power supply notifier
> [    0.861045] amd_pstate: amd_pstate: CPU 4: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.861046] amd_pstate: amd_pstate: CPU 4: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.861056] amd_pstate: amd_pstate: CPU 4: platform_profile_register succeeded
> [    0.861057] amd_pstate: amd_pstate: CPU 4: registering power supply notifier
> [    0.865044] amd_pstate: amd_pstate: CPU 5: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.865046] amd_pstate: amd_pstate: CPU 5: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.865057] amd_pstate: amd_pstate: CPU 5: platform_profile_register succeeded
> [    0.865058] amd_pstate: amd_pstate: CPU 5: registering power supply notifier
> [    0.870044] amd_pstate: amd_pstate: CPU 6: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.870046] amd_pstate: amd_pstate: CPU 6: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.870058] amd_pstate: amd_pstate: CPU 6: platform_profile_register succeeded
> [    0.870058] amd_pstate: amd_pstate: CPU 6: registering power supply notifier
> [    0.874044] amd_pstate: amd_pstate: CPU 7: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.874045] amd_pstate: amd_pstate: CPU 7: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.874056] amd_pstate: amd_pstate: CPU 7: platform_profile_register succeeded
> [    0.874057] amd_pstate: amd_pstate: CPU 7: registering power supply notifier
> [    0.878045] amd_pstate: amd_pstate: CPU 8: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.878046] amd_pstate: amd_pstate: CPU 8: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.878055] amd_pstate: amd_pstate: CPU 8: platform_profile_register succeeded
> [    0.878056] amd_pstate: amd_pstate: CPU 8: registering power supply notifier
> [    0.882045] amd_pstate: amd_pstate: CPU 9: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.882046] amd_pstate: amd_pstate: CPU 9: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.882055] amd_pstate: amd_pstate: CPU 9: platform_profile_register succeeded
> [    0.882056] amd_pstate: amd_pstate: CPU 9: registering power supply notifier
> [    0.886045] amd_pstate: amd_pstate: CPU 10: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.886046] amd_pstate: amd_pstate: CPU 10: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.886055] amd_pstate: amd_pstate: CPU 10: platform_profile_register succeeded
> [    0.886056] amd_pstate: amd_pstate: CPU 10: registering power supply notifier
> [    0.890045] amd_pstate: amd_pstate: CPU 11: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.890046] amd_pstate: amd_pstate: CPU 11: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.890056] amd_pstate: amd_pstate: CPU 11: platform_profile_register succeeded
> [    0.890056] amd_pstate: amd_pstate: CPU 11: registering power supply notifier
> [    0.894046] amd_pstate: amd_pstate: CPU 12: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.894047] amd_pstate: amd_pstate: CPU 12: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.894056] amd_pstate: amd_pstate: CPU 12: platform_profile_register succeeded
> [    0.894057] amd_pstate: amd_pstate: CPU 12: registering power supply notifier
> [    0.898046] amd_pstate: amd_pstate: CPU 13: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.898047] amd_pstate: amd_pstate: CPU 13: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.898055] amd_pstate: amd_pstate: CPU 13: platform_profile_register succeeded
> [    0.898056] amd_pstate: amd_pstate: CPU 13: registering power supply notifier
> [    0.902046] amd_pstate: amd_pstate: CPU 14: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.902048] amd_pstate: amd_pstate: CPU 14: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.902059] amd_pstate: amd_pstate: CPU 14: platform_profile_register succeeded
> [    0.902059] amd_pstate: amd_pstate: CPU 14: registering power supply notifier
> [    0.906046] amd_pstate: amd_pstate: CPU 15: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.906048] amd_pstate: amd_pstate: CPU 15: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.906060] amd_pstate: amd_pstate: CPU 15: platform_profile_register succeeded
> [    0.906060] amd_pstate: amd_pstate: CPU 15: registering power supply notifier
> [    0.910046] amd_pstate: amd_pstate: CPU 16: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.910048] amd_pstate: amd_pstate: CPU 16: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.910058] amd_pstate: amd_pstate: CPU 16: platform_profile_register succeeded
> [    0.910059] amd_pstate: amd_pstate: CPU 16: registering power supply notifier
> [    0.914047] amd_pstate: amd_pstate: CPU 17: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.914048] amd_pstate: amd_pstate: CPU 17: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.914059] amd_pstate: amd_pstate: CPU 17: platform_profile_register succeeded
> [    0.914060] amd_pstate: amd_pstate: CPU 17: registering power supply notifier
> [    0.918049] amd_pstate: amd_pstate: CPU 18: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.918051] amd_pstate: amd_pstate: CPU 18: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.918081] amd_pstate: amd_pstate: CPU 18: platform_profile_register succeeded
> [    0.918082] amd_pstate: amd_pstate: CPU 18: registering power supply notifier
> [    0.922049] amd_pstate: amd_pstate: CPU 19: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.922051] amd_pstate: amd_pstate: CPU 19: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.922070] amd_pstate: amd_pstate: CPU 19: platform_profile_register succeeded
> [    0.922071] amd_pstate: amd_pstate: CPU 19: registering power supply notifier
> [    0.926049] amd_pstate: amd_pstate: CPU 20: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.926052] amd_pstate: amd_pstate: CPU 20: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.926073] amd_pstate: amd_pstate: CPU 20: platform_profile_register succeeded
> [    0.926074] amd_pstate: amd_pstate: CPU 20: registering power supply notifier
> [    0.930049] amd_pstate: amd_pstate: CPU 21: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.930052] amd_pstate: amd_pstate: CPU 21: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.930071] amd_pstate: amd_pstate: CPU 21: platform_profile_register succeeded
> [    0.930072] amd_pstate: amd_pstate: CPU 21: registering power supply notifier
> [    0.934050] amd_pstate: amd_pstate: CPU 22: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.934052] amd_pstate: amd_pstate: CPU 22: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.934072] amd_pstate: amd_pstate: CPU 22: platform_profile_register succeeded
> [    0.934073] amd_pstate: amd_pstate: CPU 22: registering power supply notifier
> [    0.938050] amd_pstate: amd_pstate: CPU 23: calling amd_pstate_set_dynamic_epp (current_profile=3)
> [    0.938052] amd_pstate: amd_pstate: CPU 23: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
> [    0.938073] amd_pstate: amd_pstate: CPU 23: platform_profile_register succeeded
> [    0.938074] amd_pstate: amd_pstate: CPU 23: registering power supply notifier
> 
> 

