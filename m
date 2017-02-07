From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] PM / devfreq: Fix available_governor sysfs
Date: Tue, 7 Feb 2017 15:16:38 +0300
Message-ID: <20170207121638.GA19304@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:20807 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751526AbdBGMRD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Feb 2017 07:17:03 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: cw00.choi@samsung.com
Cc: linux-pm@vger.kernel.org

Hello Chanwoo Choi,

This is a semi-automatic email about new static checker warnings.

The patch bcf23c79c4e4: "PM / devfreq: Fix available_governor sysfs" 
from Jan 31, 2017, leads to the following Smatch complaint:

drivers/devfreq/devfreq.c:940 governor_store()
	 warn: variable dereferenced before check 'df->governor' (see line 935)

drivers/devfreq/devfreq.c
   934			goto out;
   935		} else if (df->governor->immutable || governor->immutable) {
                           ^^^^^^^^^^^^
Patch introduces a new dereference.

   936			ret = -EINVAL;
   937			goto out;
   938		}
   939	
   940		if (df->governor) {
                    ^^^^^^^^^^^^
Existing code assumes "df->governor" can be NULL.

   941			ret = df->governor->event_handler(df, DEVFREQ_GOV_STOP, NULL);
   942			if (ret) {

regards,
dan carpenter
