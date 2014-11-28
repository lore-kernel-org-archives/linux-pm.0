From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/26] thermal: cpu_cooling: Fixes and cleanups
Date: Fri, 28 Nov 2014 19:11:29 +0530
Message-ID: <CAKohpo=xesfU+i3akwRy9-UYnR4cGGSD0X_3cE2YCkJ3Hv-0Wg@mail.gmail.com>
References: <cover.1417167599.git.viresh.kumar@linaro.org>
	<20141128132559.GA23674@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f46.google.com ([209.85.218.46]:50544 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751405AbaK1Nl3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Nov 2014 08:41:29 -0500
Received: by mail-oi0-f46.google.com with SMTP id h136so4650023oig.5
        for <linux-pm@vger.kernel.org>; Fri, 28 Nov 2014 05:41:29 -0800 (PST)
In-Reply-To: <20141128132559.GA23674@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Zhang Rui <rui.zhang@intel.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Hongbo Zhang <hongbo.zhang@linaro.com>, Kyungmin Park <kyungmin.park@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

On 28 November 2014 at 18:56, Eduardo Valentin <edubezval@gmail.com> wrote:
> About Exynos, at which point/patch Exynos starts to fail?

e2cb864 cpu_cooling: find max level during device registration

> As I mentioned in the thread about cpu cooling vs. cpufreq, I prefer to
> update all users of the updated [of_]cpufreq_cooling_register API, if
> you don't mind.
>
> Can you please elaborate a little more about how this failure is
> happening?

Its the same problem, cpufreq driver isn't ready and
cpufreq_frequency_get_table() starts failing :)
