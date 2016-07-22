From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Revert "cpufreq: pcc-cpufreq: update default value of
 cpuinfo_transition_latency"
Date: Fri, 22 Jul 2016 16:50:29 -0700
Message-ID: <20160722235029.GA5174@ubuntu>
References: <20160722151411.GB11711@suselix.suse.de>
 <3431802.ZZWypmTthK@vostro.rjw.lan>
 <20160722212852.GE3122@ubuntu>
 <3860863.MLaNBM27lJ@vostro.rjw.lan>
 <20160722233042.GI3122@ubuntu>
 <CAJZ5v0g3_QrVD3rwjdcWKcDb5SpA11n9C_2Jpk6qMsXg3pxfOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34388 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276AbcGVXub (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 19:50:31 -0400
Received: by mail-pa0-f42.google.com with SMTP id fi15so43679335pac.1
        for <linux-pm@vger.kernel.org>; Fri, 22 Jul 2016 16:50:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAJZ5v0g3_QrVD3rwjdcWKcDb5SpA11n9C_2Jpk6qMsXg3pxfOg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andreas Herrmann <aherrmann@suse.com>, Jacob Tanenbaum <jtanenba@redhat.com>, Stable <stable@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 23-07-16, 01:47, Rafael J. Wysocki wrote:
> I'll apply the revert with a "Cc: stable" tag.

That will work.

> Question is what to do about the other drivers setting
> cpuinfo.transition_latency to CPUFREQ_ETERNAL.

Perhaps leave them as is unless someone comes and reports a problem, they don't
seem to have any problem right now anyway :)

-- 
viresh
