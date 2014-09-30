From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v2 00/11] ARM: shmobile: r8a7740/armadillo800eva legacy
 PM domain support
Date: Tue, 30 Sep 2014 17:13:05 +0900
Message-ID: <20140930081305.GS16823@verge.net.au>
References: <1411661742-4767-1-git-send-email-geert+renesas@glider.be>
 <20140930042047.GA24253@verge.net.au>
 <CAMuHMdUgP6OEt6G4VhHoDncz+17j-bDu7u_pcHM0ETmqsDKOiA@mail.gmail.com>
 <CANqRtoS+bur8DA0+gG0Q0hL9RLsQdOLyfSUbgE_6nZ8mCST0Jg@mail.gmail.com>
 <CAMuHMdXP9tFX9FZnH_dR86DkKbP_YZcWAF-hF48BtVfGYRTsFw@mail.gmail.com>
 <CANqRtoS0XgyuMBxU3CcVyQNg=r=MuA_OfJEDJbVsq-m9EHF9UA@mail.gmail.com>
 <CAMuHMdWzg0bnoT0kURFe8h2aw4CYKoHN1SMYt0S3-Dno-e=8Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43913 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752815AbaI3INJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 30 Sep 2014 04:13:09 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWzg0bnoT0kURFe8h2aw4CYKoHN1SMYt0S3-Dno-e=8Xw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 30, 2014 at 09:41:27AM +0200, Geert Uytterhoeven wrote:
> Hi Magnus,
> 
> On Tue, Sep 30, 2014 at 9:32 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> >>> So what is a good way to proceed with this series I wonder?
> >>
> >> There are two options:
> >>   1. Drop the two patches that introduce the D4 and A4MP PM domains,
> >>   2. Amend the patches that introduce the D4 and A4MP PM domains to
> >>      comment out the entries in the table in pm-r8a7740.c, like was done in
> >>      the first submission.
> >>
> >> Both will cause conflicts when applying the successive patches.
> >>
> >> If you don't care about bisectability, you can implement option 2 as a
> >> separate change, after applying the whole series.
> >
> > Thanks for leading the way! From my side I don't have any special
> > feeling, so why don't you and Simon decide?
> 
> OK.
> 
> > If it was up to me only then I think option #1 that simply reduces the
> > feature set seems rather natural, but perhaps it requires a lot of
> > rework of the patches. If we go with option #1 we can always
> > incrementally add D4 and A4MP later I assume.
> 
> Yes we can.
> 
> Please wait a bit, I'm looking into the !CONFIG_PM_RUNTIME case.
> Mostly multi-platform, but it may affect legacy too, where there's interaction
> with the drivers/sh/pm_runtime.c hack.

I also feel that option 1 is slightly nicer. But I'm happy
to consider option 2 if its a better fit for you.

As always I'm happy to wait and will now do so.
