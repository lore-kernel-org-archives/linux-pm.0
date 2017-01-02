From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v4 4/4] ARM: da850: fix da850_set_pll0rate()
Date: Mon, 2 Jan 2017 15:42:47 +0530
Message-ID: <a04624ec-6c6e-6a5b-0626-cc3520cccb29@ti.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
 <1481124138-27337-5-git-send-email-bgolaszewski@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:23753 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932208AbdABKN7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jan 2017 05:13:59 -0500
In-Reply-To: <1481124138-27337-5-git-send-email-bgolaszewski@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Wednesday 07 December 2016 08:52 PM, Bartosz Golaszewski wrote:
> This function is confusing - its second argument is an index to the
> freq table, not the requested clock rate in Hz, but it's used as the
> set_rate callback for the pll0 clock. It leads to an oops when the
> caller doesn't know the internals and passes the rate in Hz as
> argument instead of the cpufreq index since this argument isn't bounds
> checked either.
> 
> Fix it by iterating over the array of supported frequencies and
> selecting a one that matches or returning -EINVAL for unsupported
> rates.
> 
> Also: update the davinci cpufreq driver. It's the only user of this
> clock and currently it passes the cpufreq table index to
> clk_set_rate(), which is confusing. Make it pass the requested clock
> rate in Hz.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to v4.11/fixes-non-critical

Thanks,
Sekhar
