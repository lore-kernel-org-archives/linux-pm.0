From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 00/13] Krait clocks + Krait CPUfreq
Date: Thu, 2 Apr 2015 08:17:40 +0200
Message-ID: <20150402061740.GA23963@amd>
References: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426920332-9340-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Mike Turquette <mturquette@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

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
> 	 +-------+          v                 | \      |      |
> 	 | HFPLL |----------------------------|  |-----| CPU1 |
> 	 +-------+          |                 |  |     |      |
> 			    | +-----+         | /      +------+
> 			    +-| / 2 |---------|/
> 			      +-----+         +

Nice ascii art :-). There should be "+" at place marked by "v" :-).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
