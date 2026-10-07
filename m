Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCE3822BF;
	Wed,  7 Oct 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403146; cv=none; b=MR5Szn58Qu/nNw05VgpS0sLZL5HVkH3ntPTFeglUN96IrrkSf1+eYktd42QG0501pWNyT9gtAhucZYlsIBkEwxYkL7zbMFvEIskspEz6oJQMM7cLdxF0kcSn8T3cRWlotRHIuNRl5MpGOx7tMRyBYgBWGy2WEtZ2iM/FiPT5tP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403146; c=relaxed/simple;
	bh=P+s9oV6H3W3E5Qfv8ySUY+MxJRHWcMCI8hUhDmLZ2s8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNYkE/2Mb6vr42N9VSSuCeaCQHpcjVsA09JaaTFmUrlPlHrpMBjhGXjhK181UHBdcO8+i711E4W9YDrCwHitnQUynqwzFedZPir79ZVIRvHVh3jIURy4ZcRPR5vAz0Lr1nYizKyxxWLtYEItXqRQsxBobEc6MJ+FivXFo/wFOyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pkEN6e2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bRM3dOVW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pkEN6e2H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bRM3dOVW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pkEN6e2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bRM3dOVW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pkEN6e2H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bRM3dOVW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 57E1E21BBC;
	Wed,  7 Oct 2026 19:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791403142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj2gQr3IyP85g0rZ+VuBrtNcUQ+KyzMKJVC06qQSsdk=;
	b=pkEN6e2HPoZeqYUAYvGxlu5nUkVcHeSn09ma7tMaxPTILdGXcJxNuRH/L70T3khTYteob/
	gQCvgsj4ylM+RdoyST28bw2FdRHQQJdDQS5yEYI1c3Dv0GafWigcqlyKjyPHA9wJmfnb8r
	LobycT1GqMquw0Z/tmSt9EVIFyyvY/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791403142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj2gQr3IyP85g0rZ+VuBrtNcUQ+KyzMKJVC06qQSsdk=;
	b=bRM3dOVWukwXPE1M7Ez/N93e4hq+//YQCLiJfFimjrjn/1KGEGYMluL34tVK3eFZuDnAHs
	sx8dHjujki0JXVBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pkEN6e2H;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bRM3dOVW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791403142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj2gQr3IyP85g0rZ+VuBrtNcUQ+KyzMKJVC06qQSsdk=;
	b=pkEN6e2HPoZeqYUAYvGxlu5nUkVcHeSn09ma7tMaxPTILdGXcJxNuRH/L70T3khTYteob/
	gQCvgsj4ylM+RdoyST28bw2FdRHQQJdDQS5yEYI1c3Dv0GafWigcqlyKjyPHA9wJmfnb8r
	LobycT1GqMquw0Z/tmSt9EVIFyyvY/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791403142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fj2gQr3IyP85g0rZ+VuBrtNcUQ+KyzMKJVC06qQSsdk=;
	b=bRM3dOVWukwXPE1M7Ez/N93e4hq+//YQCLiJfFimjrjn/1KGEGYMluL34tVK3eFZuDnAHs
	sx8dHjujki0JXVBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA51413312;
	Wed,  7 Oct 2026 19:59:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l3swJ4WkxmpTLwAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Wed, 07 Oct 2026 19:59:01 +0000
Message-ID: <ed52d799-078c-4148-b7df-0413f2d65694@suse.cz>
Date: Wed, 7 Oct 2026 21:59:01 +0200
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
 <93531c5c-5638-4a20-919a-8471a7222218@suse.cz>
 <ab7921dd-1a28-4df4-a4a8-718e1489ec33@amd.com>
Content-Language: en-US
From: Giovanni Gherdovich <ggherdovich@suse.cz>
In-Reply-To: <ab7921dd-1a28-4df4-a4a8-718e1489ec33@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.49 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.19)[-0.964];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Score: -4.49
X-Spam-Level: 
X-Rspamd-Queue-Id: 57E1E21BBC

On Wed Oct 7, 2026 21:45, Mario Limonciello wrote:
> On 10/7/26 14:38, Giovanni Gherdovich wrote:
>> On Wed Oct 7, 2026 16:56, Mario Limonciello wrote:
>>> [...]
>>> I don't understand why core count matters though.
>>
>> My thinking was:
>>
>> 1. I want to make the "quirk" to match as many chips as possible, to
>>     make it more useful and worthwhile.
>> 2. The doc I have, "Power and Thermal Data Sheet" (publication #56736
>>     in the AMD doc library), is for family 0x17, models 0x30-0x3F
>>     processors.
>> 3. Problem: these have different nominal frequencies, depending on the
>>     core count. Specifically:
>>     24 cores: 3800 MHz (like the Ryzen 3090x I need)
>>     32 cores: 3700 Mhz
>>     64 cores: 2900 MHz
>> 4. Thus I decided to match for family 0x17, model 0x30-0x3f, 24 cores.
>>     Without the core count constraint, I couldn't tell which of the
>>     three nominal frequencies above should apply.
> 
> If there does need to be a quirk I guess I would actually say there
> should be 3 quirks then. One for each core count version.

Makes sense.

>> All that said, I've asked the openSUSE user to test the newer BIOS,
>> we'll see what that gives.
> 
> Thanks!  Based on the findings from the BIOS update everything in
> this thread should be enough to either make a v2 incorporating
> feedback (mostly making it clearer) or to drop the patch.

Yes I think so. Thanks a lot for your support so far.


Giovanni
