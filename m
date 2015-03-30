From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: hisilicon: add acpu driver
Date: Mon, 30 Mar 2015 11:04:08 +0530
Message-ID: <CAKohpomCQos+a8rjZa=B=jmhffi-qWrjz_nSZ_i68fxnJ5ioVA@mail.gmail.com>
References: <1427693197-12290-1-git-send-email-leo.yan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:34283 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775AbbC3FeI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Mar 2015 01:34:08 -0400
Received: by obbgh1 with SMTP id gh1so49532095obb.1
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2015 22:34:08 -0700 (PDT)
In-Reply-To: <1427693197-12290-1-git-send-email-leo.yan@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Leo Yan <leo.yan@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dan Zhao <dan.zhao@hisilicon.com>, zhenwei.wang@hisilicon.com, mohaoju@hisilicon.com, Haojian Zhuang <haojian.zhuang@linaro.org>, Wei Xu <xuwei5@hisilicon.com>

On 30 March 2015 at 10:56, Leo Yan <leo.yan@linaro.org> wrote:
> Add acpu driver for hisilicon SoC, acpu is application processor
> subsystem. Currently the acpu has the coupled clock domain for two
> clusters, so this driver will directly use cpufreq-dt driver as
> backend.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/cpufreq/Kconfig.arm         |  9 ++++++++
>  drivers/cpufreq/Makefile            |  1 +
>  drivers/cpufreq/hisi-acpu-cpufreq.c | 42 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 52 insertions(+)
>  create mode 100644 drivers/cpufreq/hisi-acpu-cpufreq.c

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
