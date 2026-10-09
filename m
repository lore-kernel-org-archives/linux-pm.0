Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4A149D587;
	Fri,  9 Oct 2026 10:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542666; cv=none; b=eDcnc6jI/35O2y8vQe+TWCJ6jRNxNLY1oSQu9Soh8M16BMQpUeEtuhPpgx6kqphP9F8yETXhKHrBio4KubtLBIB2BvfjNe+IojgaB4d6hsTf4nt5KIBQoQbGL69grShn8r6YDfsEr6UlqW42fekvH3/RsxChOEl2XiY3d8KZ/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542666; c=relaxed/simple;
	bh=GGB8iFEr3Rwu/Rbhkl/QSnxRbt+s/12V3Y/+M0s3zkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzIuM4to9PRPb11lbpox1YW8TmhZfj5f6bDxXoOJTQLC+AGEsppUYeJM8aHJNLlABt1RFpnjRDgkqGMqQwaAFqfIlM+kb9Z6Z1mU9LdT5pbZydhPVrnDV2SSZkGlE14U5ymYyv+oPT1cuxXhjDMzry5gQZumYTvntsZnwQT00mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 022FD21BF5;
	Fri,  9 Oct 2026 10:44:16 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 778F7136D9;
	Fri,  9 Oct 2026 10:44:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RNfADn/FyGoYLAAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Fri, 09 Oct 2026 10:44:15 +0000
Message-ID: <f15bb2b4-f11e-4e44-959d-11055720d99b@suse.cz>
Date: Fri, 9 Oct 2026 12:44:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Don't track pressure if policy->max equals top
 of freq_table
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Huang Rui <ray.huang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Pierre Gondois <pierre.gondois@arm.com>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009082928.21847-1-ggherdovich@suse.cz>
 <32a250e5-0c56-43ce-ab80-8c4375542b59@arm.com>
Content-Language: en-US
From: Giovanni Gherdovich <ggherdovich@suse.cz>
In-Reply-To: <32a250e5-0c56-43ce-ab80-8c4375542b59@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=Unknown lua;
	unknown reason
X-Spamd-Result: default: False [0.00 / 50.00]
X-Spam-Score: 0.00

On Fri Oct 9, 2026 11:40, Christian Loehle wrote:
> On 10/9/26 09:29, Giovanni Gherdovich wrote:
>> The acpi-cpufreq driver stores non-boost frequencies in
>> policy->freq_table, but policy->cpuinfo.max_freq contains the max
>> boost frequency.
>>
>> policy->max is constrained to be, at most, the largest value in
>> freq_table. This means that under nominal conditions, policy->max is
>> substantially lower than policy->cpuinfo.max_freq, resulting in large
>> values of cpufreq_pressure, on all CPUs, for no reason.
> 
> 
> I'm assuming this isn't on top of
> f341dc4d934a ("cpufreq: intel_pstate: Fix max_freq fallback in cpufreq_update_pressure()")
> Care to retry?

Ah! Yes that fixes it.

Pressure is zero on all CPUs under nominal conditions with acpi-cpufreq;
not tracked, as the commit makes it conditional to the driver implementing
.scale_freq.

Thanks Christian for pointing that out.


Giovanni
