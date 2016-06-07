From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: mvebu: fix integer to pointer cast
Date: Tue, 7 Jun 2016 19:10:17 +0530
Message-ID: <CAKohpon_euKo0Wu8fwU34EUxgBQBrL5TtbuYdvUdNt0ebK+rkA@mail.gmail.com>
References: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34764 "EHLO
	mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932542AbcFGNkT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jun 2016 09:40:19 -0400
Received: by mail-qt0-f175.google.com with SMTP id q45so21689992qtq.1
        for <linux-pm@vger.kernel.org>; Tue, 07 Jun 2016 06:40:19 -0700 (PDT)
In-Reply-To: <1465299013-32369-1-git-send-email-ben.dooks@codethink.co.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 7 June 2016 at 17:00, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Fix the use of 0 instead of NULL to clk_get() call. This stops the
> following warning:
>
> drivers/cpufreq/mvebu-cpufreq.c:73:40: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@lists.codethink.co.uk
> ---
>  drivers/cpufreq/mvebu-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
