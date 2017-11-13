From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 0/3] PM / core: Invent a WAKEUP_POWERED driver flag
Date: Mon, 13 Nov 2017 16:50:20 +0100
Message-ID: <CAPDyKFrLYbpttNgyS=J9-1v9aBH26+S7Y9a1=ngYe9BuspwVpA@mail.gmail.com>
References: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1510588003-16650-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 13 November 2017 at 16:46, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The generic problem this series is trying to solve, is that for some bus types
> and PM domains, it's not sufficient to only check the return value from
> device_may_wakeup(), to fully understand how to treat the device during system
> suspend.
>
> One particular case that suffers from this, is the generic PM domain (aka genpd)
> and that is taken care of in the final change in this series.
>
> The special case this series address, is to enable drivers to instruct bus types
> and PM domains, that the device need to remain in its current power state in
> case it should be able to generate wakeup signals during system suspend. This is
> done by an opt-in method, however bus types and PM domains that has additional
> knowledge about devices' wakeup settings may still override the setting.
>
> Geert Uytterhoeven, has been working on some related problems for some Renesas
> SoCs [1], to be able to properly configure WakeOnLAN, for some ethernet
> devices/drivers, which are used together with genpd. My intent is that this
> series enables a solution for those problems.
>
> [1]
> https://www.spinics.net/lists/linux-renesas-soc/msg19319.html
>
> Changes in v2:
>         - See change logs for each patch.
>
>
> Ulf Hansson (3):
>   PM / core: Re-factor some code dealing with parents in
>     __device_suspend()
>   PM / core: Add IN_BAND_WAKEUP driver flag
>   PM / Domains: Take wakeup_path_in_band status flag into account
>

Realized that the header of the cover letter still has the old
WAKEUP_POWERED flag name in it. It should be "IN_BAND_WAKEUP", as
following patches shows.

Apologize for noise!

Br
Uffe
