From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] PM / Domains: Validate cases of a non-bound driver in
 genpd governor
Date: Fri, 4 Dec 2015 01:28:20 +0100
Message-ID: <CAJZ5v0iPz=SJTdY4x3gaAxrDjpSGepcZo5y+JVJT9E-3Wr9Lxw@mail.gmail.com>
References: <1449061707-16030-1-git-send-email-ulf.hansson@linaro.org>
	<7htwnz13jx.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34158 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671AbbLDA2V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 3 Dec 2015 19:28:21 -0500
Received: by lbbcs9 with SMTP id cs9so11570691lbb.1
        for <linux-pm@vger.kernel.org>; Thu, 03 Dec 2015 16:28:20 -0800 (PST)
In-Reply-To: <7htwnz13jx.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert+renesas@glider.be>, Lina Iyer <lina.iyer@linaro.org>

On Fri, Dec 4, 2015 at 1:05 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> Recently genpd removed the requirement of a having a driver bound for its
>> attached devices to allow genpd to power off. That change should also have
>> removed a corresponding validation in the governor, let's correct that.
>>
>> Fixes: 298cd0f08801 ("PM / Domains: Remove dev->driver check for runtime")
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Kevin Hilman <khilman@linaro.org>

Applied with both ACKs and the Fixes: tag.

I've also tagged it for "stable".

Thanks,
Rafael
