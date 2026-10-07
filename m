Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365FA3C3434;
	Wed,  7 Oct 2026 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791366336; cv=none; b=jV4qg1PxKb3gCjAo24Q4m/mXvVLymASc2CEA0Kw/bFJj7IwflWxgOsF07XlNkc8Xe4ZIWEhYHBXLT9xfrzUXq9Kr2qwEIFKohRItv+9VSOvM9wsW/DDvO4w+D7swmWPcefCbMhUhTWGBUqA7/fkLH/u0JaesCqUmmdYE6n0GoFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791366336; c=relaxed/simple;
	bh=ByUQSwsJWoHyq9uu/IQDJP1G0Zc9Q8i+g2a6Yw20yZo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWUwWpwiV6KbOtyMfjJTtPgAl02foVKxMrve/jqTJ8E5Rgjb99JZkJaRJCQRLXgWz7pO3lpl6cus/lSL011zEZui6c6GMlg8a+BxlBW4l42p50OxU/FOLImJHfrV0TgEPqhTErB6FXS5JKAdErHCyO5Akc2qQ6IVe42WC7ek3fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o2zpRl3A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gRAn1EwV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KQc7hxej; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=94cGfY25; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o2zpRl3A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gRAn1EwV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KQc7hxej";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="94cGfY25"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4070C1F7A9;
	Wed,  7 Oct 2026 09:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791366321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuO/uLDoteFZPEDyZY/IsGmDHcFKIieGyLaRS2G1XXA=;
	b=o2zpRl3AkiSG674ITeCtPIxRBAq4uYgtD30zRhrTbHLwr2nX8N2IYTyYXfM6BOzBl3RiPi
	RG+0e0vYa9ztb3qj7b4OTym6f+ulcE3MtACgTRnWVoUu5JnqO/puy7XAFleCkx5/z+NtST
	F5POUR49W6TPcEIoNj5VRk6+8lXF5e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791366321;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuO/uLDoteFZPEDyZY/IsGmDHcFKIieGyLaRS2G1XXA=;
	b=gRAn1EwVJNIK+bLsNgi2zXlt2nQtlqmMR7RD4ekdHqCIVhTd+OGu+R7T4QS1pLe7sL6Ys3
	4ioLrbQgR3XUpWBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KQc7hxej;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=94cGfY25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791366317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuO/uLDoteFZPEDyZY/IsGmDHcFKIieGyLaRS2G1XXA=;
	b=KQc7hxejXx2NLAyOv5VDAUM5NxqDLU86QXGHeMTOUTGDjtvw4kyI0bkrUuDol0vRyZ7SCd
	uhBUZimlEzM+8blv1ClozmvIuZ3YIvcfi7oReN/I/+oaipFutVKSOs2kvfv/OLqWYfxrMK
	rp8D/RtKhNWDC7vLSmUAiUEEjv58wsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791366317;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zuO/uLDoteFZPEDyZY/IsGmDHcFKIieGyLaRS2G1XXA=;
	b=94cGfY25yo+4KM0l72ehky1ycqwNB9pGHSVrp10B5TyvAH4JrW0XbRfNzruP6HPT83qzKC
	z/THw0NKDHsZQtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0414113B95;
	Wed,  7 Oct 2026 09:45:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Jui3NawUxmp2FwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 07 Oct 2026 09:45:17 +0000
Date: Wed, 07 Oct 2026 11:45:08 +0200
Message-ID: <87o6d5ondn.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	linux-pm@vger.kernel.org,
	Ulf Hansson <ulfh@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH 08/13] ALSA: hda: Discard pm_runtime_put_autosuspend() return value
In-Reply-To: <20261006161337.8.Idcada3ae757100bf3a38f7e71bac37f827be06c6@changeid>
References: <20261006231900.3230373-1-briannorris@chromium.org>
	<20261006161337.8.Idcada3ae757100bf3a38f7e71bac37f827be06c6@changeid>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4070C1F7A9
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Level: 

On Wed, 07 Oct 2026 01:13:36 +0200,
Brian Norris wrote:
> 
> snd_hdac_power_down() and snd_hdac_power_down_pm() are defined to return
> an int, but their return values are never used by any caller.
> snd_hdac_power_down() also passes the return value of
> pm_runtime_put_autosuspend() to the caller, which is not very useful.
> 
> Returning an error code from pm_runtime_put_autosuspend() merely means
> that it has not queued up a timer or work item to check whether or not
> the device can be suspended and there are many perfectly valid
> situations in which that can happen, like after writing "on" to the
> device's runtime PM "control" attribute in sysfs for one example.
> 
> Modify snd_hdac_power_down() to discard the pm_runtime_put_autosuspend()
> return value and change the return types of snd_hdac_power_down() and
> snd_hdac_power_down_pm() to void.
> 
> No intentional functional impact.
> 
> This will facilitate a planned change of the
> pm_runtime_put_autosuspend() return type to void in the future, similar
> to commit 3afd8df02433 ("PM: runtime: Change pm_runtime_put() return
> type to void").
> 
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> This patch is independent of the rest of the series, except for the end
> (changing the return type). I expect it can be applied by individual
> maintainers, and we pick up the end once the dust is settled.

OK, I applied this one to sound.git tree for-next branch now.


thanks,

Takashi
