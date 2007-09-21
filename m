From: =?UTF-8?B?TWlrYSBQZW50dGlsw6Q=?= <mika.penttila@kolumbus.fi>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation -v3
Date: Fri, 21 Sep 2007 18:13:40 +0300
Message-ID: <46F3DFA4.90909__3756.25229576162$1190388224$gmane$org@kolumbus.fi>
References: <1190266440.21818.16.camel@caritas-dev.intel.com>	
	<46F39345.3040201@kolumbus.fi>	
	<851fc09e0709210644y4a859a2bp223ef56b08a27f0@mail.gmail.com>	
	<46F3DBAB.9010308@kolumbus.fi>
	<851fc09e0709210813s1bb3fb02y6096c74fdc9dc35d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <851fc09e0709210813s1bb3fb02y6096c74fdc9dc35d@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

huang ying wrote:
> On 9/21/07, Mika Penttil=C3=A4 <mika.penttila@kolumbus.fi> wrote:
>  =20
>> huang ying wrote:
>>    =20
>>> On 9/21/07, Mika Penttil=C3=A4 <mika.penttila@kolumbus.fi> wrote:
>>>
>>>      =20
>>>>> Usage:
>>>>>
>>>>> 1. Compile kernel with following options selected:
>>>>>
>>>>> CONFIG_X86_32=3Dy
>>>>> CONFIG_RELOCATABLE=3Dy # not needed strictly, but it is more conven=
ient with it
>>>>> CONFIG_KEXEC=3Dy
>>>>> CONFIG_CRASH_DUMP=3Dy # only needed by kexeced kernel to save/resto=
re memory image
>>>>> CONFIG_PM=3Dy
>>>>> CONFIG_KEXEC_JUMP=3Dy
>>>>>
>>>>> 2. Download the kexec-tools-testing git tree, apply the kexec-tools
>>>>>    kjump patches (or download the source tar ball directly) and
>>>>>    compile.
>>>>>
>>>>> 3. Download and compile the krestore tool.
>>>>>
>>>>> 4. Prepare 2 root partition used by kernel A and kernel B/C, referr=
ed
>>>>>    as /dev/hda, /dev/hdb in following text. This is not strictly
>>>>>    necessary, I use this scheme for testing during development.
>>>>>
>>>>> 5. Boot kernel compiled for normal usage (kernal A).
>>>>>
>>>>> 6. Load kernel compiled for hibernating/restore usage (kernel B) wi=
th
>>>>>    kexec, the same kernel as that of 5 can be used if
>>>>>    CONFIG_RELOCATABLE=3Dy and CONFIG_CRASH_DUMP=3Dy are selected.
>>>>>
>>>>>    The --elf64-core-headers should be specified in command line of
>>>>>    kexec, because only the 64bit ELF is supported by krestore tool.
>>>>>
>>>>>    For example, the shell command line can be as follow:
>>>>>
>>>>>    kexec -p -n /boot/bzImage --mem-min=3D0x100000 --mem-max=3D0xfff=
fff
>>>>>        --elf64-core-headers --append=3D"root=3D/dev/hdb single"
>>>>>
>>>>> 7. Jump to the hibernating kernel (kernel B) with following shell
>>>>>    command line:
>>>>>
>>>>>    kexec -j
>>>>>
>>>>> 8. In the hibernating kernel (kernel B), the memory image of
>>>>>    hibernated kernel (kernel A) can be saved as follow:
>>>>>
>>>>>    cp /proc/vmcore .
>>>>>    cp /sys/kernel/kexec_jump_back_entry .
>>>>>
>>>>>
>>>>>          =20
>>>> Here we save also kernel B's pages.
>>>>
>>>>        =20
>>> No, the kernel B's pages will not be saved. Because when we build the
>>> elfcore (/proc/vmcore) header, we exclude memory area used by kernel
>>> B. The details can be found in kexec-tools patches.
>>>
>>>
>>>      =20
>> Ok I see. But should the kernel B's e820 mem map be limited to 1m-16m =
in
>> order not to allocate pages found also in A's space? Or does does the
>> --mem-min and --mem-max do that also?
>>    =20
>
> That is what "memmap=3Dexactmap memmap=3D640K@0K memmap=3D15M@1M" for. =
The
> contents of e820 memmap will be overrided when these kernel parameters
> are specified.
>
> Best Regards,
> Huang Ying
>  =20
Yes, you just didn't specify exactmap for kernel B in your instructions,=20
but only for C. But it is also required for kernel B then?

Thanks,
Mika
