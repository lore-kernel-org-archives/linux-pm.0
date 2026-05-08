Received: from mout.freenet.de (mout.freenet.de [194.97.196.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4627979A;
	Fri,  8 May 2026 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.97.196.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270682; cv=none; b=ty0XbFnBzJcws6fgKqrvUjdY9gRD3jPHZKm0BltieQhiu0vazX15jld46kos9oLeDdgEcpMjGTKEH6xzToK2/TguI2n34KGWunezhq9bpZ5XJwaRQSXLstEZjSlD9DP9ItbOX6Z6Cu8d1Kcw+OxP7tnfTNq3qZ52e4/FBubLwzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270682; c=relaxed/simple;
	bh=fVSg07Bl6FKhMVaWzBeKdPRMHwWW9XTK3KTOaT9O5P4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R4ygkYUznL6OO7GHn8FbvtaFZtk60aTkeVbwPP71zo5y6nCClwtXSNcGZ3W9kFGNdXOxCKFszpjqMBtbIOgyQ+m/2L8P/t0j5Z/oy0E69enseHjvBTI2GjsgAdkVmbxShxXbo87mhT+xwp/wvVDWb1f0k1yv+6oJ+OMcbSKUQ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de; spf=pass smtp.mailfrom=freenet.de; dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b=bl2vwe+V; arc=none smtp.client-ip=194.97.196.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenet.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenet.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freenet.de header.i=@freenet.de header.b="bl2vwe+V"
Received: from [2001:748:400:2319::5] (helo=sub8.mail.fnrz.de)
	by mout4.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port 25) (Exim 4.98.2 #2)
	id 1wLRR8-0000000GFcC-1UgE;
	Fri, 08 May 2026 22:04:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de;
	s=mjaymdexmjqk; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=6WOV1ZqOVtBWsiJgvI3I6SaBo475EsCABJM7XV/bW88=; b=bl2vwe+VwOwfRk35qTGwPWkZGT
	BFUyS52PGsenWdwq6OqQ8YCb8M83yYeLKedKvsVqYfuqqXFh8EAhvVz2KUWJKIG0PZlrYKVqR6sAB
	bKkjSLtbaSw1YvstpF43D/Mx65gV3WOy8KzfPdeop+1sKOFk46Qf9FkBGAceTSkwkozeIwVDzH/CH
	AGsgmUXYGy64DsnhvIsX98oqOTE3tbmTt0PapS1dnOWcIi5qV7U4LkCaggOXUTWMWkC+Al/JeGmch
	V/EQ0pVXTzZv45uUDlxrMJENDvLkb3fHaaHSqVE4Zx0ItjN2U8Vvl2JuFiTAptf86dYf1rVZALUrB
	RrJipVhg==;
Received: from [2a02:8071:a85:f020:8898:558d:181a:86c2] (port=55280 helo=[127.0.0.1])
	by sub8.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de) (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim 4.96 #2)
	id 1wLRR8-002X8p-0c;
	Fri, 08 May 2026 22:04:38 +0200
Message-ID: <abba6f26-b696-4fcb-addc-754b295deb4f@freenet.de>
Date: Fri, 8 May 2026 22:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] CPU running at fixed frequency (~1.7 GHz) with
 kernel 7.1-rc1
Content-Language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: linux-pm@vger.kernel.org, regressions@lists.linux.dev,
 Huang Rui <ray.huang@amd.com>, Thorsten Leemhuis <regressions@leemhuis.info>
References: <14a87c99-785c-4b16-bfce-35ecbf053448@freenet.de>
 <f35244cb-1f17-42a9-9479-5eee196cae5e@amd.com>
 <f0b13b69-f5fa-4346-b1cd-dbae4a450c80@freenet.de>
 <fbfea6b5-eb13-484d-bf66-6fb1dee4d30d@amd.com>
 <8654f7a1-5023-4874-a90a-5332ba6301b3@freenet.de>
 <dba72492-e96f-4fd8-9520-89fee242271f@amd.com>
 <dea2c864-bd47-4bc8-a46b-f061771c2b4d@freenet.de>
 <f4fd9018-2a05-454b-a887-9b1c9a8a14df@amd.com>
 <33a693a8-a460-49b7-83cb-1ab7b66ce69e@freenet.de>
 <46eaec7d-a359-40c8-9c5c-57ecc3506805@leemhuis.info>
 <8c39f42a-f024-4f05-8d77-a95e7ca1c702@amd.com>
 <b5882c89-aa71-4205-ab25-ca9f038340df@freenet.de>
 <b2b60a42-53f1-4ee7-8361-2a07737e1bad@amd.com>
 <5fa4c763-bf94-4507-8667-f3dcb032b2e0@freenet.de>
 <399597ae-5186-4276-a585-acb1fd8155ad@amd.com>
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <399597ae-5186-4276-a585-acb1fd8155ad@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1778270678BB237DF0AF80O
X-Scan-TS: Fri, 08 May 2026 22:04:38 +0200

Am 08.05.26 um 21:56 schrieb Mario Limonciello:
> On 5/8/26 14:53, Viktor Jägersküpper wrote:
>> Am 08.05.26 um 21:01 schrieb Mario Limonciello:
>>> On 5/8/26 13:56, Viktor Jägersküpper wrote:
>>>> Am 08.05.26 um 14:57 schrieb Mario Limonciello:
>>>>> On 5/8/26 04:31, Thorsten Leemhuis wrote:
>>>>>> * there is a whole patch series with fixes for the culprit:
>>>>>> https://lore.kernel.org/all/20260508051748.10484-1-kprateek.nayak@amd.com/
>>>>>>
>>>>>
>>>>> I don't think any of these will help; but that would a fine surprise if so.
>>>>>
>>>>
>>>> This patch series fixes the bug when I boot with "amd_dynamic_epp=disable" (I built
>>>> the kernel with CONFIG_X86_AMD_PSTATE_DYNAMIC_EPP=y). I didn't bisect to find out
>>>> which patch contains the partial fix, but I can do this if it helps.
>>>>
>>>> If you need further information (acpidump and/or output from amd-pstate tool), just
>>>> tell me.
>>>
>>> When you have dynamic EPP enabled it sets up platform profile.  With that series in place does changing platform profile help?
>>
>> Strangely *changing* the power profile (to any value) seems to enable the expected
>> boosting behaviour, but since I can only do that when the PC has finished booting,
>> the cores still seem to be stuck at ~1.7 GHz until then. Unless I am doing something
>> stupid, that's not how it's supposed to work, I guess?
> 
> Can you confirm your tree when you found this?
> 7.1-rc2 + Prateek's series?

Yes, exactly this.

> 
> I would say that is not expected behavior; but it does hint further at the second bug.  Hopefully I can repro it.
> 
>>
>>>> Last week I got this output after applying a debugging patch from you:
>>>>>> On 4/29/26 20:34, Viktor Jägersküpper wrote:
>>>>>>> Am 29.04.26 um 19:14 schrieb Mario Limonciello:
>>>>>>>>
>>>>>>>> OK thanks.  Here is a debugging patch that should show what's happening in the new paths from e30ca6dd5345c5b8ba05f346a8e81105352fe571 so we can confirm root cause on your system.
>>>>>>>
>>>>>>> These are the dmesg lines concerning amd-pstate:
>>>>>>> [    0.845044] amd_pstate: amd_pstate: CPU 0: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.845047] amd_pstate: amd_pstate: CPU 0: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.845059] amd_pstate: amd_pstate: CPU 0: platform_profile_register succeeded
>>>>>>> [    0.845060] amd_pstate: amd_pstate: CPU 0: registering power supply notifier
>>>>>>> [    0.849046] amd_pstate: amd_pstate: CPU 1: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.849047] amd_pstate: amd_pstate: CPU 1: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.849058] amd_pstate: amd_pstate: CPU 1: platform_profile_register succeeded
>>>>>>> [    0.849059] amd_pstate: amd_pstate: CPU 1: registering power supply notifier
>>>>>>> [    0.853043] amd_pstate: amd_pstate: CPU 2: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.853044] amd_pstate: amd_pstate: CPU 2: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: platform_profile_register succeeded
>>>>>>> [    0.853054] amd_pstate: amd_pstate: CPU 2: registering power supply notifier
>>>>>>> [    0.857043] amd_pstate: amd_pstate: CPU 3: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.857044] amd_pstate: amd_pstate: CPU 3: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: platform_profile_register succeeded
>>>>>>> [    0.857054] amd_pstate: amd_pstate: CPU 3: registering power supply notifier
>>>>>>> [    0.861045] amd_pstate: amd_pstate: CPU 4: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.861046] amd_pstate: amd_pstate: CPU 4: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.861056] amd_pstate: amd_pstate: CPU 4: platform_profile_register succeeded
>>>>>>> [    0.861057] amd_pstate: amd_pstate: CPU 4: registering power supply notifier
>>>>>>> [    0.865044] amd_pstate: amd_pstate: CPU 5: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.865046] amd_pstate: amd_pstate: CPU 5: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.865057] amd_pstate: amd_pstate: CPU 5: platform_profile_register succeeded
>>>>>>> [    0.865058] amd_pstate: amd_pstate: CPU 5: registering power supply notifier
>>>>>>> [    0.870044] amd_pstate: amd_pstate: CPU 6: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.870046] amd_pstate: amd_pstate: CPU 6: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: platform_profile_register succeeded
>>>>>>> [    0.870058] amd_pstate: amd_pstate: CPU 6: registering power supply notifier
>>>>>>> [    0.874044] amd_pstate: amd_pstate: CPU 7: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.874045] amd_pstate: amd_pstate: CPU 7: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.874056] amd_pstate: amd_pstate: CPU 7: platform_profile_register succeeded
>>>>>>> [    0.874057] amd_pstate: amd_pstate: CPU 7: registering power supply notifier
>>>>>>> [    0.878045] amd_pstate: amd_pstate: CPU 8: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.878046] amd_pstate: amd_pstate: CPU 8: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.878055] amd_pstate: amd_pstate: CPU 8: platform_profile_register succeeded
>>>>>>> [    0.878056] amd_pstate: amd_pstate: CPU 8: registering power supply notifier
>>>>>>> [    0.882045] amd_pstate: amd_pstate: CPU 9: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.882046] amd_pstate: amd_pstate: CPU 9: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.882055] amd_pstate: amd_pstate: CPU 9: platform_profile_register succeeded
>>>>>>> [    0.882056] amd_pstate: amd_pstate: CPU 9: registering power supply notifier
>>>>>>> [    0.886045] amd_pstate: amd_pstate: CPU 10: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.886046] amd_pstate: amd_pstate: CPU 10: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.886055] amd_pstate: amd_pstate: CPU 10: platform_profile_register succeeded
>>>>>>> [    0.886056] amd_pstate: amd_pstate: CPU 10: registering power supply notifier
>>>>>>> [    0.890045] amd_pstate: amd_pstate: CPU 11: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.890046] amd_pstate: amd_pstate: CPU 11: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: platform_profile_register succeeded
>>>>>>> [    0.890056] amd_pstate: amd_pstate: CPU 11: registering power supply notifier
>>>>>>> [    0.894046] amd_pstate: amd_pstate: CPU 12: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.894047] amd_pstate: amd_pstate: CPU 12: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.894056] amd_pstate: amd_pstate: CPU 12: platform_profile_register succeeded
>>>>>>> [    0.894057] amd_pstate: amd_pstate: CPU 12: registering power supply notifier
>>>>>>> [    0.898046] amd_pstate: amd_pstate: CPU 13: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.898047] amd_pstate: amd_pstate: CPU 13: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.898055] amd_pstate: amd_pstate: CPU 13: platform_profile_register succeeded
>>>>>>> [    0.898056] amd_pstate: amd_pstate: CPU 13: registering power supply notifier
>>>>>>> [    0.902046] amd_pstate: amd_pstate: CPU 14: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.902048] amd_pstate: amd_pstate: CPU 14: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: platform_profile_register succeeded
>>>>>>> [    0.902059] amd_pstate: amd_pstate: CPU 14: registering power supply notifier
>>>>>>> [    0.906046] amd_pstate: amd_pstate: CPU 15: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.906048] amd_pstate: amd_pstate: CPU 15: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: platform_profile_register succeeded
>>>>>>> [    0.906060] amd_pstate: amd_pstate: CPU 15: registering power supply notifier
>>>>>>> [    0.910046] amd_pstate: amd_pstate: CPU 16: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.910048] amd_pstate: amd_pstate: CPU 16: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.910058] amd_pstate: amd_pstate: CPU 16: platform_profile_register succeeded
>>>>>>> [    0.910059] amd_pstate: amd_pstate: CPU 16: registering power supply notifier
>>>>>>> [    0.914047] amd_pstate: amd_pstate: CPU 17: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.914048] amd_pstate: amd_pstate: CPU 17: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.914059] amd_pstate: amd_pstate: CPU 17: platform_profile_register succeeded
>>>>>>> [    0.914060] amd_pstate: amd_pstate: CPU 17: registering power supply notifier
>>>>>>> [    0.918049] amd_pstate: amd_pstate: CPU 18: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.918051] amd_pstate: amd_pstate: CPU 18: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.918081] amd_pstate: amd_pstate: CPU 18: platform_profile_register succeeded
>>>>>>> [    0.918082] amd_pstate: amd_pstate: CPU 18: registering power supply notifier
>>>>>>> [    0.922049] amd_pstate: amd_pstate: CPU 19: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.922051] amd_pstate: amd_pstate: CPU 19: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.922070] amd_pstate: amd_pstate: CPU 19: platform_profile_register succeeded
>>>>>>> [    0.922071] amd_pstate: amd_pstate: CPU 19: registering power supply notifier
>>>>>>> [    0.926049] amd_pstate: amd_pstate: CPU 20: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.926052] amd_pstate: amd_pstate: CPU 20: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.926073] amd_pstate: amd_pstate: CPU 20: platform_profile_register succeeded
>>>>>>> [    0.926074] amd_pstate: amd_pstate: CPU 20: registering power supply notifier
>>>>>>> [    0.930049] amd_pstate: amd_pstate: CPU 21: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.930052] amd_pstate: amd_pstate: CPU 21: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.930071] amd_pstate: amd_pstate: CPU 21: platform_profile_register succeeded
>>>>>>> [    0.930072] amd_pstate: amd_pstate: CPU 21: registering power supply notifier
>>>>>>> [    0.934050] amd_pstate: amd_pstate: CPU 22: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.934052] amd_pstate: amd_pstate: CPU 22: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.934072] amd_pstate: amd_pstate: CPU 22: platform_profile_register succeeded
>>>>>>> [    0.934073] amd_pstate: amd_pstate: CPU 22: registering power supply notifier
>>>>>>> [    0.938050] amd_pstate: amd_pstate: CPU 23: calling amd_pstate_set_dynamic_epp (current_profile=3)
>>>>>>> [    0.938052] amd_pstate: amd_pstate: CPU 23: get_balanced_epp: power_supply_is_system_supplied=1, returning EPP=0x0 (ac=0x0, dc=0x80)
>>>>>>> [    0.938073] amd_pstate: amd_pstate: CPU 23: platform_profile_register succeeded
>>>>>>> [    0.938074] amd_pstate: amd_pstate: CPU 23: registering power supply notifier
>>>>>>>
>>>>>>>
>>>>>>
>>>>>
>>>>
>>>
>>
> 

