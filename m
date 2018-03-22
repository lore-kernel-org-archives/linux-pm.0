From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Mar 22 (thermal)
Date: Thu, 22 Mar 2018 10:36:38 -0700
Message-ID: <5449db25-c11e-68a1-532c-044689794aad@infradead.org>
References: <20180322193847.63181403@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180322193847.63181403@canb.auug.org.au>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 03/22/2018 01:38 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180321:
> 
> The vfs tree still had its build failure for which I reverted a commit.
> 

on i386:

ERROR: "nsec_to_clock_t" [drivers/thermal/thermal_sys.ko] undefined!

so in drivers/thermal/thermal_sysfs.c, please add:

#include <linux/jiffies.h>


Reported-by: Randy Dunlap <rdunlap@infradead.org>

thanks,
-- 
~Randy
