From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH v5 1/8] PM / Domains: Add DT bindings for power-on/off latencies
Date: Mon, 9 Mar 2015 14:00:27 -0700
Message-ID: <CAMAWPa-PROLJVGU2w8FSJYt4YJehc2DAnaT047fukSTAM9Eddw@mail.gmail.com>
References: <1416231044-1903-1-git-send-email-geert+renesas@glider.be>
	<1416231044-1903-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416231044-1903-2-git-send-email-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Grygorii Strashko <grygorii.strashko@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Tomasz Figa <tomasz.figa@gmail.com>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Geert,

On Mon, Nov 17, 2014 at 5:30 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> PM domain power on/off-latencies are properties of the hardware.
> In legacy code, they're specified from platform code.
> On DT platforms, their values should come from DT.

Any plans to refresh/resend this patch now that the rest of the series
has gone in?

I'm seeing some other PM domain series coming in for review[1] that
could use this feature.

Thanks,

Kevin

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/328905.html
