From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] Kexec jump: The first step to kexec base
	hibernation
Date: Thu, 12 Jul 2007 14:49:12 +0000
Message-ID: <20070712144912.GA4987@ucw.cz>
References: <1184167831.12556.13.camel@caritas-dev.intel.com>
	<4695C096.5080400@goop.org>
	<Pine.LNX.4.64.0707112319550.28090@asgard.lang.hm>
	<200707121446.14170.rjw@sisk.pl> <469631FA.2070405@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <469631FA.2070405@rtr.ca>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Lord <lkml@rtr.ca>
Cc: david@lang.hm, Jeremy Fitzhardinge <jeremy@goop.org>, linux-kernel@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> And the complexity and difficulty of setup really scares 
> me.
> Right now, we've got a pretty good/fast in-kernel (well, 
> external patch)
> that allows my machines to hibernate very quickly, wake 
> up even faster,
> and not swap like mad afterwards.  Without any external 
> programs,
> initramfs, or extra kernels required.
> 
> And we want to replace this with an ultra-complex setup 
> because.. ????

...freezer does not work with fuse :-). Or more exactly because
freezer is ugly, and we don't know how to get rid of it...

(Not that I advocate kexec-based hibernation. I think it is going to
suck. But it might allow kdump-but-keep-running, so work is not
wasted).
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
