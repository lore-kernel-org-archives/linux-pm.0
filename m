From: =?ISO-8859-1?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation -v3
Date: Fri, 21 Sep 2007 12:47:49 +0300
Message-ID: <46F39345.3040201__33520.5139163465$1190649028$gmane$org@kolumbus.fi>
References: <1190266440.21818.16.camel@caritas-dev.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1190266440.21818.16.camel@caritas-dev.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Huang, Ying" <ying.huang@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org


> Usage:
>
> 1. Compile kernel with following options selected:
>
> CONFIG_X86_32=y
> CONFIG_RELOCATABLE=y # not needed strictly, but it is more convenient with it
> CONFIG_KEXEC=y
> CONFIG_CRASH_DUMP=y # only needed by kexeced kernel to save/restore memory image
> CONFIG_PM=y
> CONFIG_KEXEC_JUMP=y
>
> 2. Download the kexec-tools-testing git tree, apply the kexec-tools
>    kjump patches (or download the source tar ball directly) and
>    compile.
>
> 3. Download and compile the krestore tool.
>
> 4. Prepare 2 root partition used by kernel A and kernel B/C, referred
>    as /dev/hda, /dev/hdb in following text. This is not strictly
>    necessary, I use this scheme for testing during development.
>
> 5. Boot kernel compiled for normal usage (kernal A).
>
> 6. Load kernel compiled for hibernating/restore usage (kernel B) with
>    kexec, the same kernel as that of 5 can be used if
>    CONFIG_RELOCATABLE=y and CONFIG_CRASH_DUMP=y are selected.
>
>    The --elf64-core-headers should be specified in command line of
>    kexec, because only the 64bit ELF is supported by krestore tool.
>
>    For example, the shell command line can be as follow:
>
>    kexec -p -n /boot/bzImage --mem-min=0x100000 --mem-max=0xffffff
>        --elf64-core-headers --append="root=/dev/hdb single"
>
> 7. Jump to the hibernating kernel (kernel B) with following shell
>    command line:
>
>    kexec -j
>
> 8. In the hibernating kernel (kernel B), the memory image of
>    hibernated kernel (kernel A) can be saved as follow:
>
>    cp /proc/vmcore .
>    cp /sys/kernel/kexec_jump_back_entry .
>   
Here we save also kernel B's pages.
> 9. Shutdown or reboot in hibernating kernel (kernel B).
>
> 10. Boot kernel (kernel C) compiled for hibernating/restore usage on
>     the root file system /dev/hdb in memory range of kernel B.
>
>     For example, the following kernel command line parameters can be
>     used:
>
>     root=/dev/hdb single memmap=exactmap memmap=640K@0K memmap=15M@1M
>   
0-640K from kernel A overrides 0-640K of kernel C at restore time.
> 11. In restore kernel (kernel C), the memory image of kernel A can be
>     restored as follow:
>
>     cp kexec_jump_back_entry /sys/kernel/kexec_jump_back_entry
>     krestore vmcore
>
>   
This steps replaces kernel C's pages with kernel B's (at least 15m-16m), 
saved at step 8, so these kernels should be equal? Or they must be 
physically located in non-overlapping regions such that C is in B's 
memory range but non-overlapping. The proposed setup doesn't guaratee 
this afaics.
> 12. Jump back to hibernated kernel (kernel A)
>
>     kexec -b
>
> Best Regards,
> Huang Ying
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
>
>   
--Mika
