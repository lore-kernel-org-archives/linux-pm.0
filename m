From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Mon, 26 May 2014 11:59:09 +0530
Message-ID: <CAKohpomb+h6ZNDgJ8AwJ_J9DjMB7AP_v-cp8coG3CACo5Wt4vQ@mail.gmail.com>
References: <20140521073457.GD31687@pengutronix.de>
	<e9090453-ce40-4662-a3ea-fbdaffdb2aa4@BN1AFFO11FD046.protection.gbl>
	<20140521182308.GN31687@pengutronix.de>
	<20140521203300.9521.67546@quantum>
	<ac335a38-b0f4-4d95-b111-56c05e1a6234@BN1BFFO11FD045.protection.gbl>
	<20140522182040.GB20155@pengutronix.de>
	<6612b069-1228-488f-81f7-ea8839f6c468@BN1BFFO11FD029.protection.gbl>
	<20140522210328.9521.34889@quantum>
	<a86642cb-855f-455f-b07c-a52bc6aa426f@BN1BFFO11FD050.protection.gbl>
	<20140523013732.9521.70820@quantum>
	<00f65d1c-a375-40e7-b30a-cd8cb3ca87fc@BN1BFFO11FD020.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:47215 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546AbaEZG3K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 02:29:10 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so7966635oag.2
        for <linux-pm@vger.kernel.org>; Sun, 25 May 2014 23:29:10 -0700 (PDT)
In-Reply-To: <00f65d1c-a375-40e7-b30a-cd8cb3ca87fc@BN1BFFO11FD020.protection.gbl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Cc: Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Michal Simek <michal.simek@xilinx.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 23 May 2014 21:44, S=C3=B6ren Brinkmann <soren.brinkmann@xilinx.com>=
 wrote:
> Viresh: Could you imagine something similar for cpufreq? You suggeste=
d
> migrating to Hz resolution. I guess that would ideally mean to follow
> the CCF to a 64-bit type for frequencies and increasing the resolutio=
n.
> I have a messy patch migrating cpufreq and OPP to Hz and unsigned lon=
g
> that works on Zynq. But cpufreq has so many users that it would becom=
e
> quite an undertaking.
> And we'd need some new/amended OPP DT binding.

If we are going to migrate to Hz from KHz, I think we must consider the
64 bit stuff right now, otherwise it will bite us later.

@Rafael: What do you think?
