From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: thermal: introduce the Power Allocator governor
Date: Sat, 21 Nov 2015 13:42:54 +0300
Message-ID: <20151121104254.GA10268@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:47307 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbKUKnG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 21 Nov 2015 05:43:06 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: javi.merino@arm.com
Cc: linux-pm@vger.kernel.org

Hello Javi Merino,

The patch 6b775e870c56: "thermal: introduce the Power Allocator
governor" from Mar 2, 2015, leads to the following static checker
warning:

	drivers/thermal/power_allocator.c:304 divvy_up_power()
	warn: should 'req_power[i] * power_range' be a 64 bit type?

drivers/thermal/power_allocator.c
   288  static void divvy_up_power(u32 *req_power, u32 *max_power, int num_actors,
   289                             u32 total_req_power, u32 power_range,
   290                             u32 *granted_power, u32 *extra_actor_power)
   291  {
   292          u32 extra_power, capped_extra_power;
   293          int i;
   294  
   295          /*
   296           * Prevent division by 0 if none of the actors request power.
   297           */
   298          if (!total_req_power)
   299                  total_req_power = 1;
   300  
   301          capped_extra_power = 0;
   302          extra_power = 0;
   303          for (i = 0; i < num_actors; i++) {
   304                  u64 req_range = req_power[i] * power_range;

Both req_power[i] and power_range are u32 so the high bits of req_range
are not used.

   305  
   306                  granted_power[i] = DIV_ROUND_CLOSEST_ULL(req_range,
   307                                                           total_req_power);
   308  
   309                  if (granted_power[i] > max_power[i]) {
   310                          extra_power += granted_power[i] - max_power[i];
   311                          granted_power[i] = max_power[i];
   312                  }
   313  
   314                  extra_actor_power[i] = max_power[i] - granted_power[i];
   315                  capped_extra_power += extra_actor_power[i];
   316          }

regards,
dan carpenter
