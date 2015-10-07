From: =?ks_c_5601-1987?B?RGF2aWQgS3dvbiAosce/+MirKQ==?=
	<wonhong.kwon@lge.com>
Subject: RE: [PATCH] PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync
Date: Wed, 7 Oct 2015 11:08:56 +0900
Message-ID: <016101d100a5$1f342550$5d9c6ff0$@lge.com>
References: <1444093820-6934-1-git-send-email-wonhong.kwon@lge.com> <20151006144213.GB24518@xo-6d-61-c0.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from LGEAMRELO12.lge.com ([156.147.23.52]:53144 "EHLO
	lgeamrelo12.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713AbbJGCYA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 22:24:00 -0400
In-Reply-To: <20151006144213.GB24518@xo-6d-61-c0.localdomain>
Content-Language: ko
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Pavel Machek' <pavel@ucw.cz>, 'Wonhong Kwon' <wonhongkwon@gmail.com>
Cc: rjw@rjwysocki.net, len.brown@intel.com, linux-pm@vger.kernel.org, gunho.lee@lge.com

> On Tue 2015-10-06 10:10:20, Wonhong Kwon wrote:
> > pm_init is being invoked by core_initcall and
> > hibernate_image_size_init calculates preferred image size (image_size)
> > based on total pages (totalram_pages). This totalram_pages can be
> > modified during various initcall-s phase and this can cause
> miscalculated image_size.
> >
> > For example, when CMA is being used, init_cma_reserved_pageblock tries
> > to change the totalram_pages and this job is done during core_initcall.
> > In order words, the totalram_pages doesn't take CMA reserved pages
> > into account when image_size is calculated and it can be too small.
> >
> > Move pm_init and pm_disk_init to late_initcall_sync so that it happens
> > after all other initcall-s change the totalram_pages.
> 
> Hmm, someone else hit same (similar) problem, but had way more complex
> solution.
> 
> So it is nice this is easy.
> 
> But is it enough? 

I'm not a MM expert, but AFAIU, lots of things including CMA try to change
totalram_pages during and after boot. For instance, memory is being plugged
out after boot, __offline_pages invokes adjust_managed_page_count and
totalram_pages
can be changed.

However, image_size can be changed by user via sysfs after boot, and I think
user's preferred size should have a high priority than one calculated with
totalram_pages.

So, my patch was intended to calculate default image_size based on more
accurate
totalram_pages during boot, not based on real one on any time after boot.

> Can CMA be modular? Can CMA allocate memory after boot?

AFAIK, CMA cannot intercept any memory after boot. Reserving memory for CMA
area
should be required on early stage.

Thanks,
Wonhong

> 
> THanks,
>
Pavel
> 
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures)
> http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

