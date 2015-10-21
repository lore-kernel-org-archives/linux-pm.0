From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/2] PM / Domains: Merge measurements for PM QoS device
 latencies
Date: Wed, 21 Oct 2015 12:33:11 +0200
Message-ID: <20151021103311.GA17163@amd>
References: <1444921339-22614-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:40344 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754407AbbJUKdN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 06:33:13 -0400
Content-Disposition: inline
In-Reply-To: <1444921339-22614-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>, Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

On Thu 2015-10-15 17:02:19, Ulf Hansson wrote:
> Measure latency does by itself contribute to an increased latency, thus we
> should avoid it when it isn't needed.
> 
> By merging the latency measurements for the ->save_state() and the
> ->stop() callbacks, we get one measurement instead of two and we get one
> value to store instead of two. Let's also apply the likewise change for
> the ->start() and ->restore_state() callbacks.

I guess we should simply delete the latency measurement code at this
point, and let interested parties patch their kernels to do the
measurements.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
