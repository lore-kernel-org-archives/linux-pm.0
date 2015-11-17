From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4 0/3] Dynamic power model from device tree
Date: Tue, 17 Nov 2015 10:05:53 +0530
Message-ID: <CAOh2x=nRf-gf56ws_HFh-gvd9rLAYu+_f9oQ1CJ-A_-8-LZ=Wg@mail.gmail.com>
References: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:35499 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752022AbbKQEfy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 23:35:54 -0500
In-Reply-To: <1447702225-13323-1-git-send-email-punit.agrawal@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Punit Agrawal <punit.agrawal@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, dawei.chien@mediatek.com, Javi Merino <javi.merino@arm.com>

On Tue, Nov 17, 2015 at 1:00 AM, Punit Agrawal <punit.agrawal@arm.com> wrote:
> Hi,
>
> This patchset adds support to build a single-coefficient dynamic power
> model for a CPU. The model is used by the CPU cooling device to
> provide an estimate of power consumption and also translate allocated
> power to performance cap.
>
> Changes from previous posting -
>
> v3 -> v4:
> arm_big_little: Migrated to using static arrays
> arm_big_little: Updated Kconfig to support building thermal as module
>
> Patch 1 extends the CPU nodes binding to provide an optional dynamic
> power coefficient which can be used to create a dynamic power model
> for the CPUs. This model is used to constrain device power consumption
> (using power_allocator governor) when the system is thermally
> constrained.
>
> Patches 2-3 extends the cpufreq-dt and arm_big_little driver to
> register cpu cooling devices with the dynamic coefficient when
> provided.
>
> The patches were previously posted at [0][1][2]. Mediatek platform
> 8173 builds on these bindings to build the power model.
>
> If there are no objections, I'd appreciate Acks from device tree
> bindings maintainers.

You forgot to cc cpufreq maintainers for this and there are good chances
that I may completely miss the series some times..
