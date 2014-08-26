From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v9 4/6] ARM: Exynos: switch to using generic cpufreq
 driver for Exynos4210/5250/5420
Date: Tue, 26 Aug 2014 10:24:18 +0530
Message-ID: <CAKohponqAqpdQ3CEpZghZ=rGRBXUtFK09GdTSDyH5z4ZNp-odQ@mail.gmail.com>
References: <1406707663-16656-1-git-send-email-thomas.ab@samsung.com>
	<1406707663-16656-5-git-send-email-thomas.ab@samsung.com>
	<53DA8BB9.6020702@samsung.com>
	<53DA8D85.3050106@gmail.com>
	<7hbnrc6px3.fsf@paris.lan>
	<53F7DA13.6090305@gmail.com>
	<CADWw7OgAS-z-UOrJU-hL2fzuefJmLtCTg57jYk2Df7f5KfLJmA@mail.gmail.com>
	<7h8umc60we.fsf@paris.lan>
	<53FB5CB4.4050705@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:53306 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbaHZEyT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 Aug 2014 00:54:19 -0400
Received: by mail-ob0-f172.google.com with SMTP id wn1so11425385obc.31
        for <linux-pm@vger.kernel.org>; Mon, 25 Aug 2014 21:54:18 -0700 (PDT)
In-Reply-To: <53FB5CB4.4050705@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <t.figa@samsung.com>
Cc: Kevin Hilman <khilman@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Mike Turquette <mturquette@linaro.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Amit Kucheria <amit.kucheria@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Marek Szyprowski <m.szyprowski@samsung.com>

On 25 August 2014 21:26, Tomasz Figa <t.figa@samsung.com> wrote:
> Kukjin, Viresh, how would you want to proceed with merging it? It

Me and Rafael has agreed earlier that Kukjin can take these through
ARM-Soc tree..
