From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v7 5/7] cpufreq:exynos:Extend Exynos cpufreq driver to
 support boost framework
Date: Mon, 26 Aug 2013 11:06:33 +0530
Message-ID: <CAKohpok1efMe180VYjSrSFkSycPr6C61qf7tLZkKY_k07i_KVw@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1376388505-30233-1-git-send-email-l.majewski@samsung.com>
	<1376388505-30233-6-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:53017 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900Ab3HZFge (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 26 Aug 2013 01:36:34 -0400
Received: by mail-ob0-f181.google.com with SMTP id dn14so2806069obc.40
        for <linux-pm@vger.kernel.org>; Sun, 25 Aug 2013 22:36:33 -0700 (PDT)
In-Reply-To: <1376388505-30233-6-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, linux-kernel <linux-kernel@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, "R, Durgadoss" <durgadoss.r@intel.com>

On 13 August 2013 15:38, Lukasz Majewski <l.majewski@samsung.com> wrote:
> The cpufreq_driver's boost_supported flag is true only when boost
> support is explicitly enabled. Boost related attributes are exported only
> under the same condition.
>
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>
>
> ---
> Changes for v7:
> - Replace CONFIG_CPU_FREQ_BOOST_SW with CONFIG_ARM_EXYNOS_CPU_FREQ_BOOST_SW
> - Move boost_supported initialization to struct cpufreq_driver exynos_driver

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
