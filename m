From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: thermal/drivers/hisi: Remove bogus const from function return
 type
Date: Mon, 1 Jan 2018 10:21:26 -0800
Message-ID: <20180101182123.GA3753@localhost.localdomain>
References: <1511089467-20525-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:42601 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752227AbeAASV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jan 2018 13:21:29 -0500
Content-Disposition: inline
In-Reply-To: <1511089467-20525-1-git-send-email-geert@linux-m68k.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Kevin Wangtao <kevin.wangtao@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Geert,

On Sun, Nov 19, 2017 at 12:04:27PM +0100, Geert Uytterhoeven wrote:
> With gcc-4.1.2:
> 
>     drivers/thermal/hisi_thermal.c: In function ‘hisi_thermal_probe’:
>     drivers/thermal/hisi_thermal.c:530: warning: type qualifiers ignored on function return type
> 
> Remove the "const" keyword to fix this.

Interesting.

I intentionally asked Daniel to include the modifier because sparse
pointed this to me:

This patch adds this issue to hisi driver (sparse)

drivers/thermal/hisi_thermal.c:398:24: warning: incorrect type in assignment (different modifiers)
drivers/thermal/hisi_thermal.c:398:24:    expected int ( *platform_probe )( ... )
drivers/thermal/hisi_thermal.c:398:24:    got void const *

which makes sense to me to be const, given that it is receiving the return 
of a function which returns a const void *. 
nclude/linux/of_device.h:extern const void *of_device_get_match_data(const struct device *dev);

Cheers,
