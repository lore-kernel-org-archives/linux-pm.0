From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v1 7/8] powerpc/Kconfig: Enable STRICT_KERNEL_RWX
Date: Mon, 05 Jun 2017 15:46:13 +1000
Message-ID: <87y3t7q95m.fsf@concordia.ellerman.id.au>
References: <201705260000.CDMt1Ieh%fengguang.wu@intel.com> <6dcd8ea3-e953-3319-0e0e-8543018e882f@c-s.fr> <CAKTCnzmeRsr8LcrP37A4qWzYv+A3xyNc5XXFQwLgEC08cZGGcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:38957 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751262AbdFEFqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 5 Jun 2017 01:46:17 -0400
In-Reply-To: <CAKTCnzmeRsr8LcrP37A4qWzYv+A3xyNc5XXFQwLgEC08cZGGcg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Balbir Singh <bsingharora@gmail.com>, Christophe LEROY <christophe.leroy@c-s.fr>
Cc: kbuild test robot <lkp@intel.com>, linux-pm@vger.kernel.org, "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" <linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>, kbuild-all@01.org, "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Laura Abbott <labbott@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Rashmica Gupta <rashmica.g@gmail.com>

Balbir Singh <bsingharora@gmail.com> writes:
> On Mon, May 29, 2017 at 6:00 PM, Christophe LEROY
> <christophe.leroy@c-s.fr> wrote:
>> Le 25/05/2017 à 18:45, kbuild test robot a écrit :
>>> All errors (new ones prefixed by >>):
>>>
>>>>> kernel//power/snapshot.c:40:28: fatal error: asm/set_memory.h: No such
>>>>> file or directory
>>>
>>>      #include <asm/set_memory.h>
>>
>>
>> Looks like it is linked to commit 50327ddfb ("kernel/power/snapshot.c: use
>> set_memory.h header").
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=50327ddfb
>>
>> I believe that inclusion should be conditional to
>> CONFIG_ARCH_HAS_SET_MEMORY, which is not set by powerpc arch, just like in
>> include/linux/filter.c
>>
> Agreed, it needs to be fixed in kernel/power/sanpshot.c

It should be fixed in asm-generic/set_memory.h, there should be no need
to guard an include of a generic header.

cheers
