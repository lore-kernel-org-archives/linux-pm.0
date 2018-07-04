From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/2] powernv/cpuidle Device-tree parsing cleanup
Date: Wed, 04 Jul 2018 12:54:16 +0200
Message-ID: <1970525.ZJ2QEpmLmV@aspire.rjw.lan>
References: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1530609656-13301-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 3, 2018 11:20:54 AM CEST Akshay Adiga wrote:
> 
> Device-tree parsed multiple time in powernv cpuidle and powernv
> hotplug code. 
> 
> First to identify supported flags. Second time, to identify deepest_state
> and first deep state. Third time, during cpuidle init to find the available
> idle states. Any change in device-tree format will lead to make changes in
> these 3 places. Errors in device-tree can be handled in a better manner.
> 
> This series adds code to parse device tree once and save in global structure.
> 
> Changes from v2 :
>  - Fix build error (moved a hunk from patch 1 to patch 2)
> Changes from v1 :
>  - fold first 2 patches into 1
>  - rename pm_ctrl_reg_* as psscr_*
>  - added comment stating removal of pmicr parsing code
>  - removed parsing code for pmicr
>  - add member valid in pnv_idle_states_t to indicate if the psscr-mask/val
> are valid combination,
>  - Change function description of pnv_parse_cpuidle_dt
>  - Added error handling code.
> 
> 
> Akshay Adiga (2):
>   powernv/cpuidle: Parse dt idle properties into global structure
>   powernv/cpuidle: Use parsed device tree values for cpuidle_init
> 
>  arch/powerpc/include/asm/cpuidle.h    |  13 ++
>  arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
>  drivers/cpuidle/cpuidle-powernv.c     | 154 ++++--------------
>  3 files changed, 177 insertions(+), 206 deletions(-)
> 
> 

I am assuming that this series will go in via the powerpc tree.

Thanks,
Rafael
