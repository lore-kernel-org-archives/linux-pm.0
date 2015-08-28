From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V4 2/2] PM / OPP: Fix static checker warning (broken 64bit big endian systems)
Date: Fri, 28 Aug 2015 16:14:33 +0200
Message-ID: <20319405.E46lXZHqyF@vostro.rjw.lan>
References: <fac7aa53b304bbff1ff22f65670e05e5e6dc6396.1439376998.git.viresh.kumar@linaro.org> <0a41aca3107cea2d9fac3f4536e5c7f4acd90f7d.1439818955.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52827 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751841AbbH1Nq6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2015 09:46:58 -0400
In-Reply-To: <0a41aca3107cea2d9fac3f4536e5c7f4acd90f7d.1439818955.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, dan.carpenter@oracle.com, nm@ti.com, sboyd@codeaurora.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>

On Monday, August 17, 2015 07:20:20 PM Viresh Kumar wrote:
> Dan Carpenter reported (generated with static checker):
> 
> drivers/base/power/opp.c:949 _opp_add_static_v2()
> warn: passing casted pointer '&new_opp->clock_latency_ns' to
> 'of_property_read_u32()' 64 vs 32.
> 
> This code will break on 64 bit, big endian machines.
> 
> Fix this by reading the value in a u32 type variable first and then
> assigning it to the unsigned long variable.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

I've applied this and the [1/2], thanks!

Rafael

