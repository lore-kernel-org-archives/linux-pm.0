From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: thermal: cpu_cooling: Use cpufreq_dev->freq_table for finding
 level/freq
Date: Thu, 11 Jun 2015 10:14:09 +0300
Message-ID: <20150611071409.GD11734@mwanda>
References: <20150610150211.GA30208@mwanda>
 <20150611030542.GM24662@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:38038 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062AbbFKHOQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 11 Jun 2015 03:14:16 -0400
Content-Disposition: inline
In-Reply-To: <20150611030542.GM24662@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org

On Thu, Jun 11, 2015 at 08:35:42AM +0530, Viresh Kumar wrote:
> 	/* max_level is an index, not a counter */
> 	cpufreq_dev->max_level--;

Argh...  I am an idiot.  Sorry for the noise.

regards,
dan carpenter
