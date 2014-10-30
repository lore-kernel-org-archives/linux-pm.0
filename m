From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v3 0/9] PM / Domains: Fix race conditions during boot
Date: Thu, 30 Oct 2014 13:46:43 -0700
Message-ID: <7hsii58evg.fsf@deeprootsystems.com>
References: <1413208930-26019-1-git-send-email-ulf.hansson@linaro.org>
	<7hd29h8n0o.fsf@deeprootsystems.com>
	<20141024161804.GH3729@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <20141024161804.GH3729@sirena.org.uk> (Mark Brown's message of
	"Fri, 24 Oct 2014 17:18:04 +0100")
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tomasz Figa <tomasz.figa@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Kukjin Kim <kgene.kim@samsung.com>, Philipp Zabel <philipp.zabel@gmail.com>, Wolfram Sang <wsa@the-dreams.de>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jack Dai <jack.dai@rock-chips.com>, Jinkun Hong <jinkun.hong@rock-chips.com>, Aaron Lu <aaron.lu@intel.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>
List-Id: linux-pm@vger.kernel.org

Mark Brown <broonie@kernel.org> writes:

> On Fri, Oct 24, 2014 at 09:12:39AM -0700, Kevin Hilman wrote:
>> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> > There may be more than one device in a PM domain which then will be
>> > probed at different points in time.
>
>> > Depending on timing and runtime PM support, in for the device related
>> > driver/subsystem, a PM domain may be advised to power off after a
>> > successful probe sequence.
>
>> > A general requirement for a device within a PM domain, is that the
>> > PM domain must stay powered during the probe sequence. To cope with
>> > such requirement, let's add two new APIs, dev_pm_domain_get|put().
>
>> I'm confused. Why arent' pm_runtime_get*() and pm_runtime_put*() working?
>
>> What's not explained here (or what I'm not understanding) is why a PM
>> domain is powering off if it has active devices.
>
> The issue AIUI is what happens during system boot - if one device in a
> domain probes and marks itself runtime idle then that will trigger
> domain powerdown even if there is another device in the domain that
> hasn't yet been probed.  This can cause undesirable glitches (or worse)
> during boot depending on what's getting powered down.

I'm not quite seeing how this series fixes that problem.

Looking at platform devices in PATCH 4/9, the new _get() and _put() are
still happening around ->probe(), so if a platform device runtime suspends
after probe, don't we still have a PM domain that can turn off?

Kevin
