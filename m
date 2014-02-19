From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Sleep: Set pm_generic functions to NULL for
 !CONFIG_PM_SLEEP
Date: Wed, 19 Feb 2014 13:27:15 +0100
Message-ID: <20140219122715.GB32069@amd.pavel.ucw.cz>
References: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:39916 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaBSM1R (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2014 07:27:17 -0500
Content-Disposition: inline
In-Reply-To: <1392811761-28201-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Russell King <linux@arm.linux.org.uk>

On Wed 2014-02-19 13:09:21, Ulf Hansson wrote:
> Previously only a subset of the functions were defined and set to NULL
> while !CONFIG_PM_SLEEP. Let's make them all available so they can be
> used no matter of CONFIG_PM_SLEEP or not.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Reviewed-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
