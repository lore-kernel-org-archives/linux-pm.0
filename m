From: "Huang, Ying" <ying.huang@intel.com>
Subject: RE: [RFC][PATCH 0/2 -mm] kexec based hibernation
Date: Mon, 27 Aug 2007 10:16:37 +0800
Message-ID: <1188180997.3247.68.camel__14733.1519787715$1188181021$gmane$org@caritas-dev.intel.com>
References: <9D7649D18729DE4BB2BD7B494F7FEDC257EA60@pdsmsx415.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9D7649D18729DE4BB2BD7B494F7FEDC257EA60@pdsmsx415.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Hu, Fenghua" <fenghua.hu@intel.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, 2007-08-27 at 09:28 +0800, Hu, Fenghua wrote:
> One quick question is, can it improve hiberation/wakeup time?

In general, for kexec based hibernation, what increases
hibernation/wakeup time:

- One extra Linux boot is needed to hibernate and wakeup.


What decreases hibernation/wakeup time:

- Most hibernation/wakeup work is done in full functional user space
program, so it is possible to do some optimization, such as parallel
compression.


So, I think the kexec based hibernation may be slower than original
implementation in general. In this prototype implementation, the
hibernation/wakeup time is much longer than original hibernation/wakeup
implementation. But it has much to be optimized and I think it can
approach the speed of the original implementation after optimization.


For example, the hibernation image is an ordinary ELF file, so it can be
loaded by bootloader directly.

Best Regards,
Huang Ying

> Best regards
> Hu, Fenghua
>=20
>=20
> -----Original Message-----
> From: linux-pm-bounces@lists.linux-foundation.org [mailto:linux-pm-boun=
ces@lists.linux-foundation.org] On Behalf Of Huang, Ying
> Sent: 2007=E5=B9=B48=E6=9C=8827=E6=97=A5 9:14
> To: Eric W. Biederman; Pavel Machek; nigel@nigel.suspend2.net; Andrew M=
orton; Jeremy Maitin-Shepard; Alan Stern
> Cc: linux-pm@lists.linux-foundation.org; Kexec Mailing List; linux-kern=
el@vger.kernel.org
> Subject: [linux-pm] [RFC][PATCH 0/2 -mm] kexec based hibernation
>=20
> Kexec base hibernation has some potential advantages over uswsusp and
> TuxOnIce (suspend2). Some most obvious advantages are:
>=20
> 1. The hibernation image size can exceed half of memory size easily.
>=20
> 2. The hibernation image can be written to and read from almost
>    anywhere, such as USB disk, NFS.
>=20
> 3. It is possible to eliminate freezer from kexec based hibernation
>    implementation.
>=20
> 4. Based on kexec/kdump implementation, the kernel code needed is
>    less.
>=20
>=20
> This patch set implements a prototype of kexec based hibernation. The
> kernel functionalities added are as follow:
>=20
> 1. Jumping from kexeced kernel back to original kernel. This is used
>    by hibernation to save/load necessary state in original kernel and
>    jumping back to original kernel after restore the memory of
>    original kernel.
>=20
> 2. Add writing support to /dev/oldmem. This is used by hibernation to
>    restore the memory of original kernel.
>=20
>=20
> The hibernation process with the patch set is as follow:
>=20
> 1. Boot a kernel A
>=20
> 2. Work under kernel A
>=20
> 3. Kexec another kernel B (crash dump enabled) in kernel A.
>=20
> 4. Save the memory image of kernel A through crash dump (such as "cp
>    /proc/vmcore =E2=80=BE"). Save the "jump buffer pfn".
>=20
> 5. Shutdown or reboot
>=20
>=20
> The restore process with the patch set is as follow:
>=20
> 1. Boot a kernel C
>=20
> 2. Kexec another kernel D (crash dump enabled) in kernel C. The memory
>    area used by kernel D must be a subset of memory area used by
>    kernel B.
>=20
> 3. Restore the memory image of kernel A through /dev/oldmem. Restore
>    the "jump buffer pfn".
>=20
> 4. Jump from kernel D back to kernel A
>=20
> 5. Continue work under kernel A
>=20
>=20
> The following user-space tools are needed to implement hibernation and
> restore.
>=20
> 1. kexec-tools needs to be patched to support kexec jump. The patch is
>    attached in this mail. The precompiled kexec can be download from:
>        http://linux-mcr700.sourceforge.net/kjump/kexec
>=20
> 2. Memory image saving tool. Currently, the memory image saving is
>    done through: "cp /proc/vmcore <image file>". This will save all
>    memory pages of original kernel including the free pages. Maybe the
>    crash dump tool "makedumpfile" can be used for this, but it has not
>    been tested.
>=20
> 3. Memory image restore tool. A simplest memory image restoring tool
>    named "krestore" is implemented. It can be downloaded from
>    following URL:
>        source: http://linux-mcr700.sourceforge.net/kjump/krestore.tar.g=
z
>        binary: http://linux-mcr700.sourceforge.net/kjump/krestore
>=20
>=20
> Known issues:
>=20
> 1. The kernel B run as a crashdump kernel in reserved memory
>    region. This is the biggest constrains of the patch set and planed
>    to be eliminated in the future version. That is, instead of
>    reserving memory region previously, the needed memory region is
>    backupped before kexec and restored after jumping back.
>=20
> 2. Another constrains of the patch set is that the CONFIG_ACPI must be
>    turned off to make kexec jump work. Because ACPI will put devices
>    into low power state, the kexeced kernel can not be booted properly
>    under it. This constrains can be eliminated by separating the
>    suspend method and hibernate method of the devices as proposed
>    earlier in the LKML.
>=20
> 3. The setup of hibernation/restore is fairly complex. I will continue
>    working on simplifying.
>=20
> 4. Memory pages including free pages of kernel A are saved. I think
>    the "makedumpfile" tool can be used to exclude "free pages", but I
>    have not tested it.
>=20
> Now, only the i386 architecture is supported. The patch is based on
> Linux kernel 2.6.23-rc3-mm1, and has been tested on my IBM T42.
>=20
>=20
> Usage:
>=20
> 1. Compile kernel with following options selected:
>=20
> CONFIG_X86_32=3Dy
> CONFIG_RELOCATABLE=3Dy # not needed strictly, but it is more convenient=
 with it
> CONFIG_KEXEC=3Dy
> CONFIG_CRASH_DUMP=3Dy # only needed by kexeced kernel to save/restore m=
emory image
> CONFIG_PM=3Dy
> CONFIG_KEXEC_JUMP=3Dy
>=20
> 2. Download the kexec-tools-testing git tree, apply the kexec-tools
>    kjump patch and compile. The kexec-tools kjump patch is appended
>    with the mail. The precompiled kexec can be download from:
>        http://linux-mcr700.sourceforge.net/kjump/kexec
>=20
> 3. Download and compile the krestore tool. The source code and
>    precompiled binary can be downloaded from the following URL:
>        source: http://linux-mcr700.sourceforge.net/kjump/krestore.tar.g=
z
>        binary: http://linux-mcr700.sourceforge.net/kjump/krestore
>=20
> 4. Prepare 3 root partition used by kernel A, kernel B, kernel C,
>    refered as /dev/hda, /dev/hdb, /dev/hdc in following text. This is
>    not strictly necessary, I use this scheme for testing during
>    development.
>=20
> 5. Boot kernel compiled for normal usage (kernel A), the reserved
>    crash kernel memory region must be added to kernel command line as
>    follow:
>=20
>    crashkernel=3D<XX>M@<XX>M
>=20
>    Where, <XX> should be replaced by the real memory size and
>    position. I use 16M@32M in my testing.
>=20
> 6. Load kernel compiled for hibernating usage (kernel B) as a
>    crashdump kernel with kexec, the same kernel as that of 5 can be
>    used if CONFIG_RELOCATABLE=3Dy and CONFIG_CRASH_DUMP=3Dy are
>    selected. The kernel command line option as follow should be
>    appended to kernel command line.
>=20
>    kexec_jump_buf_pfn=3D`cat /sys/kernel/kexec_jump_buf_pfn`
>=20
>    The --elf64-core-headers should be specified in command line of
>    kexec, because only the 64bit ELF is supported by krestore tool.
>=20
>    For example, the shell command line can be as follow:
>=20
>    kexec -p /boot/bzImage --elf64-core-headers --append=3D"root=3D/dev/=
hdb
>        single kexec_jump_buf_pfn=3D`cat /sys/kernel/kexec_jump_buf_pfn`=
"
>=20
> 7. Jump to the hibernating kernel (kernel B) with following shell
>    command line:
>=20
>    kexec -j
>=20
> 8. In the hibernating kernel (kernel B), the memory image of
>    hibernated kernel (kernel A) can be saved as follow:
>=20
>    cp /proc/vmcore .
>    cp /sys/kernel/kexec_jump_buf_pfn .
>=20
> 9. Shutdown or reboot in hibernating kernel (kernel B).
>=20
> 10. Boot kernel (kernel C) compiled for normal usage in another root
>     file system (/dev/hdc).
>=20
> 11. Load restore kernel (kernel D) in kernel C through kexec. This is
>     almost same as step 6. The root file system of kernel D should be
>     /dev/hdb.
>=20
> 12. In restore kernel (kernel D), the memory image of kernel A can be
>     restored as follow:
>=20
>     # get backup address through kernel command line
>     backup_addr=3D`cat /proc/cmdline | tr ' ' '=C2=A5n' | grep kexec_ba=
ckup | cut -d '=3D' -f 2`
>     cp kexec_jump_buf_pfn /sys/kernel/kexec_jump_buf_pfn
>     krestore -b $backup_addr vmcore
>=20
> 13. Jump back to hibernated kernel (kernel A)
>=20
>     kexec -b
>=20
>=20
> ---
>=20
> Changelog of kexec-tools
>=20
> A command line option -j/--jump-to is added to support jumping
> to/executing the currently loaded kernel. A command line option
> -b/--jump-back is added to support jumping back to the original
> kernel. The implementation of options is to call corresponding
> syscall.
>=20
> For i386 architecture, the address of backup of 0=E2=80=BE640k is passe=
d to
> kexeced kernel as a kernel command line option. This is used by
> kexeced kernel to restore the backup.
>=20
> This patch is against kexec-tools-testing git tree.
>=20
> Index: kexec-tools/kexec/arch/i386/crashdump-x86.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kexec-tools.orig/kexec/arch/i386/crashdump-x86.c	2007-08-17 13:48:5=
1.000000000 +0800
> +++ kexec-tools/kexec/arch/i386/crashdump-x86.c	2007-08-17 13:49:50.000=
000000 +0800
> @@ -428,6 +428,29 @@
>  	return 0;
>  }
> =20
> +/* Adds the kexec_backup=3D command line parameter to command line. */
> +static int cmdline_add_backup(char *cmdline, unsigned long addr)
> +{
> +	int cmdlen, len, align =3D 1024;
> +	char str[30], *ptr;
> +
> +	/* Passing in kexec_backup=3DxxxK format. Saves space required
> +	 * in cmdline. Ensure 1K alignment*/
> +	if (addr%align)
> +		return -1;
> +	addr =3D addr/align;
> +	ptr =3D str;
> +	strcpy(str, " kexec_backup=3D");
> +	ptr +=3D strlen(str);
> +	ultoa(addr, ptr);
> +	strcat(str, "K");
> +	len =3D strlen(str);
> +	cmdlen =3D strlen(cmdline) + len;
> +	if (cmdlen > (COMMAND_LINE_SIZE - 1))
> +		die("Command line overflow=C2=A5n");
> +	strcat(cmdline, str);
> +	return 0;
> +}
> =20
>  /*
>   * This routine is specific to i386 architecture to maintain the
> @@ -575,6 +598,7 @@
>  		return -1;
>  	cmdline_add_memmap(mod_cmdline, memmap_p);
>  	cmdline_add_elfcorehdr(mod_cmdline, elfcorehdr);
> +	cmdline_add_backup(mod_cmdline, info->backup_start);
>  	return 0;
>  }
> =20
> Index: kexec-tools/kexec/kexec-syscall.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kexec-tools.orig/kexec/kexec-syscall.h	2007-08-17 13:48:51.00000000=
0 +0800
> +++ kexec-tools/kexec/kexec-syscall.h	2007-08-24 13:44:22.000000000 +08=
00
> @@ -21,6 +21,8 @@
>  #define LINUX_REBOOT_CMD_KEXEC_OLD	0x81726354
>  #define LINUX_REBOOT_CMD_KEXEC_OLD2	0x18263645
>  #define LINUX_REBOOT_CMD_KEXEC		0x45584543
> +#define LINUX_REBOOT_CMD_KJUMP_TO	0x3928A5FD
> +#define LINUX_REBOOT_CMD_KJUMP_BACK	0x4A39B60E
> =20
>  #ifdef __i386__
>  #define __NR_kexec_load		283
> @@ -63,6 +65,15 @@
>  	return (long) syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_=
MAGIC2, LINUX_REBOOT_CMD_KEXEC, 0);
>  }
> =20
> +static inline long kexec_jump_to(void)
> +{
> +	return (long) syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_=
MAGIC2, LINUX_REBOOT_CMD_KJUMP_TO, 0);
> +}
> +
> +static inline long kexec_jump_back(void)
> +{
> +	return (long) syscall(__NR_reboot, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_=
MAGIC2, LINUX_REBOOT_CMD_KJUMP_BACK, 0);
> +}
> =20
>  #define KEXEC_ON_CRASH  0x00000001
>  #define KEXEC_ARCH_MASK 0xffff0000
> Index: kexec-tools/kexec/kexec.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kexec-tools.orig/kexec/kexec.c	2007-08-17 13:48:51.000000000 +0800
> +++ kexec-tools/kexec/kexec.c	2007-08-24 13:53:43.000000000 +0800
> @@ -716,6 +716,33 @@
>  	return -1;
>  }
> =20
> +/*
> + *	Jump to the new kernel
> + */
> +static int my_jump_to(void)
> +{
> +	int result;
> +
> +	result =3D kexec_jump_to();
> +	if (result)
> +		fprintf(stderr, "kexec jump to failed: %s=C2=A5n",
> +			strerror(errno));
> +	return result;
> +}
> +
> +/*
> + *	Jump back to the original kernel
> + */
> +static int my_jump_back(void)
> +{
> +	int result;
> +
> +	result =3D kexec_jump_back();
> +	fprintf(stderr, "kexec jump back failed: %s=C2=A5n",
> +		strerror(errno));
> +	return -1;
> +}
> +
>  static void version(void)
>  {
>  	printf(PACKAGE " " VERSION " released " RELEASE_DATE "=C2=A5n");
> @@ -743,6 +770,8 @@
>  	       "                      If capture kernel is being unloaded=C2=A5=
n"
>  	       "                      specify -p with -u.=C2=A5n"
>  	       " -e, --exec           Execute a currently loaded kernel.=C2=A5=
n"
> + 	       " -j, --jump-to        Jump to a currently loaded kernel.=C2=A5=
n"
> +	       " -b, --jump-back      Jump back to the original kernel.=C2=A5=
n"
>  	       " -t, --type=3DTYPE      Specify the new kernel is of this typ=
e.=C2=A5n"
>  	       "     --mem-min=3D<addr> Specify the lowest memory address to=C2=
=A5n"
>  	       "                      load code into.=C2=A5n"
> @@ -773,6 +802,19 @@
>  	return ret;
>  }
> =20
> +static int kexec_crash_loaded(void)
> +{
> +	int ret;
> +	FILE *fp;
> +
> +	fp =3D fopen("/sys/kernel/kexec_crash_loaded", "r");
> +	if (fp =3D=3D NULL)
> +		return -1;
> +	fscanf(fp, "%d", &ret);
> +	fclose(fp);
> +	return ret;
> +}
> +
>  /* check we retained the initrd */
>  void check_reuse_initrd(void)
>  {
> @@ -803,6 +845,8 @@
>  {
>  	int do_load =3D 1;
>  	int do_exec =3D 0;
> +	int do_jump_to =3D 0;
> +	int do_jump_back =3D 0;
>  	int do_shutdown =3D 1;
>  	int do_sync =3D 1;
>  	int do_ifdown =3D 0;
> @@ -858,6 +902,22 @@
>  			do_ifdown =3D 1;
>  			do_exec =3D 1;
>  			break;
> +		case OPT_JUMP_TO:
> +			do_load =3D 0;
> +			do_shutdown =3D 0;
> +			do_sync =3D 1;
> +			do_ifdown =3D 0;
> +			do_exec =3D 0;
> +			do_jump_to =3D 1;
> +			break;
> +		case OPT_JUMP_BACK:
> +			do_load =3D 0;
> +			do_shutdown =3D 0;
> +			do_sync =3D 1;
> +			do_ifdown =3D 1;
> +			do_exec =3D 0;
> +			do_jump_back =3D 1;
> +			break;
>  		case OPT_TYPE:
>  			type =3D optarg;
>  			break;
> @@ -936,6 +996,9 @@
>  	if ((result =3D=3D 0) && (do_shutdown || do_exec) && !kexec_loaded())=
 {
>  		die("Nothing has been loaded!=C2=A5n");
>  	}
> +	if ((result =3D=3D 0) && do_jump_to && !kexec_crash_loaded()) {
> +		die("Nothing has been loaded!=C2=A5n");
> +	}
>  	if ((result =3D=3D 0) && do_shutdown) {
>  		result =3D my_shutdown();
>  	}
> @@ -949,6 +1012,12 @@
>  	if ((result =3D=3D 0) && do_exec) {
>  		result =3D my_exec();
>  	}
> +	if ((result =3D=3D 0) && do_jump_to) {
> +		result =3D my_jump_to();
> +	}
> +	if ((result =3D=3D 0) && do_jump_back) {
> +		result =3D my_jump_back();
> +	}
> =20
>  	fflush(stdout);
>  	fflush(stderr);
> Index: kexec-tools/kexec/kexec.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- kexec-tools.orig/kexec/kexec.h	2007-08-17 13:48:51.000000000 +0800
> +++ kexec-tools/kexec/kexec.h	2007-08-24 11:15:27.000000000 +0800
> @@ -156,6 +156,8 @@
>  #define OPT_FORCE		'f'
>  #define OPT_NOIFDOWN		'x'
>  #define OPT_EXEC		'e'
> +#define OPT_JUMP_TO		'j'
> +#define OPT_JUMP_BACK		'b'
>  #define OPT_LOAD		'l'
>  #define OPT_UNLOAD		'u'
>  #define OPT_TYPE		't'
> @@ -172,13 +174,15 @@
>  	{ "load",		0, 0, OPT_LOAD }, =C2=A5
>  	{ "unload",		0, 0, OPT_UNLOAD }, =C2=A5
>  	{ "exec",		0, 0, OPT_EXEC }, =C2=A5
> + 	{ "jump-to",		0, 0, OPT_JUMP_TO }, =C2=A5
> + 	{ "jump-back",		0, 0, OPT_JUMP_BACK }, =C2=A5
>  	{ "type",		1, 0, OPT_TYPE }, =C2=A5
>  	{ "load-panic",         0, 0, OPT_PANIC }, =C2=A5
>  	{ "mem-min",		1, 0, OPT_MEM_MIN }, =C2=A5
>  	{ "mem-max",		1, 0, OPT_MEM_MAX }, =C2=A5
>  	{ "reuseinitrd",	0, 0, OPT_REUSE_INITRD }, =C2=A5
> =20
> -#define KEXEC_OPT_STR "hvdfxluet:p"
> +#define KEXEC_OPT_STR "hvdfxluejbt:p"
> =20
>  extern void die(char *fmt, ...);
>  extern void *xmalloc(size_t size);
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
