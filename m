Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECC3347FE1
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456302; cv=none; b=iwbWbRv4v+NwBv+N1XIQkI4WLqXFnfk/SYEzDGszTKr3fzQFX7K+7aISf8RfNDAj3QFO4vBbGSWRKYjbVhGwvRTT2QiyBTwwbDdG8HkCTj/fXTcqXG+2/BQXAMxs718EIkJCdfFO0noZfJGYfDFai8E65loLPrF8d7S9hDSPD6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456302; c=relaxed/simple;
	bh=vuv4cZ4+Kij/ayHslR63EpSTdYs3ewYXv8NaV9BSR8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vej3TJQItIxeQIbCKk/x96xLnAD7/FsKKgm0kDPwQyLWDz6qcrD2QaF0ohP6SZ4H5BZ4LTiTWer076KeddQsvq5xcXPoJqKnuxnrqBzL9gTxDCGBssedvlWrBZI3OzM+qpIfc9YT9FvIeX9Cs5W75Rs5FGEf6jOF7Wmwb34bDTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h8HmsH4T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gWm+wQAZ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h8HmsH4T; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gWm+wQAZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h8HmsH4T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gWm+wQAZ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h8HmsH4T";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gWm+wQAZ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52FC55BD0C;
	Wed, 29 Apr 2026 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777456299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrneAhWHWoB9/4QqFD1WcX1CW3YqIVAAvz4XfZEvDso=;
	b=h8HmsH4Tgo3g13gp6hS+9AShVrp/tAmjE0vtf7PwBfQsRxhIOvvrRftXHfdOSAYB1jJkOL
	qKkb+pBJhfgYiKTIw8hbU2zcptEC3OJxHvxMj4Pi5uFCT9pY/+Ynq9AFqZtUYkcBbPj9cW
	cn66JUjkbju81iS1EPWDkf4d10N9wFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777456299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrneAhWHWoB9/4QqFD1WcX1CW3YqIVAAvz4XfZEvDso=;
	b=gWm+wQAZXEIohBDXUl1hOHLX9LvclbYyEy0Pv/DJ2sig0AKGrSw9l26M2kAoYLOs4yF6D9
	7cDjT1nh00rblDDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h8HmsH4T;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gWm+wQAZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777456299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrneAhWHWoB9/4QqFD1WcX1CW3YqIVAAvz4XfZEvDso=;
	b=h8HmsH4Tgo3g13gp6hS+9AShVrp/tAmjE0vtf7PwBfQsRxhIOvvrRftXHfdOSAYB1jJkOL
	qKkb+pBJhfgYiKTIw8hbU2zcptEC3OJxHvxMj4Pi5uFCT9pY/+Ynq9AFqZtUYkcBbPj9cW
	cn66JUjkbju81iS1EPWDkf4d10N9wFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777456299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TrneAhWHWoB9/4QqFD1WcX1CW3YqIVAAvz4XfZEvDso=;
	b=gWm+wQAZXEIohBDXUl1hOHLX9LvclbYyEy0Pv/DJ2sig0AKGrSw9l26M2kAoYLOs4yF6D9
	7cDjT1nh00rblDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42CAA593B0;
	Wed, 29 Apr 2026 09:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1FYTD6vU8WkgTAAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 29 Apr 2026 09:51:39 +0000
Date: Wed, 29 Apr 2026 11:51:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
	Jan Stancek <jstancek@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org, helena.anna.dubel@intel.com,
	tomasz.ossowski@intel.com, Piotr Kubaj <piotr.kubaj@intel.com>,
	automated-testing@lists.yoctoproject.org
Subject: Re: [PATCH v2 2/2] power_management: Remove unused tools
Message-ID: <afHUq-kKGs7JpYMN@yuki.lan>
References: <20260330090844.79598-1-pvorel@suse.cz>
 <20260330090844.79598-3-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330090844.79598-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,yuki.lan:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 52FC55BD0C

Hi!

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
