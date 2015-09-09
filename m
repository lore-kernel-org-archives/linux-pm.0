From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/9] cpufreq: ondemand: only queue canceled works from
 update_sampling_rate()
Date: Wed, 9 Sep 2015 08:00:20 +0530
Message-ID: <20150909023020.GI7639@linux>
References: <cover.1437999691.git.viresh.kumar@linaro.org>
 <1806697.T1XSqGqSN5@vostro.rjw.lan>
 <20150908015831.GY26760@linux>
 <32794142.WpJFa6Ni1D@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36266 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752879AbbIICaY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2015 22:30:24 -0400
Received: by padhk3 with SMTP id hk3so56591188pad.3
        for <linux-pm@vger.kernel.org>; Tue, 08 Sep 2015 19:30:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <32794142.WpJFa6Ni1D@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, preeti.lkml@gmail.com, open list <linux-kernel@vger.kernel.org>

On 09-09-15, 03:06, Rafael J. Wysocki wrote:
> I've just realized that if you combined this patch with the [6/9],
> you wouldn't need to make any changes to gov_queue_work() at all,
> because that patch removes the case in point entirely.

Yeah, but then these are really two separate issues at hand and so I
solved them separately. Lemme know how you want to see that and I can
change :)

-- 
viresh
