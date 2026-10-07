Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA2B27281E;
	Wed,  7 Oct 2026 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791399007; cv=none; b=hFFxz41WtKLvhUIgxRmIxK3jB0kyHKqsoUAxCBA1pZIcWDb1i4BlNGJRaaF8gMUShfXOnklBF4Mh+28ZjCAXcu7+9zbAh/GEaQvY21QrWmnW2FjuEWFzrdQcnHLWdfLWwXqKHuy2zF9KIeJztS09ItKBaUB6OZILWH39/PfDHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791399007; c=relaxed/simple;
	bh=FQfOOfatz8/cDKbjo1SuHMdZYoDfLfc8UDR4XIw6NeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSj1fJ/Yq6rOgdnXC9ZTJWuMVFb6P4KZgiTu8KHCIcui3eDn2D98VB4+NRJEQ3KV2pSOx+v9SH73gjBjaG9470k6o9Cr1IE3uqf4FWcDmGQhZW4fIbENs7rDzL7fPyJobIyjW3yjCGwT8ohhzWhles9k4TG634Q72Tn9iD5lSUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nQVZNhsn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z/1k8DlW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FXXRGEu/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=27PT8V4c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nQVZNhsn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z/1k8DlW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FXXRGEu/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="27PT8V4c"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7FC901F44E;
	Wed,  7 Oct 2026 18:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791399003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmUGawMMCEgPcOW12DL3MmBf9FDH9woSZ3i9HhDa4rg=;
	b=nQVZNhsnjCZKgJQ90r6q8mKre2P6eiask4Kp53aXKiARasnnRClDU2hpFwqFrKSb+u2xRA
	jYIz/Bup2RwuWW/o6p8IwzZolIBrbF2Zo+M356HbvwohUerdw1IFO8nYaRb2Gfh2QVq2+7
	7byD9huvyKGtgTte1867aHtfQ/d6Dkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791399003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmUGawMMCEgPcOW12DL3MmBf9FDH9woSZ3i9HhDa4rg=;
	b=Z/1k8DlWI9DK2qUHoV6zYgQLshplk0QPNpt6YJAzpvkccy5pPJ4OJL9Pf1VSy3S+0p6w1s
	aTjVFB3t0TNha5CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791399002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmUGawMMCEgPcOW12DL3MmBf9FDH9woSZ3i9HhDa4rg=;
	b=FXXRGEu/L4b+0Csw+j85MTpF9oUBhRpI3t64MOzMxvJH9LvmLzQmM5vAHpK4x00e4fU8qG
	r3n2zW2deWlUXeGsgpB3+A7AVMCt/SEBIxNhLQ834YYO0zm6mPbMXbCP5tPXIMO8c9ED9o
	9s+KZp1J/xFqFdOYBkHu1FmPOBsF610=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791399002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LmUGawMMCEgPcOW12DL3MmBf9FDH9woSZ3i9HhDa4rg=;
	b=27PT8V4cDv2lc3AIBtKwC52QPaCs37zcQ+DeOzKo2ixj/VBt0Sf4QXDJLRxq5fbk7Zatje
	ZsBf4Fb76rAm3jDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D937113354;
	Wed,  7 Oct 2026 18:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vBUfK1mUxmocZwAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Wed, 07 Oct 2026 18:50:01 +0000
Message-ID: <0ebef43d-fba6-44dc-83ce-43137ece2025@suse.cz>
Date: Wed, 7 Oct 2026 20:49:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq/amd-pstate: Supply nominal/lowest freq for
 TRX40-based motherboards
To: Mario Limonciello <mario.limonciello@amd.com>,
 Kyle Gospodnetich <me@kylegospodneti.ch>
Cc: Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
 <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
 <nfzkXrDTHHjIW_SUzjPg0gOHamPmFkMiNw8Xyzu1ET_un0fM-tmdI3ChdnOkXAkrh_nX4jiwmzCK6GgWwOsfDti3ta-vlRMihfH4dGUgBCU=@kylegospodneti.ch>
 <a387ee24-ef09-4983-865c-47ef43fa0964@amd.com>
 <N6r-1w2v2oSkh5ABRHMoj9_YQ7F7eICWqD2rdyL7M1SmbVzhiK0plLXBCzZbDmO8M6w28qHy--pue6kfl1k8B-j03x5f6VYC2DlQ_spmIpc=@kylegospodneti.ch>
 <DC1J2LrrQ6hdyQJ_ThQRfGrnzKLI5qCCQYGA5I2LhASN8j8MLcpfvJ2T4Qn_8xmO2TB4MW9Sl6LyQKkuANWwowWXafKbEqJ8pXEBEnmE2yA=@kylegospodneti.ch>
 <1c6ba221-a73c-4793-aac6-b38d6e573295@amd.com>
 <bK7n7j4SGpNNcHzUh7I63T_Ozbd5u6wVHdVlpa3Ym76UQs2PhQDtaREPYuFsHMKZku0B9v2-d8A9PdeBRx_0l0xUZ9gt--wxwyI4-sTKfyM=@kylegospodneti.ch>
 <c9c92c6e-4f2b-48c3-a2da-d3f3ed320b20@amd.com>
Content-Language: en-US
From: Giovanni Gherdovich <ggherdovich@suse.cz>
In-Reply-To: <c9c92c6e-4f2b-48c3-a2da-d3f3ed320b20@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.27
X-Spam-Level: 
X-Spamd-Result: default: False [-4.27 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.18)[-0.902];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:email,amd.com:email,imap1.dmz-prg2.suse.org:helo,kylegospodneti.ch:email,msi.com:url];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylegospodneti.ch:email,suse.cz:email,msi.com:url,imap1.dmz-prg2.suse.org:helo,amd.com:email]

Hello Mario, Kyle,

Kyle:
thanks for checking BIOS updates, you and I have a very similar
motherboard in fact; the one I'm working with is the MSI "TRX40 PRO WIFI".

Mario:
Yes I suppose I do have a BIOS update; sorry, it escaped my notice.
After Kyle's successful test, I checked msi.com and indeed there's a
BIOS release at https://www.msi.com/Motherboard/TRX40-PRO-WIFI/support
from last June (version 7C60v294 from 2026-06-23).

I need to ask the openSUSE user who reported this problem to test the
new BIOS (I don't have direct access to this machine). I'll let you know.


Thanks,
Giovanni

On Wed Oct 7, 2026 20:32, Mario Limonciello wrote:
> Well that's great news.
> 
> Giorvanni - are you sure you don't have a BIOS update available from your vendor?
> 
> I would much rather not carry a quirk like this if it has been fixed in latest BIOS.
> 
> On 10/7/26 13:30, Kyle Gospodnetich wrote:
>> Looks like it's finally fixed with that last BIOS release, it's been years!
>>
>> Platform Firmware Information
>>     Vendor: American Megatrends International, LLC.
>>     Version: 1.A4
>>     Release Date: 06/15/2026
>>
>> cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
>> amd-pstate-epp
>>
>> And no performance issues. Thanks!
>>
>>
>> On Wednesday, October 7th, 2026 at 11:08 AM, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>
>>> OK, let's wait and see what happens after you upgrade.  New versions of
>>> FW and the behavior please.
>>>
>>> On 10/7/26 12:43, Kyle Gospodnetich wrote:
>>>> Missed one,
>>>>
>>>> Release Date: 05/17/2022
>>>>
>>>>
>>>> On Wednesday, October 7th, 2026 at 10:36 AM, Kyle Gospodnetich <me@kylegospodneti.ch> wrote:
>>>>
>>>>> AMD Ryzen Threadripper 3960X
>>>>> MSI TRX40-PRO-10G
>>>>> https://www.msi.com/Motherboard/TRX40-PRO-10G/support
>>>>> I am using 7C60v1A3(Beta version), I will update to the latest today -- just learning that exists.
>>>>> dmidecode reports that as:
>>>>> Vendor: American Megatrends International, LLC.
>>>>> Version: 1.80
>>>>>
>>>>> I've had to disable pstate with:
>>>>> amd_pstate.enable=0 initcall_blacklist=amd-pstate
>>>>>
>>>>> Without that my system grinds to a hault, takes upwards of 15 minutes just to hit the desktop.
>>>>>
>>>>> Thanks, let me know if anything else is needed.
>>>>> -Kyle Gospodnetich
>>>>>
>>>>>
>>>>> On Wednesday, October 7th, 2026 at 8:06 AM, Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>>
>>>>>> Kyle,
>>>>>>
>>>>>> Can you please confirm more about your system?  System Model, vendor,
>>>>>> BIOS version, BIOS vendor, CPU model.
>>>>>>
>>>>>> Thanks,
>>>>>>
>>>>>> On 10/7/26 10:04, Kyle Gospodnetich wrote:
>>>>>>> Yes this does appear to be the same problem, thank you!
>>>>>>>
>>>>>>> -------- Original Message --------
>>>>>>> On Wednesday, 10/07/26 at 07:56 Mario Limonciello <mario.limonciello@amd.com> wrote:
>>>>>>> + Kyle
>>>>>>>
>>>>>>> Kyle,
>>>>>>>
>>>>>>> By chance is this the same system that you were talking to me about offline?
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On 10/7/26 09:41, Giovanni Gherdovich wrote:
>>>>>>>> Some motherboard based on the TRX40 chipset has been reported to ship
>>>>>>>> firmware lacking lowest and nominal frequency values in the
>>>>>>>> _CPC ACPI package. That is, it supports CPPC V2 but not CPPC V3.
>>>>>>>> Firmware updates aren't available.
>>>>>>>
>>>>>>> Can you please add more information about the vendor/model of the MB, etc?
>>>>>>>>
>>>>>>>> amd-pstate requires explicit knowledge of nominal frequency, so it
>>>>>>>> can't load on this hardware. The driver already has a mechanism (the
>>>>>>>> so-called "quirks") to accommodate for missing nominal freq in ACPI
>>>>>>>> tables, so here we use it to match against CPU family, model, core
>>>>>>>> count, and BIOS version.
>>>>>>>
>>>>>>> Yeah; it's intended for this specific case of really old hardware that
>>>>>>> the BIOS isn't going to fix it.
>>>>>>>
>>>>>>> I don't understand why core count matters though.
>>>>>>>
>>>>>>>>
>>>>>>>> Signed-off-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>>>>>>>> ---
>>>>>>>>      drivers/cpufreq/amd-pstate.c | 31 +++++++++++++++++++++++++++++++
>>>>>>>>      1 file changed, 31 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
>>>>>>>> index 8bfd46d60843..532ff16dd076 100644
>>>>>>>> --- a/drivers/cpufreq/amd-pstate.c
>>>>>>>> +++ b/drivers/cpufreq/amd-pstate.c
>>>>>>>> @@ -145,6 +145,11 @@ static struct quirk_entry quirk_amd_7k62 = {
>>>>>>>>          .lowest_freq = 550,
>>>>>>>>      };
>>>>>>>>
>>>>>>>> +static struct quirk_entry quirk_amd_ryzen_threadripper_3000_24c = {
>>>>>>>> +    .nominal_freq = 3800,
>>>>>>>> +    .lowest_freq = 550,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>      static inline u8 freq_to_perf(union perf_cached perf, u32 nominal_freq, unsigned int freq_val)
>>>>>>>>      {
>>>>>>>>          u32 perf_val = DIV_ROUND_UP_ULL((u64)freq_val * perf.nominal_perf, nominal_freq);
>>>>>>>> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>>>>>>>>          return 0;
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id *dmi)
>>>>>>>> +{
>>>>>>>> +    /**
>>>>>>>> +     * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socket / TRX40 chipset.
>>>>>>>> +     */
>>>>>>>> +    if (boot_cpu_data.x86 == 0x17 &&
>>>>>>>> +        boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x3F &&
>>>>>>>> +        topology_num_cores_per_package() == 24) {
>>>>>>>
>>>>>>> Does the number of cores actually matter?  Do you mean to say if you
>>>>>>> swap the CPU to another part CPPC works?
>>>>>>>
>>>>>>>> +        quirks = dmi->driver_data;
>>>>>>>> +        pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
>>>>>>>
>>>>>>> The BIOS bug specifically is lack of values, not invalid values, right?
>>>>>>> Just want to make sure I'm following this right.
>>>>>>>
>>>>>>>> +        return 1;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>>>>>>>          {
>>>>>>>>              .callback = dmi_matched_7k62_bios_bug,
>>>>>>>> @@ -184,6 +205,16 @@ static const struct dmi_system_id amd_pstate_quirks_table[] __initconst = {
>>>>>>>>              },
>>>>>>>>              .driver_data = &quirk_amd_7k62,
>>>>>>>>          },
>>>>>>>> +    {
>>>>>>>> +        .callback = dmi_matched_trx40_bios_bug,
>>>>>>>> +        .ident = "AMD Ryzen Threadripper 3000",
>>>>>>>> +        .matches = {
>>>>>>>> +            DMI_MATCH(DMI_BIOS_VENDOR,  "American Megatrends International"),
>>>>>>>> +            DMI_MATCH(DMI_BIOS_VERSION, "2.80"),
>>>>>>>> +            DMI_MATCH(DMI_BIOS_DATE,    "05/17/2022"),
>>>>>>>> +        },
>>>>>>>> +        .driver_data = &quirk_amd_ryzen_threadripper_3000_24c,
>>>>>>>> +    },
>>>>>>>>          {}
>>>>>>>>      };
>>>>>>>>      MODULE_DEVICE_TABLE(dmi, amd_pstate_quirks_table);
>>>>>>>
>>>>>>
>>>>>>
>>>
>>>
> 

