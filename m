From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH 0/4] Convert thermal subsystem to the IDA allocator
Date: Wed, 04 Jan 2017 12:49:27 +0800
Message-ID: <1483505367.2320.52.camel@intel.com>
References: <1482342426-30520-1-git-send-email-mawilcox@linuxonhyperv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:29855 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751101AbdADEtc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Jan 2017 23:49:32 -0500
In-Reply-To: <1482342426-30520-1-git-send-email-mawilcox@linuxonhyperv.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Matthew Wilcox <mawilcox@linuxonhyperv.com>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, linux-pm@vger.kernel.org

Hi, Matthew,

On Wed, 2016-12-21 at 09:47 -0800, Matthew Wilcox wrote:
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> None of the ID allocations are in a hot path, so I think it's better
> to use the ida_simple_get/ida_simple_remove API instead of having
> individual mutexes.
> 
I agree. Thanks for the patches.
Applied and queued for 4.11.

thanks,
rui
> I've only compile-tested these changes ... even that is quite tricky
> given
> the maze of Kconfig options which make it hard to select those
> drivers.
> I eventually gave up and played games with the header files to get
> the
> compiler to compile them cleanly.
> 
> Matthew Wilcox (4):
>   thermal core: convert ID allocation to IDA
>   thermal: convert clock cooling to use an IDA
>   thermal: convert cpu_cooling to use an IDA
>   thermal: convert devfreq_cooling to use an IDA
> 
>  drivers/thermal/clock_cooling.c   | 50 +++++---------------------
>  drivers/thermal/cpu_cooling.c     | 63 ++++++-----------------------
> ---
>  drivers/thermal/devfreq_cooling.c | 53 +++++----------------------
>  drivers/thermal/thermal_core.c    | 75 ++++++++++++++---------------
> ----------
>  include/linux/thermal.h           |  4 +--
>  5 files changed, 56 insertions(+), 189 deletions(-)
> 
