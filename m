Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3959F2D949F
	for <linux-pm@vger.kernel.org>; Sun,  7 Jun 2026 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865226; cv=none; b=HjaiJ6qXnWDuDnBfYO+oV0diTIsVQBMWQNsVuS0UPMAx0eaIMlzaETIYHaOl1tg/oTTPHWztuHMSU/HvHyX4WiS9fEfkvO0X9AUiubDndxSqOMouZge8Ta+mt0TGOMxQFKcbJo5letobEpzCVe46RA0LhbZtryW5BfvikAyAzHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865226; c=relaxed/simple;
	bh=ad1hq5JNhLtXzY7IPHT3fS14o1GnWbOaJ778Mf40PiI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jVkujmitZ8om6SkIgthPvJpKAh3EI+RHRLf0FWHZPHfgNROK7+SJbIEX0sUQS1cHiF+d0Mqcup1BjOY2t8ueBwWKeeTUxwY10zJaAM/EE9nOUaiEwkIvqmeZU6AIrF2R1Mt/SLAVnee99tcobxCNri/wezcNK/MYUXQ4zZJQS5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMDQzDnE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMDQzDnE"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b12270b3so21660615e9.1
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780865223; x=1781470023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0fGqOLKGiTBs4GzJtJROxaA/ChE132hfn8KfuQAtzY=;
        b=RMDQzDnEMZPtO7WHex3XB+RyYhJo/U6JTe0NPjDhCcVPJR1x2QVYMCJg42YlITmpQv
         SemgIA9DEidSFpMOLygDC0fi2rDagksRwddSjC1HPDisPvRl1WS1HZRk4PgHQenOOTpP
         +PL5WNVyal5Bya6NXih9QsH+a4hO1sHsqjs7hGN19KazA734abQx7Qs39woN8w0uAfSC
         JEwgo8gRZUdYc9blRwsos4xtUfy/HOVqU4JMgbsAm/ZyXgyC+CCK6sBtEWd35YNsKr7p
         4Evy4ejoNlHObTglzI8LGJBXyuolEn1bBNq3aYRbrSosE5iTLkvn8XKsej7Oi+K584Mc
         8/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780865223; x=1781470023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0fGqOLKGiTBs4GzJtJROxaA/ChE132hfn8KfuQAtzY=;
        b=aLI4K1E0lRKs+gohyd9FxKruqNzsqCRMNgIXoDtVGb42euCFWATqObkBwFqprNrlaN
         4MWyORf061QWi9HBXQUBXxqaHcFhAj7cV9P5CwA8Gei2phblmHAJk5EzFQWBaogxOlt8
         71vO7tJDgfbO4vk6Dn2mMrrh4x57r9Kp9iAz2JjSxhgVG+KmBF44evEcd1tYoO3AD0tA
         iBRwmpBqJr4AbFOHyo1r8MJQV+88W2knZIQ4aVHVs2u1lP6zZagNwIVgBtA8ANdqZFst
         gPGY2WDhcXqKmHfmvB7ZICLNjmkeZAruzPuBMJAmPB0EkHF0qp3AG+6lb7P557QCblEB
         WUNw==
X-Forwarded-Encrypted: i=1; AFNElJ9SrlX6RSOtidoS3+1u61R11z4qOJRvVjHsVauNlr6D2rj10HDWvgRZj0RCLKyZ+iFKarykKCsTiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9fGpdHP11WJivCauNuPldZiCih5cRL+LNGYi+Fb0i/dGM8OoR
	eSZOQbuSeXfMdFmxrA/bsmS0tQRhjn7nteSy4WxQ/57JTbPJG905ODof
X-Gm-Gg: Acq92OEvQb9exLMkQa01Thr4kl7+8i7jxC5fdmug8TV78K2epUijY0pMue5/6cTj+aw
	seLE8Trk1/W3F/AY22XkBBKsU9mUYewSsAnlbuaYiSAGGfsd9eatRGRKKBhZ1spqjyUh5lHQx/Q
	rlV2C7xKgpv5nmAb1p/VRzgwnCVF7lpaCVnokBS9scS9XbvijI1ocbuZdsJPCLRtQWi5TXJa7nI
	osJxYMg/q0yscK8RWJDcN0InXbn+g6t1nHfTenhSY+E7RELAbreBsRqs3sUhlfdeaRDzmr/IoZ/
	xowB6XcD78eoSYAJhN1SHcuBnnbt3XKbHA2a3mQZxkevqOLdpP/9vWrX5rJxYOv/b0Yx2NkXG7C
	ZfM6YpcwglCvhkL1kNk3kH3CmDwcSDBmQkhSB1hmgYN30FpaPRLwwOW+WeljzXNtfSitzX3Azu7
	fGedK+CYSgwfIjpcZoZ2wqjNStHNbmIvyYsxOMq2EDwFVMqxn5LcGNxZFqGBVWnCYjfLoV39w=
X-Received: by 2002:a05:600c:620f:b0:490:5074:651e with SMTP id 5b1f17b1804b1-490c2612cb7mr187071515e9.25.1780865222444;
        Sun, 07 Jun 2026 13:47:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2c9ebeesm182835285e9.0.2026.06.07.13.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 13:47:02 -0700 (PDT)
Date: Sun, 7 Jun 2026 21:47:00 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: testing: Avoid NULL pointer dereference on
 missing arg
Message-ID: <20260607214700.5c5e88b6@pumpkin>
In-Reply-To: <aiXMoaYaRlTsMwqd@gurudas.dev>
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
	<aiTdAQ6uCuFenv7N@shakti>
	<20260607122318.40696a11@pumpkin>
	<aiXMoaYaRlTsMwqd@gurudas.dev>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 7 Jun 2026 12:55:13 -0700
Guru Das Srinagesh <linux@gurudas.dev> wrote:

> On Sun, Jun 07, 2026 at 12:23:18PM +0100, David Laight wrote:
> > On Sat, 6 Jun 2026 19:52:49 -0700
> > Guru Das Srinagesh <linux@gurudas.dev> wrote:
> >   
> > > On Sun, Jun 07, 2026 at 12:04:18AM +0300, Ovidiu Panait wrote:
> > > [...]  
> > > > To fix this, make arg an empty string instead of leaving it NULL when the
> > > > separator is missing. sscanf() then fails correctly with -EINVAL on it.    
> > > [...]  
> > > > ---
> > > >  drivers/thermal/testing/command.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
> > > > index 1159ecea57e7..5513a26feed7 100644
> > > > --- a/drivers/thermal/testing/command.c
> > > > +++ b/drivers/thermal/testing/command.c
> > > > @@ -150,6 +150,8 @@ static ssize_t tt_command_process(char *s)
> > > >  	if (arg) {
> > > >  		*arg = '\0';
> > > >  		arg++;
> > > > +	} else {
> > > > +		arg = s + strlen(s);
> > > >  	}    
> > > 
> > > Here, `arg` is made to point to the NUL terminator of s. Couldn't this be simplified to:
> > > 
> > > 	arg = "";
> > > 
> > > to make the intent clearer? Since `tt_command_exec()` takes in arg as `const char *`,
> > > pointing `arg` to a string literal is fine.
> > >   
> > 
> > Except that 'arg' itself must be 'char *' otherwise the '*arg = 0'
> > higher up will fail.  
> 
> Sorry, could you please clarify the concern further?
> 
> `arg` is already `char *` (line 144), and I verified that my suggestion compiles fine.

But "" is 'const char *'.
Which is usually a compile error.
Unless the kernel is compiled with some permissive compilation options...

-- David


