From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH 2/3] thermal: rockchip: improve conversion error messages
Date: Mon, 21 Nov 2016 18:15:07 -0800
Message-ID: <20161122021506.GA103691@google.com>
References: <1479513177-81504-1-git-send-email-briannorris@chromium.org>
 <1479513177-81504-2-git-send-email-briannorris@chromium.org>
 <b6da9490-9a27-4330-7988-cb25724ba345@rock-chips.com>
 <378ade3d-a980-58e4-5253-c16702c74bf3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33619 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754309AbcKVCPL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 21 Nov 2016 21:15:11 -0500
Received: by mail-pf0-f172.google.com with SMTP id d2so1008350pfd.0
        for <linux-pm@vger.kernel.org>; Mon, 21 Nov 2016 18:15:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <378ade3d-a980-58e4-5253-c16702c74bf3@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Heiko Stuebner <heiko@sntech.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Stephen Barber <smbarber@chromium.org>, linux-rockchip@lists.infradead.org

On Tue, Nov 22, 2016 at 09:51:23AM +0800, Caesar Wang wrote:
> CHECK: Alignment should match open parenthesis
> #428: FILE: drivers/thermal/rockchip_thermal.c:428:
> +    pr_err("%s: invalid temperature, temp=%d error=%d\n",
> +        __func__, temp, error);
> 
> CHECK: Alignment should match open parenthesis
> #480: FILE: drivers/thermal/rockchip_thermal.c:480:
> +        pr_err("%s: invalid conversion table, mode=%d\n",
> +            __func__, table->mode);

What patch are you checking? I ran mine through checkpatch, and there
are no problems. Did you perhaps mangle the tabs into spaces when you
saved the patch?

> I'm ready to resend all rockchip thermal patches. (contain them)

I see no reason to resend so far; the only criticism was on the 1st
patch (a non-critical patch to the core thermal code; the others are
relatively independent, as long as you don't care that I'm adding
another error return without fixing up the broken
CONFIG_THERMAL_EMULATION support).

Brian
