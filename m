From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 01/10] freezer: shorten freezer sleep time using
 exponential backoff
Date: Thu, 2 May 2013 14:28:02 +0200
Message-ID: <20130502122802.GB22618@amd.pavel.ucw.cz>
References: <1367271946-7239-1-git-send-email-ccross@android.com>
 <1367271946-7239-2-git-send-email-ccross@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:35196 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008Ab3EBM2E (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 May 2013 08:28:04 -0400
Content-Disposition: inline
In-Reply-To: <1367271946-7239-2-git-send-email-ccross@android.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, arve@android.com, Len Brown <len.brown@intel.com>

On Mon 2013-04-29 14:45:37, Colin Cross wrote:
> All tasks can easily be frozen in under 10 ms, switch to using
> an initial 1 ms sleep followed by exponential backoff until
> 8 ms.  Also convert the printed time to ms instead of centiseconds.
> 
> Signed-off-by: Colin Cross <ccross@android.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
