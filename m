From: Markus Mayer <markus.mayer@broadcom.com>
Subject: Re: [PATCH] cpufreq: brcmstb-cpufreq: CPUfreq driver for older
 Broadcom STB SoCs
Date: Fri, 11 Nov 2016 11:00:40 -0800
Message-ID: <CAGt4E5vt1=WhOcnUDm0tEKYkG3BSwLBX8rxwYP=-AE58Db_zww@mail.gmail.com>
References: <20161110235601.71395-1-code@mmayer.net> <201611111422.fC7e66mg%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:36008 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933664AbcKKTAm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Nov 2016 14:00:42 -0500
Received: by mail-ua0-f178.google.com with SMTP id b35so20195862uaa.3
        for <linux-pm@vger.kernel.org>; Fri, 11 Nov 2016 11:00:42 -0800 (PST)
In-Reply-To: <201611111422.fC7e66mg%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Cc: Markus Mayer <code@mmayer.net>, kbuild-all@01.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Power Management List <linux-pm@vger.kernel.org>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On 10 November 2016 at 22:14, kbuild test robot <lkp@intel.com> wrote:
> Hi Markus,
>
> [auto build test ERROR on pm/linux-next]
> [also build test ERROR on next-20161110]
> [cannot apply to v4.9-rc4]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Markus-Mayer/cpufreq-brcmstb-cpufreq-CPUfreq-driver-for-older-Broadcom-STB-SoCs/20161111-075914
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> All errors (new ones prefixed by >>):
>
>>> FATAL: drivers/cpufreq/brcmstb-cpufreq: sizeof(struct platform_device_id)=24 is not a modulo of the size of section __mod_platform__<identifier>_device_table=392.
>>> Fix definition of struct platform_device_id in mod_devicetable.h

This is a strange one. It does apply to Rafael's pm-linux/linux-next
branch when I do it manually. It also builds.

  CHK     include/config/kernel.release
  CHK     include/generated/uapi/linux/version.h
  CHK     include/generated/utsrelease.h
  CHK     include/generated/timeconst.h
  CHK     include/generated/bounds.h
  CHK     include/generated/asm-offsets.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  EXPORTS arch/arm/lib/lib-ksyms.o
  LD      arch/arm/lib/built-in.o
  CC      drivers/cpufreq/brcmstb-cpufreq.o
  EXPORTS lib/lib-ksyms.o
  LD      drivers/cpufreq/built-in.o
  LD      lib/built-in.o
  EXPORTS drivers/firmware/efi/libstub/lib-ksyms.o
  LD      drivers/firmware/efi/libstub/built-in.o
  LD      drivers/firmware/efi/built-in.o
  LD      drivers/firmware/built-in.o
  LD      drivers/built-in.o
  LD      vmlinux.o
  MODPOST vmlinux.o
[...]

I used the linux-next branch from here:
https://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git

Regards,
-Markus

> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
