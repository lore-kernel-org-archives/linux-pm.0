From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFC][PATCH -mm 0/5] swsusp: Fix handling of highmem
Date: Wed, 9 Aug 2006 13:38:22 +0200
Message-ID: <20060809113822.GQ3308@elf.ucw.cz>
References: <200608091152.49094.rjw@sisk.pl> <200608092047.13493.ncunningham@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030706AbWHILij@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200608092047.13493.ncunningham@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Comments welcome.
> 
> Thanks for the reminder. I'd forgotten half the reason why I didn't want to 
> make Suspend2 into incremental patches! You're a brave man!

Why does this serve as a reminder? No, it is not easy to merge big
patches to mainline. But it is actually a feature.

> while (1) {
>   size=$RANDOM * 65536 + 1
>   dd if=/dev/random bs=1 count=$size | patch -p0-b
>   make && break
>}

Is this what you use to generate suspend2 patches? :-)))))

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
