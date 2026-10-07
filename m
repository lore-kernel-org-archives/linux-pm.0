Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7CC3B2D39;
	Wed,  7 Oct 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791401920; cv=none; b=WX+23wlrGXyXZuR0/IuVULSvm0fxkuSssJ813q/2mC/cR74A/GpUYhryvO299206CTqvt75O90N91OffIiFuIQomulFn8mYWSqnHu/uZS1KobFv7BGAL022rHCeYUOePYlO26z0Ka+00DnfQ+V4RYIvOP4CdsNnzJNPFNRrGuR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791401920; c=relaxed/simple;
	bh=a0vlzlHndgpYoeHytTBpze7DzGNQ9VVdMkGYg758LOk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SfvJV/iM89LYi0ClN17htYOF3dF08OHXeFCthztTar7N5COdGGjRa7t6V7NCfO6WecAgwIGE4DjOf3HBE5jECQZR+jSdcBTHE6MvlOg0tIx0Jcz6KqJZrTr24HyY0K7InQRAIwAYyyXzF6Oi0Fi+GWKOtSNtuPs1KtwEDMtU9oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XbSFWh/R; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PennwLe6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=C0ni1XFs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qjtzeqOl; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XbSFWh/R";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PennwLe6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="C0ni1XFs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qjtzeqOl"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E20C221B7C;
	Wed,  7 Oct 2026 19:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791401916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhbzsX6KPxjfSWY+sKOL4UDqM8IH1BrEMNPNgMyAt68=;
	b=XbSFWh/R6QXNAwCLwF9bWAYf+f5QQmtDz7eXsfrVCMkf++t/Pn+KYGrrn3HyFEQeTaJpZM
	Rs11vOfV9ZG4J4blxJOJr+KAES5quj8VND2ql837UNYbs/Yc6AZTwVsKNDv2+RLs8QpEGx
	J1EZF3dAEv6XXldaXY4jy5SltQo9KSQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791401916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhbzsX6KPxjfSWY+sKOL4UDqM8IH1BrEMNPNgMyAt68=;
	b=PennwLe6BmYHtZmJ1Cr6pAnpC6IIpcBO6eFyzTSwUrP/jxcph+wDXDXCR5qiGOi62CBY/t
	DDALYPWnp7XRzuBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=C0ni1XFs;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qjtzeqOl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791401914; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhbzsX6KPxjfSWY+sKOL4UDqM8IH1BrEMNPNgMyAt68=;
	b=C0ni1XFsYTFCli42TZHRYZo1fYRtbtlCk6NdWC2d6L2DOMnS7NwtKq2TDb3IQESt4WqcJA
	xHQ7v7ad/Q/A0RK52nenSdJqWsrfN0aNxUHQbYDjcLA0TDeNz6TfBnQAmNJriraRxbkYzf
	k3e55qv9weNR74iOYP2sve1KcVidpk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791401914;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qhbzsX6KPxjfSWY+sKOL4UDqM8IH1BrEMNPNgMyAt68=;
	b=qjtzeqOlwcM+58mUTDsBldcZf8xZ/wHZSWC1fcZHwN2HLMUPYJM6/8ShHgEQUQtVi0uniL
	A2s+nHpUgAiUHqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3FF7A13312;
	Wed,  7 Oct 2026 19:38:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jtTFOLmfxmpAGgAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Wed, 07 Oct 2026 19:38:34 +0000
Message-ID: <93531c5c-5638-4a20-919a-8471a7222218@suse.cz>
Date: Wed, 7 Oct 2026 21:38:29 +0200
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
 Huang Rui <ray.huang@amd.com>, Perry Yuan <perry.yuan@amd.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261007144150.15113-1-ggherdovich@suse.cz>
 <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
Content-Language: en-US
From: Giovanni Gherdovich <ggherdovich@suse.cz>
In-Reply-To: <27b226c7-f30b-4863-96e6-6798232863c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E20C221B7C
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.50
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.993];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msi.com:url,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]

Hello Mario,

[moving Kyle to BCC, I hope it's OK]

in my last message I forgot to reply to the rest of your questions;
see below. In any event, next step for me is testing the latest bios,
as there seems to be an update.

On Wed Oct 7, 2026 16:56, Mario Limonciello wrote:
> 
> Can you please add more information about the vendor/model of the MB, etc?

right.

Motherboard is MSI, model is TRX40 PRO WIFI, CPU is AMD Ryzen Threadripper 3960X.
https://www.msi.com/Motherboard/TRX40-PRO-WIFI
Practically the same system as Kyle.

>> amd-pstate requires explicit knowledge of nominal frequency, so it
>> can't load on this hardware. The driver already has a mechanism (the
>> so-called "quirks") to accommodate for missing nominal freq in ACPI
>> tables, so here we use it to match against CPU family, model, core
>> count, and BIOS version.
> 
> Yeah; it's intended for this specific case of really old hardware that the BIOS isn't going to fix it.
> 
> I don't understand why core count matters though.

My thinking was:

1. I want to make the "quirk" to match as many chips as possible, to
    make it more useful and worthwhile.
2. The doc I have, "Power and Thermal Data Sheet" (publication #56736
    in the AMD doc library), is for family 0x17, models 0x30-0x3F
    processors.
3. Problem: these have different nominal frequencies, depending on the
    core count. Specifically:
    24 cores: 3800 MHz (like the Ryzen 3090x I need)
    32 cores: 3700 Mhz
    64 cores: 2900 MHz
4. Thus I decided to match for family 0x17, model 0x30-0x3f, 24 cores.
    Without the core count constraint, I couldn't tell which of the
    three nominal frequencies above should apply.

>> @@ -174,6 +179,22 @@ static int __init dmi_matched_7k62_bios_bug(const struct dmi_system_id *dmi)
>>       return 0;
>>   }
>> +static int __init dmi_matched_trx40_bios_bug(const struct dmi_system_id *dmi)
>> +{
>> +    /**
>> +     * Match the Ryzen Threadripper 3000 series, 24-core SKU, sTRX4 socket / TRX40 chipset.
>> +     */
>> +    if (boot_cpu_data.x86 == 0x17 &&
>> +        boot_cpu_data.x86_model >= 0x30 && boot_cpu_data.x86_model <= 0x3F &&
>> +        topology_num_cores_per_package() == 24) {
> 
> Does the number of cores actually matter?  Do you mean to say if you swap the CPU to another part CPPC works?

No no. It was either wide matching (models 0x30-0x3f) but constraint
on #cores, or narrow matching for the exact CPU in my motherboard, (model 0x31).
Since I'm hard-coding data into the kernel, I figured wide matching
would make the quirk more applicable to potentially other affected
systems, hence more useful.

>> +        quirks = dmi->driver_data;
>> +        pr_info("Overriding nominal and lowest frequencies for %s\n", dmi->ident);
> 
> The BIOS bug specifically is lack of values, not invalid values, right? Just want to make sure I'm following this right.

Correct, BIOS is lacking the values. That info message "Overriding"
is taken verbatim from the other "quirk" in the source, but strictly
speaking inaccurate. Values weren't there to begin with.

All that said, I've asked the openSUSE user to test the newer BIOS,
we'll see what that gives.


Thanks,
Giovanni
