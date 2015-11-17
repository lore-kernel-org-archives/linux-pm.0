From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] cpufreq: do not mark s3c2410_plls_add as __init
Date: Tue, 17 Nov 2015 10:01:36 +0100
Message-ID: <4654010.UfKTsDKyes@wuerfel>
References: <8497197.sYxqVOch7s@wuerfel> <4389196.cuM78vZZnJ@wuerfel> <564A899C.4040402@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:53451 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbbKQJCO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2015 04:02:14 -0500
In-Reply-To: <564A899C.4040402@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>

On Tuesday 17 November 2015 10:57:48 Krzysztof Kozlowski wrote:
> On 17.11.2015 07:17, Arnd Bergmann wrote:
> > On Monday 16 November 2015 23:36:42 Rafael J. Wysocki wrote:
> >>
> >> This should go in through the Samsung tree, so I'll leave it for them to pick
> >> it up (at least for the time being).
> > 
> > Ok, fair enough. Kukjin or Krzysztof, can you pick this up?
> 
> Sure.
> 
> As for the patch I think everything can be converted to init/initdata
> (as in attachment).
> 

I don't think so:

static struct subsys_interface s3c2442_plls169344_interface __initdata = {
        .name           = "s3c2442_plls169344",
        .subsys         = &s3c2442_subsys,
        .add_dev        = s3c2440_plls169344_add,
};

This gets passed into subsys_interface_register(), which is not __init
in turn. subsys_interface_register() then goes on to add
s3c2442_plls169344_interface into a linked list that is traversed
at runtime, but the __initdata section gets discarded so you now
have a broken list.

	Arnd

