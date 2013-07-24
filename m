From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 3/3] cpufreq: pmac64: enable cpufreq on iMac G5 (iSight) model
Date: Wed, 24 Jul 2013 11:04:06 +0530
Message-ID: <CAKohponoKzQv+jqgHsqsAgEkaQeeZof6XtegKdPwa4mLE3b9UA@mail.gmail.com>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
	<1374611079-28091-3-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:61529 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843Ab3GXFeH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 01:34:07 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so936200obc.6
        for <linux-pm@vger.kernel.org>; Tue, 23 Jul 2013 22:34:06 -0700 (PDT)
In-Reply-To: <1374611079-28091-3-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 24 July 2013 01:54, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Enable cpufreq on iMac G5 (iSight) model. Tested with the 2.1 GHz version.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  drivers/cpufreq/pmac64-cpufreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
