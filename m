From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] sleepy linux
Date: Sat, 29 Dec 2007 23:44:35 +0000
Message-ID: <20071229234435.GA17823@ucw.cz>
References: <20071225230731.GA29030@elf.ucw.cz> <4772A3FB.8080108@zytor.com> <200712262108.35643.oliver@neukum.org> <4772BD0C.3040609@zytor.com> <20071226205103.GG8094@elf.ucw.cz> <4772BF86.4010906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756038AbXL2Wqb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4772BF86.4010906@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Oliver Neukum <oliver@neukum.org>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
List-Id: linux-pm@vger.kernel.org

Hi!

> >NOHZ + C4 + turn off screen + turn off disk + turn off SATA is still
> >~8W on thinkpad x60.
> >
> >S3 is ~1W.
> >
> >That's quite significant difference.
> >
> >(But yes, connected-to-ethernet is not most important use scenario.)
> >								Pavel
> 
> Still... if we could get the desktops of the world down anywhere close 
> to that range when not used, it would be a huge win.

Plus, it is probably mandatory if you want EnergyStar logo ...
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
