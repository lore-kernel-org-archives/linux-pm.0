From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 0/9] i2c: move handling of suspended adapters to the
 core
Date: Mon, 24 Dec 2018 09:55:35 +0100
Message-ID: <7fd31445-6cf8-5094-3cd8-d6ca5c059541@redhat.com>
References: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222202623.4521-1-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi,

On 22-12-18 21:26, Wolfram Sang wrote:
> Here is the new version without specific I2C helpers but using the
> 'is_suspended' flag from the PM core. I didn't like messing with the
> flag directly, so I did a helper in patch 1. So far, I like the
> approach. The diffstat looks nice, and i2c-rcar.c and i2c-sh_mobile.c
> rejected rightfully too later transfers without further modifications.
> Tested on a Renesas Lager board (R-Car H2).
> 
> I dropped a few Tested-by tags because I think this approach is too
> different from V1 to keep them. I hope you guys can have a look again.
> Thanks for all the testing, so far!
> 
> A branch can be found here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/i2c/reject-when-suspended
> 
> If this series is acceptable, I'd suggest to take it via my i2c tree
> after rc1. And then I'll provide an immutable branch for the PM tree to
> pick. Let me know if this works for you.
> 
> And thanks to Renesas for funding this work!

Series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> 
> Thanks and kind regards,
> 
>     Wolfram
> 
> Wolfram Sang (9):
>    PM / core: add helper to return suspend status of a device
>    i2c: reject new transfers when adapters are suspended
>    i2c: synquacer: remove unused is_suspended flag
>    i2c: brcmstb: don't open code to reject transfers when suspended
>    i2c: zx2967: don't open code to reject transfers when suspended
>    i2c: sprd: don't use pdev as variable name for struct device *
>    i2c: sprd: don't open code to reject transfers when suspended
>    i2c: exynos5: don't open code to reject transfers when suspended
>    i2c: s3c2410: don't open code to reject transfers when suspended
> 
>   Documentation/i2c/fault-codes      |  4 ++++
>   drivers/i2c/busses/i2c-brcmstb.c   | 22 +-------------------
>   drivers/i2c/busses/i2c-exynos5.c   | 10 ----------
>   drivers/i2c/busses/i2c-s3c2410.c   |  7 -------
>   drivers/i2c/busses/i2c-sprd.c      | 32 ++++++++++--------------------
>   drivers/i2c/busses/i2c-synquacer.c |  5 -----
>   drivers/i2c/busses/i2c-zx2967.c    |  8 --------
>   drivers/i2c/i2c-core-base.c        |  3 +++
>   drivers/i2c/i2c-core-smbus.c       |  4 ++++
>   include/linux/device.h             |  5 +++++
>   10 files changed, 27 insertions(+), 73 deletions(-)
> 
