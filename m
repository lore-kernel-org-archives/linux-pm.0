From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: da2bc1b9db3351addd293e5b82757efe1f77ed1d breaks hibernation was Re: 4.1-rc7, thinkpad X60: platform mode hibernation does very wrongthing
Date: Tue, 30 Jun 2015 17:29:26 +0200
Message-ID: <10509203.AKVxuCLZm3@vostro.rjw.lan>
References: <20150617121352.GA20553@amd> <20150617151800.GA12312@amd> <20150630094455.GA11558@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49669 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753598AbbF3PDK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Jun 2015 11:03:10 -0400
In-Reply-To: <20150630094455.GA11558@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Paul Bolle <pebolle@tiscali.nl>, imre.deak@intel.com, ville.syrjala@linux.intel.com, daniel.vetter@ffwll.ch, Linus Torvalds <torvalds@linux-foundation.org>, linus <linus_torvalds@foxmail.com>, lenb <lenb@kernel.org>, kernel list <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@vger.kernel.org>

On Tuesday, June 30, 2015 11:44:55 AM Pavel Machek wrote:
> Hi!
> 
> > > And this all reminded me of https://lkml.org/lkml/2015/3/18/133 . So I
> > > think that's another system not covered by commit ab3be73fa7b4
> > > ("drm/i915: gen4: work around hang during hibernation").
> > 
> > Yes, another system broken by
> > 
> > commit da2bc1b9db3351addd293e5b82757efe1f77ed1d
> > Author: Imre Deak <imre.deak@intel.com>
> > Date:   Thu Oct 23 19:23:26 2014 +0300
> 
> Imre, your patch already broken 3 machines, and now we discovered it
> breakes another. Can you please revert it before it causes more
> damage?

It looks like Imre has just sent a fix for that.  Can you please test that one?

Rafael

