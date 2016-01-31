From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM/freezer: y2038, use boottime to compare tstamps
Date: Sun, 31 Jan 2016 20:42:55 +0100
Message-ID: <20160131194255.GA31180@amd>
References: <1454268541-28064-1-git-send-email-klock.android@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40341 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757432AbcAaTnI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 31 Jan 2016 14:43:08 -0500
Content-Disposition: inline
In-Reply-To: <1454268541-28064-1-git-send-email-klock.android@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Abhilash Jindal <klock.android@gmail.com>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net

On Sun 2016-01-31 14:29:01, Abhilash Jindal wrote:
> Wall time obtained from do_gettimeofday gives 32 bit timeval which can only
> represent time until January 2038. This patch moves to ktime_t, a 64-bit time.
> 
> Also, wall time is susceptible to sudden jumps due to user setting the time or
> due to NTP.  Boot time is constantly increasing time better suited for
> subtracting two timestamps.

Umm. Setting time while we are freezeing is probably not going to be a
problem, but ok, why not... Code is simpler as well, and 2038 is
coming ;-).

Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
