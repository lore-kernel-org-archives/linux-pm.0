From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 6/6] cpufreq: Loongson1: Add cpufreq driver for Loongson1B
Date: Fri, 17 Oct 2014 13:47:40 +0530
Message-ID: <CAKohpo=iRubshWkv0xj6DDomeR-wdYs3y2QebCgW5u-dvu0J3g@mail.gmail.com>
References: <1413527826-22906-1-git-send-email-keguang.zhang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:60180 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbaJQIRl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Oct 2014 04:17:41 -0400
Received: by mail-oi0-f46.google.com with SMTP id h136so224199oig.19
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2014 01:17:40 -0700 (PDT)
In-Reply-To: <1413527826-22906-1-git-send-email-keguang.zhang@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kelvin Cheung <keguang.zhang@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>

On 17 October 2014 12:07, Kelvin Cheung <keguang.zhang@gmail.com> wrote:
> V2:
>    Use devm_clk_get() instead of clk_get().

Search for a few drivers which have used this API and understand how
to use it.
