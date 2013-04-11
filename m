From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v6 3/8] reset: Add driver for gpio-controlled reset pins
Date: Thu, 11 Apr 2013 09:45:43 -0700
Message-ID: <CAOesGMg8JEntxcOeh667d84_UwS5M3XQpSKJsTiHrPaOkvtwHA@mail.gmail.com>
References: <1364488523-20310-1-git-send-email-p.zabel@pengutronix.de>
	<1364488523-20310-4-git-send-email-p.zabel@pengutronix.de>
	<CAOesGMgo61M=oxG6_6EEGu7kL3Wa+HsdEomCxUnvj-Rbdhujgg@mail.gmail.com>
	<5166DCC4.6050206@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-we0-f181.google.com ([74.125.82.181]:61167 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935363Ab3DKQpp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Apr 2013 12:45:45 -0400
Received: by mail-we0-f181.google.com with SMTP id d7so1405459wer.40
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2013 09:45:44 -0700 (PDT)
In-Reply-To: <5166DCC4.6050206@wwwdotorg.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Marek Vasut <marex@denx.de>, Fabio Estevam <fabio.estevam@freescale.com>, Mike Turquette <mturquette@linaro.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sascha Hauer <s.hauer@pengutronix.de>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>

On Thu, Apr 11, 2013 at 8:54 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 04/11/2013 04:35 AM, Olof Johansson wrote:
>> On Thu, Mar 28, 2013 at 9:35 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>>> This driver implements a reset controller device that toggles gpios
>>> connected to reset pins of peripheral ICs. The delay between assertion
>>> and de-assertion of the reset signal can be configured.
> ...
>> Since this is a platform driver and not just an OF driver, shouldn't
>> you provide a way to specify the same configuration data through a
>> platform_data structure as well?
>
> I believe the only practical use-cases for this driver are /currently/
> for device-tree platforms. Shouldn't we add the platform_data support
> only when some platform actively uses it?

Then the Kconfig needs to depend on OF in this case.

> In the past when reviewing new drivers, I pushed for platform drivers to
> always implement the platform_data structure up-front, and support using
> that if present rather than "falling back" to DT. However, Grant then
> shot that down saying that there was no point adding dead code...

Uh, ok. I don't care much either way but it somehow seems like it'll
be impopular to start adding a lot of new "depends on OF" drivers. I
might be wrong though.

> (this will also feed into the discussion about simple-framebuffer, which
> also only needs DT support right now, but could in theory be extended to
> support platform_data in the future if somebody wants).

Yeah, that's turning out to be a color preference discussion for
sheds, not very surprising.


-Olof
