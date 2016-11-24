From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [RFC PATCH 0/3] PM / Domains: Add support for devices that
 require multiple domains
Date: Wed, 23 Nov 2016 18:30:14 -0800
Message-ID: <20161124023014.GK6095@codeaurora.org>
References: <CAPDyKFoFPNNnoc-7G34A7a4Yo8f=WUyurNP1evabw3MOEubEoA@mail.gmail.com>
 <90faea7d-65b6-590a-83f1-24fcdffa0569@nvidia.com>
 <CAPDyKFr4S3tM7KL2hfwJ3R4e5z1-Zd99aMhMSgVq4XzkrUUdow@mail.gmail.com>
 <fd7c8f40-2a9f-b71c-bd11-43ee657441ae@nvidia.com>
 <63670abf-1d58-a7e3-6927-0c815d44d8a1@nvidia.com>
 <d961715d-820a-dd63-e3a9-c908ce465582@nvidia.com>
 <CAJZ5v0hqdjGJ8v+k-Nkp_bx-fj_yTD5WoMeVfkmqBuTwCjRoyA@mail.gmail.com>
 <d9a4c1cd-6682-663d-e30d-cc85f665cf64@nvidia.com>
 <m2lgwbxtea.fsf@baylibre.com>
 <f54b4912-bfdd-aa2c-6f04-e09ed4207af6@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <f54b4912-bfdd-aa2c-6f04-e09ed4207af6@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Kevin Hilman <khilman@baylibre.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 11/22, Jon Hunter wrote:
> 
> On 22/11/16 18:26, Kevin Hilman wrote:
> > Jon Hunter <jonathanh@nvidia.com> writes:
> > 
> >> However, I would rather the client of
> >> the power-domains specify which power-domains they require and
> >> dynamically nested the power-domains at runtime. This is slightly
> >> different to what I proposed in this RFC, but it is not really beyond
> >> the bounds of what we support today IMO. What is missing is a means to
> >> do this dynamically and not statically.
> >>
> >> By the way, I am not sure if you are suggesting that for devices that
> >> may need multiple power-domains we should architect the driver
> >> differently and split it up in some way such that we have a power-domain
> >> per device. But for the case of the Tegra XHCI it is quite complex
> >> because the driver loads firmware which runs on a micro-controller and
> >> we need to manage the various power-domains that are used.
> > 
> > IMO, constructing a network of new struct devices just to workaround
> > limitations in the framework doesn't sound quite right either.
> 
> I agree.
> 

Marek is attempting to do this for the samsung clock
controller[1] (patch #5 is informative). From what I can tell
they have one DT node for their clock controller because it's one
register address space to control clocks. But, certain clocks
exposed by that driver only work when certain power domains are
enabled. For example, they have a clock controller that exposes
clock signals for multimedia hardware blocks like video
accelerators, gpus, and cameras. The clocks seem to have been
placed inside different power domains for the multimedia hardware
they're associated with, so there may be 10 or so power domains
that need to be enabled at different times for different clocks
to work. If the GPU power domain isn't enabled when the GPU
clocks are touched by the driver, things break, etc.

In the proposed patchset, we have the top-level clock controller
node with subnodes for each power domain that needs to be
associated with clocks inside these different multimedia blocks.
So we end up with one parent device and attached driver for the
clock driver, and then that driver populates child nodes as
devices and matches up clocks with child nodes while registering
clks with clk_register(). Because we pass a dev pointer to
clk_register, we associate different devices with different
clocks all from the same top-level clock controller device
driver. Then clk framework calls runtime_pm APIs with devices
used during clk registration. Some of those devices don't have
any driver bound to them, which feels odd.

This seems like a case where we really want a better way to
explicitly control power domains without making up subnodes and
registering struct devices just to work around the one device to
one genpd construct we have today. Maybe power domains just don't
map to genpd though and that's the disconnect.

[1] http://lkml.kernel.org/r/1477311130-6534-1-git-send-email-m.szyprowski@samsung.com
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
