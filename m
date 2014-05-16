From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] PM / OPP: discard duplicate OPPs
Date: Fri, 16 May 2014 15:33:49 +0530
Message-ID: <CAKohpokzz0xOnseM=wdyQ0_xf1G2d6=1vTvh+ztVRg-Vr0PxZw@mail.gmail.com>
References: <1400230809-11401-1-git-send-email-chander.kashyap@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f48.google.com ([209.85.219.48]:58037 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475AbaEPKDt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 16 May 2014 06:03:49 -0400
Received: by mail-oa0-f48.google.com with SMTP id i4so2722562oah.21
        for <linux-pm@vger.kernel.org>; Fri, 16 May 2014 03:03:49 -0700 (PDT)
In-Reply-To: <1400230809-11401-1-git-send-email-chander.kashyap@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chander Kashyap <chander.kashyap@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, "Brown, Len" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chander Kashyap <k.chander@samsung.com>, Inderpal Singh <inderpal.s@samsung.com>

On 16 May 2014 14:30, Chander Kashyap <chander.kashyap@linaro.org> wrote:
> From: Chander Kashyap <k.chander@samsung.com>
>
> This patch detects the duplicate OPP entries and discards them

I wish this would have been a bit more explanatory :)

> Signed-off-by: Chander Kashyap <k.chander@samsung.com>
> Signed-off-by: Inderpal Singh <inderpal.s@samsung.com>
> ---
>  Changes in v3:
>         - Modify the commit log
>  Changes in v2:
>         - Reorder check for duplicate opp
>
>  drivers/base/power/opp.c |   13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
