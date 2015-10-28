From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/5] cpufreq: ondemand: update sampling rate
 immediately
Date: Wed, 28 Oct 2015 20:58:11 +0530
Message-ID: <20151028152811.GE3716@ubuntu>
References: <cover.1444723240.git.viresh.kumar@linaro.org>
 <2498053.EX0k8RstLZ@vostro.rjw.lan>
 <20151028093109.GJ30039@ubuntu>
 <3215277.8YKq8PWCpx@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35796 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234AbbJ1P2Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 28 Oct 2015 11:28:16 -0400
Received: by pasz6 with SMTP id z6so10129654pas.2
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2015 08:28:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3215277.8YKq8PWCpx@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

On 28-10-15, 16:31, Rafael J. Wysocki wrote:
> Is the current code really problematic?

Its not problematic, but just that I didn't like special code written
here.

Also, its a blocker for the next patch which tries to schedule work on
all the policy->cpus together.

-- 
viresh
