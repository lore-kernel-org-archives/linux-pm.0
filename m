From: Leo Yan <leo.yan@linaro.org>
Subject: Re: [PATCH v3] cpufreq: hisilicon: add acpu driver
Date: Mon, 30 Mar 2015 13:54:22 +0800
Message-ID: <20150330055422.GB30058@leoy-linaro>
References: <1427693197-12290-1-git-send-email-leo.yan@linaro.org>
 <CAKohpomCQos+a8rjZa=B=jmhffi-qWrjz_nSZ_i68fxnJ5ioVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:35901 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbbC3Fyb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 01:54:31 -0400
Received: by qgf60 with SMTP id 60so160795827qgf.3
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2015 22:54:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKohpomCQos+a8rjZa=B=jmhffi-qWrjz_nSZ_i68fxnJ5ioVA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com, Haojian Zhuang <haojian.zhuang@linaro.org>, Wei Xu <xuwei5@hisilicon.com>

On Mon, Mar 30, 2015 at 11:04:08AM +0530, Viresh Kumar wrote:
> On 30 March 2015 at 10:56, Leo Yan <leo.yan@linaro.org> wrote:
> > Add acpu driver for hisilicon SoC, acpu is application processor
> > subsystem. Currently the acpu has the coupled clock domain for two
> > clusters, so this driver will directly use cpufreq-dt driver as
> > backend.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  drivers/cpufreq/Kconfig.arm         |  9 ++++++++
> >  drivers/cpufreq/Makefile            |  1 +
> >  drivers/cpufreq/hisi-acpu-cpufreq.c | 42 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 52 insertions(+)
> >  create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, Viresh.
