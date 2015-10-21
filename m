From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / Domains: Don't measure ->start|stop() latency
 in system PM callbacks
Date: Wed, 21 Oct 2015 12:31:26 +0200
Message-ID: <20151021103126.GA16738@amd>
References: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40281 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753750AbbJUKba (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 06:31:30 -0400
Content-Disposition: inline
In-Reply-To: <1444921326-22574-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Thu 2015-10-15 17:02:06, Ulf Hansson wrote:
> Measure latency does by itself contribute to an increased latency, thus we
> should avoid it when it isn't needed.
> 
> Genpd measures latencies in the system PM phase for the ->start|stop()
> callbacks and is thus affecting the system PM suspend/resume time.
> Moreover these latencies are validated only at runtime PM suspend/resume.
> 
> To this reasoning, let's decide to leave these measurements out of the
> system PM phase. There should be plenty of occasions during runtime PM to
> perform these measurements anyway.

How much latency does the latency measure cause? Something like 0.000
msec?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
