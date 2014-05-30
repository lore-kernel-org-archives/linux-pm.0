From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 0/2] cpufreq: opp: Add device tree based lookup of boost mode frequency
Date: Fri, 30 May 2014 14:19:06 +0200
Message-ID: <5683009.PqtetcWKuO@vostro.rjw.lan>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50278 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751272AbaE3MB6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 May 2014 08:01:58 -0400
In-Reply-To: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Abraham <thomas.ab@samsung.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, t.figa@samsung.com, l.majewski@samsung.com, viresh.kumar@linaro.org, nm@ti.com

On Friday, May 30, 2014 02:31:15 PM Thomas Abraham wrote:
> Changes since v5:
> - Fixes for checkpatch warnings with --strict option as suggested by
>   Nishanth Menon.
> 
> Changes since v4:
> - Code improvements suggested by Viresh Kumar.
> 
> Changes since v3:
> - Minor changes as suggested in the last version.
> 
> Changes since v2:
> - Reworked based on the "PM / OPP: move cpufreq specific helpers out of OPP 
>   layer" patch series posted by Nishanth Menon.
> 
> Changes since v1:
> - Boost mode frequencies are specfied as a set of frequencies instead of
>   specifying them as OPPs. Thanks to Nishanth, Lukasz and Rob for the
>   feedback.
> 
> This series has been acked by authors and maintainers of the code
> portions changed in this series. The new DT binding introduced in this
> patch needs an ack from device tree binding maintainers as well.
> 
> Commit 6f19efc0 ("cpufreq: Add boost frequency support in core") adds
> support for CPU boost mode for CPUfreq drivers. To use the new boost
> mode, CPUfreq drivers have to specify the boost mode frequency and
> voltage within the CPUfreq driver, which is the case for Exynos4x12
> CPUfreq driver.
> 
> But for CPUfreq drivers which obtain the OPPs from cpus node, this
> patch series adds support to specify boost mode frequencies in the
> cpu device tree node. This requirement came up when Lukasz pointed
> out the regression caused by the Exynos CPUfreq driver consolidation
> patches.

Both patches queued up for 3.16 in the linux-pm tree.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
