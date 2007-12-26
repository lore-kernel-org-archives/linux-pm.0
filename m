From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sleepy linux
Date: Wed, 26 Dec 2007 20:00:45 +0100
Message-ID: <20071226190045.GB8094@elf.ucw.cz>
References: <20071225230731.GA29030@elf.ucw.cz> <4772A3FB.8080108@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752539AbXLZTBS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4772A3FB.8080108@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

On Wed 2007-12-26 10:56:59, H. Peter Anvin wrote:
> Pavel Machek wrote:
>> This is RFC. It does not even work for me... it sleeps but it will not
>> wake up, because SATA wakeup code is missing. Code attached for 
>> illustration.
>> I wonder if this is the right approach? What is right interface to the
>> drivers?
>> 3) Network card that is either down
>>    or can wake up system on any packet (and not loose too many packets)
>
> This is the big crux I see.  You're going to constantly wake up the machine 
> due to broadcast packets, and spend a lot of power just going in and out of 
> S3.

Yep... for the first version, I'll be very happy if it autosleeps when
I'm traveling by bus or something. Working with ethernet plugged in is
quite a distant goal.

(But I guess some cleverness could be done on the router or
something. Automagically converting "interesting" packets into WoL
enabled ones, or...?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
