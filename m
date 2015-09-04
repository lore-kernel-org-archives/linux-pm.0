From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 7/7] ARM: smp: Add runtime PM support for CPU hotplug
Date: Fri, 4 Sep 2015 09:39:30 +0200
Message-ID: <CAMuHMdUROhCFOLWqABY3G_VaOavz5crDsM4z6KkGcBOEQtXj_g@mail.gmail.com>
References: <1441310314-8857-1-git-send-email-lina.iyer@linaro.org>
	<1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35272 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257AbbIDHja (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 4 Sep 2015 03:39:30 -0400
Received: by obuk4 with SMTP id k4so10670122obu.2
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2015 00:39:30 -0700 (PDT)
In-Reply-To: <1441310314-8857-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

On Thu, Sep 3, 2015 at 9:58 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> Enable runtime PM for CPU devices. Do a runtime get of the CPU device
> when the CPU is hotplugged in and a runtime put of the CPU device when

s/in/on/

> the CPU is hotplugged off. When all the CPUs in a domain are hotplugged
> off, the domain may also be powered off and cluster_pm_enter/exit()
> notifications are be sent out.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
