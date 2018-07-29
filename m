From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/2] ata: ahci: Enable DEVSLP by default on SLP_S0
 support
Date: Sun, 29 Jul 2018 11:25:08 +0200
Message-ID: <930a28d9-6a81-ee03-eb77-4c3802145c65@redhat.com>
References: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180727204703.6505-1-srinivas.pandruvada@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, tj@kernel.org, rjw@rjwysocki.net
Cc: alan.cox@intel.com, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Mario.Limonciello@dell.com
List-Id: linux-pm@vger.kernel.org

Hi,

On 27-07-18 22:47, Srinivas Pandruvada wrote:
> One of the requirement for modern x86 system to enter lowest power mode
> (SLP_S0) is SATA IP block to be off. This is true even during when
> platform is suspended to idle and not only in opportunistic (runtime)
> suspend.
> This series is to enable DEVSLP by default.
> 
> v2:
>   As suggested by Hans, take care of the module param is same as default
>   LPM policy

Thanks.

Series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Note we need to keep an eye out for this causing regressions with
some disks / firmware-versions.

Regards,

Hans




> 
> -current (non-rfc) series
> Implemented suggestions from Hans
> - no override of policy set via module param
> - Override lpm policy per host not global policy
> - changed the new policy name to "min_power_with_partial"
> 
> rfc-v2
> - As suggested by Hans, it is possible to have ASP with DEVSLP, so
> add a new state.
> - Removed usage of mem_sleep_current, instead just rely on low power
> idle flag. Don't feel good to EXPORT from core suspend code.
> - Depending host policy to decide if we enable DEVSLP by default.
> 
> Srinivas Pandruvada (2):
>    ata: ahci: Support state with min power but Partial low power state
>    ata: ahci: Enable DEVSLP by default on x86 with SLP_S0
> 
>   drivers/ata/ahci.c        | 38 +++++++++++++++++++++++++++++++++-----
>   drivers/ata/libahci.c     |  5 ++++-
>   drivers/ata/libata-core.c |  1 +
>   drivers/ata/libata-scsi.c |  1 +
>   include/linux/libata.h    |  3 ++-
>   5 files changed, 41 insertions(+), 7 deletions(-)
> 
