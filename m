From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM/freezer: y2038, use boottime to compare tstamps
Date: Sun, 21 Feb 2016 14:46:42 +0100
Message-ID: <2178100.KqWrTOMtmd@vostro.rjw.lan>
References: <1454268541-28064-1-git-send-email-klock.android@gmail.com> <20160131194255.GA31180@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44702 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751162AbcBURpN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Feb 2016 12:45:13 -0500
In-Reply-To: <20160131194255.GA31180@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>, Abhilash Jindal <klock.android@gmail.com>
Cc: linux-pm@vger.kernel.org

On Sunday, January 31, 2016 08:42:55 PM Pavel Machek wrote:
> On Sun 2016-01-31 14:29:01, Abhilash Jindal wrote:
> > Wall time obtained from do_gettimeofday gives 32 bit timeval which can only
> > represent time until January 2038. This patch moves to ktime_t, a 64-bit time.
> > 
> > Also, wall time is susceptible to sudden jumps due to user setting the time or
> > due to NTP.  Boot time is constantly increasing time better suited for
> > subtracting two timestamps.
> 
> Umm. Setting time while we are freezeing is probably not going to be a
> problem, but ok, why not... Code is simpler as well, and 2038 is
> coming ;-).
> 
> Acked-by: Pavel Machek <pavel@ucw.cz>

Queued up for 4.6, thanks!

Rafael

