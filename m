From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: powernow-k8: Suppress checkpatch warnings
Date: Mon, 12 May 2014 09:52:06 +0530
Message-ID: <CAKohponF4KKjq5JwTSjeHKPfyfvi=2Qpv8+6NNODPO1DxDVrvQ@mail.gmail.com>
References: <536FB2B8.1060505@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:42313 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaELEWI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 12 May 2014 00:22:08 -0400
Received: by mail-ob0-f181.google.com with SMTP id wm4so7333424obc.26
        for <linux-pm@vger.kernel.org>; Sun, 11 May 2014 21:22:07 -0700 (PDT)
In-Reply-To: <536FB2B8.1060505@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 11 May 2014 22:56, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> Suppress the following checkpatch.pl warnings:
>
> - WARNING: Prefer pr_err(... to printk(KERN_ERR ...
> - WARNING: Prefer pr_info(... to printk(KERN_INFO ...
> - WARNING: Prefer pr_warn(... to printk(KERN_WARNING ...
> - WARNING: quoted string split across lines
> - WARNING: please, no spaces at the start of a line
>
> Also, define the pr_fmt macro instead of PFX for the module name.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>
> Changes v1 -> v2
>         - Use pr_err_once instead of printk_once
>         - Change missing_pss_msg to macro (because pr_err_once
>         doesn't compile otherwise)
>         - Put one pr_err message in a single line instead of two
>         - Ignore "line over 80 characters" warnings
>         - Change the word "Fix" in the subject of the patch to
>         "Suppress" as the patch doesn't really fix anything
>
>  drivers/cpufreq/powernow-k8.c | 180 +++++++++++++++++-------------------------
>  drivers/cpufreq/powernow-k8.h |   2 +-
>  2 files changed, 74 insertions(+), 108 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
