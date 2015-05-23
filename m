From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 09/14] cpufreq: add/remove sysfs links via
 cpufreq_add_remove_dev_symlink()
Date: Sat, 23 May 2015 09:11:20 +0530
Message-ID: <20150523034120.GA4210@linux>
References: <cover.1431924457.git.viresh.kumar@linaro.org>
 <93a3bfbe26dfa1c298e21da369e6ed37fca1da34.1431924457.git.viresh.kumar@linaro.org>
 <3403066.ABqM7b3uGI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33177 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756243AbbEWDlZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 May 2015 23:41:25 -0400
Received: by pdbqa5 with SMTP id qa5so32966002pdb.0
        for <linux-pm@vger.kernel.org>; Fri, 22 May 2015 20:41:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3403066.ABqM7b3uGI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, sboyd@codeaurora.org, prarit@redhat.com, skannan@codeaurora.org, Srivatsa Bhat <srivatsa@mit.edu>

On 23-05-15, 01:28, Rafael J. Wysocki wrote:
> (The last statement line is likely longer than 80 chars, but that's fine.)

No, it isn't.

I am dropping this patch and merging it with the next one. Otherwise
it generates warnings about routine defined but not used. So I will be
resending 10/14 and that replaces 9-10/14.

Thanks.

-- 
viresh
