From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: PM / OPP: Add clock-latency-ns support
Date: Mon, 10 Aug 2015 19:38:04 +0300
Message-ID: <20150810163804.GA10496@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:50109 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750958AbbHJQiT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Aug 2015 12:38:19 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch 3ca9bb33c627: "PM / OPP: Add clock-latency-ns support" from
Jul 29, 2015, leads to the following static checker warning:

	drivers/base/power/opp.c:949 _opp_add_static_v2()
	warn: passing casted pointer '&new_opp->clock_latency_ns' to 'of_property_read_u32()' 64 vs 32.

drivers/base/power/opp.c
   946          new_opp->np = np;
   947          new_opp->dynamic = false;
   948          new_opp->available = true;
   949          of_property_read_u32(np, "clock-latency-ns",
   950                               (u32 *)&new_opp->clock_latency_ns);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^

This code will break on 64 bit, big endian machines.  I doin't know if
that is an issue for this driver.  I saw this was in the power/
directory and I spent a minute googling to see if PowerPC machines are
big endian...  :P

   951  
   952          ret = opp_get_microvolt(new_opp, dev);
   953          if (ret)
   954                  goto free_opp;
   955  

Also:

	drivers/base/power/opp.c:956 _opp_add_static_v2()
	warn: passing casted pointer '&new_opp->u_amp' to 'of_property_read_u32()' 64 vs 32.

regards,
dan carpenter
