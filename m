From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / AVS: rockchip-io: make the log more consistent
Date: Tue, 18 Oct 2016 14:14:18 -0700
Message-ID: <7heg3d9x79.fsf@baylibre.com>
References: <1476103462-7559-1-git-send-email-shawn.lin@rock-chips.com>
        <1883054.D2Rm2X9N2G@phil>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35846 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752265AbcJRVOU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Oct 2016 17:14:20 -0400
Received: by mail-pf0-f175.google.com with SMTP id e6so2726876pfk.3
        for <linux-pm@vger.kernel.org>; Tue, 18 Oct 2016 14:14:20 -0700 (PDT)
In-Reply-To: <1883054.D2Rm2X9N2G@phil> (Heiko Stuebner's message of "Mon, 10
        Oct 2016 22:15:50 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>

Heiko Stuebner <heiko@sntech.de> writes:

> Am Montag, 10. Oktober 2016, 20:44:22 CEST schrieb Shawn Lin:
>> When testing SD hotplug automatically, I got bunch of
>> useless log like this:
>> 
>> [  588.357838] mmc0: card 0007 removed
>> [  589.492664] rockchip-iodomain ff770000.syscon:io-domains: Setting to
>> 3300000 done [  589.500698] vccio_sd: ramp_delay not set
>> [  589.504817] rockchip-iodomain ff770000.syscon:io-domains: Setting to
>> 3300000 done [  589.669705] rockchip-iodomain ff770000.syscon:io-domains:
>> Setting to 3300000 done [  589.677593] vccio_sd: ramp_delay not set
>> [  589.681581] rockchip-iodomain ff770000.syscon:io-domains: Setting to
>> 1800000 done [  590.032820] dwmmc_rockchip ff0c0000.dwmmc: Successfully
>> tuned phase to 140 [  590.039725] mmc0: new ultra high speed SDR50 SDHC
>> card at address 0007 [  590.046641] mmcblk0: mmc0:0007 SD32G 29.3 GiB
>> [  590.052163]  mmcblk0: p1
>> 
>> Moreover the code is intent to print the 'uV' for debug but
>> later print it using dev_info. It looks more like to me that
>> it should be the real intention of the code. Anyway, let's
>> mark this verbose log as debug message.
>> 
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>
> reducing the amount of logs, especially for information not generally needed 
> looks sane
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Acked-by: Kevin Hilman <khilman@baylibre.com>

Rafael, feel free to apply directly as a fix for v4.9-rc, or wait for
v4.10 if you prefer.

Kevin
