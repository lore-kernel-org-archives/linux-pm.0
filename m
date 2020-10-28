Return-Path: <SRS0=Ui8E=ED=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C56C388F7
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 22:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3031A20754
	for <linux-pm@archiver.kernel.org>; Wed, 28 Oct 2020 22:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389659AbgJ1Www (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 28 Oct 2020 18:52:52 -0400
Received: from leibniz.telenet-ops.be ([195.130.137.77]:56812 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389655AbgJ1Wv6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2020 18:51:58 -0400
X-Greylist: delayed 4199 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Oct 2020 18:51:57 EDT
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4CLkR13wFdzMqwlG
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2020 10:53:17 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id lMtG2300W4C55Sk01MtGMp; Wed, 28 Oct 2020 10:53:17 +0100
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXi8q-000lf0-Hq; Wed, 28 Oct 2020 10:53:16 +0100
Date:   Wed, 28 Oct 2020 10:53:16 +0100 (CET)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] opp: Don't always remove static OPPs in
 _of_add_opp_table_v1()
In-Reply-To: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
Message-ID: <alpine.DEB.2.22.394.2010281050200.183010@ramsan.of.borg>
References: <2c73ab54717ef358b118ea0cfb727b1427e7730a.1602648719.git.viresh.kumar@linaro.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

 	Hi Viresh,

On Wed, 14 Oct 2020, Viresh Kumar wrote:
> The patch missed returning 0 early in case of success and hence the
> static OPPs got removed by mistake. Fix it.
>
> Fixes: 90d46d71cce2 ("opp: Handle multiple calls for same OPP table in _of_add_opp_table_v1()")
> Reported-by: Aisheng Dong <aisheng.dong@nxp.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This revives cpufreq on R-Car Gen2, and fixes a later s2ram regression
in commit dc279ac6e5b4e06e ("cpufreq: dt: Refactor initialization to
handle probe deferral properly"), where the PMIC is accessesed while
the I2C controller is still suspended.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -944,6 +944,8 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
> 		nr -= 2;
> 	}
>
> +	return 0;
> +
> remove_static_opp:
> 	_opp_remove_all_static(opp_table);
>
> -- 
> 2.25.0.rc1.19.g042ed3e048af

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
