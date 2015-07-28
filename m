From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Update][PATCH 7/7] cpufreq: Separate CPU device registration
 from CPU online
Date: Tue, 28 Jul 2015 07:50:56 +0530
Message-ID: <20150728022056.GN18535@linux>
References: <7868353.pEStq1MJ2a@vostro.rjw.lan>
 <3874727.Jpay9zgokc@vostro.rjw.lan>
 <1739669.kedIsxdRK2@vostro.rjw.lan>
 <1702607.RH80fBCN6J@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:33336 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755075AbbG1CVC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 22:21:02 -0400
Received: by padck2 with SMTP id ck2so61259410pad.0
        for <linux-pm@vger.kernel.org>; Mon, 27 Jul 2015 19:21:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1702607.RH80fBCN6J@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>

On 27-07-15, 23:55, Rafael J. Wysocki wrote:
> +static void cpufreq_online(unsigned int cpu)

As I said in the earlier message, I need the return value of this to
be used for add_dev() callback. Which is required to retry probing the
device if it wasn't ready on a earlier call, i.e. it returns
-EPROBE_DEFER. My other patch already fixes the subsys layer for this.

-- 
viresh
