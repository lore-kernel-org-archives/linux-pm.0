From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v3 1/3] ARM: da850: fix infinite loop in clk_set_rate()
Date: Wed, 7 Dec 2016 12:00:18 +0530
Message-ID: <94b2151a-7e9e-3e77-f3da-df2fa3b66848@ti.com>
References: <1480932549-30811-1-git-send-email-bgolaszewski@baylibre.com>
 <1480932549-30811-2-git-send-email-bgolaszewski@baylibre.com>
 <148e4d35-da65-a212-1490-c2d902dd4410@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fllnx209.ext.ti.com ([198.47.19.16]:63554 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbcLGGcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Dec 2016 01:32:36 -0500
In-Reply-To: <148e4d35-da65-a212-1490-c2d902dd4410@lechnology.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Lechner <david@lechnology.com>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <linux@armlinux.org.uk>, Viresh Kumar <viresh.kumar@linaro.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@atmel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org

On Wednesday 07 December 2016 07:24 AM, David Lechner wrote:
> On 12/05/2016 04:09 AM, Bartosz Golaszewski wrote:
>> The aemif clock is added twice to the lookup table in da850.c. This
>> breaks the children list of pll0_sysclk3 as we're using the same list
>> links in struct clk. When calling clk_set_rate(), we get stuck in
>> propagate_rate().
> 
> &emac_clk is used twice in this list as well. Shouldn't we fix it too? I
> would expect that it causes the same problem.

Yes, indeed.

Thanks,
Sekhar
