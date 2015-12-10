From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 5/6] cpufreq: governor: replace per-cpu delayed work
 with timers
Date: Thu, 10 Dec 2015 08:06:26 +0530
Message-ID: <20151210023626.GE29459@ubuntu>
References: <96a8e6745e6335efb537dccafbc213286fdf9ad5.1449209505.git.viresh.kumar@linaro.org>
 <3250190a623b11f8479c0c9e144d867b8cf7b305.1449626558.git.viresh.kumar@linaro.org>
 <1517731.pZjrRh9Im6@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33435 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991AbbLJCga (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 9 Dec 2015 21:36:30 -0500
Received: by pabur14 with SMTP id ur14so39508652pab.0
        for <linux-pm@vger.kernel.org>; Wed, 09 Dec 2015 18:36:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1517731.pZjrRh9Im6@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sfr@canb.auug.org.au, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Ashwin Chaugule <ashwin.chaugule@linaro.org>, open list <linux-kernel@vger.kernel.org>

On 09-12-15, 23:06, Rafael J. Wysocki wrote:
> BTW, can you please add an extra From: line to the bodies of your patch
> messages?
> 
> For some unknown reason Patchwork or your mailer or the combination of the
> two mangles your name for me and I have to fix it up manually in every patch
> from you which is a !@#$%^&*() pain.

I have raised an RT request for this, lets see what's wrong.

-- 
viresh
