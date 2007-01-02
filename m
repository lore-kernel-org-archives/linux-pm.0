From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.20 regression: suspend to disk no more works
Date: Tue, 2 Jan 2007 11:32:51 +0100
Message-ID: <20070102103251.GD2122@elf.ucw.cz>
References: <200701012244.42781.arvidjaar@mail.ru> <200701020028.19866.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932691AbXABKdA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200701020028.19866.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrey Borzenkov <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > While 'echo a:b > /sys/power/resume' before 
> > suspend is a workaround, this still breaks perfectly valid setup that worked
> > before. Also 'echo a:b > /sys/power/resume' is actually wrong - we are not
> > going to resume at this point; but there is no way to just tell kernel "use
> > this device for next STD" ... also the error message is misleading, it should
> > complaint "no resume device found". Swap is there all right.
> 
> Thanks for the report.

It fixes it for too people, I guess that's ACK... certainly for -mm,
probably for 2.6.20, too.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
