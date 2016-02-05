From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 5/10] cpufreq: governor: Rename some data types and
 variables
Date: Fri, 5 Feb 2016 12:47:37 +0530
Message-ID: <20160205071737.GH21792@vireshk>
References: <3705929.bslqXH980s@vostro.rjw.lan>
 <9008098.QDD8C89zDx@vostro.rjw.lan>
 <3702180.uHU6PQUSgm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36575 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752330AbcBEHRk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 5 Feb 2016 02:17:40 -0500
Received: by mail-pa0-f52.google.com with SMTP id yy13so29599917pab.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Feb 2016 23:17:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <3702180.uHU6PQUSgm@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Juri Lelli <juri.lelli@arm.com>, Steve Muckle <steve.muckle@linaro.org>, Saravana Kannan <skannan@codeaurora.org>

On 05-02-16, 03:17, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ondemand and conservative governors are represented by
> struct common_dbs_data whose name doesn't reflect the purpose it
> is used for, so rename it to struct dbs_governor and rename
> variables of that type accordingly.
> 
> No functional changes.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
