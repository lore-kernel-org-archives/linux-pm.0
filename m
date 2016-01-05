From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] PM / OPP: Use snprintf() instead of sprintf()
Date: Tue, 5 Jan 2016 11:51:16 +0100
Message-ID: <CAMuHMdVdNbGmA+tQ54E=eZcKz6EZMBj4n1Udc1SrdsHCyLB-EQ@mail.gmail.com>
References: <dd64d12079ec788d337b17840e54f0fc60d3b8ce.1451990751.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:33496 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751997AbcAEKvR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2016 05:51:17 -0500
In-Reply-To: <dd64d12079ec788d337b17840e54f0fc60d3b8ce.1451990751.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel <linaro-kernel@lists.linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>, Viresh Kumar <vireshk@kernel.org>

On Tue, Jan 5, 2016 at 11:45 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> sprintf() can access memory outside of the range of the character array,
> and is risky in some situations. The driver specified prop_name string
> can be longer than NAME_MAX here (only an attacker will do that though)
> and so blindly copying it into the character array of size NAME_MAX
> isn't safe. Instead we must use snprintf() here.

Thanks!

> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
