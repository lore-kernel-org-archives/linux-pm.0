From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH 2/5] clk: Introduce 'clk_round_rate_nearest()'
Date: Mon, 26 May 2014 16:37:13 +0530
Message-ID: <CAKohpomam0qKdkMMMRDOfWN9QnZ3DzCviV=RuZ5f_7JbmYNDNw@mail.gmail.com>
References: <20140521073457.GD31687@pengutronix.de>
	<00f65d1c-a375-40e7-b30a-cd8cb3ca87fc@BN1BFFO11FD020.protection.gbl>
	<CAKohpomb+h6ZNDgJ8AwJ_J9DjMB7AP_v-cp8coG3CACo5Wt4vQ@mail.gmail.com>
	<9956925.Qsz2bH3rDg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:37990 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbaEZLHO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 May 2014 07:07:14 -0400
Received: by mail-ob0-f174.google.com with SMTP id uz6so7962944obc.33
        for <linux-pm@vger.kernel.org>; Mon, 26 May 2014 04:07:13 -0700 (PDT)
In-Reply-To: <9956925.Qsz2bH3rDg@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Russell King <linux@arm.linux.org.uk>, Stephen Boyd <sboyd@codeaurora.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Michal Simek <michal.simek@xilinx.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 26 May 2014 16:52, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> I agree as far as the 64-bit thing goes, but is switching to Hz really
> necessary?

Don't really know that.. It seems that there will always be problems with
close enough frequencies whenever rounding is done.

More can be elaborated by Soren.
