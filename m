From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] MAINTAINERS: Reorder maintainer addresses for PM and ACPI
Date: Thu, 20 Mar 2014 03:47:51 +0100
Message-ID: <2462139.FluJI6yiK7@vostro.rjw.lan>
References: <1744772.yf52reTAmC@vostro.rjw.lan> <1395282105.8649.55.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58807 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750740AbaCTCcU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Mar 2014 22:32:20 -0400
In-Reply-To: <1395282105.8649.55.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Wednesday, March 19, 2014 07:21:45 PM Joe Perches wrote:
> On Thu, 2014-03-20 at 00:00 +0100, Rafael J. Wysocki wrote:
> 
> > Reorder PM and ACPI maintainer addresses in MAINTAINERS to make
> > the probability of that a bit smaller.
> 
> >  FREEZER
> > +M:	Rafael J. Wysocki <rjw@rjwysocki.net>
> > -M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
> []
> >  HIBERNATION (aka Software Suspend, aka swsusp)
> > +M:	Rafael J. Wysocki <rjw@rjwysocki.net>
> > -M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
> []
> >  SUSPEND TO RAM
> > +M:	Rafael J. Wysocki <rjw@rjwysocki.net>
> > -M:	"Rafael J. Wysocki" <rjw@rjwysocki.net>
> 
> Please keep the quotes around your name.
> 
> It makes it easier for some systems to accept
> names with periods via copy/paste.

I can do that, but the quotes aren't there everywhere anyway.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
