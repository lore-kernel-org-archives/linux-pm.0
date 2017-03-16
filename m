From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 0/2] Hi all,
Date: Thu, 16 Mar 2017 11:07:06 -0500
Message-ID: <22cd07ef-78a1-75b6-9552-d8604ab35368@ti.com>
References: <20170316160530.14956-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170316160530.14956-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, Evgeniy Polyakov <zbr@ioremap.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hmm, subject got messed up, should be:

[PATCH 0/2] Remove BQ27xxx platform interface

On 03/16/2017 11:05 AM, Andrew F. Davis wrote:
> To finish the work started in this patch[0] we needed to reorganize
> the 1-wire subsystem a bit, this is done here[1]. After that is taken
> this series can remove the need for a platform driver for supporting
> 1-wire connected BQ27xxx devices.
> 
> Thanks,
> Andrew
> 
> [0] https://patchwork.kernel.org/patch/7684371/
> [1] https://lkml.org/lkml/2017/3/16/604
> 
> Andrew F. Davis (2):
>   power: supply: move HDQ interface for bq27xxx from w1 to power/supply
>   power: supply: bq27xxx: move platform driver code into
>     bq27xxx_battery_hdq.c
> 
>  drivers/power/supply/Kconfig               |   9 ++
>  drivers/power/supply/Makefile              |   1 +
>  drivers/power/supply/bq27xxx_battery.c     | 104 ----------------------
>  drivers/power/supply/bq27xxx_battery_hdq.c | 135 +++++++++++++++++++++++++++++
>  drivers/w1/slaves/Kconfig                  |   6 --
>  drivers/w1/slaves/Makefile                 |   1 -
>  drivers/w1/slaves/w1_bq27000.c             | 117 -------------------------
>  include/linux/power/bq27xxx_battery.h      |  17 ----
>  8 files changed, 145 insertions(+), 245 deletions(-)
>  create mode 100644 drivers/power/supply/bq27xxx_battery_hdq.c
>  delete mode 100644 drivers/w1/slaves/w1_bq27000.c
> 
