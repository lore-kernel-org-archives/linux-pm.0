From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/9] amba: Keep PM domain powered during ->probe()
Date: Mon, 16 Mar 2015 09:37:11 +0100
Message-ID: <CAPDyKFr9W+eHFRzR5O+2em9EUiiW=oDrKCaG196yD7NgtPL90g@mail.gmail.com>
References: <1426261429-31883-1-git-send-email-ulf.hansson@linaro.org>
	<1426261429-31883-4-git-send-email-ulf.hansson@linaro.org>
	<20150313160341.GQ8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f179.google.com ([209.85.216.179]:35309 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbbCPIhM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2015 04:37:12 -0400
Received: by qcbkw5 with SMTP id kw5so37340501qcb.2
        for <linux-pm@vger.kernel.org>; Mon, 16 Mar 2015 01:37:11 -0700 (PDT)
In-Reply-To: <20150313160341.GQ8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 13 March 2015 at 17:03, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Mar 13, 2015 at 04:43:43PM +0100, Ulf Hansson wrote:
>> To sucessfully probe some devices their corresponding PM domains may
>> need to be powered.
>>
>> Use the dev_pm_domain_get|put() APIs, to control the behavior of the PM
>> domain.
>
> Given that AMBA gets the runtime PM status across a probe, none of this
> should be necessary, as generic PM domains ensures that if runtime PM
> is active for any device bound to the PM domain, the PM domain will be
> powered up.

This patch is needed to enable us to do the revert in patch 9. Since
otherwise amba drivers will probe their devices when the attached PM
domain may be powered off.

That should have been better explained in the commit message.

Kind regards
Uffe

>
> In that respect, AMBA is a model of how runtime PM should've been done
> for stuff like platform devices. :)
>
> --
> FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
> according to speedtest.net.
