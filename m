From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Reorder maintainer addresses for PM and
 ACPI
Date: Thu, 20 Mar 2014 02:36:15 -0700
Message-ID: <1395308175.8649.67.camel@joe-AO722>
References: <1744772.yf52reTAmC@vostro.rjw.lan>
	 <1395282105.8649.55.camel@joe-AO722>
	 <CAMuHMdXFkf0g15vY=PkeMgxhr4G2=tWhK+jd8ejiqT0bJVaxQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtprelay0025.hostedemail.com ([216.40.44.25]:45945 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750960AbaCTJgU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Mar 2014 05:36:20 -0400
In-Reply-To: <CAMuHMdXFkf0g15vY=PkeMgxhr4G2=tWhK+jd8ejiqT0bJVaxQQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>

On Thu, 2014-03-20 at 08:58 +0100, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Thu, Mar 20, 2014 at 3:21 AM, Joe Perches <joe@perches.com> wrote:
> >>  SUSPEND TO RAM
> >> +M:   Rafael J. Wysocki <rjw@rjwysocki.net>
> >> -M:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >
> > Please keep the quotes around your name.
> >
> > It makes it easier for some systems to accept
> > names with periods via copy/paste.
> 
> While for "git send-email", it's easier if I don't have to remove the one in
> the middle manually...
> 
> Anyway, scripts/get_maintainer.pl re-adds them.

A lot of people just open MAINTAINERS, root around
for sections of interest, and copy/paste.


