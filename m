From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [acpi:release 3/3] intel_idle.c:undefined reference to
 `__udivdi3'
Date: Thu, 24 Mar 2016 06:55:52 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E883BB64024@SHSMSX101.ccr.corp.intel.com>
References: <201603241443.6LBLekqw%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201603241443.6LBLekqw%fengguang.wu@intel.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: "Wu, Fengguang" <fengguang.wu@intel.com>, "Brown, Len" <len.brown@intel.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi, Len

This looks like a job that human should do because machines cannot do that for us.
We need to use div64() in the kernel because kernel doesn't link CRT.
While for the indentation issue, it won't hurt anybody.

Thanks
-Lv

> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> Subject: [acpi:release 3/3] intel_idle.c:undefined reference to `__udivdi3'
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release
> head:   1664c8b16a75e9f73f4f40186c0c843bbf7dbde8
> commit: 1664c8b16a75e9f73f4f40186c0c843bbf7dbde8 [3/3] intel_idle: add
> BXT support
> config: i386-randconfig-n0-03241107 (attached as .config)
> reproduce:
>         git checkout 1664c8b16a75e9f73f4f40186c0c843bbf7dbde8
>         # save the attached .config to linux build tree
>         make ARCH=i386
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/built-in.o: In function `intel_idle_init':
> >> intel_idle.c:(.init.text+0x16a3): undefined reference to `__udivdi3'
>    intel_idle.c:(.init.text+0x16e4): undefined reference to `__udivdi3'
>    intel_idle.c:(.init.text+0x1725): undefined reference to `__udivdi3'
>    intel_idle.c:(.init.text+0x1766): undefined reference to `__udivdi3'
>    intel_idle.c:(.init.text+0x17ab): undefined reference to `__udivdi3'
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
