From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 03/17] thermal: cpu_cooling: Replace cpufreq_device with
 cpufreq_dev
Date: Wed, 12 Apr 2017 11:46:52 +0530
Message-ID: <20170412061652.GA5910@vireshk-i7>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
 <1ebaf8113e79154e9b8e7696c4e1c70791d26e14.1489640000.git.viresh.kumar@linaro.org>
 <20170411173330.GA5528@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f54.google.com ([74.125.83.54]:33603 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752303AbdDLGQ5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Apr 2017 02:16:57 -0400
Received: by mail-pg0-f54.google.com with SMTP id x125so9817313pgb.0
        for <linux-pm@vger.kernel.org>; Tue, 11 Apr 2017 23:16:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170411173330.GA5528@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>

On 11-04-17, 10:33, Eduardo Valentin wrote:
> On Thu, Mar 16, 2017 at 10:59:38AM +0530, Viresh Kumar wrote:
> > Objects of "struct cpufreq_cooling_device" are named a bit
> > inconsistently. Lets use cpufreq_dev everywhere.
> > 
> 
> Naming is always a matter of taste.. but I frankly cannot see how this
> patch improves anything here. cpufreq_dev is still misleading.

I wasn't trying to get to a better name, but rather be consistent.

> Here other options:
>  cpufreq_cooling_dev: not misleading but, may a bit too long..
>  cpufreq_cdev: better, but still, not a char dev

I will go for the second one.

-- 
viresh
