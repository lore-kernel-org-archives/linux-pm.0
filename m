From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dt: call of_node_put() before error out
Date: Mon, 27 Jun 2016 11:22:52 +0530
Message-ID: <20160627055252.GB3238@vireshk-i7>
References: <1467006613-24076-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:36262 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbcF0Fw4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 01:52:56 -0400
Received: by mail-pa0-f43.google.com with SMTP id wo6so55750187pac.3
        for <linux-pm@vger.kernel.org>; Sun, 26 Jun 2016 22:52:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1467006613-24076-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org

On 27-06-16, 14:50, Masahiro Yamada wrote:
> If of_match_node() fails, this init function bails out without
> calling of_node_put().
> 
> I also changed of_node_put(of_root) to of_node_put(np); both of them
> hold the same pointer, but it seems better to call of_node_put()
> against the node returned by of_find_node_by_path().
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Thanks.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
