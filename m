From: Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v1 7/8] powerpc/Kconfig: Enable STRICT_KERNEL_RWX
Date: Sat, 3 Jun 2017 15:42:04 +1000
Message-ID: <CAKTCnzmeRsr8LcrP37A4qWzYv+A3xyNc5XXFQwLgEC08cZGGcg@mail.gmail.com>
References: <201705260000.CDMt1Ieh%fengguang.wu@intel.com> <6dcd8ea3-e953-3319-0e0e-8543018e882f@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:33230 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750753AbdFCFmG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jun 2017 01:42:06 -0400
In-Reply-To: <6dcd8ea3-e953-3319-0e0e-8543018e882f@c-s.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Christophe LEROY <christophe.leroy@c-s.fr>
Cc: kbuild test robot <lkp@intel.com>, Laura Abbott <labbott@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Paul Mackerras <paulus@samba.org>, kbuild-all@01.org, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, Rashmica Gupta <rashmica.g@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Mon, May 29, 2017 at 6:00 PM, Christophe LEROY
<christophe.leroy@c-s.fr> wrote:
>
>
> Le 25/05/2017 =C3=A0 18:45, kbuild test robot a =C3=A9crit :
>>
>> Hi Balbir,
>>
>> [auto build test ERROR on powerpc/next]
>> [also build test ERROR on v4.12-rc2 next-20170525]
>> [if your patch is applied to the wrong git tree, please drop us a note t=
o
>> help improve the system]
>>
>> url:
>> https://github.com/0day-ci/linux/commits/Balbir-Singh/Enable-STRICT_KERN=
EL_RWX/20170525-150234
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.gi=
t
>> next
>> config: powerpc-allmodconfig (attached as .config)
>> compiler: powerpc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
>> reproduce:
>>          wget
>> https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross=
 -O
>> ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # save the attached .config to linux build tree
>>          make.cross ARCH=3Dpowerpc
>>
>> All errors (new ones prefixed by >>):
>>
>>>> kernel//power/snapshot.c:40:28: fatal error: asm/set_memory.h: No such
>>>> file or directory
>>
>>      #include <asm/set_memory.h>
>
>
> Looks like it is linked to commit 50327ddfb ("kernel/power/snapshot.c: us=
e
> set_memory.h header").
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3D50327ddfb
>
> I believe that inclusion should be conditional to
> CONFIG_ARCH_HAS_SET_MEMORY, which is not set by powerpc arch, just like i=
n
> include/linux/filter.c
>
> Christophe
>
>
Agreed, it needs to be fixed in kernel/power/sanpshot.c

Balbir Singh
