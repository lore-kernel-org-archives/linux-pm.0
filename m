From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 1/5] swsusp: Introduce memory bitmaps
Date: Wed, 9 Aug 2006 12:31:20 +0200
Message-ID: <20060809103120.GI3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608091158.38458.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030661AbWHIKbe@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608091158.38458.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Introduce the memory bitmap data structure and make swsusp use in the suspend
> phase.
> 
> The current swsusp's internal data structure is not very efficient from the
> memory usage point of view, so it seems reasonable to replace it with a data
> structure that will require less memory, such as a pair of bitmaps.

Well, 500 lines of code  for what... 0.25% bigger image? I see it
enables you to do some cleanups... but could we get those cleanups
without those 500 lines? :-).


>  kernel/power/power.h    |    3 
>  kernel/power/snapshot.c |  605 ++++++++++++++++++++++++++++++++++++++++++------
>  kernel/power/swsusp.c   |    5 
>  3 files changed, 542 insertions(+), 71 deletions(-)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
