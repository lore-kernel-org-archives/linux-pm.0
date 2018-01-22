From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: add and use
 cpufreq_for_each_{valid_,}entry_idx
Date: Mon, 22 Jan 2018 10:09:49 +0530
Message-ID: <20180122043949.GB2421@vireshk-i7>
References: <20180121161117.GA7073@light.dominikbrodowski.net>
 <20180121182412.GA2876@light.dominikbrodowski.net>
 <20180121215706.GA2642@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41842 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750955AbeAVEjy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Jan 2018 23:39:54 -0500
Received: by mail-pg0-f67.google.com with SMTP id 136so6182552pgd.8
        for <linux-pm@vger.kernel.org>; Sun, 21 Jan 2018 20:39:54 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20180121215706.GA2642@light.dominikbrodowski.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: rjw@rjwysocki.net, linux-pm@vger.kernel.org, viro@ZenIV.linux.org.uk

On 21-01-18, 22:57, Dominik Brodowski wrote:
> Pointer subtraction is slow and tedious. Therefore, replace all instances
> where cpufreq_for_each_{valid_,}entry loops contained such substractions
> with a macro which provides an index to the element currently being
> iterated over.
> 
> Suggested-by: Al Viro <viro@ZenIV.linux.org.uk>
> Link: http://lkml.kernel.org/r/20180120020237.GM13338@ZenIV.linux.org.uk
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
> 
> v3: Fix sh typo
> v2: Fix cpufreq_table_find_index_* to handle non-results properly

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
