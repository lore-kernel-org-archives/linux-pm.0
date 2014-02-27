From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Domains: Turn latency warning into debug message
Date: Thu, 27 Feb 2014 23:46:42 +0100
Message-ID: <20140227224642.GC7416@amd.pavel.ucw.cz>
References: <1393525604-21471-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33220 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbaB0Wqn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Feb 2014 17:46:43 -0500
Content-Disposition: inline
In-Reply-To: <1393525604-21471-1-git-send-email-p.zabel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org

On Thu 2014-02-27 19:26:44, Philipp Zabel wrote:
> If devices don't provide latency data, this warning can be quite noisy until
> the pm domain was enabled and disabled a few times. Turn this warning into
> a debug message.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

Acked-by: Pavel Machek <pavel@ucw.cz>


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
