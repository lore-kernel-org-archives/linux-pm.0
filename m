From: Ryan Tandy <ryan@nardis.ca>
Subject: Re: [PATCH v4 1/2] power: reset: add linkstation-reset driver
Date: Sun, 8 Jan 2017 09:02:09 -0800
Message-ID: <20170108170209.GD573@kiwi.nardis.ca>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33360 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754196AbdAHRCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 8 Jan 2017 12:02:12 -0500
Received: by mail-pg0-f67.google.com with SMTP id 194so4822343pgd.0
        for <linux-pm@vger.kernel.org>; Sun, 08 Jan 2017 09:02:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20170107150451.17912-2-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Roger Shimizu <rogershimizu@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>, Florian Fainelli <f.fainelli@gmail.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Roger,

On Sun, Jan 08, 2017 at 12:04:50AM +0900, Roger Shimizu wrote:
>+config POWER_RESET_LINKSTATION
>+	bool "Buffalo Linkstation and its variants reset driver"
>+	depends on OF_GPIO && PLAT_ORION
>+	help
>+	  This driver supports power off Buffalo Linkstation / KuroBox Pro
>+	  NAS and their variants by sending commands to the micro-controller
>+	  which controls the main power.
>+
>+	  Say Y if you have a Buffalo Linkstation / KuroBox Pro NAS.
>+

Would it make sense to mention something about these being the 
ARM9/orion5x Linkstations? If I understand correctly, the older PPC 
Linkstations have a single-byte poweroff command. (Maybe they could even 
be supported by qnap-poweroff.)

See arch/powerpc/platforms/embedded6xx/linkstation.c around line 123, 
and arch/powerpc/platforms/embedded6xx/ls_uart.c.
