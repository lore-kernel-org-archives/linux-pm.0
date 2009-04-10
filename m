From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [REGRESSION] commit 66c1ca0: {fbmem: fix
 fb_info->lock and mm->mmap_sem ...} causes Xfbdev not working
Date: Fri, 10 Apr 2009 22:21:22 +0200
Message-ID: <20090410222122.87be60f6.krzysztof.h1__32625.3714891665$1239395167$gmane$org@poczta.fm>
References: <f17812d70904090436kd03744brca4a4bc4b85bba8@mail.gmail.com>
	<20090409125850.GA2727@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090409125850.GA2727@linux>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrea Righi <righi.andrea@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, Andrey Borzenkov <arvidjaar@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, LKML <linux-kernel@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Harvey Harrison <harvey.harrison@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 9 Apr 2009 14:58:51 +0200
Andrea Righi <righi.andrea@gmail.com> wrote:

> On Thu, Apr 09, 2009 at 07:36:24PM +0800, Eric Miao wrote:
> > This happens on my Marvell PXA310-based Littleton platform with
> > Angstrom Distribution. The offending paths are many:
> > 
> > FBIOPUT_VSCREENINFO:
> >   lock_fb_info()
> >   --> fb_set_var()
> >     --> fb_notifier_call_chain() [FBINFO_MISC_USEREVENT]
> >       --> fbcon_event_notifier() [FB_EVENT_MODE_CHANGE]
> >         --> lock_fb_info()
> > 
> > OK, now hang. I'd suggest a clean fix to the original assumption of
> > circular locking
> > issue and revert this commit first.
> > 
> > -- 
> > Cheers
> > - eric
> 
> I can agree to revert 66c1ca019078220dc1bf968f2bb18421100ef147, since I
> don't have a clean fix for this. Pushing down fb_info->lock in
> fb_set_var() excluding to call fb_notifier_call_chain with fb_info->lock
> held doesn't seem to be so trivial...
> 
> However, reverting this will re-introduce the circular locking
> dependency fb_info->lock => mm->mmap_sem => fb_info->lock.
> 

If anybody is interested I have looked into the code of the fb_mmap()
and have found that the problem Andrea tried to fix is caused
only by drivers which implements their own fb_mmap().

The correct solution is to push the info->lock mutex into
the fb_mmap() implemented inside the drivers. Some drivers
may not need it (the ones which only calculate offsets
and do not "real" iommaping).

I'll try to prepare a patch after the Easters. This will require a revert
 of the 66c1ca commit.

Happy Easters,
Krzysztof

----------------------------------------------------------------------
Nagrody w jednym miejscu!
Sprawdz >> http://link.interia.pl/f210b
