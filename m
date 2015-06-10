From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: thermal: cpu_cooling: Use cpufreq_dev->freq_table for finding
 level/freq
Date: Wed, 10 Jun 2015 18:02:12 +0300
Message-ID: <20150610150211.GA30208@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:48786 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932309AbbFJPCZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jun 2015 11:02:25 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org

Hello Viresh Kumar,

The patch 4843c4a19049: "thermal: cpu_cooling: Use
cpufreq_dev->freq_table for finding level/freq" from Dec 4, 2014,
leads to the following static checker warning:

	drivers/thermal/cpu_cooling.c:163 get_level()
	warn: potential off by one 'cpufreq_dev->freq_table[]' limit 'cpufreq_dev->max_level'

drivers/thermal/cpu_cooling.c
   157  static unsigned long get_level(struct cpufreq_cooling_device *cpufreq_dev,
   158                                 unsigned int freq)
   159  {
   160          unsigned long level;
   161  
   162          for (level = 0; level <= cpufreq_dev->max_level; level++) {
                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
   163                  if (freq == cpufreq_dev->freq_table[level])
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Reading beyond the end of the array.

   164                          return level;
   165  
   166                  if (freq > cpufreq_dev->freq_table[level])
   167                          break;
   168          }
   169  
   170          return THERMAL_CSTATE_INVALID;
   171  }

The truth is that I have lots of checks that I can't publish, like for
example, if you use something with the word "size" or "max" as an index.
Obviously, it looks like <= should probably be < but just because it
looks wrong doesn't mean it is wrong.  I searched for ->max_level and
read the documentation:

  * @max_level: maximum cooling level. One less than total number of valid
  *     cpufreq frequencies.

The documentation is very clear that this loop is correct.  It also
turns out that it used consistently almost throughout.  But when I see
these unusual limits, I know it is often difficult to be 100%
consistent so I kept looking.  It turns out there is off by one mistake
when we allocate the buffer.

        cpufreq_dev->freq_table = kmalloc(sizeof(*cpufreq_dev->freq_table) *
                                          cpufreq_dev->max_level, GFP_KERNEL);

It should be allocating:

	sizeof(*cpufreq_dev->freq_table) * (cpufreq_dev->max_level + 1)

We could just change the allocation, but really this kind of unusual
limit is just going to cause more headaches in the future...

regards,
dan carpenter
