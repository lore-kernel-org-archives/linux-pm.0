From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH v5 Resend 2/3] Cpufreq: s5pv210 cpufreq fixes for CCF
Date: Mon, 30 Dec 2013 08:55:16 +0530
Message-ID: <CAK9yfHwC950-+iJza=PG2XPn9LZLwwVGtNu_2UU1gHE2CJ+yTg@mail.gmail.com>
References: <1388250556-4594-1-git-send-email-mat.krawczuk@gmail.com>
	<1388250556-4594-3-git-send-email-mat.krawczuk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:45946 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753183Ab3L3DZQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 29 Dec 2013 22:25:16 -0500
Received: by mail-oa0-f46.google.com with SMTP id o6so11471743oag.5
        for <linux-pm@vger.kernel.org>; Sun, 29 Dec 2013 19:25:16 -0800 (PST)
In-Reply-To: <1388250556-4594-3-git-send-email-mat.krawczuk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mateusz Krawczuk <mat.krawczuk@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Mateusz Krawczuk <m.krawczuk@partner.samsung.com>

(Trimmed down the CC list)

Hi Mateusz,

On 28 December 2013 22:39, Mateusz Krawczuk <mat.krawczuk@gmail.com> wrote:
> From: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
>
> Use common clock framework api to get clock.

The commit message looks a bit off. clk_get() is also a CCF API.
Hence it makes more sense to mention the reason for replacing clk_get() with
clk_get_sys(). Since the patch title says it is a fix, please also
mention the issue
this patch fixes.

-- 
With warm regards,
Sachin
