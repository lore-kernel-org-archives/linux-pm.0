From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 00/11] ARM: shmobile: r8a7740/armadillo legacy prototype
 pm domain support
Date: Thu, 11 Sep 2014 09:22:42 +0900
Message-ID: <20140911002242.GE29858@verge.net.au>
References: <1409320217-13278-1-git-send-email-geert+renesas@glider.be>
 <20140909022649.GC31320@verge.net.au>
 <CAMuHMdWZ_MZQo5QyZmZCx-EHvxOvO==gnoefDqsipHqfSLPXww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:58880 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaIKAWq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Sep 2014 20:22:46 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdWZ_MZQo5QyZmZCx-EHvxOvO==gnoefDqsipHqfSLPXww@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux-sh list <linux-sh@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Sep 09, 2014 at 11:48:23AM +0200, Geert Uytterhoeven wrote:
> Hi Simon, Magnus,
> 
> On Tue, Sep 9, 2014 at 4:26 AM, Simon Horman <horms@verge.net.au> wrote:
> > I would like Magnus's opinion but mine is that the non-WIP patches
> > could be queued up. At least patch 1 and 2. Possibly others if
> > they don't depend (other than diff noise) on WIP patches.
> 
> The legacy platforms are meant to be extinct in the near future, but
> Armadillo-legacy already has some PM domain support, so adding a
> little bit more can't hurt much, IMHO.
> 
> Besides diff noise, there should not be any dependencies on WIP patches.
> 
> > With the WIP patches, I am not entirely opposed to merging them
> > too, so long as they move things in a good direction. And in particular
> > don't break anything.
> 
> "[PATCH 03/11] [WIP] ARM: shmobile: armadillo800eva legacy: Add
> missing A3SP pm domain devices" should be OK, as this turned out to be
> intended behavior.
> 
> "[PATCH 10/11] [WIP] ARM: shmobile: r8a7740: Add A4SU pm domain
>  support" probably introduces a regression for USB, as the domain is now
> powered down after boot-up. I haven't tried USB on Armadillo yet, though.
> So don't apply this one.
> 
> "[PATCH 11/11] [WIP] ARM: shmobile: r8a7740: Add A3SM pm domain
>  support" should be safe.
> 
> I would not apply the other WIP patches that add C99-commented-out code.
> These issues must be fixed for DT as well.

Thanks Geert, that all sounds reasonable to me.
I will confer with Magnus.
