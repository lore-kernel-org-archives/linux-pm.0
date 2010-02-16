From: Pavel Machek <pavel@ucw.cz>
Subject: Re: slow resume from suspend to disk
Date: Tue, 16 Feb 2010 14:54:44 +0100
Message-ID: <20100216135444.GA1337@ucw.cz>
References: <201002110140.16122.mihai.dontu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201002110140.16122.mihai.dontu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mihai Don??u <mihai.dontu@gmail.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!
> 
> Is there any way to speed up the resume from suspend to disk? Currently, on my 
> laptop it suspends in ~15s (wrote about 360MB) but resumes in ~120s and after 
> that I'm still left with ~361MB in swap:
> 
>              total       used       free     shared    buffers     cached
> Mem:       3333472    1139332    2194140          0      12808     473084
> -/+ buffers/cache:     653440    2680032
> Swap:      2104472     369428    1735044
> 
> Right now I'm better off with a cold boot.

That's way too slow. Are you using in-kernel swsusp, or userland
s2disk? dmesgM
> 
> Although I did not study the kernel code to see how things really work, I 
> suspect on resume only necessary kernel data is loaded from swap and the 
> userland tasks are left with the page fault mechanism to bring back their own 
> data, which leads to an I/O storm on the swap device. Maybe changing the I/O 
> scheduler from CFQ would help? or better yet, is there any way to tell the 
> kernel to bring back all the pages from swap in one quick move? That would be 
> something I want to put in my resume scripts.
> 
> $ uname -a
> Linux mdontu-dell 2.6.32-gentoo-r3 #1 SMP PREEMPT Mon Feb 1 02:36:01 EET 2010 
> x86_64 Intel(R) Core(TM)2 CPU T5500 @ 1.66GHz GenuineIntel GNU/Linux
> 
> I've installed Windows XP just for a test, started a few apps (like visual 
> studio, mplayer, etc.) and then suspended/hibernated (~15s). It took roughly 
> 15s to come back.
> 
> Thanks,
> 
> PS: I'm editing this e-mail as I do tests and I just noticed that my /sbin 
> directory is empty. rmmod is there and I needed it to reload the b43 driver 
> which generally does not feel well after a suspend/resume. A reboot fixed it. 
> Weird ...
> 

Seems like your system has problems...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
