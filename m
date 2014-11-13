From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH] PM / Domains: Fix initial default state of the need_restore
 flag
Date: Thu, 13 Nov 2014 22:22:49 +0200
Message-ID: <54651319.8010807@ti.com>
References: <1415366847-4807-1-git-send-email-ulf.hansson@linaro.org> <20141107215751.GA4439@dtor-ws> <CAPDyKFot-LZjazq190cY3-tawB_-ukdsmrLcD3vtidLvX68FOg@mail.gmail.com> <2882656.Dm8xnxDtKM@vostro.rjw.lan> <5464EF7B.6080402@ti.com> <20141113175449.GK3815@sirena.org.uk> <5465017F.5070303@ti.com> <20141113191129.GP3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:59084 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933977AbaKMUXQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 13 Nov 2014 15:23:16 -0500
In-Reply-To: <20141113191129.GP3815@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Hi Mark,

On 11/13/2014 09:11 PM, Mark Brown wrote:
> On Thu, Nov 13, 2014 at 09:07:43PM +0200, Grygorii Strashko wrote:
>> On 11/13/2014 07:54 PM, Mark Brown wrote:
> 
>>> No, it doesn't - probe() leaves the device powered (you can see the
>>> driver interacting with the device before it enables runtime PM).
> 
>> What I've found there is:
>> arizona_dev_init()
>>   |- arizona_clk32k_enable()
>>      |-pm_runtime_get_sync() if arizona->pdata.clk32k_src == ARIZONA_32KZ_MCLK1
            |-arizona_runtime_resume() if dev->driver.pm == arizona_pm_ops 

> 
>> so it's added as "may rely"
> 
> No, that's adding a reference to stop it power down under runtime PM -
> if runtime PM is inactive it will have no effect.
> 
NP. You know better - it's not about something wrong. It's just small
list of drivers where .runtime_resume() is called or may be called from
.probe() (just as an example) :)

regards,
-grygorii



