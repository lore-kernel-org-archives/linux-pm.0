From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.2-rc7
Date: Sat, 15 Aug 2015 10:17:05 -0700
Message-ID: <20150815171702.GB4151@localhost.localdomain>
References: <20150815171445.GA4151@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36573 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269AbbHORRI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 15 Aug 2015 13:17:08 -0400
Content-Disposition: inline
In-Reply-To: <20150815171445.GA4151@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Rui,

On Sat, Aug 15, 2015 at 10:14:45AM -0700, Eduardo Valentin wrote:
> Hello Rui,
> 
> Please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
> 
> to receive Thermal-SoC Management updates for v4.2-rc7 with top-most
> 
> 1afb9c539daebc2c8a7b33d0e0b8fc9f74671b02:
> 
>   thermal/cpu_cooling: update policy limits if clipped_freq < policy->max (2015-08-14 18:26:23 -0700)
> 
> on top of commit 7ddab73346a1277b90fd6a4d044bc948f9cc9ad8:
> 
>   Merge branch 'fixes' of git://ftp.arm.linux.org.uk/~rmk/linux-arm (2015-08-13 16:34:56 -0700)
> 
> 
> Specifics:
> - Locked fix in the cpu cooling code.

Sorry for the late notice, but this fix should make it as soon as
possible. I messed up by forgetting this one for very long time. 

> - Refactoring in the cpu cooling code.
> - Remove devm* functions from power allocator.
> 
> BR,
> 
> Eduardo Valentin
> ----------------------------------------------------------------
> Dmitry Torokhov (1):
>       thermal: power_allocator: do not use devm* interfaces
> 
> Russell King (1):
>       thermal: cpu_cooling: fix lockdep problems in cpu_cooling
> 
> Viresh Kumar (6):
>       thermal/cpu_cooling: No need to initialize max_freq to 0
>       thermal/cpu_cooling: quit early after updating policy
>       thermal/cpu_cooling: convert 'switch' block to 'if' block in notifier
>       thermal/cpu_cooling: rename cpufreq_val as clipped_freq
>       thermal/cpu_cooling: rename max_freq as clipped_freq in notifier
>       thermal/cpu_cooling: update policy limits if clipped_freq < policy->max
> 
>  drivers/thermal/cpu_cooling.c     | 73 +++++++++++++++++++++++----------------
>  drivers/thermal/power_allocator.c |  8 ++---
>  2 files changed, 48 insertions(+), 33 deletions(-)
