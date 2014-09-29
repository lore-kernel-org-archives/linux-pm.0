From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpufreq: ppc-corenet: remove duplicate update of cpu_data
Date: Tue, 30 Sep 2014 01:41:29 +0200
Message-ID: <3197815.43z37DGtN8@vostro.rjw.lan>
References: <09092df3d8b03df99ee475357c5f5c9cc439c61c.1409629117.git.viresh.kumar@linaro.org> <28824009.MYR6qnPOLR@vostro.rjw.lan> <CAKohponrb872=EDKea8U+j8ofOF0cs75Nh6VehByXWZhj1eCUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65533 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751028AbaI2XVe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Sep 2014 19:21:34 -0400
In-Reply-To: <CAKohponrb872=EDKea8U+j8ofOF0cs75Nh6VehByXWZhj1eCUQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Yuantian Tang <yuantian.tang@freescale.com>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Hongbo Zhang <hongbo.zhang@freescale.com>, Li Yang <leoli@freescale.com>

On Monday, September 29, 2014 02:05:15 AM Viresh Kumar wrote:
> On 24 September 2014 16:45, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Tuesday, September 02, 2014 09:11:24 AM Viresh Kumar wrote:
> >> 'cpu_data' is updated for policy->cpu first and then for all CPUs in
> >> policy->cpus. policy->cpus is guaranteed to contain policy->cpu as well and so
> >> the first write to 'cpu_data' for policy->cpu is redundant. Remove it.
> >>
> >> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > I'm not sure about the status here?
> 
> Apply only the first patch (1/2) with
> 
> Acked-by: Tang Yuantian <Yuantian.Tang@freescale.com>

Please resend with the ACK.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
