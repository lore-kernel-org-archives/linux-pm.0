From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3 2/2] cpufreq: tegra: Re-model Tegra cpufreq driver
Date: Wed, 18 Dec 2013 16:41:35 +0530
Message-ID: <CAKohpom0n8P8goQnsgBnWJwyqCVv_FRX3xKvO1yFW0VUMpMW8w@mail.gmail.com>
References: <1386229462-3474-1-git-send-email-bilhuang@nvidia.com>
	<1386229462-3474-3-git-send-email-bilhuang@nvidia.com>
	<CAKohponns4B+BPPum3EN6EuXx6U+6MzOa50gMdR1BNBtxMNf0Q@mail.gmail.com>
	<52B02D04.4050905@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:40326 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751241Ab3LRLLh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 18 Dec 2013 06:11:37 -0500
Received: by mail-ob0-f173.google.com with SMTP id gq1so7715956obb.18
        for <linux-pm@vger.kernel.org>; Wed, 18 Dec 2013 03:11:37 -0800 (PST)
In-Reply-To: <52B02D04.4050905@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: bilhuang <bilhuang@nvidia.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stephen Warren <swarren@wwwdotorg.org>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>

On 17 December 2013 16:22, bilhuang <bilhuang@nvidia.com> wrote:
> Tegra20 DVFS is a little bit complicated due to the fact that we can't scale
> VDD_CPU directly, there are constraints or relationship to other power rails
> so I don't think it is a good idea to use generic cpufreq-cpu0 driver if
> we're going to support voltage scaling.

But why can't we handle that in a CPU specific regulator code?
