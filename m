From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: respect the min/max settings from user space
Date: Mon, 10 Nov 2014 10:39:25 +0530
Message-ID: <CAKohpo=jZAmqvdYr+0uUY8xBi5bK0isADS4o5xsaK+rxALcVHQ@mail.gmail.com>
References: <1412232900-11238-1-git-send-email-vinceh@nvidia.com>
	<CAKohpon=dwc--SSbwjREdrALfXH=7QCw8UJnyVX5x3TCKB=7Bw@mail.gmail.com>
	<54321F90.2010103@nvidia.com>
	<544F0C8C.3090003@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:49972 "EHLO
	mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbaKJFJ0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Nov 2014 00:09:26 -0500
Received: by mail-oi0-f41.google.com with SMTP id e131so4902892oig.28
        for <linux-pm@vger.kernel.org>; Sun, 09 Nov 2014 21:09:25 -0800 (PST)
In-Reply-To: <544F0C8C.3090003@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Vince Hsu <vinceh@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bill Huang <bilhuang@nvidia.com>, Dylan Reid <dgreid@google.com>, olofj@chromium.org

On 28 October 2014 08:55, Vince Hsu <vinceh@nvidia.com> wrote:
> Hi Viresh,
>
> Could you remind me where can I find this patch upstream? It seems this was
> missed?

Rafael hasn't picked it up. You can normally look at the tree Rafael
manages:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git

Can you please resend it to Rafael ?
