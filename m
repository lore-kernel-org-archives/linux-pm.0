Received: from out-12.smtp.spacemail.com (out-12.smtp.spacemail.com [198.54.127.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C4A1F7575;
	Sun,  7 Jun 2026 20:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780862703; cv=none; b=QQm5Z0lJ/Qc2qY/eY5sHQ8OzZNs8O+0SjTwJLFyhzlwhfaE/gk9pxK5pAIBbWoB8njiw5fSzlivp2pkGuYwEj5lF9E1+L3hNonfWXK5ZMyfQdpPr2blN3VPj8h49xYfSdbi8Nro7fuNQZttcpDAHrGxZCQp9147pNWgDDKviB8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780862703; c=relaxed/simple;
	bh=9otd83bczCuqnHUpkJD863o36R3dRZvYBrvvPQIE0ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDWR4GFBkIPdIWrQUEZxTGUcfvIv4axXhUS1HTrVHLulZyush+QRplWwqfjQ75t9sv5af/eizuYXLSy8KpVGZQezB344caeWqlAV1EFoK3Ggpl1hcww/Gw4WQelQ9hpcPY9ltOKLv+IU6ZyuG5SCuYPuw3B4m2K6hpqtxEgYmuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev; spf=pass smtp.mailfrom=gurudas.dev; dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b=nCY1bkPq; arc=none smtp.client-ip=198.54.127.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gurudas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gurudas.dev header.i=@gurudas.dev header.b="nCY1bkPq"
Received: from gurudas.dev (107-194-158-19.lightspeed.sntcca.sbcglobal.net [107.194.158.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4gYQrM3K8hz6tkK;
	Sun, 07 Jun 2026 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gurudas.dev;
	s=spacemail; t=1780862115;
	bh=DrsGYE3UP5YicSpCe02vZjCljBAMJPS9dm2zYfuSQFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCY1bkPqYwCraH1anlH6VmbyxpJO/AA8645j0lWGur6Ex+XHkOPFsB4INFUIkgZdK
	 tm6qxVcNRa3NttyUoR7arBSVB5jhlNfUuMqpokKaRHSkyw2qpnmIa0/nfPc5TcMqPH
	 /iL85QQKfH6yHvbdYrKZUHdv9nDc2cMM/jc8K/8kRO7Wr90q16f4Gy78sZj9XTOpvs
	 IN2hQZpdzo+bTPw2+7Bmm5yZuUfXlJ/7+qPLKQqsuHpyzYlSWU6/ogHFy1W3Qp5E/k
	 aaenr0Vn1KdEWneZr89zuL2SSVGYhk68RplVmUFxa3LZAj7yiakweNVN5O7X4/mA2M
	 2KUbWS9pMwrWw==
Date: Sun, 7 Jun 2026 12:55:13 -0700
From: Guru Das Srinagesh <linux@gurudas.dev>
To: David Laight <david.laight.linux@gmail.com>
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>, rafael@kernel.org,
	daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: testing: Avoid NULL pointer dereference on
 missing arg
Message-ID: <aiXMoaYaRlTsMwqd@gurudas.dev>
Mail-Followup-To: David Laight <david.laight.linux@gmail.com>,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>, rafael@kernel.org,
	daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
 <aiTdAQ6uCuFenv7N@shakti>
 <20260607122318.40696a11@pumpkin>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607122318.40696a11@pumpkin>
X-Envelope-From: linux@gurudas.dev

On Sun, Jun 07, 2026 at 12:23:18PM +0100, David Laight wrote:
> On Sat, 6 Jun 2026 19:52:49 -0700
> Guru Das Srinagesh <linux@gurudas.dev> wrote:
> 
> > On Sun, Jun 07, 2026 at 12:04:18AM +0300, Ovidiu Panait wrote:
> > [...]
> > > To fix this, make arg an empty string instead of leaving it NULL when the
> > > separator is missing. sscanf() then fails correctly with -EINVAL on it.  
> > [...]
> > > ---
> > >  drivers/thermal/testing/command.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
> > > index 1159ecea57e7..5513a26feed7 100644
> > > --- a/drivers/thermal/testing/command.c
> > > +++ b/drivers/thermal/testing/command.c
> > > @@ -150,6 +150,8 @@ static ssize_t tt_command_process(char *s)
> > >  	if (arg) {
> > >  		*arg = '\0';
> > >  		arg++;
> > > +	} else {
> > > +		arg = s + strlen(s);
> > >  	}  
> > 
> > Here, `arg` is made to point to the NUL terminator of s. Couldn't this be simplified to:
> > 
> > 	arg = "";
> > 
> > to make the intent clearer? Since `tt_command_exec()` takes in arg as `const char *`,
> > pointing `arg` to a string literal is fine.
> > 
> 
> Except that 'arg' itself must be 'char *' otherwise the '*arg = 0'
> higher up will fail.

Sorry, could you please clarify the concern further?

`arg` is already `char *` (line 144), and I verified that my suggestion compiles fine.
