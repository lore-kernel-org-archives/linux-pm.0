From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: stats: Walk online CPUs with CPU
 offline/online locked
Date: Tue, 24 May 2016 17:47:17 +0530
Message-ID: <20160524121717.GY17585@vireshk-i7>
References: <19792191.esL3UuyORb@vostro.rjw.lan>
 <CAJZ5v0h-1rqishrGAJXnvzyKjxoAxMcitW64LCZqtGC6vTRmCg@mail.gmail.com>
 <20160524045630.GP17585@vireshk-i7>
 <2500818.MtOb9b1ZsB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:34349 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753821AbcEXMRV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 24 May 2016 08:17:21 -0400
Received: by mail-pa0-f44.google.com with SMTP id qo8so6372132pab.1
        for <linux-pm@vger.kernel.org>; Tue, 24 May 2016 05:17:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2500818.MtOb9b1ZsB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On 24-05-16, 14:13, Rafael J. Wysocki wrote:
> I don't really get it why you don't like get/put_online_cpus() so much.

Not that I don't like them, I just wanted to see if its possible to
work without any additional locking.

Anyway, so the first version of your patch did the get_online_cpus()
around a bigger section of the code instead of just the
for_each_online_cpu() loop. Should we change that? 

-- 
viresh
