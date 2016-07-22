From: Phil Reid <preid@electromag.com.au>
Subject: Re: [PATCH 4/4] power: sbs-battery: Use gpio_desc and sleeping calls
 for battery detect
Date: Fri, 22 Jul 2016 22:18:28 +0800
Message-ID: <fbc31b36-e6bf-b7c5-742b-91619280b8f4@electromag.com.au>
References: <201607221825.d8qlO3ak%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from anchovy3.45ru.net.au ([203.30.46.155]:37568 "EHLO
	anchovy.45ru.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750810AbcGVOSh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 10:18:37 -0400
In-Reply-To: <201607221825.d8qlO3ak%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org

On 22/07/2016 18:40, kbuild test robot wrote:
> Hi,
>
> [auto build test ERROR on battery/master]
> [also build test ERROR on v4.7-rc7 next-20160722]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Phil-Reid/power-sbs-manager-fixup-gpio-detect-irq-handling/20160722-174454
> base:   git://git.infradead.org/battery-2.6.git master
> config: x86_64-randconfig-n0-07221807 (attached as .config)
> compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64
>
> All errors (new ones prefixed by >>):
>
>    drivers/power/sbs-battery.c: In function 'sbs_probe':
>>> drivers/power/sbs-battery.c:857:33: error: passing argument 1 of 'sbs_of_populate_pdata' from incompatible pointer type [-Werror=incompatible-pointer-types]
>       pdata = sbs_of_populate_pdata(chip);
>                                     ^~~~
>    drivers/power/sbs-battery.c:805:34: note: expected 'struct i2c_client *' but argument is of type 'struct sbs_info *'
>     static struct sbs_platform_data *sbs_of_populate_pdata(
>                                      ^~~~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
>
> vim +/sbs_of_populate_pdata +857 drivers/power/sbs-battery.c
>
>    851		chip->ignore_changes = 1;
>    852		chip->last_state = POWER_SUPPLY_STATUS_UNKNOWN;
>    853	
>    854		if (pdata) {
>    855			pdata = sbs_populate_pdata(chip);
>    856		} else {
>  > 857			pdata = sbs_of_populate_pdata(chip);
>    858		}
>    859	
>    860		if (IS_ERR(pdata))
>
Forgot to update an empty function for when CONFIG_OF is not defined.
I'll update after other feedback on the patch.

-- 
Regards
Phil Reid

