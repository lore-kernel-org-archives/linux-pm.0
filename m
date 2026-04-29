Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED9B1A9FBC
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777456285; cv=none; b=sVSu4PWSvs97fzKkL3rKgo6VxP2h8EvDrKKUyWfs6jbYV/UtBr+/T7paS36jzCRGcGv4ETitL7nf/fAP9ZgjZSsHXtbckCL4sTSWm/qHfPsW0XzlngXdkF++F04nr9hshDNiNZUqbSwGKxZM8PHF5WUhyiqOH/Q4+jugbMdoWn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777456285; c=relaxed/simple;
	bh=iQ5IhtZgLm+rkc5eoGm9hIH3ZDzmZomFvTPndZ9kpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kWJdZkMqfphxVvw/6uS/QQsI0HCAqmq9xo0u1NoRkmrQa1SlFzIB61Lhno+E0IllGNp7RHRzQ1//iwoBSe7sNEv4LncSBk5/S/f12+mHjfGLSH1ciQQVBt/aeokdseeJmBpt/4s0tAG5M1cO9KjM2yTu+Lr7QgJ6ttvYDQVEE0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nd+Z1WXr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z5o48gII; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nd+Z1WXr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z5o48gII; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nd+Z1WXr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5o48gII";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nd+Z1WXr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z5o48gII"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA77D6A864;
	Wed, 29 Apr 2026 09:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777456275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=nd+Z1WXrdftM/Yws3FDBOCRnKHWOyFxJw6AaWYqAMH5amNzr/ZKJB40b1la0nLZei9904h
	8Ep88nHZrFt8zhFwmqG56ubiYExFVzoaT2KbMuXRXcYml4Ji9bkVQY/YgkUyTU8/i6i1yu
	ZnH2nAZfNQrhUlN4+AyaGqTlJ84j+Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777456275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=Z5o48gIIf+6soxhr8c++2NokHAz+Aou0gFlzFBNzRRipMfgL7/VPRfk+1C3+PtQV2VDjhA
	WDFMjwV8iDrtJDDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777456275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=nd+Z1WXrdftM/Yws3FDBOCRnKHWOyFxJw6AaWYqAMH5amNzr/ZKJB40b1la0nLZei9904h
	8Ep88nHZrFt8zhFwmqG56ubiYExFVzoaT2KbMuXRXcYml4Ji9bkVQY/YgkUyTU8/i6i1yu
	ZnH2nAZfNQrhUlN4+AyaGqTlJ84j+Ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777456275;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+qEjuQevZqyO6CweEJ3yMgcImI5q9b4HueNFxukrWBY=;
	b=Z5o48gIIf+6soxhr8c++2NokHAz+Aou0gFlzFBNzRRipMfgL7/VPRfk+1C3+PtQV2VDjhA
	WDFMjwV8iDrtJDDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 95062593B0;
	Wed, 29 Apr 2026 09:51:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CSMLIZPU8WmeSwAAD6G6ig
	(envelope-from <chrubis@suse.cz>); Wed, 29 Apr 2026 09:51:15 +0000
Date: Wed, 29 Apr 2026 11:51:11 +0200
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
Subject: Re: [PATCH v2 1/2] Remove now unsupported power management tests
Message-ID: <afHUjxwBaXNa3dIi@yuki.lan>
References: <20260330090844.79598-1-pvorel@suse.cz>
 <20260330090844.79598-2-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330090844.79598-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi!
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
