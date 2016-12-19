From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v2] power: reset: add linkstation-reset driver
Date: Mon, 19 Dec 2016 09:34:11 +0900
Message-ID: <20161219093411.8ab4b73814a9701337f889f2@gmail.com>
References: <20161207172415.9776-1-rogershimizu@gmail.com>
        <20161216100501.18173-1-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34775 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751694AbcLSAeQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Dec 2016 19:34:16 -0500
Received: by mail-pg0-f65.google.com with SMTP id b1so6495974pgc.1
        for <linux-pm@vger.kernel.org>; Sun, 18 Dec 2016 16:34:15 -0800 (PST)
In-Reply-To: <20161216100501.18173-1-rogershimizu@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Ryan Tandy <ryan@nardis.ca>, Martin Michlmayr <tbm@cyrius.com>, Sylver Bruneau <sylver.bruneau@googlemail.com>, Herbert Valerio Riedel <hvr@gnu.org>

On Fri, 16 Dec 2016 19:05:01 +0900
Roger Shimizu <rogershimizu@gmail.com> wrote:

> Buffalo Linkstation / KuroBox and their variants need magic command
> sending to UART1 to power-off.
> 
> Power driver linkstation-reset implements the magic command and I/O
> routine, which come from files listed below:
>   - arch/arm/mach-orion5x/kurobox_pro-setup.c
>   - arch/arm/mach-orion5x/terastation_pro2-setup.c
> 
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Martin Michlmayr <tbm@cyrius.com>
> Cc: Sylver Bruneau <sylver.bruneau@googlemail.com>
> Cc: Herbert Valerio Riedel <hvr@gnu.org>
> Reported-by: Ryan Tandy <ryan@nardis.ca>
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---

Original reporter Ryan Tandy told me in a separate email that he has confirmed my patch works on his Linkstation Pro device.
So please add:

  Tested-by: Ryan Tandy <ryan@nardis.ca>

when merging this patch. Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
