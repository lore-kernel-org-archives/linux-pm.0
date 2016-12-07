From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v4 2/4] thermal: rcar_gen3_thermal: Add R-Car Gen3
 thermal driver
Date: Tue, 6 Dec 2016 17:15:46 -0800
Message-ID: <20161207011544.GC12562@localhost.localdomain>
References: <20161201220442.22057-1-wsa+renesas@sang-engineering.com>
 <20161201220442.22057-3-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161201220442.22057-3-wsa+renesas@sang-engineering.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Khiem Nguyen <khiem.nguyen.xt@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Hien Dang <hien.dang.eb@renesas.com>, Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
List-Id: linux-pm@vger.kernel.org

Hello Wolfram,

On Thu, Dec 01, 2016 at 11:04:40PM +0100, Wolfram Sang wrote:
> Add support for R-Car Gen3 thermal sensors. Polling only for now,
> interrupts will be added incrementally. Same goes for reading fuses.
> This is documented already, but no hardware available for now.
> 
> Signed-off-by: Hien Dang <hien.dang.eb@renesas.com>
> Signed-off-by: Thao Nguyen <thao.nguyen.yb@rvc.renesas.com>
> Signed-off-by: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Changes since v3:
> 
> * call 'init' callback a tad earlier, avoids need for locking
> * converted spinlock to mutex and simplified locking (only done against
>   concurrent access in rcar_gen3_thermal_get_temp() now)
> * use usleep_range instead of udelay
> * use s64 instead of long (int didn't work)
> * fixed an error path
> * simplified rcar_gen3_thermal_update_temp() and its use
> 

When I try compiling this driver (from this commit only), using
multi_v7_defconfig, I get this error when set as module:
ERROR: "__aeabi_ldivmod" [drivers/thermal/rcar_gen3_thermal.ko]
undefined!
scripts/Makefile.modpost:91: recipe for target '__modpost' failed

And these errors when builtin:
  LD      init/built-in.o
  drivers/built-in.o: In function `rcar_gen3_thermal_get_temp':
  :(.text+0x461778): undefined reference to `__aeabi_ldivmod'
  :(.text+0x461798): undefined reference to `__aeabi_ldivmod'
  drivers/built-in.o: In function `rcar_gen3_thermal_probe':
  :(.text+0x461948): undefined reference to `__aeabi_ldivmod'
  :(.text+0x461998): undefined reference to `__aeabi_ldivmod'
  :(.text+0x4619d0): undefined reference to `__aeabi_ldivmod'
  drivers/built-in.o::(.text+0x4619fc): more undefined references to
  `__aeabi_ldivmod' follow
  Makefile:962: recipe for target 'vmlinux' failed
  make: *** [vmlinux] Error 1

So, definitely would make sense to squash patch 5 here. BUT,

looking closer to it, I am getting this in the menuconfig on the flag
you added:
  │ Symbol: 64BIT [=64BIT]
  │  
  │ Type  : unknown   


  Am I missing something?


  BR,

Eduardo
