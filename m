From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the need_restore
 flag
Date: Thu, 13 Nov 2014 21:07:43 +0200
Message-ID: <5465017F.5070303@ti.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org> <20141107215751.GA4439@dtor-ws> <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com> <2882656.Dm8xnxDtKM@vostro.rjw.lan> <5464EF7B.6080402@ti.com> <20141113175449.GK3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:51500 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754023AbaKMTII (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 13 Nov 2014 14:08:08 -0500
In-Reply-To: <20141113175449.GK3815@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

On 11/13/2014 07:54 PM, Mark Brown wrote:
> On Thu, Nov 13, 2014 at 07:50:51PM +0200, Grygorii Strashko wrote:
> 
>> I've checked few folders and below few drivers i found which rely or may rely on their
>> .runtime_resume callback to be executed (It very hard to identify dependency for some of drivers):
> 
>> arizona-core.c
> 
> No, it doesn't - probe() leaves the device powered (you can see the
> driver interacting with the device before it enables runtime PM).
> 

What I've found there is:
arizona_dev_init()
 |- arizona_clk32k_enable()
    |-pm_runtime_get_sync() if arizona->pdata.clk32k_src == ARIZONA_32KZ_MCLK1

so it's added as "may rely"

regards,
-grygorii

