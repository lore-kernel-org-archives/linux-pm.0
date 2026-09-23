Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5351B44682F;
	Wed, 23 Sep 2026 11:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790162682; cv=none; b=bCJI1QLGfIsrG9vYcveOYQ9yqMD72hGt++N/VDxR/hmpe25WGSxkXc7DhDDZFt7mlFa89PS1WVRJY7jsKJU0hvH8Wa0ovFzNLNhDyBEX+FDQem2+39QEFAHQ8xRdt/ACLA3fvcNLit5BtOlZ2hxUzINkqLPmpjGFqyMFYUBAssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790162682; c=relaxed/simple;
	bh=R5oxb6m8WVWtkbZescvvGACC4Cc94mbIk9mwEjBCDME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S9vhUsWGVbNTKK81yKlDKFZ7/3SWS7Xfch32/aTEF9CX4dVICa9jvLvCp1SalAUXCzkJZZ8TftM6E7LfNycMxNP2WTQ3DVctJccwdcLQ2i+YFXEBJWp8R/IuLSfw7QRyAvcWQCjkwbu7gQM0HU0vYs9JZpaTKPsUKoLFudSOXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ng7rNtrw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Yoov0oZK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qmi1Mseu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RO07Z1AT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ng7rNtrw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Yoov0oZK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qmi1Mseu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RO07Z1AT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC9EE21960;
	Wed, 23 Sep 2026 11:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790162673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fk49lFwz7XQifz8uGeQXDLmbUiEK2SXoI4A3bPMHcPk=;
	b=ng7rNtrwBhc3uWMCg6wiqeSXRE2zwTF53KoRG1Lh3JbAzOVTNHKUVC/TgstkgmxqxyIzO9
	xNsvnS5K0NvFIXO2BHjrcykmE0mYMOse0hf9f1wAbHcciq4dwyS0NhuVL6LpxXp5PlJLYH
	JCj6iJd3pwta6BxDU2mK3rSXwu/BHsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790162673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fk49lFwz7XQifz8uGeQXDLmbUiEK2SXoI4A3bPMHcPk=;
	b=Yoov0oZKwLMmrVmcrmQBI51vL0DeVCD/H997UfXxImVWFuArq0/VmR3R4I7jGbWKdNZUGE
	+7noRe3cJaGtbrDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qmi1Mseu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RO07Z1AT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790162669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fk49lFwz7XQifz8uGeQXDLmbUiEK2SXoI4A3bPMHcPk=;
	b=qmi1MseuDQvyNPhzO89e7wSxCXAqruJgi999LPxStDIwLEvoMUBay4ZbBwyin0AjxuLw5K
	tgpkBqe+KaJ3Zu7FodM5EPHzyYCixLs5R8WE9bMYhtCOvUflO1y5Z06jQoSQ2nKtcM6ReT
	zZ615XMJ0uEh3f5aZEnYEI6QexybvwA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790162669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fk49lFwz7XQifz8uGeQXDLmbUiEK2SXoI4A3bPMHcPk=;
	b=RO07Z1ATRD45EhD+8KK5vDq26oa5RtXyaeYeNkplGS4/y1NCs1kZrORrvZPF0BiDgqiPjs
	uxhc0rhKU+LtzPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9404B13432;
	Wed, 23 Sep 2026 11:24:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HBrGG+22s2qZGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Sep 2026 11:24:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39444A13D4; Wed, 23 Sep 2026 13:24:25 +0200 (CEST)
Date: Wed, 23 Sep 2026 13:24:25 +0200
From: Jan Kara <jack@suse.cz>
To: Sadrul Chowdhury <sadrul@google.com>
Cc: linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, linux-pm@vger.kernel.org, John Stultz <jstultz@google.com>
Subject: Re: [PATCH 1/2] fs/epoll: mark epoll_wait tasks TASK_FREEZABLE
Message-ID: <sqmmgjre63ltp2m6y5ui35hijnnwfljnzjscceunvzmzd5rh6i@us2amzhvtkw7>
References: <20260922211559.3633398-1-sadrul@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922211559.3633398-1-sadrul@google.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: BC9EE21960
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO

On Tue 22-09-26 21:15:58, Sadrul Chowdhury wrote:
> During system suspend (freeze_processes) and resume (thaw_processes),
> threads blocked in epoll_wait() sleep in TASK_INTERRUPTIBLE. When
> try_to_freeze_tasks() executes, it must wake up every sleeping thread
> with a synthetic signal so the thread can schedule, run try_to_freeze(),
> enter TASK_FROZEN, and sleep again. Upon resume, the freezer wakes them
> all up simultaneously, only for each thread to re-enter ep_poll(),
> observe no ready I/O events, and call schedule() to go back to sleep.
> 
> On systems with numerous event-driven daemons (where hundreds of
> threads idle in event loops), this causes a large wakeup stampede and
> thousands of redundant context switches per suspend/resume cycle.
> 
> An earlier attempt to make epoll_wait() freezable in commit 1c441e921201
> ("epoll: use freezable blocking call") was reverted in commit
> c511851de162 ("Revert "epoll: use freezable blocking call"") due to
> reports of userspace corruption (Bugzilla #61781). Under the legacy
> freezer design, freezable tasks could wake up prematurely while
> hardware and peripheral drivers were still suspended.
> 
> With the 2022 core freezer rewrite (commit f5d39b020809 ("freezer,sched:
> Rewrite core freezer logic")), the legacy fake-signal mechanism was
> replaced with the TASK_FROZEN state. Tasks sleeping in TASK_FREEZABLE
> are safely frozen in-place without waking them up, and the scheduler
> guarantees they cannot be woken until thaw_processes() explicitly clears
> the frozen state.
> 
> Mark sleeping tasks in ep_poll() as TASK_FREEZABLE. Benchmarks on an
> ARM64 test device demonstrate that combining this with freezable
> select/poll reduces thaw latency by 63% (from 20.64 ms down to 7.55 ms
> mean at fixed CPU frequency) and reduces context switches during
> freeze/thaw by 87%.
> 
> Signed-off-by: Sadrul Chowdhury <sadrul@google.com>

With similar caveat as on patch 2/2 feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/eventpoll.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index 6cbef8b4c2e0..35992f6457bf 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -39,6 +39,7 @@
>  #include <linux/rculist.h>
>  #include <linux/capability.h>
>  #include <net/busy_poll.h>
> +#include <linux/freezer.h>
>  
>  #include <trace/hooks/fs.h>
>  
> @@ -1987,7 +1988,7 @@ static int ep_poll(struct eventpoll *ep, struct epoll_event __user *events,
>  		 * the same lock on wakeup ep_poll_callback() side, so it
>  		 * is safe to avoid an explicit barrier.
>  		 */
> -		__set_current_state(TASK_INTERRUPTIBLE);
> +		__set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
>  
>  		/*
>  		 * Do the final check under the lock. ep_start/done_scan()
> -- 
> 2.55.0.1082.g2b9226bbc0-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
