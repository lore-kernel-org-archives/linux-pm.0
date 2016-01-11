From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 1/8] lib/string: introduce match_string() helper
Date: Tue, 12 Jan 2016 00:24:36 +0200
Message-ID: <CAHp75VdBSnn+X41JZprX++a29yaSp49YB1DY2bv89ORzhOr3CA@mail.gmail.com>
References: <1452242596.30729.425.camel@linux.intel.com>
	<20160109011241.GB560@swordfish>
	<CAHp75Vf_dESyzvi5EN5KP8OCKtqKoD8YK7w5s0yHpBgt=-q7Uw@mail.gmail.com>
	<1452524400.26146.32.camel@linux.intel.com>
	<8760yzbwd5.fsf@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f181.google.com ([209.85.160.181]:34020 "EHLO
	mail-yk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933186AbcAKWYh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 17:24:37 -0500
In-Reply-To: <8760yzbwd5.fsf@rasmusvillemoes.dk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>

On Tue, Jan 12, 2016 at 12:10 AM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
> On Mon, Jan 11 2016, Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
>
>> On Sat, 2016-01-09 at 13:57 +0200, Andy Shevchenko wrote:
>>> On Sat, Jan 9, 2016 at 3:12 AM, Sergey Senozhatsky
>>> <sergey.senozhatsky@gmail.com> wrote:
>>> > Andy Shevchenko wrote:
>>> > [..]
>>> > > >
>>> > > > strncmp() case seems to be quite common.
>>> > >
>>> > > Like I answered to Rasmus, please, provide real examples.
>>> >
>>> > [..]
>>> > > > int nmatch_string(array, array_size, string, string_len)
>>> > > > {
>>> > > >       do {
>>> > > >               strncmp();
>>> > > >       } while ();
>>> > > > }
>>> > > >
>>> > > > int match_string(array, array_size, string)
>>> > > > {
>>> > > >       return nmatch_string(array, array_size, string,
>>> > > > strlen(string));
>>> > > > }
>>> > >
>>> > > See above.
>>> >
>>> > after some quick and inaccurate grepping, well, probably you're
>>> > right - not worth it.
>>>
>>> Good grep anyway, it clearly shows that there is hard to generalize
>>> which limit to use: a) length of a first argument / item from a list,
>>> b) length of a second argument or a constant.
>>>
>>> > arch/mips/bcm63xx/boards/board_bcm963xx.c  void __init
>>> > board_prom_init(void)
>>> > net/irda/irnet/irnet_irda.c   irnet_dname_to_daddr()
>>> > arch/powerpc/sysdev/ppc4xx_cpm.c static ssize_t cpm_idle_store()
>>> > arch/x86/ras/mce_amd_inj.c static int __set_inj
>>> > drivers/hwtracing/intel_th/msu.c mode_store
>>> > drivers/pci/pcie/aer/ecrc.c void pcie_ecrc_get_policy
>>> > drivers/pci/pcie/aspm.c pcie_aspm_set_policy
>>> > drivers/scsi/aic7xxx/aic7xxx_osm.c aic7xxx_setup
>>> > drivers/scsi/aic7xxx/aic79xx_osm.c aic79xx_setup
>>> > drivers/scsi/scsi_transport_fc.c static int get_fc_##title##_match
>>> > drivers/staging/android/ion/hisilicon/hi6220_ion.c get_type_by_name
>>> > drivers/staging/lustre/lustre/lmv/lproc_lmv.c placement_name2policy
>>> > drivers/xen/sys-hypervisor.c pmu_mode_store
>>
>> Thought more about those cases.
>>
>> If you would like you may introduce something like
>>
>> int nmatch_string(array, array_size, string, int len)
>> {
>>   if (len < 0)
>>     return match_string();
>>
>>   for (...) {
>>     size_t itemlen = (len > 0) ? len : strlen(array[index]);
>> ...
>>     if (!strncmp(array[index], string, itemlen))
>>       return index;
>>   }
>>   return -EINVAL;
>> }
>
> Yeah, a separate function is probably better. But why not a more
> explicit name, match_prefix, match_string_prefix, match_string_starts?
>
> I like the idea of passing the string length if one wants the "is this a
> prefix of some array element" semantics, and a sentinel otherwise. But I
> don't see any case where one would want match_string() semantics (why
> not call match_string directly instead?), so why not let len < 0 mean
> "is some array element a prefix of this string" and "len >= 0" be the
> other case. I don't see why one shouldn't be able to ask "is the empty
> string a prefix of some array element" (that is, are there any elements
> in the array); both the array and the string might be run-time things,
> so this could occur. And it's not up to a generic library routine like
> this to impose restrictions like "the empty string makes no sense, go
> away".

I have no strong feelings to my initial proposal, and your suggestions
sound sane. Unfortunately I have no time to properly implement it and
convert users, so, if Sergey would like to do that, I will no object.

-- 
With Best Regards,
Andy Shevchenko
