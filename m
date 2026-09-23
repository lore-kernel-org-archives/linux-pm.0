Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1923BE156;
	Wed, 23 Sep 2026 11:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162656; cv=none; b=HxjE7/KRbBE7Q2QQqA2WiCMUPy5YbDs0gmd9UeE+zYJm0vZA+08IpHOpPfn2rAM5anFWw8xqcUl6RYms2D3KtRl4XqVd5Ea0HWa26Xxlvc+kGA86tlxnr+B+elBQGoz/F2+SFcmgwnkjGwbgR/pV7ZVHgq1Zpi45UlhcXDUMsgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162656; c=relaxed/simple;
	bh=Uam1aAg0TZby4kQQ7Pu91OfFEjng3tPLNmcYKdXWumk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR3qDMV8oBfoIy526Cfz3lYyQDk8Judk7frgBRl/UBzH5CL9VjRP8vdyrJbzMaJDzaPzpHhgq/2Z6OvlkRX3olZhpj4HlTZIpoIvyZjzgQJ+sbSB5l9+n5C8tAQKFaTpIODRumZsaWyxHvfart2IpHNN7IOUXO6PeRScIhcu3mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gdTZGavJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=j9ka2BWP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GCqTsNFb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3kAh+SAf; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gdTZGavJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="j9ka2BWP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GCqTsNFb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3kAh+SAf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B40011FF72;
	Wed, 23 Sep 2026 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790162648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J1fJO3PoUASIoxVEUYPDfzhb5Id5vgFRROctbMSRL8=;
	b=gdTZGavJTIRC7qo/QIG7J1ySPZLwUDic0vfHhL7qWL0dCubWBaRZyp/oa9N6TQO440jYno
	L5wc+Ps8RxDMSDKEdSGPZfr2sgLgDjET+CwkpN3UGd8tBK/SeefQQf6BQRobFGF5/r9fwO
	CmrVDY4TEtcnxWhU73OYnwqdm/5hVhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790162648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J1fJO3PoUASIoxVEUYPDfzhb5Id5vgFRROctbMSRL8=;
	b=j9ka2BWPTBDbuAfUJlAs7e0FIuRF/Y0fg9Op83H/eYnZW3MjydHuzhKV12ezBSpqUh8XPK
	+rXCOmp0BF5aZzDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GCqTsNFb;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3kAh+SAf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790162644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J1fJO3PoUASIoxVEUYPDfzhb5Id5vgFRROctbMSRL8=;
	b=GCqTsNFbDWrCkgrgQEWkoeBn4SWX5gG8CGWCs5kNTdpoAEBA/oPHosBGH1XyqbGkbllKK0
	1kok52OVNao2ZJuMTp9qhfqK43WFvtVmhrNwwx8HtGxSPU9LI7OlNUZ/OuzNZaqLMu6Vrb
	/CZu7FJNWLY65dEPAXjXHYg4wZUJMJc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790162644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8J1fJO3PoUASIoxVEUYPDfzhb5Id5vgFRROctbMSRL8=;
	b=3kAh+SAfjqoWesjBriDJ7Rw3sNQymn5v9QtoTLXlZ5v5YUp7hyBYfPah8GQmtSyKPBdFY3
	7rNNBgxaJfZN1TDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A2BB13432;
	Wed, 23 Sep 2026 11:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id i16rGNS2s2pLGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 11:24:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1588CA13D4; Wed, 23 Sep 2026 13:24:00 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:24:00 +0200
From: Jan Kara <jack@suse.cz>
To: Sadrul Chowdhury <sadrul@google.com>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>
Subject: Re: [PATCH 2/2] fs/select: mark select and poll tasks TASK_FREEZABLE
Message-ID: <temfkewrcrvv7cnw7f26m7wl2flmr4n2ytcfqa5hcosuoer54j@mfuovklowkc4>
References: <20260922211559.3633398-1-sadrul@google.com>
 <20260922211559.3633398-2-sadrul@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922211559.3633398-2-sadrul@google.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B40011FF72
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 22-09-26 21:15:59, Sadrul Chowdhury wrote:
> Similar to epoll_wait(), threads sleeping in do_select() and do_poll()
> sleep in TASK_INTERRUPTIBLE via poll_schedule_timeout(). During system
> suspend and resume, these threads are woken up by the freezer solely to
> transition to TASK_FROZEN, and woken again upon thaw only to re-evaluate
> file descriptors with no pending activity and sleep again.
> 
> A previous attempt to make select() and poll() freezable in commit
> 9745cdb36da8 ("select: use freezable blocking call") was reverted in
> commit 59612d187912 ("Revert "select: use freezable blocking call"")
> alongside the epoll revert due to issues caused by the legacy freezer
> architecture.
> 
> Following the freezer overhaul in commit f5d39b020809 ("freezer,sched:
> Rewrite core freezer logic"), tasks in TASK_FREEZABLE are safely frozen
> in-place into TASK_FROZEN without running userspace code or experiencing
> premature wakeups before resume completes.
> 
> Pass TASK_FREEZABLE to poll_schedule_timeout() in do_select() and
> do_poll() (TASK_INTERRUPTIBLE | TASK_FREEZABLE) so that polling threads
> remain asleep undisturbed across suspend/resume cycles.
> 
> Signed-off-by: Sadrul Chowdhury <sadrul@google.com>

I'm by no means system suspend expert but I don't see a reason why this
shouldn't work. So feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/select.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/select.c b/fs/select.c
> index 8943f20e8300..5cbbe86135bc 100644
> --- a/fs/select.c
> +++ b/fs/select.c
> @@ -601,7 +601,7 @@ static noinline_for_stack int do_select(int n, fd_set_bits *fds, struct timespec
>  			to = &expire;
>  		}
>  
> -		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE,
> +		if (!poll_schedule_timeout(&table, TASK_INTERRUPTIBLE | TASK_FREEZABLE,
>  					   to, slack))
>  			timed_out = 1;
>  	}
> @@ -961,7 +961,7 @@ static int do_poll(struct poll_list *list, struct poll_wqueues *wait,
>  			to = &expire;
>  		}
>  
> -		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE, to, slack))
> +		if (!poll_schedule_timeout(wait, TASK_INTERRUPTIBLE | TASK_FREEZABLE, to, slack))
>  			timed_out = 1;
>  	}
>  	return count;
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
