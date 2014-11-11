From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v6 00/48] kernel: Add support for power-off handler call
 chain
Date: Tue, 11 Nov 2014 11:17:45 -0800
Message-ID: <20141111191745.GA24918@roeck-us.net>
References: <1415583785-6980-1-git-send-email-linux@roeck-us.net>
 <20141110083347.GA29543@amd>
 <20141111182023.GA21970@roeck-us.net>
 <20141111185019.GA29452@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:56910 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbaKKTRw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Nov 2014 14:17:52 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XoGwq-001rJE-20
	for linux-pm@vger.kernel.org; Tue, 11 Nov 2014 19:17:52 +0000
Content-Disposition: inline
In-Reply-To: <20141111185019.GA29452@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>, Andrew Morton <akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Heiko Stuebner <heiko@sntech.de>, Lee Jones <lee.jones@linaro.org>, Len Brown <len.brown@intel.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Romain Perier <romain.perier@gmail.com>

On Tue, Nov 11, 2014 at 07:50:20PM +0100, Pavel Machek wrote:
> On Tue 2014-11-11 10:20:23, Guenter Roeck wrote:
> > On Mon, Nov 10, 2014 at 09:33:48AM +0100, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > Introduce a system power-off handler call chain to solve the described
> > > > problems.  This call chain is expected to be executed from the architecture
> > > > specific machine_power_off() function.  Drivers providing system power-off
> > > > functionality are expected to register with this call chain.  By using the
> > > > priority field in the notifier block, callers can control power-off
> > > > handler
> > > 
> > > Linus rather disliked the idea of notifier chains for this... And I
> > > don't see how it got addressed.
> > > 
> > Hi all,
> > 
> > After more thought, I concluded that it is technically impossible to support
> > multiple power-off handlers without some kind of list or call chain, no matter
> > how it is called. Given the opposition from Linus and the power maintainers
> > to the series, I decided to shelf it.
> 
> Well, you can still do preparations -- current code directly setting
> pm_power_off is ugly -- so that if you want to switch to call chain
> later, it will be easy.
> 
Yes, it is ugly, but with pretty much everyone who counts opposed to my proposal
for a cleanup I don't really have an idea how to continue. In addition to that,
I did this as a community project in my free time, I don't need it myself,
I already spent way more time on it than I thought it would take, there
is no end in sight, and other things I am working on are significantly
more important for me. At some point one has to cut one's losses.

Guenter
