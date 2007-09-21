From: "huang ying" <huang.ying.caritas@gmail.com>
Subject: Re: [RFC][PATCH 0/2 -mm] kexec based hibernation -v3
Date: Fri, 21 Sep 2007 21:44:57 +0800
Message-ID: <851fc09e0709210644y4a859a2bp223ef56b08a27f0@mail.gmail.com>
References: <1190266440.21818.16.camel@caritas-dev.intel.com>
	<46F39345.3040201@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46F39345.3040201@kolumbus.fi>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mika.penttila@kolumbus.fi>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On 9/21/07, Mika Penttil=C3=A4 <mika.penttila@kolumbus.fi> wrote:
>
> > Usage:
> >
> > 1. Compile kernel with following options selected:
> >
> > CONFIG_X86_32=3Dy
> > CONFIG_RELOCATABLE=3Dy # not needed strictly, but it is more convenie=
nt with it
> > CONFIG_KEXEC=3Dy
> > CONFIG_CRASH_DUMP=3Dy # only needed by kexeced kernel to save/restore=
 memory image
> > CONFIG_PM=3Dy
> > CONFIG_KEXEC_JUMP=3Dy
> >
> > 2. Download the kexec-tools-testing git tree, apply the kexec-tools
> >    kjump patches (or download the source tar ball directly) and
> >    compile.
> >
> > 3. Download and compile the krestore tool.
> >
> > 4. Prepare 2 root partition used by kernel A and kernel B/C, referred
> >    as /dev/hda, /dev/hdb in following text. This is not strictly
> >    necessary, I use this scheme for testing during development.
> >
> > 5. Boot kernel compiled for normal usage (kernal A).
> >
> > 6. Load kernel compiled for hibernating/restore usage (kernel B) with
> >    kexec, the same kernel as that of 5 can be used if
> >    CONFIG_RELOCATABLE=3Dy and CONFIG_CRASH_DUMP=3Dy are selected.
> >
> >    The --elf64-core-headers should be specified in command line of
> >    kexec, because only the 64bit ELF is supported by krestore tool.
> >
> >    For example, the shell command line can be as follow:
> >
> >    kexec -p -n /boot/bzImage --mem-min=3D0x100000 --mem-max=3D0xfffff=
f
> >        --elf64-core-headers --append=3D"root=3D/dev/hdb single"
> >
> > 7. Jump to the hibernating kernel (kernel B) with following shell
> >    command line:
> >
> >    kexec -j
> >
> > 8. In the hibernating kernel (kernel B), the memory image of
> >    hibernated kernel (kernel A) can be saved as follow:
> >
> >    cp /proc/vmcore .
> >    cp /sys/kernel/kexec_jump_back_entry .
> >
> Here we save also kernel B's pages.

No, the kernel B's pages will not be saved. Because when we build the
elfcore (/proc/vmcore) header, we exclude memory area used by kernel
B. The details can be found in kexec-tools patches.

> > 9. Shutdown or reboot in hibernating kernel (kernel B).
> >
> > 10. Boot kernel (kernel C) compiled for hibernating/restore usage on
> >     the root file system /dev/hdb in memory range of kernel B.
> >
> >     For example, the following kernel command line parameters can be
> >     used:
> >
> >     root=3D/dev/hdb single memmap=3Dexactmap memmap=3D640K@0K memmap=3D=
15M@1M
> >
> 0-640K from kernel A overrides 0-640K of kernel C at restore time.

No. The 0-640K is not in the memory image of kernel A. It is excluded
from memory image of kernel A in /sbin/kexec. Not very strictly, there
is one backup page for each page in 0-640K, after jump back, the
backup page will be swapped with the target page (in 0-640K). No
information is lost. So you can jump back and forth, for arbitrary
times.

> > 11. In restore kernel (kernel C), the memory image of kernel A can be
> >     restored as follow:
> >
> >     cp kexec_jump_back_entry /sys/kernel/kexec_jump_back_entry
> >     krestore vmcore
> >
> >
> This steps replaces kernel C's pages with kernel B's (at least 15m-16m)=
,
> saved at step 8, so these kernels should be equal? Or they must be
> physically located in non-overlapping regions such that C is in B's
> memory range but non-overlapping. The proposed setup doesn't guaratee
> this afaics.

No. These pages are excluded from /proc/vmcore. These kernels need not
to be equal.

> > 12. Jump back to hibernated kernel (kernel A)
> >
> >     kexec -b
> >

Best Regards,
Huang Ying
