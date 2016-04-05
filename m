From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: mt8173: use list_for_each_entry*()
Date: Tue, 5 Apr 2016 08:35:57 +0530
Message-ID: <20160405030557.GC20655@vireshk-i7>
References: <0679e197c8c0c4329d3d8190f1777fd61edbaebf.1459823809.git.geliangtang@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33473 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbcDEDGB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Apr 2016 23:06:01 -0400
Received: by mail-pa0-f51.google.com with SMTP id zm5so947752pac.0
        for <linux-pm@vger.kernel.org>; Mon, 04 Apr 2016 20:06:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <0679e197c8c0c4329d3d8190f1777fd61edbaebf.1459823809.git.geliangtang@163.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geliang Tang <geliangtang@163.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 05-04-16, 10:38, Geliang Tang wrote:
> Use list_for_each_entry*() instead of list_for_each*() to simplify
> the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@163.com>
> ---
>  drivers/cpufreq/mt8173-cpufreq.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
