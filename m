From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 8/8] PM / doc: Update device documentation for devices
 in IRQ safe PM domains
Date: Fri, 21 Oct 2016 15:07:24 +0200
Message-ID: <CAJZ5v0hP9QNSqU053keCgY-LEGAyOiOT_vuUK71Oa6i3f7pycg@mail.gmail.com>
References: <1476467276-75094-1-git-send-email-lina.iyer@linaro.org> <1476467276-75094-9-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1476467276-75094-9-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-arm-msm@vger.kernel.org, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 14, 2016 at 7:47 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Update documentation to reflect the changes made to support IRQ safe PM
> domains.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  Documentation/power/devices.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/power/devices.txt b/Documentation/power/devices.txt
> index 8ba6625..0401b53 100644
> --- a/Documentation/power/devices.txt
> +++ b/Documentation/power/devices.txt
> @@ -607,7 +607,14 @@ individually.  Instead, a set of devices sharing a power resource can be put
>  into a low-power state together at the same time by turning off the shared
>  power resource.  Of course, they also need to be put into the full-power state
>  together, by turning the shared power resource on.  A set of devices with this
> -property is often referred to as a power domain.
> +property is often referred to as a power domain. A power domain may also be
> +nested inside another power domain.
> +
> +Devices and PM domains may be defined as IRQ-safe, if they can be powered
> +on/off even when the IRQs are disabled. An IRQ-safe device in a domain will
> +disallow power management on the domain, unless the domain is also defined as
> +IRQ-safe. The restriction this framework imposes on the parent domain of an
> +IRQ-safe domain is that it must also be defined as IRQ-safe.

I would put this paragraph below, before the last paragraph in the section.

Also I suppose that a domain should only be defined as "IRQ-safe" if
all of the devices in it are "IRQ-safe" (or there will be problems at
least in principle).  If that is the case, it should be stated clearly
in the paragraph you are adding as well.

Thanks,
Rafael
