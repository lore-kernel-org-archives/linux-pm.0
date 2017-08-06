From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 18/18] i2c-cht-wc: Add device-properties for fusb302 integration
Date: Sun, 6 Aug 2017 19:29:08 +0300
Message-ID: <CAHp75VfM-cGzhng4amYs=Y3nJorFud6u6R_xj4C-rSJuHePicQ@mail.gmail.com>
References: <20170806123555.5124-1-hdegoede@redhat.com> <20170806123555.5124-19-hdegoede@redhat.com>
 <9ba933c6-daae-f30d-2c83-e9c2b756d27f@roeck-us.net> <ae6fcdce-1dd0-d29f-ce04-9d9c77f14730@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34733 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751300AbdHFQ3J (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 6 Aug 2017 12:29:09 -0400
In-Reply-To: <ae6fcdce-1dd0-d29f-ce04-9d9c77f14730@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Wolfram Sang <wsa@the-dreams.de>, Sebastian Reichel <sre@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Platform Driver <platform-driver-x86@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-i2c <linux-i2c@vger.kernel.org>, Liam Breck <liam@networkimprov.net>, Tony Lindgren <tony@atomide.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, devel@driverdev.osuosl.org

On Sun, Aug 6, 2017 at 6:05 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> On 06-08-17 16:35, Guenter Roeck wrote:
>> On 08/06/2017 05:35 AM, Hans de Goede wrote:

> FWIW all DSTDs I've seen are all copy and paste and all declare a INT33FE
> ACPI
> device with identical i2c client addresses which strongly suggests the
> use of the same combo. Note that on most devices this part of the DSTD is
> not active (_STA returns 0) because they actually use a different config.

Which is quite likely just blindly copied from a reference BIOS code.
(Reminds me that bug with GPIO pin setting for interrupt as output only)

> The only extra safe-guard I can come up with is a DMI string check, but that
> is sub-optimal since the DMI strings on these devices contain useful values
> as "Default String" still we could add it as an extra check.

...and in worst cases CPU model ID.

> Since I had the same concern I've done a web search and I've been unable
> to find any other devices which seem to use a Whiskey Cove PMIC, but that
> does not mean that there aren't any.


-- 
With Best Regards,
Andy Shevchenko
