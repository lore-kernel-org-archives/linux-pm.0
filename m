From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [Thermal] Need confirmation for the pending thermal soc patches
Date: Mon, 5 Sep 2016 06:16:01 -0700
Message-ID: <20160905131600.GA24253@localhost.localdomain>
References: <1471788540.2188.19.camel@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1471788540.2188.19.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello Rui,

On Sun, Aug 21, 2016 at 10:09:00PM +0800, Zhang Rui wrote:
> Hi,
> 
> As Eduardo is quite busy recently, I will take all the thermal soc
> driver changes this time.

Thanks for helping me out. I am slowing coming back to upstream
activities. I have refreshed my branches, removing the rework and
locking patches works out of the integration branches so we do not have
merge conflicts or further delays on outstanding patches.

> Currently, I have cherry picked all the patches that Eduardo has
> already applied in thermal-soc tree and reviewed all the pending

Great! This makes things easier for me.

> patches in patchwork. Now, there are four patches queued for next -rc (
> https://git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/log/?h=fo
> r-rc),

I checked this branch. Can you please cherry-pick the following patch
for rc:
https://git.kernel.org/cgit/linux/kernel/git/evalenti/linux-soc-thermal.git/commit/?h=linus&id=4ba16f1256bd13efa2f3179ff1f4ab16a4ad3c7f

?


> and 23 thermal soc patches queued for next merge window (https:/
> /git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/log/?h=release).
> 
> If you think some soc fixes that are urgent and should be in 4.8
> instead of 4.9, please let me know.
> If there are some patches that are neither in thermal -next tree(https:
> //git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/log/?h=next),
> nor have my response, please let me know, in case I missed some. :)


The above -next branch has all my outstanding material.

Given that you have taken care of all thermal-soc patches for the coming
merging window, I will work on the sysfs rework and locking patches
again. I will be sending them in smaller chunks this time.

> 
> thanks,
> rui
