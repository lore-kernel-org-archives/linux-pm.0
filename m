From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v4] cpufreq: add and use cpufreq_for_each_{valid_,}entry_idx
Date: Thu, 08 Feb 2018 11:13:16 +0100
Message-ID: <10500211.th50Gy9OeX@aspire.rjw.lan>
References: <20180121161117.GA7073@light.dominikbrodowski.net> <20180121182412.GA2876@light.dominikbrodowski.net> <20180130054237.GA15655@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:60493 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbeBHKPA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Feb 2018 05:15:00 -0500
In-Reply-To: <20180130054237.GA15655@light.dominikbrodowski.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, viro@zeniv.linux.org.uk

On Tuesday, January 30, 2018 6:42:37 AM CET Dominik Brodowski wrote:
> Pointer subtraction is slow and tedious. Therefore, replace all instances
> where cpufreq_for_each_{valid_,}entry loops contained such substractions
> with an iteration macro providing an index to the frequency_table entry.
> 
> Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
> Link: http://lkml.kernel.org/r/20180120020237.GM13338@ZenIV.linux.org.uk
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

Applied, thanks!
