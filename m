From: Javi Merino <javi.merino@arm.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.3-rc2
Date: Mon, 21 Sep 2015 09:57:45 +0100
Message-ID: <20150921085744.GB2746@e104805>
References: <20150914035500.GC5075@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150914035500.GC5075@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Eduardo, Rui,

On Mon, Sep 14, 2015 at 04:55:01AM +0100, Eduardo Valentin wrote:
> Hello Rui,
> 
> (apologize for duplicates, now copying the mailing lists)
> 
> Please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
> 
> to receive Thermal-SoC Management updates for v4.3-rc2 with top-most
> 
> eba4f88d5af84e0fcaa5d6eb4fe35a75c47203cb:
> 
>   thermal: cpu_cooling: free power table on error or when unregistering (2015-09-13 20:34:05 -0700)
> 
> on top of commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:
> 
>   Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)
> 
> Specifics:
> - Add compile test flags on thermal drivers that allow it without
> producing compilation errors
> - Fixes around memory allocation on cpu_cooling
> - Fix on db8500 cpufreq code to allow autoload
> - Maintainer entries for cpu cooling device
> 
> More fixes still to come, but if not for rc2, for rc3.

Looks like this didn't make it for -rc2.  Please send a pull request
for -rc3.

Thanks,
Javi
