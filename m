From: Steve Muckle <steve.muckle@linaro.org>
Subject: Re: [PATCH V2] cpufreq: Disallow ->resolve_freq() for drivers
 providing ->target_index()
Date: Thu, 21 Jul 2016 16:22:28 -0700
Message-ID: <20160721232228.GT27987@graphite.smuckle.net>
References: <065301260510fbca81f5481b27b0de956073068a.1469137133.git.viresh.kumar@linaro.org>
 <1490801.bHMYROVPDC@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33046 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583AbcGUXWc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Jul 2016 19:22:32 -0400
Received: by mail-pa0-f52.google.com with SMTP id ks6so33345834pab.0
        for <linux-pm@vger.kernel.org>; Thu, 21 Jul 2016 16:22:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1490801.bHMYROVPDC@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, steve.muckle@linaro.org, peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org, morten.rasmussen@arm.com, dietmar.eggemann@arm.com, Juri.Lelli@arm.com, patrick.bellasi@arm.com

On Fri, Jul 22, 2016 at 01:22:22AM +0200, Rafael J. Wysocki wrote:
> OK, applied.

FWIW I do have a concern on this patch, I think it adds unnecessary
overhead.

