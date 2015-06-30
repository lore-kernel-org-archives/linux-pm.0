From: Pavel Machek <pavel@ucw.cz>
Subject: Re: da2bc1b9db3351addd293e5b82757efe1f77ed1d breaks hibernation was
 Re: 4.1-rc7, thinkpad X60: platform mode hibernation does very wrongthing
Date: Tue, 30 Jun 2015 11:44:55 +0200
Message-ID: <20150630094455.GA11558@amd>
References: <20150617121352.GA20553@amd>
 <7336539.OpACL0uN6J@vostro.rjw.lan>
 <20150617123333.GA21389@amd>
 <2490787.R6LzZId8tR@vostro.rjw.lan>
 <20150617131608.GA24030@amd>
 <1434549754.2400.5.camel@x220>
 <20150617151800.GA12312@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:56586 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751600AbbF3Jo6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 05:44:58 -0400
Content-Disposition: inline
In-Reply-To: <20150617151800.GA12312@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>, imre.deak@intel.com, ville.syrjala@linux.intel.com, daniel.vetter@ffwll.ch, Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linus <linus_torvalds@foxmail.com>, lenb <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>

Hi!

> > And this all reminded me of https://lkml.org/lkml/2015/3/18/133 . So I
> > think that's another system not covered by commit ab3be73fa7b4
> > ("drm/i915: gen4: work around hang during hibernation").
> 
> Yes, another system broken by
> 
> commit da2bc1b9db3351addd293e5b82757efe1f77ed1d
> Author: Imre Deak <imre.deak@intel.com>
> Date:   Thu Oct 23 19:23:26 2014 +0300

Imre, your patch already broken 3 machines, and now we discovered it
breakes another. Can you please revert it before it causes more
damage?

Thanks,
									Pavel


>     drm/i915: add poweroff_late handler
> 
>     The suspend_late handler saves some registers and powers off the
>     device,
>         so it doesn't have a big overhead. Calling it at S4
>     poweroff_late time
>         makes the power off handling identical to the S3 suspend and
>     S4 freeze
>         handling, so do this for consistency.
> 	
> 
> And no, adding another system to the "blacklist" is a not good idea,
> because we know there are other broken systems out there. Can we
> revert da2bc1b9db3351addd293e5b82757efe1f77ed1d, please? Consistency
> is nice, but not having regressions is even nicer.
> 									Pavel
> 									
> PS: Now I have real Linus and fake Linus on the Cc list. Or maybe two
> real Linuses, its hard to tell.
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
