From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] cpufreq: few fix on mvebu driver
Date: Sun, 17 Dec 2017 19:11:01 +0100
Message-ID: <7730090.7esIMHHDxy@aspire.rjw.lan>
References: <20171213172914.6148-1-gregory.clement@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53914 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757348AbdLQSLt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 17 Dec 2017 13:11:49 -0500
In-Reply-To: <20171213172914.6148-1-gregory.clement@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Antoine Tenart <antoine.tenart@free-electrons.com>, =?ISO-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@free-electrons.com>

On Wednesday, December 13, 2017 6:29:12 PM CET Gregory CLEMENT wrote:
> Hi,
> 
> The second patch of this series was originally part of the series "Add CPU
> Frequency scaling support on Armada 37xx" [1].
> 
> As requested by Viresh Kumar, it is extracted in a independent series.
> In the meantime, Thomas Petazzoni pointed an issue on the first
> version that I fixed in this series.
> 
> While I was on this driver I found an aother issue that I fixed with
> the first patch.
> 
> Thanks,
> 
> Gregory
> 
> [1]: http://lists.infradead.org/pipermail/linux-arm-kernel/2017-December/547650.html
> 
> Gregory CLEMENT (2):
>   cpufreq: mvebu: Free the clock reference in the normal path
>   cpufreq: mvebu: Free opp if registering failed
> 
>  drivers/cpufreq/mvebu-cpufreq.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> 

Both applied, thanks!
