From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH] s5pv210-cpufreq: fix wrong do_div() usage
Date: Wed, 4 Nov 2015 09:41:14 +0900
Message-ID: <CAJKOXPeYxrwK-1OQUkE9YEHcTg8QFEJJcvpJVWBov1v8jt9OiA@mail.gmail.com>
References: <alpine.LFD.2.20.1511031706460.630@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:32976 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965132AbbKDAlP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 19:41:15 -0500
Received: by qgeo38 with SMTP id o38so29022895qge.0
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2015 16:41:14 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1511031706460.630@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org

2015-11-04 7:13 GMT+09:00 Nicolas Pitre <nicolas.pitre@linaro.org>:
> It is wrong to use do_div() with 32-bit dividends (unsigned long is
> 32 bits on 32-bit architectures).
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>

Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof
