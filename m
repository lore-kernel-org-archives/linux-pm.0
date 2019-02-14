From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2] drivers: base: add support to skip power management
 in device/driver model
Date: Thu, 14 Feb 2019 10:29:53 +0000
Message-ID: <20190214102953.GB28361@e107155-lin>
References: <20190213120137.23354-1-sudeep.holla@arm.com>
 <20190213223849.GA26335@vmlxhi-102.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190213223849.GA26335@vmlxhi-102.adit-jv.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eugeniu Rosca <erosca@de.adit-jv.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jisheng Zhang <jszhang@marvell.com>, Ulf Hansson <ulf.hansson@linaro.org>, Steve Longerbeam <slongerbeam@gmail.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 13, 2019 at 11:38:49PM +0100, Eugeniu Rosca wrote:
> Hello Sudeep,
>
> I appreciate your efforts. Currently, this patch generates below
> warnings during s2ram on R-Car H3-Salvator-X:
>
> [ 46.874214] PM: suspend entry (deep)
> [ 46.878211] PM: Syncing filesystems ... done.
> [ 46.989148] Freezing user space processes ... (elapsed 0.004 seconds) done.
> [ 47.000428] OOM killer disabled.
> [ 47.003895] Freezing remaining freezable tasks ... (elapsed 0.003 seconds) done.
> [ 47.226363] PM: suspend devices took 0.210 seconds
> [ 47.280553] Disabling non-boot CPUs ...
> [ 47.289157] ------------[ cut here ]------------
> [ 47.294524] sysfs group 'power' not found for kobject 'index0'
> [ 47.300622] WARNING: CPU: 1 PID: 14 at fs/sysfs/group.c:256 sysfs_remove_group+0x78/0xc4
> ---snip---
> [ 47.550425] sysfs group 'power' not found for kobject 'index1'
> ---snip---
> [ 47.807005] sysfs group 'power' not found for kobject 'index2'
> ---snip---
> [ 48.063703] sysfs group 'power' not found for kobject 'cache'
> ---snip---
>

Thanks for the report, looks like I am not able to reproduce this, will
check if I am missing something while testing.

> Complete log and .config are shared in
> https://gist.github.com/erosca/da9ea551033a503121de61049d77b834
>

Thanks again, much appreciated for providing full log.

--
Regards,
Sudeep
