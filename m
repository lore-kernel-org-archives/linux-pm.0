From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: respect the min/max settings from user space
Date: Mon, 6 Oct 2014 10:25:24 +0530
Message-ID: <CAKohpo=LFLRimA=_PH_OK4XddpphciaZdDEc2dirJifKnL=4Tw@mail.gmail.com>
References: <1412232900-11238-1-git-send-email-vinceh@nvidia.com>
	<CAKohpon=dwc--SSbwjREdrALfXH=7QCw8UJnyVX5x3TCKB=7Bw@mail.gmail.com>
	<54321F90.2010103@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f54.google.com ([209.85.218.54]:43114 "EHLO
	mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363AbaJFEzZ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 6 Oct 2014 00:55:25 -0400
Received: by mail-oi0-f54.google.com with SMTP id v63so3091985oia.41
        for <linux-pm@vger.kernel.org>; Sun, 05 Oct 2014 21:55:24 -0700 (PDT)
In-Reply-To: <54321F90.2010103@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vince Hsu <vinceh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill Huang <bilhuang@nvidia.com>, dgreid@google.com, olofj@chromium.org

On 6 October 2014 10:20, Vince Hsu <vinceh@nvidia.com> wrote:
> I did test with Chrome kernel on Tegra platform. I can't do that with
> mainline kernel because we haven't had the CPU EDP driver upstream yet.

You should have mentioned this clearly :)

Looks fine to me then.
