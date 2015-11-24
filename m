From: Javi Merino <javi.merino@arm.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.4-rc2 #1
Date: Tue, 24 Nov 2015 15:05:15 +0000
Message-ID: <20151124150515.GC17897@e104805>
References: <20151117033239.GA27415@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151117033239.GA27415@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 16, 2015 at 07:32:41PM -0800, Eduardo Valentin wrote:
> Hello Rui,
> 
> Please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal fixes
> 
> to receive Thermal-SoC Management updates for v4.4-rc2 with top-most
> 
> 84f0e490bee0684bd00c8ee02b15487d58bcea9f:
> 
>   thermal: rcar_thermal: remove redundant operation (2015-11-16 10:53:08 -0800)
> 
> on top of commit 5d50ac70fe98518dbf620bfba8184254663125eb:
> 
>   Merge tag 'xfs-for-linus-4.4' of git://git.kernel.org/pub/scm/linux/kernel/git/dgc/linux-xfs (2015-11-11 20:18:48 -0800)
> 
> Specifics in this pull request:
> - Several fixes and cleanups on Rockchip thermal drivers.
> - On top of fixes, Rockchip driver also learned how to handle RK3368.
> - Small fixes on: of-thermal, power_allocator, and rcar driver.
> - Build/boot tests powered by KernelCI [1,2] \o/
> 
> There are still pending fixes that need to go through my testing cycle.
> But I might send them either in another pull request, or for rc3.
> 
> [1] - http://kernelci.org/boot/all/job/evalenti/kernel/v4.3-11636-g84f0e490bee0/
> [2] - http://kernelci.org/build/evalenti/kernel/v4.3-11636-g84f0e490bee0/
> 
> BR,
> 
> Eduardo Valentin
> ----------------------------------------------------------------
> Caesar Wang (7):
>       dt-bindings: rockchip-thermal: Support the RK3368 SoCs compatible
>       thermal: rockchip: better to compatible the driver for different SoCs
>       thermal: rockchip: trivial: fix typo in commit
>       thermal: rockchip: improve the conversion function
>       thermal: rockchip: Add the sort mode for adc value increment or decrement
>       thermal: rockchip: consistently use int for temperatures
>       thermal: rockchip: Support the RK3368 SoCs in thermal driver
> 
> Jiada Wang (1):
>       thermal: of-thermal: Reduce log level for message when can't fine thermal zone
> 
> Kapileshwar Singh (1):
>       thermal: power_allocator: Use temperature reading from tz
> 
> Kuninori Morimoto (1):
>       thermal: rcar_thermal: remove redundant operation
> 
>  .../bindings/thermal/rockchip-thermal.txt          |   4 +-
>  drivers/thermal/of-thermal.c                       |   2 +-
>  drivers/thermal/power_allocator.c                  |  24 +-
>  drivers/thermal/rcar_thermal.c                     |  49 ++-
>  drivers/thermal/rockchip_thermal.c                 | 328 +++++++++++++++------
>  5 files changed, 272 insertions(+), 135 deletions(-)

Looks like this didn't make it for v4.4-rc2, can you please resend it
for v4.4-rc3?

Cheers,
Javi
