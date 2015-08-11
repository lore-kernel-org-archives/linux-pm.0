From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PM / OPP: Add clock-latency-ns support
Date: Tue, 11 Aug 2015 13:42:28 +0530
Message-ID: <20150811081228.GC5509@linux>
References: <20150810163804.GA10496@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:35609 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932079AbbHKIMc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 04:12:32 -0400
Received: by pdrg1 with SMTP id g1so81061957pdr.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2015 01:12:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150810163804.GA10496@mwanda>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-pm@vger.kernel.org

On 10-08-15, 19:38, Dan Carpenter wrote:
> Hello Viresh Kumar,
> 
> The patch 3ca9bb33c627: "PM / OPP: Add clock-latency-ns support" from
> Jul 29, 2015, leads to the following static checker warning:
> 
> 	drivers/base/power/opp.c:949 _opp_add_static_v2()
> 	warn: passing casted pointer '&new_opp->clock_latency_ns' to 'of_property_read_u32()' 64 vs 32.
> 
> drivers/base/power/opp.c
>    946          new_opp->np = np;
>    947          new_opp->dynamic = false;
>    948          new_opp->available = true;
>    949          of_property_read_u32(np, "clock-latency-ns",
>    950                               (u32 *)&new_opp->clock_latency_ns);
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> This code will break on 64 bit, big endian machines.  I doin't know if
> that is an issue for this driver.  I saw this was in the power/
> directory and I spent a minute googling to see if PowerPC machines are
> big endian...  :P
> 
>    951  
>    952          ret = opp_get_microvolt(new_opp, dev);
>    953          if (ret)
>    954                  goto free_opp;
>    955  
> 
> Also:
> 
> 	drivers/base/power/opp.c:956 _opp_add_static_v2()
> 	warn: passing casted pointer '&new_opp->u_amp' to 'of_property_read_u32()' 64 vs 32.

Hi Dan,

The problem is that the value here is of type 'unsigned long' which is
32/64 bit on 32/64 bit machines.

So, I looked at how other places in code has done it, and that's what
I found.

-- 
viresh
