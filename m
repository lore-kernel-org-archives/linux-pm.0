From: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Thu, 01 Sep 2005 21:55:48 +1000
Message-ID: <1125575747.4785.20.camel@localhost>
References: <20050901110539.GA1926@elf.ucw.cz>
Reply-To: ncunningham@linuxmail.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============93714705354343386=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050901110539.GA1926@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============93714705354343386==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-09-01 at 21:05, Pavel Machek wrote:
> Hi!
> 
> This is preview of what I'm doing. I call it swsusp3 for the
> moment. Idea is to push image reading and writing to userspace, so it
> can be compressed, can have nice progress bar etc.
> 
> In the current state I do not write image anywhere, and user <->
> kernel interface is *very* ugly, but you get the idea. It should allow
> us to do most of stuff suspend2 does _and_ shrink kernel a bit at the
> same time.
> 
> Warning: Preview only. Code is ugly and probably broken.

Ummm... it's really hard to know what to say. I guess I'll just have to
wait and see how you progress.

A few general comments:

- I don't see any indication of support for storing a complete image of memory. Planning it?
- Aren't new syscalls generally viewed as pretty undesirable?
- Should comments be in English?

Regards,

Nigel

> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -27,6 +27,7 @@
>  #include <linux/crash_dump.h>
>  #include <linux/backing-dev.h>
>  #include <linux/bootmem.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/uaccess.h>
>  #include <asm/io.h>
> @@ -466,6 +467,7 @@ do_write_kmem(void *p, unsigned long rea
>  }
>  
> 
> +
>  /*
>   * This function writes to the *virtual* memory as seen by the kernel.
>   */
> @@ -565,6 +567,39 @@ static ssize_t write_port(struct file * 
>  }
>  #endif
>  
> +static int
> +ioctl_kmem(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
> +{
> +        int retval = 0;
> +
> +        switch (cmd) {
> +	case IOCTL_FREEZE:
> +		retval = sys_freeze();
> +		break;
> +	case IOCTL_UNFREEZE:
> +		retval = sys_unfreeze();
> +		break;
> +	case IOCTL_ATOMIC_SNAPSHOT:
> +		retval = sys_atomic_snapshot(arg);
> +		break;
> +	case IOCTL_ATOMIC_RESTORE:
> +		{
> +			int pages;
> +			void *pgdir;
> +			get_user(pages, (long *) arg);
> +			get_user(pgdir, (long *) (arg + 4));
> +			retval = sys_atomic_restore(pgdir, pages);
> +		}
> +		break;
> +        default:
> +                retval = -ENOTTY;
> +                break;
> +        }
> +
> +        return retval;
> +}
> +
> +
>  static ssize_t read_null(struct file * file, char __user * buf,
>  			 size_t count, loff_t *ppos)
>  {
> @@ -775,6 +810,7 @@ static struct file_operations mem_fops =
>  static struct file_operations kmem_fops = {
>  	.llseek		= memory_lseek,
>  	.read		= read_kmem,
> +	.ioctl		= ioctl_kmem,
>  	.write		= write_kmem,
>  	.mmap		= mmap_kmem,
>  	.open		= open_kmem,
> diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
> --- a/drivers/char/tipar.c
> +++ b/drivers/char/tipar.c
> @@ -360,7 +360,7 @@ tipar_ioctl(struct inode *inode, struct 
>  
>  	switch (cmd) {
>  	case IOCTL_TIPAR_DELAY:
> -		delay = (int)arg;    //get_user(delay, &arg);
> +		delay = (int)arg;
>  		break;
>  	case IOCTL_TIPAR_TIMEOUT:
>  		if (arg != 0)
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -1,6 +1,7 @@
>  #ifndef _LINUX_SWSUSP_H
>  #define _LINUX_SWSUSP_H
>  
> +#ifdef __KERNEL__
>  #if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
>  #include <asm/suspend.h>
>  #endif
> @@ -9,6 +10,7 @@
>  #include <linux/config.h>
>  #include <linux/init.h>
>  #include <linux/pm.h>
> +#endif
>  
>  /* page backup entry */
>  typedef struct pbe {
> @@ -21,6 +23,7 @@ typedef struct pbe {
>  				 */
>  } suspend_pagedir_t;
>  
> +#ifdef __KERNEL__
>  #define for_each_pbe(pbe, pblist) \
>  	for (pbe = pblist ; pbe ; pbe = pbe->next)
>  
> @@ -72,4 +75,12 @@ struct saved_context;
>  void __save_processor_state(struct saved_context *ctxt);
>  void __restore_processor_state(struct saved_context *ctxt);
>  
> +#endif
> +
> +#define IOCTL_FREEZE 0xeee
> +#define IOCTL_UNFREEZE 0x70eee
> +#define IOCTL_ATOMIC_SNAPSHOT 0x5a5707
> +#define IOCTL_ATOMIC_RESTORE 0x8e5708e
> +
> +
>  #endif /* _LINUX_SWSUSP_H */
> diff --git a/kernel/power/console.c b/kernel/power/console.c
> --- a/kernel/power/console.c
> +++ b/kernel/power/console.c
> @@ -9,6 +9,7 @@
>  #include <linux/console.h>
>  #include "power.h"
>  
> +#undef SUSPEND_CONSOLE
>  static int new_loglevel = 10;
>  static int orig_loglevel;
>  #ifdef SUSPEND_CONSOLE
> diff --git a/kernel/power/disk.c b/kernel/power/disk.c
> --- a/kernel/power/disk.c
> +++ b/kernel/power/disk.c
> @@ -106,6 +106,7 @@ static void free_some_memory(void)
>  	}
>  }
>  
> +/* FIXME: Call it when appropriate */
>  static inline void platform_finish(void)
>  {
>  	if (pm_disk_mode == PM_DISK_PLATFORM) {
> @@ -146,12 +147,25 @@ thaw:
>  
>  static void unprepare_processes(void)
>  {
> -	platform_finish();
>  	thaw_processes();
>  	enable_nonboot_cpus();
>  	pm_restore_console();
>  }
>  
> +
> +int sys_freeze(void)
> +{
> +	return prepare_processes();
> +}
> +
> +int sys_unfreeze(void)
> +{
> +	thaw_processes();
> +	enable_nonboot_cpus();
> +	pm_restore_console();
> +	return 0;
> +}
> +
>  /**
>   *	pm_suspend_disk - The granpappy of power management.
>   *
> @@ -247,6 +261,9 @@ static int software_resume(void)
>  	if ((error = swsusp_check()))
>  		goto Done;
>  
> +	/* Prepare processes only after swsusp_check; we could do it before,
> +	   but it would mean an ugly console switch even in case of normal boot.
> +	 */
>  	pr_debug("PM: Preparing processes for restore.\n");
>  
>  	if ((error = prepare_processes())) {
> diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
> --- a/kernel/power/swsusp.c
> +++ b/kernel/power/swsusp.c
> @@ -405,6 +405,8 @@ static int write_suspend_image(void)
>   FreeData:
>  	data_free();
>  	goto Done;
> +	/* FIXME: proc se tady uvolnuje?! Aha, ono neni potreba
> +	   uvolnovat pri uspesnym resume, takze se uvolnuje tady. */
>  }
>  
> 
> @@ -580,6 +582,8 @@ static void copy_data_pages(void)
>  			}
>  		}
>  	}
> +	if (pbe)
> +		printk(KERN_CRIT "Too many free slots prepared\n");
>  	BUG_ON(pbe);
>  }
>  
> @@ -590,7 +594,7 @@ static void copy_data_pages(void)
>  
>  static int calc_nr(int nr_copy)
>  {
> -	return nr_copy + (nr_copy+PBES_PER_PAGE-2)/(PBES_PER_PAGE-1);
> +	return nr_copy;
>  }
>  
>  /**
> @@ -671,10 +675,12 @@ static struct pbe * alloc_pagedir(unsign
>  
>  	pr_debug("alloc_pagedir(): nr_pages = %d\n", nr_pages);
>  	pblist = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
> +	SetPageNosave(virt_to_page(pblist));
>  	for (pbe = pblist, num = PBES_PER_PAGE; pbe && num < nr_pages;
>          		pbe = pbe->next, num += PBES_PER_PAGE) {
>  		pbe += PB_PAGE_SKIP;
>  		pbe->next = (struct pbe *)get_zeroed_page(GFP_ATOMIC | __GFP_COLD);
> +		SetPageNosave(virt_to_page(pbe->next)); 
>  	}
>  	if (!pbe) { /* get_zeroed_page() failed */
>  		free_pagedir(pblist);
> @@ -717,6 +723,9 @@ static int alloc_image_pages(void)
>  	return 0;
>  }
>  
> +/* Free pages we allocated for suspend. Suspend pages are alocated
> + * before atomic copy, so we need to free them after resume.
> + */
>  void swsusp_free(void)
>  {
>  	BUG_ON(PageNosave(virt_to_page(pagedir_save)));
> @@ -779,8 +788,11 @@ static int swsusp_alloc(void)
>  	if (!enough_free_mem())
>  		return -ENOMEM;
>  
> +#if 0
> +	/* FIXME: belongs elsewhere */
>  	if (!enough_swap())
>  		return -ENOSPC;
> +#endif
>  
>  	if (!(pagedir_save = alloc_pagedir(nr_copy_pages))) {
>  		printk(KERN_ERR "suspend: Allocating pagedir failed.\n");
> @@ -861,6 +873,8 @@ asmlinkage int swsusp_save(void)
>  	return suspend_prepare_image();
>  }
>  
> +static int suspend_count __nosavedata = 0;
> +
>  int swsusp_suspend(void)
>  {
>  	int error;
> @@ -881,31 +895,54 @@ int swsusp_suspend(void)
>  
>  	if ((error = swsusp_swap_check())) {
>  		printk(KERN_ERR "swsusp: cannot find swap device, try swapon -a.\n");
> +#if 0
>  		device_power_up();
>  		local_irq_enable();
>  		return error;
> +#endif
>  	}
>  
> +
>  	save_processor_state();
>  	if ((error = swsusp_arch_suspend()))
>  		printk(KERN_ERR "Error %d suspending\n", error);
>  	/* Restore control flow magically appears here */
> +	printk("back in swsusp_suspend\n");
>  	restore_processor_state();
>  	BUG_ON (nr_copy_pages_check != nr_copy_pages);
>  	restore_highmem();
>  	device_power_up();
>  	local_irq_enable();
> +#if 0
> +	if (suspend_count++ < 5)
> +		swsusp_resume();
> +#endif
>  	return error;
>  }
>  
>  int swsusp_resume(void)
>  {
>  	int error;
> +	printk("swsusp_resume: kill devices ");
>  	local_irq_disable();
>  	if (device_power_down(PMSG_FREEZE))
>  		printk(KERN_ERR "Some devices failed to power down, very bad\n");
>  	/* We'll ignore saved state, but this gets preempt count (etc) right */
>  	save_processor_state();
> +	printk("ignore processor: ");
> +	/* swsusp_arch_resume takes pagedir_nosave as the only parameter */ 
> +	mdelay(1000);
> +	printk("hope for the best: ");
> +
> +	/* Takes pagedir_nosave as an argument. Does not need nr_copy_pages */ 
> +	{
> +		struct pbe *p = pagedir_nosave;
> +		int i = 0;
> +		for_each_pbe (p, pagedir_nosave)
> +			i++;
> +		printk("[%d pages]", i);
> +	}
> +	mdelay(1000);
>  	error = swsusp_arch_resume();
>  	/* Code below is only ever reached in case of failure. Otherwise
>  	 * execution continues at place where swsusp_arch_suspend was called
> @@ -1066,8 +1103,9 @@ static struct pbe * swsusp_pagedir_reloc
>  		free_pagedir(pblist);
>  		free_eaten_memory();
>  		pblist = NULL;
> -	}
> -	else
> +		/* Is this even worth handling? It should never ever happen, and we 
> +		   have just lost user's state, anyway... */
> +	} else
>  		printk("swsusp: Relocated %d pages\n", rel);
>  
>  	return pblist;
> @@ -1373,7 +1411,7 @@ int swsusp_read(void)
>  	}
>  
>  	error = read_suspend_image();
> -	blkdev_put(resume_bdev);
> +	swsusp_close();
>  
>  	if (!error)
>  		pr_debug("swsusp: Reading resume file was successful\n");
> @@ -1385,7 +1423,6 @@ int swsusp_read(void)
>  /**
>   *	swsusp_close - close swap device.
>   */
> -
>  void swsusp_close(void)
>  {
>  	if (IS_ERR(resume_bdev)) {
> @@ -1395,3 +1432,60 @@ void swsusp_close(void)
>  
>  	blkdev_put(resume_bdev);
>  }
> +
> +static int in_suspend __nosavedata = 0;
> +
> +int sys_atomic_snapshot(void **pgdir)
> +{
> +	int err;
> +
> +	printk(KERN_CRIT "Freezing devices\n");
> +	err = device_suspend(PMSG_FREEZE);
> +	if (err)
> +		return err;
> +
> +	printk(KERN_CRIT "Devices frozen\n");
> +	in_suspend = 1;
> +	err = swsusp_suspend();
> +
> +	*pgdir = pagedir_nosave; /* FIXME: put_user */
> +
> +	{
> +		struct pbe *p = pagedir_nosave;
> +		int i = 0;
> +		for_each_pbe (p, pagedir_nosave)
> +			i++;
> +		printk("Got image: [%d pages, pgdir at %lx]", i, pagedir_nosave);
> +	}
> +
> +	if (!err)
> +		err = nr_copy_pages;
> +	if (in_suspend == 2) {
> +		printk("This was actually an resume!\n");
> +		err = -ENOANO;
> +	}
> +
> +	device_resume();
> +	return err;
> +}
> +
> +int sys_atomic_restore(void *pgdir, int pages)
> +{
> +	int err;
> +	/* FIXME: we'll probably overwrite pagedir with itself in inconsistent state...
> +	 ...no, pagedir is NOSAVE.
> +	*/
> +
> +	err = device_suspend(PMSG_FREEZE);
> +	if (err)
> +		return err;
> +
> +	in_suspend = 2;
> +	printk("Should restore from: [%d pages, pgdir at %lx]", pages, pgdir);
> +	pagedir_nosave = pgdir;
> +	nr_copy_pages = pages;
> +
> +	int error = swsusp_resume();
> +	printk(KERN_CRIT "This should never return\n");
> +	return error;
> +}
> diff --git a/usr/swsusp.c b/usr/swsusp.c
> new file mode 100644
> --- /dev/null
> +++ b/usr/swsusp.c
> @@ -0,0 +1,103 @@
> +/*
> + * Swsusp3 control program
> + *
> + * Copyright 2005 Pavel Machek <pavel@suse.cz>
> + *
> + * Distribute under GPLv2
> + */
> +
> +#include <stdlib.h>
> +#include <stdio.h>
> +#include <asm/mman.h>
> +#include <asm/fcntl.h>
> +
> +typedef long swp_entry_t;
> +
> +#include "/data/l/linux-sw3/include/linux/suspend.h"
> +
> +struct resume {
> +	int pages;
> +	void *pgdir;
> +} resume;
> +
> +int kmem;
> +
> +void
> +seek(long dest)
> +{
> +	if (lseek64(kmem, dest, SEEK_SET) != dest) {
> +		fprintf(stderr, "Could not do intial seek: %m\n");
> +		exit(1);
> +	}
> +
> +}
> +
> +void
> +walk_chain(struct resume *r)
> +{
> +	struct pbe p;
> +	int i = 0;
> +
> +	seek((long) r->pgdir);
> +	while (1) {
> +		if (read(kmem, &p, sizeof(p)) != sizeof(p)) {
> +			fprintf(stderr, "Could not read pbe #%d: %m\n", i);
> +			exit(1);
> +		}
> +		i++;
> +		if (!p.next)
> +			break;
> +		seek((long) p.next);
> +	}
> +	printf("Verified chain: %d pages\n", i);
> +}
> +
> +int
> +main(int argc, char *argv[])
> +{
> +	kmem = open("/dev/kmem", O_RDWR | O_LARGEFILE);
> +	resume.pages = -1;
> +	resume.pgdir = NULL;
> +
> +	if (kmem < 0) {
> +		fprintf(stderr, "Could not open /dev/kmem: %m\n");
> +		return 1;
> +	}
> +
> +	if (mlockall(MCL_CURRENT | MCL_FUTURE)) {
> +		fprintf(stderr, "Could not lock myself: %m\n");
> +		return 1;
> +	}
> +
> +#if 1
> +	if (ioctl(kmem, IOCTL_FREEZE, 0)) {
> +		fprintf(stderr, "Could not freeze system: %m\n");
> +		return 1;
> +	}
> +#endif
> +
> +#if 1
> +	resume.pages = ioctl(kmem, IOCTL_ATOMIC_SNAPSHOT, &resume.pgdir);
> +	if (resume.pages < 0) {
> +		fprintf(stderr, "Could not snapshot system: %m\n");
> +		goto unfreeze;
> +	}
> +
> +	printf("Snapshotted, have %d pages, pgdir at %lx\n", resume.pages, resume.pgdir);
> +	walk_chain(&resume);
> +#endif
> +#if 1
> +	if (ioctl(kmem, IOCTL_ATOMIC_RESTORE, &resume)) {
> +		fprintf(stderr, "Could not restore system: %m\n");
> +	}
> +	/* Ouch, at this point we'll appear in ATOMIC_SNAPSHOT syscall, with no way to tell... */
> +#endif
> +
> + unfreeze:
> +	if (ioctl(kmem, IOCTL_UNFREEZE, 0)) {
> +		fprintf(stderr, "Could not unfreeze system: %m\n");
> +		return 1;
> +	}
> +	printf("All done, returning to the shell.\n");
> +	return 0;
> +}
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.


--===============93714705354343386==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============93714705354343386==--
