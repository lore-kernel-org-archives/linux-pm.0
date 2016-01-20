From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH v2 1/4] dt-bindings: power: reset: add document for
 reboot-mode driver
Date: Wed, 20 Jan 2016 12:25:44 -0800
Message-ID: <CALAqxLVY7mg2arS7u63fRow8Ln2u7hbrfFf1h2UcoojtwJMRyw@mail.gmail.com>
References: <1452598029-8222-1-git-send-email-andy.yan@rock-chips.com>
	<1452598189-8272-1-git-send-email-andy.yan@rock-chips.com>
	<20160120182840.GA15741@rob-hp-laptop>
	<CALAqxLVvJqL60nKfrDiZ+p-1ujxuG72iUN3DCvEE3WJ9bpnGLA@mail.gmail.com>
	<CAL_Jsq+suCyqSi+cJiVLuA0aZKSciAaeUKW9A5Y_X_3wyW60Ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33930 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754719AbcATUZp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 20 Jan 2016 15:25:45 -0500
Received: by mail-yk0-f173.google.com with SMTP id a85so23832961ykb.1
        for <linux-pm@vger.kernel.org>; Wed, 20 Jan 2016 12:25:45 -0800 (PST)
In-Reply-To: <CAL_Jsq+suCyqSi+cJiVLuA0aZKSciAaeUKW9A5Y_X_3wyW60Ug@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Andy Yan <andy.yan@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Arnd Bergmann <arnd@arndb.de>, Guenter Roeck <linux@roeck-us.net>, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Sebastian Reichel <sre@kernel.org>, Olof Johansson <olof@lixom.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jun Nie <jun.nie@linaro.org>, =?UTF-8?Q?Pawe=C5=82_Moll?= <pawel.moll@arm.com>, Florian Fainelli <f.fainelli@gmail.com>, Will Deacon <will.deacon@arm.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On Wed, Jan 20, 2016 at 11:53 AM, Rob Herring <robh@kernel.org> wrote:
> On Wed, Jan 20, 2016 at 12:47 PM, John Stultz <john.stultz@linaro.org> wrote:
> The question here really is will we ever need additional data for each
> mode (in the DT) besides "magic". We can do some amount of extending
> the property like allowing more that single 32-bit value. We can't mix
> strings and integers though. If we don't need that, then lets go with
> the more concise approach. This isn't really an evolving area.
> Selecting boot mode/device has existed for a long time on PCs (it is
> fixed list in the IPMI spec for example). So I can't imagine that we'd
> have to extend this, but I'd like to hear thoughts on it. You had
> mentioned the Galaxy Nexus having a value and a string, but I'd find
> it surprising if the bootloader actually uses the string.

So I've been told the galaxy nexus and possibly other older TI
hardware used only a string.

And the HTC implementations I've seen have code for both a string and
command to be placed, but usually don't actually copy anything to the
string address (which suggest its not used by the bootloader, as you
note).

Either way, we'd have to extend or implement a new driver, but that's
a bridge I think we can cross later when we see such hardware support
upstream (rather then try to create a super driver that handles
everything a creative firmware developer could come up with).

thanks
-john
