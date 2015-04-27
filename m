From: Javi Merino <javi.merino@arm.com>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.1-rc1
Date: Mon, 27 Apr 2015 09:35:36 +0100
Message-ID: <20150427083536.GB3066@e104805>
References: <20150415054819.GA16396@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150415054819.GA16396@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Zhang <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Linux PM <linux-pm@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 15, 2015 at 06:48:20AM +0100, Eduardo Valentin wrote:
> Hello Rui,
> 
> Please pull from
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus
> 
> to receive Thermal-SoC Management updates for v4.1-rc1 with top-most
> 
> 55920e072776533fd314fb3d9b69c866ed90b3df:
> 
>   thermal: exynos: Add the support for Exynos5433 TMU (2015-04-14 22:31:17 -0700)
> 
> on top of commit f8b3d8a5af7559a58613384cd23fc03a3c787acf:
> 
>   Merge tag 'usb-4.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb (2015-04-04 12:26:28 -0700)
> 
> Specifics:
> - Exynos thermal driver learns how to handle Exynos5433 TMU. Thanks to Chanwoo C.;
> - Thermal Framework now supports QPNP PMIC temperature alarm as a new thermal
>   driver. Thanks to Ivan T. I.;
> - TI thermal driver now has a better implementation for EOCZ bit. Thanks to Pavel M.;
> - Thermal Framework now has learned several new capabilities:
>   . use power estimates
>   . compute weights with relative integers instead of percentages
>   . allow governors to have private data in thermal zones
>   . export thermal zone parameters through sysfs
>   Thanks to the ARM thermal team (Javi M., Punit A., and KP).
> - Thermal Framework earns a new thermal governor: power allocator. First in kernel
>   closed loop PI(D) controller for thermal control. Thanks to ARM thermal team.
> - OF thermal now allows thermal zones to have sustainable power HW specification.
>   Thanks to Punit.

4.1-rc1 is out and it looks like this fell through the cracks.  If
there isn't any objection, can any of you send the pull request to
Linus?

Thanks,
Javi
