From: Richard Zhao <linuxzsc@gmail.com>
Subject: Re: [PATCH 0/6] Tegra: Use cpufreq-cpu0 driver
Date: Thu, 8 Aug 2013 16:31:22 +0800
Message-ID: <CANg6MZgqxF1GBOhtebZLuHBh_F6CxWT=YRsQunPR+wdCQRunPw@mail.gmail.com>
References: <cover.1375886595.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:51234 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933743Ab3HHIbY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 8 Aug 2013 04:31:24 -0400
In-Reply-To: <cover.1375886595.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, Stephen Warren <swarren@nvidia.com>, linaro-kernel@lists.linaro.org, Mike Turquette <mturquette@linaro.org>, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Wed, Aug 7, 2013 at 10:46 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Hi Stephen,
>
> This is the first attempt to get rid of tegra-cpufreq driver. This patchset
> tries to add supporting infrastructure for tegra to use cpufreq-cpu0 driver.

If tegra has only 4-core fast cpu, I would agree with the patch set. But now
I'm not so sure. Tegra cpuquiet driver and cluster switch may need special
settings of cpufreq driver.

Thanks
Richard
