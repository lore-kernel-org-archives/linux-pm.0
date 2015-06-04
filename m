From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/3] cpufreq: governor: register notifier from cs_init()
Date: Thu, 4 Jun 2015 11:32:31 +0530
Message-ID: <20150604060231.GD11325@linux>
References: <cover.1433326032.git.viresh.kumar@linaro.org>
 <7c79b6ede0407a940da2076f562360990ef0061a.1433326032.git.viresh.kumar@linaro.org>
 <556FE44A.8080806@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:33528 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbbFDGCh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jun 2015 02:02:37 -0400
Received: by pdbqa5 with SMTP id qa5so23648520pdb.0
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2015 23:02:36 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <556FE44A.8080806@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, paulus@samba.org, shilpa.bhat@linux.vnet.ibm.com, prarit@redhat.com, robert.schoene@tu-dresden.de, skannan@codeaurora.org

On 04-06-15, 11:08, Preeti U Murthy wrote:
> I don't see why we need the check on policy->governor->initialized
> because we call cdata->init() and cdata->exit(), *only* when the first
> and last references to the governor are being made respectively
> (filtered by dbs_data->usage_count), which is precisely what the
> initialized flag checks. So passing policy->governor->initialized seems
> to be redundant? And this is the case for both gov_per_policy and otherwise.

That's the case only for !gov_per_policy.

In case of gov_per_policy, the same governor is used by multiple
policies but with different dbs_data objects. And in this case INIT
will be called only once for a dbs_data and so usage count will be max
1 at any time. But we want to register the notifiers for a governor
only once and so we need this extra check.

policy->governor->initialized is set to 1 when the governor is
initialized for the first policy. For all others it is incremented to
other values.

-- 
viresh
