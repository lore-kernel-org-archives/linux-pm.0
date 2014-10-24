From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Fri, 24 Oct 2014 09:12:39 -0700
Message-ID: <7hd29h8n0o.fsf@deeprootsystems.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org> (Ulf
	Hansson's message of "Mon, 13 Oct 2014 16:02:01 +0200")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-pm@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> writes:

> Changes in v3:
> 	-Rework the entire intermediate step which was suggested in v2.
> 	 That means solving the race condition, but also cope with PM domains
> 	 that are initialized in powered off state.
>
> Changes in v2:
> 	-Added some acks.
> 	-Updated commit messages.
> 	-Included a wider audience of the patchset. V1 was lacking SoC
> 	 maintainers.
>
> Here are link to the first patchset, were some discussion started.
> http://marc.info/?l=linux-pm&m=141208104729597&w=2
>
> There may be more than one device in a PM domain which then will be
> probed at different points in time.
>
> Depending on timing and runtime PM support, in for the device related
> driver/subsystem, a PM domain may be advised to power off after a
> successful probe sequence.
>
> A general requirement for a device within a PM domain, is that the
> PM domain must stay powered during the probe sequence. To cope with
> such requirement, let's add two new APIs, dev_pm_domain_get|put().
>
> These APIs are intended to be invoked from subsystem-level code and the
> calls between get/put needs to be balanced.
>
> dev_pm_domain_get(), tells the PM domain that it needs to increase a
> usage count and to keep supplying power. dev_pm_domain_put(), does the
> opposite.

I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?

What's not explained here (or what I'm not understanding) is why a PM
domain is powering off if it has active devices.

Kevin
