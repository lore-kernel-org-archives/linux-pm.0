From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Sat, 9 Jan 2016 13:57:07 +0200
Message-ID: <CAHp75Vf_dESyzvi5EN5KP8OCKtqKoD8YK7w5s0yHpBgt=-q7Uw@mail.gmail.com>
References: <1452242596.30729.425.camel@linux.intel.com>
	<20160109011241.GB560@swordfish>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f194.google.com ([209.85.160.194]:33775 "EHLO
	mail-yk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcAIL5H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 9 Jan 2016 06:57:07 -0500
In-Reply-To: <20160109011241.GB560@swordfish>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On Sat, Jan 9, 2016 at 3:12 AM, Sergey Senozhatsky
<sergey.senozhatsky@gmail.com> wrote:
> Andy Shevchenko wrote:
> [..]
>> >
>> > strncmp() case seems to be quite common.
>>
>> Like I answered to Rasmus, please, provide real examples.
>
> [..]
>> > int nmatch_string(array, array_size, string, string_len)
>> > {
>> >       do {
>> >               strncmp();
>> >       } while ();
>> > }
>> >
>> > int match_string(array, array_size, string)
>> > {
>> >       return nmatch_string(array, array_size, string,
>> > strlen(string));
>> > }
>>
>> See above.
>
> after some quick and inaccurate grepping, well, probably you're right - not worth it.

Good grep anyway, it clearly shows that there is hard to generalize
which limit to use: a) length of a first argument / item from a list,
b) length of a second argument or a constant.

> arch/mips/bcm63xx/boards/board_bcm963xx.c  void __init board_prom_init(void)
> net/irda/irnet/irnet_irda.c   irnet_dname_to_daddr()
> arch/powerpc/sysdev/ppc4xx_cpm.c static ssize_t cpm_idle_store()
> arch/x86/ras/mce_amd_inj.c static int __set_inj
> drivers/hwtracing/intel_th/msu.c mode_store
> drivers/pci/pcie/aer/ecrc.c void pcie_ecrc_get_policy
> drivers/pci/pcie/aspm.c pcie_aspm_set_policy
> drivers/scsi/aic7xxx/aic7xxx_osm.c aic7xxx_setup
> drivers/scsi/aic7xxx/aic79xx_osm.c aic79xx_setup
> drivers/scsi/scsi_transport_fc.c static int get_fc_##title##_match
> drivers/staging/android/ion/hisilicon/hi6220_ion.c get_type_by_name
> drivers/staging/lustre/lustre/lmv/lproc_lmv.c placement_name2policy
> drivers/xen/sys-hypervisor.c pmu_mode_store

-- 
With Best Regards,
Andy Shevchenko
