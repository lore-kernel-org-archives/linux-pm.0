From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2] PM / Domains: Allow holes in genpd_data.domains array
Date: Fri, 16 Sep 2016 09:13:05 -0700
Message-ID: <7hy42rj01a.fsf@baylibre.com>
References: <5256c34e-5afb-2cfe-9818-8e6a6e1f0fa3@nvidia.com>
        <1473941123-15090-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473941123-15090-1-git-send-email-tomeu.vizoso@collabora.com>
        (Tomeu Vizoso's message of "Thu, 15 Sep 2016 14:05:23 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Heiko Stuebner <heiko@sntech.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Tomeu Vizoso <tomeu.vizoso@collabora.com> writes:

> In platforms such as Rockchip's, the array of domains isn't always
> filled without holes, as which domains are present depend on the
> particular SoC revision.
>
> By allowing holes to be in the array, such SoCs can still use a single
> set of constants to index the array of power domains.
>
> Fixes: 0159ec670763 ("PM / Domains: Verify the PM domain is present when adding a provider")
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Heiko Stuebner <heiko@sntech.de>
>
> ---
>
> v2: Also skip holes in the error path.

Acked-by: Kevin Hilman <khilman@baylibre.com>
