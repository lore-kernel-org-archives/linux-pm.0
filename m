From: Oleksandr Natalenko <oleksandr@natalenko.name>
Subject: Re: [BUG] oops in cpufreq driver with AMD Kaveri CPU
Date: Wed, 13 Aug 2014 08:43:27 +0300
Message-ID: <3895042.gWY0G31aDD@spock>
References: <4708675.eITUXPv8Ih@spock> <2067094.cJOA1APdny@spock> <CAKohponLC=NqTUG-mENuJ5Tomx6xgCYEBocj2P5RXXZumZaPZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from natalenko.name ([78.47.77.148]:34536 "EHLO natalenko.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743AbaHMFnh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 13 Aug 2014 01:43:37 -0400
In-Reply-To: <CAKohponLC=NqTUG-mENuJ5Tomx6xgCYEBocj2P5RXXZumZaPZQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wednesday 13 August 2014 10:12:06 Viresh Kumar wrote: 
> Also will it be possible for you to find the last working kernel after
> which this
> happened?

I'll try to reproduce the issue with older kernels, but that could be 
problematic and may take some time. So far, I can say that 3.13 and 3.15 are 
also affected (haven't tried 3.14, though).

-- 
Oleksandr post-factum Natalenko, MSc
pf-kernel community
https://natalenko.name/
