From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] [PATCH] Rt-tester makes freezing processes fail.
Date: Fri, 14 Jul 2006 20:33:04 +0000
Message-ID: <20060714203304.GB8731@ucw.cz>
References: <200607140918.49040.nigel@suspend2.net> <20060713163743.e71975b0.akpm@osdl.org> <200607141017.27832.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1422757AbWGNUeU@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200607141017.27832.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, tglx@timesys.com, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > I yesterday queued up the below patch.  Which approach is most appropriate?
> 
> I prefer the one that makes these threads freeze (ie. the Luca's patch).

Agreed. We definitely do not want unneccessary stuff to run during
suspend.
							Pavel
-- 
Thanks for all the (sleeping) penguins.
