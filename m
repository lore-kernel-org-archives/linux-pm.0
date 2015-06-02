From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC PATCH] cpufreq/hotplug: Fix cpu-hotplug cpufreq race
 conditions
Date: Tue, 2 Jun 2015 11:57:24 +0530
Message-ID: <20150602062724.GF10443@linux>
References: <20150601064031.2972.59208.stgit@perfhull-ltc.austin.ibm.com>
 <20150601071934.GC4242@linux>
 <556D3FAA.3080703@linux.vnet.ibm.com>
 <20150602053956.GD10443@linux>
 <556D4748.7040105@linux.vnet.ibm.com>
 <20150602061133.GE10443@linux>
 <556D4B32.3000407@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35741 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752245AbbFBG1a (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2015 02:27:30 -0400
Received: by pdbnf5 with SMTP id nf5so64717291pdb.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2015 23:27:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <556D4B32.3000407@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, ego@linux.vnet.ibm.com, paulus@samba.org, linux-kernel@vger.kernel.org, shilpa.bhat@linux.vnet.ibm.com, linux-pm@vger.kernel.org

On 02-06-15, 11:50, Preeti U Murthy wrote:
>  CPU0                        CPU1
> 
> store*                     store*
> 
> lock(policy 1)              lock(policy 2)
> cpufreq_set_policy()       cpufreq_set_policy()
> EXIT() :
> dbs-data->usage_count--
> 
> INIT()                      EXIT()

When will INIT() follow EXIT() in set_policy() for the same governor ?
Maybe not, and so this sequence is hypothetical ?

> dbs_data exists             dbs_data->usage_count -- = 0
>                             kfree(dbs_data)
> dbs-data->usage_count++
> *NULL dereference*

But even if this happens, it should be handled with
dbs_data->mutex_lock, which is used at other places already.

-- 
viresh
