From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] PM / core: Assign the wakeup_path status flag in __device_prepare()
Date: Thu, 21 Dec 2017 02:43:09 +0100
Message-ID: <CAJZ5v0hctW_-WR2Gy4tszeXYJJfTRQbLCr_NRhAXao5_XR5NOw@mail.gmail.com>
References: <1513353391-30806-1-git-send-email-ulf.hansson@linaro.org> <1513353391-30806-2-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513353391-30806-2-git-send-email-ulf.hansson@linaro.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>, Vincent Guittot <vincent.guittot@linaro.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 15, 2017 at 4:56 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> The PM core in the device_prepare() phase, resets the wakeup_path status
> flag to the value of device_may_wakeup(). This means if a ->prepare() or a
> ->suspend() callback for the device would update the device's wakeup
> setting, this doesn't become reflected in the wakeup_path status flag.
>
> In general this isn't a problem, because wakeup settings isn't supposed to
> be changed during those system suspend phases. Nevertheless, there are a
> cases not conforming to that behaviour, as device_set_wakeup_enable() is
> indeed called from ->suspend() callbacks.

And why is this regarded as correct?
