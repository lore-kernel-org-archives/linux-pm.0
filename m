From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v2] PM / Domains: Allow holes in genpd_data.domains array
Date: Fri, 16 Sep 2016 00:00:06 +0200
Message-ID: <2780473.p0Dg5RSlIV@diego>
References: <5256c34e-5afb-2cfe-9818-8e6a6e1f0fa3@nvidia.com> <1473941123-15090-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:54279 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754966AbcIOWAT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Sep 2016 18:00:19 -0400
In-Reply-To: <1473941123-15090-1-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

Am Donnerstag, 15. September 2016, 14:05:23 schrieb Tomeu Vizoso:
> In platforms such as Rockchip's, the array of domains isn't always
> filled without holes, as which domains are present depend on the
> particular SoC revision.
> 
> By allowing holes to be in the array, such SoCs can still use a single
> set of constants to index the array of power domains.
> 
> Fixes: 0159ec670763 ("PM / Domains: Verify the PM domain is present when
> adding a provider") Signed-off-by: Tomeu Vizoso
> <tomeu.vizoso@collabora.com>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> Cc: Heiko Stuebner <heiko@sntech.de>

We talked about this today and the change looks good for handling the
holes in Rockchip power-domain lists, so

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

also, on a rk3288-veyron Chromebook the display comes up again
with this patch (by not defering because of the missing domains), so

Tested-by: Heiko Stuebner <heiko@sntech.de>


Thanks
Heiko
