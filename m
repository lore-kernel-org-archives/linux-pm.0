From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3][update] PM / sleep: Introduce command line argument for sleep state enumeration
Date: Sat, 14 Jun 2014 00:23:15 +0200
Message-ID: <34237308.7Kff3QYgup@vostro.rjw.lan>
References: <1817539.9KW2IGGbDV@vostro.rjw.lan> <20140613214612.GA25712@amd.pavel.ucw.cz> <3836835.YaZPGXsEQ2@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65472 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751741AbaFMWFr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 Jun 2014 18:05:47 -0400
In-Reply-To: <3836835.YaZPGXsEQ2@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Saturday, June 14, 2014 12:16:26 AM Rafael J. Wysocki wrote:
> On Friday, June 13, 2014 11:46:12 PM Pavel Machek wrote:

[...]

> > > So I'm really not sure what's the problem?  Do you think it's wrong to be
> > > helpful to users or something?
> > 
> > It is not wrong to be helpful, but messed up interface is too big a
> > price.
> 
> Why?  I will have to maintain it after all, right?

And by the way, the very fact that this workaround is even useful in some cases
indicates that the interface that we've invented originally is not particularly
useful to user space.  The reason why is because user space is supposed to
enumerate the sleep states and then present the ones that are present in a
consistent way to the user.  It basically has to do "Is 'mem' present"?  Use it
if so, but if not is 'standby' present?  Use it if so etc." every time or
squirrel that information somewhere which isn't particularly straightforward.

So perhaps we should change the interface entirely?

Rafael

