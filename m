From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 00/13] Krait clocks + Krait CPUfreq
Date: Thu, 2 Apr 2015 08:18:28 +0200
Message-ID: <20150402061828.GB23963@amd>
References: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:57884 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbbDBGSa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 02:18:30 -0400
Content-Disposition: inline
In-Reply-To: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org

On Fri 2015-03-20 23:45:19, Stephen Boyd wrote:
> These patches provide cpufreq scaling on devices with Krait CPUs.
> In Krait CPU designs there's one PLL and two muxes per CPU, allowing
> us to switch CPU frequencies independently.
> 
> 				 secondary
> 	 +-----+                    +
> 	 | QSB |-------+------------|\
> 	 +-----+       |            | |-+
> 		       |    +-------|/  |
> 		       |    |       +   |
> 	 +-----+       |    |           |
> 	 | PLL |----+-------+           |   primary
> 	 +-----+    |  |                |     +
> 		    |  |                +-----|\       +------+
> 	 +-------+  |  |                      | \      |      |
> 	 | HFPLL |----------+-----------------|  |-----| CPU0 |
> 	 +-------+  |  |    |                 |  |     |      |
> 		    |  |    | +-----+         | /      +------+
> 		    |  |    +-| / 2 |---------|/
> 		    |  |      +-----+         +
> 		    |  |         secondary
> 		    |  |            +
> 		    |  +------------|\
> 		    |               | |-+
> 		    +---------------|/  |   primary
> 				    +   |     +
> 					+-----|\       +------+
> 	 +-------+                            | \      |      |
> 	 | HFPLL |----------------------------|  |-----| CPU1 |
> 	 +-------+          |                 |  |     |      |
> 			    | +-----+         | /      +------+
> 			    +-| / 2 |---------|/
> 			      +-----+         +

And actually this picture should go to Documentation/ somewhere...

									Pavel
									
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
