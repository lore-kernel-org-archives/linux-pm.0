From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/PATCH] dt: bindings: Define bindings for device idle states
Date: Fri, 26 Aug 2016 15:58:42 +0200
Message-ID: <20160826135842.GA9303@amd>
References: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:33951 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbcHZN6q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Aug 2016 09:58:46 -0400
Content-Disposition: inline
In-Reply-To: <1472207073-4901-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Brendan Jackman <Brendan.Jackman@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, devicetree@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Axel Haslam <ahaslam@baylibre.com>, linux-pm@vger.kernel.org

Hi!

> @@ -0,0 +1,102 @@
> +Device idle states
> +========================
> +
> +A device are often capable of entering a low power state(s) when it becomes
> +idle, hence the terminology of device idle states. Entering an idle state for a
> +device helps it to avoid wasting power and reduces the leakage of current.

First things first: what do these states _really_ represent? We have
GPIOs in device tree, we have clock domains. What are these?

Actually I don't think I like this. We should describe the hardware,
not particular use case.

On what hardware would you use these new bindings?

> +Required properties:
> +- compatible:		Must contain "simple-dev, idle-state".
> +- entry-latency-ns:	An u32 value in nano-seconds representing the worst case
> +			latency required for the device to enter the idle state.
> +- exit-latency-ns:	An u32 value in nano-seconds representing the worst case
> +			wakeup latency of the device, after entry-latency-ns has
> +			passed.

u32 nanoseconds have 4sec limit, right? So anything with spinning
harddrive is out?

> +== Assigning idle states to devices ==
> +
> +Required properties:
> + - dev-idle-states:	A list of phandles pointing to the supported
> +			device idle states nodes. The list must be ordered as
> +			the shallower state - the earlier in the list.

Does such ordering really neccessarily exist?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
