From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: cpufreq: AMD "frequency sensitivity feedback" powersave bias for
 ondemand governor
Date: Thu, 14 Apr 2016 14:03:27 +0300
Message-ID: <20160414110327.GA24237@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:19823 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbcDNLDi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 14 Apr 2016 07:03:38 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jacob.shin@amd.com
Cc: linux-pm@vger.kernel.org

Hello Jacob Shin,

The patch 9c5320c8ea8b: "cpufreq: AMD "frequency sensitivity
feedback" powersave bias for ondemand governor" from Apr 4, 2013,
leads to the following static checker warning:

	drivers/cpufreq/amd_freq_sensitivity.c:98 amd_powersave_bias_target()
	error: uninitialized symbol 'index'.

drivers/cpufreq/amd_freq_sensitivity.c
    83          /* this workload is not CPU bound, so choose a lower freq */
    84          if (sensitivity < od_tuners->powersave_bias) {
    85                  if (data->freq_prev == policy->cur)
    86                          freq_next = policy->cur;
    87  
    88                  if (freq_next > policy->cur)
    89                          freq_next = policy->cur;
    90                  else if (freq_next < policy->cur)
    91                          freq_next = policy->min;
    92                  else {
    93                          unsigned int index;
    94  
    95                          cpufreq_frequency_table_target(policy,
    96                                  od_info->freq_table, policy->cur - 1,
    97                                  CPUFREQ_RELATION_H, &index);

If cpufreq_frequency_table_target() return -EINVAL the index isn't set.

    98                          freq_next = od_info->freq_table[index].frequency;
    99                  }


regards,
dan carpenter
