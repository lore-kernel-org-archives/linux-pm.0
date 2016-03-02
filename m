From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] thermal: rcar_thermal: don't open code of_device_get_match_data()
Date: Wed, 2 Mar 2016 10:07:36 +0100
Message-ID: <CAMuHMdW3E_QAjDYqzONL0ZMgupMZop=XLFfatsT_rzCSkmtRDg@mail.gmail.com>
References: <1456850319-8386-1-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:32860 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337AbcCBJHi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 04:07:38 -0500
In-Reply-To: <1456850319-8386-1-git-send-email-wsa@the-dreams.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM list <linux-pm@vger.kernel.org>

On Tue, Mar 1, 2016 at 5:38 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> This change will also make Coverity happy by avoiding a theoretical NULL
> pointer dereference; yet another reason is to use the above helper function
> to tighten the code and make it more readable.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
