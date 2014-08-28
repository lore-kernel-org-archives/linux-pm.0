From: "Elliott, Robert (Server Storage)" <Elliott@hp.com>
Subject: cpufreq_governor_lock contention
Date: Thu, 28 Aug 2014 15:40:46 +0000
Message-ID: <94D0CD8314A33A4D9D801C0FE68B402958C2A19D@G9W0745.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g4t3426.houston.hp.com ([15.201.208.54]:15458 "EHLO
	g4t3426.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbaH1Plx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 28 Aug 2014 11:41:53 -0400
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "jiel@marvell.com" <jiel@marvell.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "scameron@beardog.cce.hp.com" <scameron@beardog.cce.hp.com>

While running heavy storage IO to test scsi-mq in 3-17.0-rc1,
cpufreq_governor_lock shows up as the third highest contended lock 
- about 21 million contentions in a 12 hour test run.

It looks like that might be from a patch in January that added
the calls in gov_queue_work:
   https://lkml.org/lkml/2014/1/3/34

Could this be modified to run lockless?

>From /proc/lock_stat (very wide lines), the top 4 were:
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
                              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------37--

                   async_umap_flush_lock:    5328638171     5328649297           0.08         524.83 153171738163.9         148.18    14311039119    15023422962           0.09        1405.42 18458469940.63           8.63
                   ---------------------
                   async_umap_flush_lock     5328649297          [<ffffffff814ed355>] add_unmap+0x35/0xf0
                   ---------------------
                   async_umap_flush_lock             10          [<ffffffff814ed42a>] flush_unmaps_timeout+0x1a/0x40
                   async_umap_flush_lock     5328649287          [<ffffffff814ed355>] add_unmap+0x35/0xf0                                     261           4012                                     72539.44

.............................................................................................................................................................................................................................

                  &(&__ctx->lock)->rlock:     147426205      148262954           0.09        1119.96  2169366898.55          14.63     1029612354    30151514252           0.07        1688.77 39760142571.97         458.37
                  ----------------------
                  &(&__ctx->lock)->rlock      145415400          [<ffffffff8129b164>] __blk_mq_run_hw_queue+0xd4/0x340
                  &(&__ctx->lock)->rlock        2847554          [<ffffffff8129cb75>] blk_sq_make_request+0x155/0x3a0
                  ----------------------
                  &(&__ctx->lock)->rlock       60595106          [<ffffffff8129cb75>] blk_sq_make_request+0x155/0x3a0                                        586                                       740.06              6
                  &(&__ctx->lock)->rlock       87667847          [<ffffffff8129b164>] __blk_mq_run_hw_queue+0xd4/0x340
                  &(&__ctx->lock)->rlock              1          [<ffffffff8129c058>] blk_mq_insert_requests+0x98/0x140

.............................................................................................................................................................................................................................

                   cpufreq_governor_lock:      21235811       21235811           2.42       33550.02  1902671135.22          89.60       46473313       46799453           0.15         693.28   151036247.08           3.23
                   ---------------------
                   cpufreq_governor_lock       21235811          [<ffffffff814bc65f>] gov_queue_work+0x2f/0xe0
                   ---------------------
                   cpufreq_governor_lock       21235811          [<ffffffff814bc65f>] gov_queue_work+0x2f/0xe0
                                                     39             39                                      5253.51                          4989         801257                                     40807.71
.............................................................................................................................................................................................................................
                                                     39
                               &rq->lock:       3553336        3553458           0.11         407.00     4924475.84           1.39       52327296      876363060           0.00         253.05  1202364929.39           1.37
                               ---------             39
                               &rq->lock         222825          [<ffffffff8107f20c>] ttwu_queue+0xdc/0x150
                               &rq->lock             11          [<ffffffff810858d8>] migration_call+0x118/0x170
                               &rq->lock          45385          [<ffffffff815e8476>] __schedule+0xb6/0x780
                               &rq->lock           8549          [<674fffff8108f2ef>] load_balance+0x45f/0x75887.79                         33381         413034                                    517478.27
                               ---------
                               &rq->lock        3429840          [<ffffffff815e8476>] __schedule+0xb6/0x780
                               &rq->lock             11          [<ffffffff810858d8>] migration_call+0x118/0x170
                               &rq->lock           4433          [<ffffffff8108f2ef>] load_balance+0x45f/0x770
                               &rq->lock           7400          [<ffffffff8108f217>] load_balance+0x387/0x770

....................................................923......................................................................................................................................................................


---
Rob Elliott    HP Server Storage



