From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Initialize the governor again while restoring
 policy
Date: Wed, 8 Jul 2015 14:59:15 +0530
Message-ID: <20150708092915.GA24289@linux>
References: <f428ecb0927075b25cf7e2ea5fb00eab3d254fdd.1436333568.git.viresh.kumar@linaro.org>
 <1436347629.2844.12.camel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36756 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933047AbbGHJ3V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2015 05:29:21 -0400
Received: by pddu5 with SMTP id u5so55207010pdd.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2015 02:29:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436347629.2844.12.camel@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Jon Medhurst (Tixy)" <tixy@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Pi-Cheng Chen <pi-cheng.chen@linaro.org>, open list <linux-kernel@vger.kernel.org>

On 08-07-15, 10:27, Jon Medhurst (Tixy) wrote:
> I believe this also fixes the other issue I mentioned (nullptr deref in
> in arm_big_little driver). To test that, after applying this patch, I
> modified the code to force __cpufreq_governor to still return an error
> when a cpu is hotpluged back in. Now the arm_big_little driver doesn't
> get called when I manually poke scaling_setspeed, presumably because
> policy->governor==NULL prevents that from reaching the driver?

I would like to fix that issue without using this patch as we aren't
cleaning up things properly on errors today. I am almost done with the
patches, and will send them to you shortly. Please give them a try
without this patch.

-- 
viresh
