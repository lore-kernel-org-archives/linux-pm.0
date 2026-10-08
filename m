Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A8D3D3CFF;
	Thu,  8 Oct 2026 07:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443911; cv=none; b=GjcJsGNuBnC9uFjhTg+UNMydb5j1YSo725ogZGsvI3bhSkWv4NNlez0/XRK1zV2okZweg6UMtpBBjk+Hwd3d9L1hAKfCD/ju/rDqfiNm4bPq/vfVPhmxco6STsCX4f1beXXaj69siWjOXLfgUUQNxP806CfTcV60zQDdhZAaHn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443911; c=relaxed/simple;
	bh=x1Rv4vPNBzDKlppGnW5xG+IrmdjEXR8nQoRzs5+6QPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IuC3crNDn7ZeEIF1SLiQaluOAOIH3QBgalR5n660ZuYpfmFKOYyGF5etBrN79wz65RbXZf/aefKn7Uc5z3R4x6D8qTK8niUebSQIeRklGNmgEDdWvPk72/zZmhw7j4pxeV+FW63ZWfxK2moVN11QWHQz+y65JGUamH7Wjp6bNiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQpH7C+k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXGkB7gz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RQpH7C+k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DXGkB7gz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQpH7C+k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXGkB7gz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RQpH7C+k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DXGkB7gz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A251B1F786;
	Thu,  8 Oct 2026 07:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791443907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qN1yeAVBYWTNINSeZUvzmaT433y7nkZ59785Hvtm7no=;
	b=RQpH7C+kHOIWp1SX8oNnfG+iOd9Z1wf9OwWFEKdrheR4DrCUKIP1HoRsp14Susb3/Rktty
	l+rRndBlMwBHna0XLXyQaryJJBYhA9OLCuKRUxMVvzPl3kf3LlYm+sJEKDkk/sqSMsBk56
	mK9BpoFvNo5WavW5SyA3OVzz3bHnt5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791443907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qN1yeAVBYWTNINSeZUvzmaT433y7nkZ59785Hvtm7no=;
	b=DXGkB7gzLqqBn0SCBwmX+9I+P+lP3BNWkbF7AySAGjBlpxeDbiQs2ysaMVArsLmo/3ocJA
	WuAMlKpzd2iWr2Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1791443907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qN1yeAVBYWTNINSeZUvzmaT433y7nkZ59785Hvtm7no=;
	b=RQpH7C+kHOIWp1SX8oNnfG+iOd9Z1wf9OwWFEKdrheR4DrCUKIP1HoRsp14Susb3/Rktty
	l+rRndBlMwBHna0XLXyQaryJJBYhA9OLCuKRUxMVvzPl3kf3LlYm+sJEKDkk/sqSMsBk56
	mK9BpoFvNo5WavW5SyA3OVzz3bHnt5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1791443907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qN1yeAVBYWTNINSeZUvzmaT433y7nkZ59785Hvtm7no=;
	b=DXGkB7gzLqqBn0SCBwmX+9I+P+lP3BNWkbF7AySAGjBlpxeDbiQs2ysaMVArsLmo/3ocJA
	WuAMlKpzd2iWr2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D54413354;
	Thu,  8 Oct 2026 07:18:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TPsUAcNDx2oXcAAAD6G6ig
	(envelope-from <ggherdovich@suse.cz>); Thu, 08 Oct 2026 07:18:27 +0000
Message-ID: <93ad2855-d876-4df3-a105-f08d93dc7d7d@suse.cz>
Date: Thu, 8 Oct 2026 09:18:26 +0200
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
X-Spam-Score: -4.25
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.25 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.997];
	NEURAL_HAM_SHORT(-0.17)[-0.827];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed Oct 7, 2026 21:45, Mario Limonciello wrote:
> 
> Thanks! Based on the findings from the BIOS update everything in
> this thread should be enough to either make a v2 incorporating
> feedback (mostly making it clearer) or to drop the patch.

The patch can be dropped, as the latest BIOS release fixes the
problem; lowest and nominal freq are present in the ACPI _CPC package,
and amd-pstate loads without issues.

Here a summary for posterity, hardware and working firmware:

   Motherboard: MSI TRX40 PRO WIFI
   CPU: AMD Ryzen Threadripper 3960X
   BIOS Vendor: American Megatrends International
   BIOS Version: 2.94
   BIOS Release Date: 06/15/2026


Thanks,
Giovanni
