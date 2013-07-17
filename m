From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v5 6/7] cpufreq:boost:Kconfig: Enable software managed
 BOOST support at Kconfig
Date: Wed, 17 Jul 2013 13:59:15 +0530
Message-ID: <CAKohponWhYFntyay004qErHxFRkjZEtes-+ZHE49oG-CrZMzOg@mail.gmail.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-1-git-send-email-l.majewski@samsung.com>
	<1372927830-2949-7-git-send-email-l.majewski@samsung.com>
	<CAKohpokR=jrcLQQ7VAD+vr7GWgSFBfuqbOhWHwA3FCgk__EJ3Q@mail.gmail.com>
	<20130716135022.64a102f8@amdc308.digital.local>
	<CAKohpo=XbUtYBVQ_y4_R18wpag_HAVvXrxfSfmaNSqq=wLpciQ@mail.gmail.com>
	<20130717091706.69b77c2f@amdc308.digital.local>
	<CAKohpona8E-JgLxyLnc_QuS9LAuJ7FBbsSGPZawQtOd8kRd4JA@mail.gmail.com>
	<20130717101251.164fbad8@amdc308.digital.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:56095 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752622Ab3GQI3Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 04:29:16 -0400
Received: by mail-oa0-f41.google.com with SMTP id n10so2193887oag.0
        for <linux-pm@vger.kernel.org>; Wed, 17 Jul 2013 01:29:15 -0700 (PDT)
In-Reply-To: <20130717101251.164fbad8@amdc308.digital.local>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Jonghwa Lee <jonghwa3.lee@samsung.com>, l.majewski@majess.pl, linux-kernel <linux-kernel@vger.kernel.org>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>

On 17 July 2013 13:42, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Then it should be enough to only write:
>
> depends on THERMAL
>
> (since CPUFREQ is already enabled for entering this menu).

Correct
