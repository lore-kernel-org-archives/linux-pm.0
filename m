From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/7] powerpc: change CONFIG_6xx to CONFIG_PPC_BOOK3S_32
Date: Tue, 04 Dec 2018 14:55:36 +1100
Message-ID: <877egqhrnr.fsf@concordia.ellerman.id.au>
References: <aeeaafbdf0357f8bdb8ffd86822a0ddfd5521fd6.1542395798.git.christophe.leroy@c-s.fr> <73b5e7a43bb5979ac534d1c236adb2e04f9d6307.1542395798.git.christophe.leroy@c-s.fr> <CA+7wUsx3iZhPH0uwukRNXaT_ZygaqKNXaNf=kcwoJ9nGqTb2Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+7wUsx3iZhPH0uwukRNXaT_ZygaqKNXaNf=kcwoJ9nGqTb2Mw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mathieu Malaterre <malat@debian.org>, Christophe LEROY <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, rjw@rjwysocki.net, viresh.kumar@linaro.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Mathieu Malaterre <malat@debian.org> writes:
> On Sat, Nov 17, 2018 at 11:29 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> Today we have:
>>
>> config PPC_BOOK3S_32
>>         bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx"
>>         [depends on PPC32 within a choice]
>>
>> config PPC_BOOK3S
>>         def_bool y
>>         depends on PPC_BOOK3S_32 || PPC_BOOK3S_64
>>
>> config 6xx
>>         def_bool y
>>         depends on PPC32 && PPC_BOOK3S
>>
>> 6xx is therefore redundant with PPC_BOOK3S_32.
>>
>> In order to make the code clearer, lets use preferably PPC_BOOK3S_32.
>> This will allow to remove CONFIG_6xx in a later patch.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/Makefile                     |  2 +-
>>  arch/powerpc/include/asm/cache.h          |  2 +-
>>  arch/powerpc/include/asm/mmu.h            |  2 +-
>>  arch/powerpc/include/asm/reg.h            |  2 +-
>>  arch/powerpc/include/asm/time.h           |  2 +-
>>  arch/powerpc/kernel/Makefile              |  2 +-
>>  arch/powerpc/kernel/cpu_setup_6xx.S       |  2 +-
>>  arch/powerpc/kernel/entry_32.S            | 10 +++++-----
>>  arch/powerpc/kernel/head_32.S             | 14 +++++++-------
>>  arch/powerpc/kernel/misc_32.S             |  4 ++--
>>  arch/powerpc/kernel/pmc.c                 |  2 +-
>>  arch/powerpc/kernel/setup_32.c            |  2 +-
>>  arch/powerpc/kernel/sysfs.c               |  2 +-
>>  arch/powerpc/mm/mmu_decl.h                |  2 +-
>>  arch/powerpc/oprofile/Makefile            |  2 +-
>>  arch/powerpc/oprofile/common.c            |  2 +-
>>  arch/powerpc/platforms/powermac/cache.S   |  4 ++--
>>  arch/powerpc/platforms/powermac/feature.c |  2 +-
>>  arch/powerpc/platforms/powermac/sleep.S   |  4 ++--
>>  arch/powerpc/sysdev/Makefile              |  2 +-
>>  20 files changed, 33 insertions(+), 33 deletions(-)
>>
>> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
>> index 8a2ce14d68d0..e259b8a2dd44 100644
>> --- a/arch/powerpc/Makefile
>> +++ b/arch/powerpc/Makefile
>> @@ -241,7 +241,7 @@ KBUILD_CFLAGS       += $(call cc-option,-fno-dwarf2-cfi-asm)
>>  # often slow when they are implemented at all
>>  KBUILD_CFLAGS          += $(call cc-option,-mno-string)
>>
>> -ifdef CONFIG_6xx
>> +ifdef CONFIG_PPC_BOOK3S_32
>>  KBUILD_CFLAGS          += -mcpu=powerpc
>>  endif
>
> I never quite understood this part. Let say I want to specify 'power4'
> in arch/powerpc/platforms/Kconfig.cputype as new TARGET_CPU. The line
> above will always append -mcpu=powerpc *after* a TARGET_CPU=power4
> which defeat the whole purpose, right ?

Yes, I think you're right.

The code above was added in 2006 in f48b8296b315 ("[PATCH] powerpc32:
Set cpu explicitly in kernel compiles").

Back then the target CPU selection was 64-bit only, so setting it to
powerpc always for 6xx was fine.

It was only recently that Christophe made the target CPU selection
available on 32-bit, see 0e00a8c9fd92 ("powerpc: Allow CPU selection
also on PPC32").

So since that commit the above has been overriding any specific CPU
selection it seems, eg:
  gcc -Wp,-MD,init/.do_mounts.o.d ...
  -mcpu=powerpc -mbig-endian -m32 ...
  -mcpu=e300c2 ...
  -mcpu=powerpc ...
  ../init/do_mounts.c

That seems like a bug.

It would be good to clean up the CPU selection logic, it's a bit of a
mess. But for now it's probably best to just move the above snippet
prior to the TARGET_CPU logic.

cheers
