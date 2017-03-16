From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC 0/9] cpufreq: schedutil: Allow remote wakeups
Date: Thu, 16 Mar 2017 08:39:16 +0530
Message-ID: <20170316030916.GA5201@vireshk-i7>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
 <4261790.UfzOU18DRK@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:33886 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbdCPDJW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Mar 2017 23:09:22 -0400
Received: by mail-pg0-f43.google.com with SMTP id 141so18055892pgd.1
        for <linux-pm@vger.kernel.org>; Wed, 15 Mar 2017 20:09:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4261790.UfzOU18DRK@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org

On 15-03-17, 12:45, Rafael J. Wysocki wrote:
> From the first quick look patches [1-3/9] seem to be split out somewhat
> artificially.
> 
> Any chance to fold them into the patches where the new stuff is actually used?
> 
> I'll be looking at the rest of the patchset shortly.

I thought it would be better to keep them separate, but I can merge them to
others in the next version if you want.

-- 
viresh
