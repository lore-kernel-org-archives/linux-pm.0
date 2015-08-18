From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 0/6] ARM: berlin: add cpufreq support
Date: Tue, 18 Aug 2015 18:26:42 +0530
Message-ID: <CAOh2x=ke9NWa-GjL=c+RgEWWfsNeKvE2O9CRHmW2dG5mj8ATCg@mail.gmail.com>
References: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:33692 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbbHRM4n (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 18 Aug 2015 08:56:43 -0400
In-Reply-To: <1439898368-11543-1-git-send-email-antoine.tenart@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Antoine Tenart <antoine.tenart@free-electrons.com>
Cc: sebastian.hesselbarth@gmail.com, zmxu@marvell.com, jszhang@marvell.com, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Aug 18, 2015 at 5:16 PM, Antoine Tenart
<antoine.tenart@free-electrons.com> wrote:
> Hi,
>
> This series adds the cpufreq support to the Berlin SoCs, using
> cpufreq-dt.
>
> First, the cpuclk clock is added to the BG2Q clock driver. This clock
> has a divider fixed to 1, so we use a fixed factor clock here.
>
> Then register a platform device for cpufreq-dt.
>
> I also added the OPP table definition in the BG2Q, BG2 and BG2CD device
> trees. When using a BG2Q, some bootloaders may update this table when
> booting (mine doesn't).

You can switch to OPP-v2 bindings if you want. Just have a look, they are
much more powerful.. Should be in linux-next/master.
