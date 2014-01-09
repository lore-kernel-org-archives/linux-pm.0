From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] ARM: SA1100: Create dummy clk_get_rate() to avoid
 build failures
Date: Thu, 9 Jan 2014 08:26:08 -0800
Message-ID: <CAOesGMgQgOUxbj=0=AYx2pN4mh5HoDcW4p1W89+kvNtXpFmYxA@mail.gmail.com>
References: <aaadbfa341a881c8250f2d23bc77062228d2e70b.1389279793.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f42.google.com ([209.85.128.42]:47057 "EHLO
	mail-qe0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754878AbaAIQ0K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jan 2014 11:26:10 -0500
Received: by mail-qe0-f42.google.com with SMTP id b4so3424670qen.1
        for <linux-pm@vger.kernel.org>; Thu, 09 Jan 2014 08:26:09 -0800 (PST)
In-Reply-To: <aaadbfa341a881c8250f2d23bc77062228d2e70b.1389279793.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd.bergmann@linaro.org>, Russell King <linux@arm.linux.org.uk>

On Thu, Jan 9, 2014 at 7:08 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> There are some parts of common kernel which would be using routines like
> clk_get_rate() on some platforms. Currently these wouldn't be called for SA1100
> boards but we need these routines for successful builds of these boards.
>
> So, this patch creates a dummy clk_get_rate() routine which is being used by
> cpufreq core. More dummy routines might be added later if there is a need for
> that.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd.bergmann@linaro.org>
> Reported-by: <Olof Johansson> olof@lixom.net

That's not the right format.

-Olof
