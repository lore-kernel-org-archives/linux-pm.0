From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Date: Sat, 23 Sep 2006 13:18:05 +0200
Message-ID: <20060923111805.GF20778@elf.ucw.cz>
References: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750696AbWIWLSI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200609222034.k8MKYoDK008487@olwen.urbana.css.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: eugeny.mints@gmail.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> Note that I don't think PowerOp would cover all devices. In fact, I
> think most devices would remain autonomous or controlled as part of
> specific subsystems. The only things that PowerOp would bundle together
> would be things that aren't independent (and may not even be visible as
> "devices" in the usual Linux sense), but that have to be managed
> together in changing frequency/voltage. At least, that's the way I
> imagined it would work.

Well, two objections to that

a) current powerop code does not handle 256 CPU machine, because that
would need 256 independend bundles, and powerop has hardcoded "only
one bundle" rule.

b) having some devices controlled by powerop and some by specific
subsystem is indeed ugly. I'd hope powerop would cover all the
devices. (Or maybe cover _no_ devices). Userland should not need to
know if touchscreen is part of SoC or if it happens to be independend
on given machine.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
