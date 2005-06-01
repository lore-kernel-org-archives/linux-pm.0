From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Don't explode on swsusp failure to find swap
Date: Wed, 1 Jun 2005 11:27:42 +0200
Message-ID: <20050601092742.GC6693@elf.ucw.cz>
References: <1117523585.5826.18.camel@gaston>
	<20050531103623.GB1848@elf.ucw.cz>
	<1117550706.5826.43.camel@gaston> <1117583403.5826.72.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66936309867209265=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117583403.5826.72.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============66936309867209265==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > If we specify a swap device for swsusp using resume= kernel argument and
> > > > that device doesn't exist in the swap list, we end up calling
> > > > swsusp_free() before we have allocated pagedir_save. That causes us to
> > > > explode when trying to free it.
> > > > 
> > > > Pavel, does that look right ?
> > > 
> > > It looks like a workaround. We should not call swsusp_free in case
> > > device does not exists. Quick look did not reveal where the bug comes
> > > from, can you try to trace it?
> > > 								Pavel
> > 
> > Well, the bug comes from arch code calling swsusp_save() which fails,
> > then we call swsusp_free()
> 
> More specifically, arch suspend calls swsusp_save().
> 
> It fails and returns the error to the arch asm code, which itself
> returns it to it's caller swsusp_suspend(), which does that:
> 
>  	if ((error = swsusp_arch_suspend()))
> 		swsusp_free();

Ugh, swsusp_free should be totally unneccessary at this point; only
error returns are from the time before anything is allocated.

Does something like this help?

diff --git a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c
+++ b/kernel/power/swsusp.c
@@ -975,13 +975,6 @@ extern asmlinkage int swsusp_arch_resume
 
 asmlinkage int swsusp_save(void)
 {
-	int error = 0;
-
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
-				"swapon -a!\n");
-		return error;
-	}
 	return suspend_prepare_image();
 }
 
@@ -999,12 +992,19 @@ int swsusp_suspend(void)
 	 */
 	if ((error = device_power_down(PMSG_FREEZE))) {
 		local_irq_enable();
-		swsusp_free();
 		return error;
 	}
+
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: FATAL: cannot find swap device, try "
+				"swapon -a!\n");
+		local_irq_enable();
+		return error;
+	}
+
 	save_processor_state();
 	if ((error = swsusp_arch_suspend()))
-		swsusp_free();
+		printk("Error %d suspending\n", error);
 	/* Restore control flow magically appears here */
 	restore_processor_state();
 	BUG_ON (nr_copy_pages_check != nr_copy_pages);

--===============66936309867209265==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66936309867209265==--
