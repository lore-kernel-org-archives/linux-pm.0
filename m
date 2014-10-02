From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Domains: Rename cpu_data to cpuidle_data
Date: Thu, 2 Oct 2014 22:37:34 +0200
Message-ID: <20141002203734.GA17230@amd>
References: <1412277154-5853-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40361 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbaJBUhh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Oct 2014 16:37:37 -0400
Content-Disposition: inline
In-Reply-To: <1412277154-5853-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On Thu 2014-10-02 21:12:34, Ulf Hansson wrote:
> The "cpu_data" are defined for some archs and thus conflicting with the
> "cpu_data" member in the struct gpd_cpu_data. This causes a compiler
> error for those archs.
> 
> Let's fix it by rename the member to cpuidle_data. In this context it
> also seems appropriate to rename the struct to gpd_cpuidle_data to
> better reflect its use.
> 
> Fixes: f48c767ce895 (PM / Domains: Move dev_pm_domain_attach|detach() to pm_domain.h)
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
