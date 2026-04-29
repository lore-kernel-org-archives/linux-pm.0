Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401CB3E51FD
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459417; cv=none; b=bLvoEgGYOg0peGZlreCdZYUpI8H9UUZksT/lm3XEBXtopf9pOHmEhYcAkNf3C/mS9RwedRhbIm+jlaVu/KGPu/QmD9lLLyfXCDZ9PBX5SefsiRNZs+ecssYDoimjqB+SrrAhGPFd6fi5GDTw3KDSjTdgjUAzx91+WJB2PoZf+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459417; c=relaxed/simple;
	bh=QOQ9nDZeeJCtvZOTa/sGOjY9MpBV9tn2sOh8//LodDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnePMgJOuApRovFmPMvQ26m0T4XPyKz1YgRjuWGz+b6LYMOHVF1d7b/8O1CdmvTctSVQMMeK7er50scky+lKrSbftZfJgXJs3VZBKXRaGod9hI+8r1laL9XCbRyJLev8Ydlzm7vz3XD2PDLoUrczJoY0Jd0fnH5jWe3+0v5+lDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F5666A864;
	Wed, 29 Apr 2026 10:43:34 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C958593B0;
	Wed, 29 Apr 2026 10:43:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AWBrDdbg8WmjAQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 29 Apr 2026 10:43:34 +0000
Date: Wed, 29 Apr 2026 12:43:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
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
Message-ID: <20260429104332.GA981510@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260330090844.79598-1-pvorel@suse.cz>
 <20260330090844.79598-2-pvorel@suse.cz>
 <afHUjxwBaXNa3dIi@yuki.lan>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afHUjxwBaXNa3dIi@yuki.lan>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 9F5666A864
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

Hi Cyril,

whole patchset merged, thanks for having a look.

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
FYI this is your original commit, therefore I did not add your RBT (it's your
original commit).

Kind regards, Petr
