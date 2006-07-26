From: Pavel Machek <pavel@suse.cz>
Subject: Re: swsusp status report
Date: Wed, 26 Jul 2006 12:08:07 +0200
Message-ID: <20060726100807.GF1905@elf.ucw.cz>
References: <200607251325.14747.rjw@sisk.pl> <20060725151145.GG14964@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751177AbWGZKIT@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060725151145.GG14964@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Jones <davej@redhat.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2006-07-25 11:11:45, Dave Jones wrote:
> On Tue, Jul 25, 2006 at 01:25:14PM +0200, Rafael J. Wysocki wrote:
> 
>  > V. Freeing memory
>  > 
>  > Step (3) of the suspend procedure is completed by calling the same
>  > functions that are normally used by kswapd, but in a slightly different way.
>  > The part of swsusp responsible for that is referred to as 'the memory
>  > shrinker' and it may sometimes be called by the suspend-to-RAM code as well
> 
> This isn't actually necessary though is it ?
> (Ie, it's a bug that needs fixing?)

Well, it is "nice" to the drivers to let them do their work with
reasonable ammount of memory free. Of course, it is also bug in the
driver if it fails to work in low-memory conditions. 

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
