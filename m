From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v6 08/18] cpufreq: exynos: Use device tree to determine if
 cpufreq cooling should be registered
Date: Sun, 25 Jan 2015 19:31:14 +0530
Message-ID: <CAKohponvCzJrseb7UW1szYc=1M9BA=A8nVpocOQVyr1c=zO6VQ@mail.gmail.com>
References: <1421666462-7606-1-git-send-email-l.majewski@samsung.com>
	<1422015260-14225-1-git-send-email-l.majewski@samsung.com>
	<CAKohpok1EacvJ3PCOZYnz81D3=P04apRp7VOxPFE1QxYF4Wydg@mail.gmail.com>
	<20150123145744.3dc47a47@amdc2363>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f50.google.com ([209.85.218.50]:43579 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330AbbAYOBP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jan 2015 09:01:15 -0500
Received: by mail-oi0-f50.google.com with SMTP id h136so3912947oig.9
        for <linux-pm@vger.kernel.org>; Sun, 25 Jan 2015 06:01:14 -0800 (PST)
In-Reply-To: <20150123145744.3dc47a47@amdc2363>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Kukjin Kim <kgene@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>

On 23 January 2015 at 19:27, Lukasz Majewski <l.majewski@samsung.com> wrote:
> Please pay a note about following problem:
>
> Previously we got: cpu0: cpu@0 for all Exynos devices.
>
> Now, however, cpu numbering has changed (due to GIC rework).
> For example:
>
> Exynos4412:
>         cpus {
>                 cpu0: cpu@A00 {
>                         ...
>                         #cooling-cells = <2>; /* min followed by max */
>                 };
>
>                 cpu@A01 {
>                 };
>
>                 cpu@A02 {
>                 };
>
>                 cpu@A03 {
>                 };
>         }
>
> Exynos 4210:
>         cpus {
>                 cpu0: cpu@900 {
>                         #cooling-cells = <2>; /* min followed by max */
>                 };
>
>                 cpu@901 {
>                 };
>         };
>
> Exynos 5250:
>         cpus {
>                 cpu0: cpu@0 {
>                         #cooling-cells = <2>; /* min followed by max */
>                 };
>
>                 cpu@1 {
>                 };
>         };
>
>
> As you can see different cpu@XXY nodes we have and simply calling cpu@0
> won't work.

I wasn't asked you to get the cpu0 node from dt but this:

cpu_dev = get_cpu_dev(0);
np = of_node_get(cpu_dev->of_node);

Wouldn't this work? You only need to guarantee that the cooling-cells is added
onto the boot CPUs node.
