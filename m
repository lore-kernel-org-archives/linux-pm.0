From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 14/14] cpufreq: Add support for physical hoplug of CPUs
Date: Sat, 16 May 2015 07:43:07 +0530
Message-ID: <20150516021307.GE4600@linux>
References: <cover.1431065963.git.viresh.kumar@linaro.org>
 <22ea2a0dd3e860d9b0e8703f49d07ca32e2fc490.1431065963.git.viresh.kumar@linaro.org>
 <3771347.4CYzBDSQ1Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35368 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992449AbbEPCNL (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2015 22:13:11 -0400
Received: by pdea3 with SMTP id a3so39099877pde.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2015 19:13:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3771347.4CYzBDSQ1Q@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On 16-05-15, 03:18, Rafael J. Wysocki wrote:
> You seem to be breaking things first and then fixing them up with this patch.
> 
> Would it be possible to avoid breaking them in the first place?

I thought it was already broken in mainline and so did it towards the
end. Will check that again.

-- 
viresh
