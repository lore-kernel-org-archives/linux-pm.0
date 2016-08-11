From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 3/3] PM / hibernate: Recycle safe pages after image restoration
Date: Thu, 11 Aug 2016 23:23:20 +0200
Message-ID: <3432840.yEuDW8huOO@vostro.rjw.lan>
References: <2260927.OOWMYX738E@vostro.rjw.lan> <2448424.sR3JM3oiG3@vostro.rjw.lan> <20160811210615.GA28618@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:63006 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932301AbcHKVR6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Aug 2016 17:17:58 -0400
In-Reply-To: <20160811210615.GA28618@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thursday, August 11, 2016 11:06:15 PM Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > One of the memory bitmaps used by the hibernation image restoration
> > code is freed after the image has been loaded.
> > 
> > That is not quite efficient, though, because the memory pages used
> > for building that bitmap are known to be safe (ie. they were not
> > used by the image kernel before hibernation) and the arch-specific
> > code finalizing the image restoration may need them.  In that case
> > it needs to allocate those pages again via the memory management
> > subsystem, check if they are really safe again by consulting the
> > other bitmaps and so on.
> > 
> > To avoid that, recycle those pages by putting them into the global
> > list of known safe pages so that they can be given to the arch code
> > right away when necessary.
> 
> Ok, so you are trying to gain speed here? How much is the speedup?

This is more about making it easier to debug than about speed, TBH.

Avoiding bitmap operations and the mm subsystem involvement reduces
complexity and the number of places to look into in case something goes
wrong.

Thanks,
Rafael

