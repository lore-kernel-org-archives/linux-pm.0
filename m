From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/7] tboot: Add return values for tboot_sleep
Date: Thu, 12 Jan 2012 15:23:09 -0500
Message-ID: <20120112202308.GA2030@phenom.dumpdata.com>
References: <1324075099-11397-1-git-send-email-konrad.wilk@oracle.com>
	<1324075099-11397-3-git-send-email-konrad.wilk@oracle.com>
	<9F57BF860713DF4BA3EFA4F8C6DFEDAC2420CBB9@ORSMSX101.amr.corp.intel.com>
	<20120112174958.GA22515@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120112174958.GA22515@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Cihula, Joseph" <joseph.cihula@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>, "x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>, "liang.tang@oracle.com" <liang.tang@oracle.com>, "hpa@zytor.com" <hpa@zytor.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 12, 2012 at 09:49:58AM -0800, Konrad Rzeszutek Wilk wrote:
> On Tue, Jan 10, 2012 at 08:10:53PM +0000, Cihula, Joseph wrote:
> > ACK, but tboot_sleep() calls tboot_shutdown() and there are error conditions in that which you are not reflecting upward--i.e. you should make tboot_shutdown() return an 'int' and propagate its errors through tboot_sleep().
> 
> Hey Joe,
> 
> Thanks for looking at the patches.
> 
> Right now [with this patch applied] the code looks as so:
> 
> 297 
> 298         tboot_shutdown(acpi_shutdown_map[sleep_state]);
> 299         return 0;
> 300 }
> 
> 
> If we do make tboot_shutdown() return an int, there will be a need to modify
> other callers: native_machine_emergency_restart, native_machine_halt, 
> native_machine_power_off, and native_play_dead as well.
> 
> Perhaps that could be done in another patch and leave this one as is
> where the 'tboot_sleep' would just return 0 instead of
> 'return tboot_shutdown(...)' ?
> 
> Perhaps another way to do this is to extract the common code of tboot_sleep
> and tboot_shutdown?

Like this (not yet tested):

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 6410744..2f93a50 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -212,17 +212,16 @@ static int tboot_setup_sleep(void)
 {
 	/* S3 shutdown requested, but S3 not supported by the kernel... */
 	BUG();
-	return -1;
+	return -ENOSYS;
 }
 
 #endif
 
-void tboot_shutdown(u32 shutdown_type)
-{
-	void (*shutdown)(void);
+static int tboot_check(u32 shutdown_type) {
+
 
 	if (!tboot_enabled())
-		return;
+		return -ENODEV;
 
 	/*
 	 * if we're being called before the 1:1 mapping is set up then just
@@ -230,12 +229,21 @@ void tboot_shutdown(u32 shutdown_type)
 	 * due to very early panic()
 	 */
 	if (!tboot_pg_dir)
-		return;
+		return -EBUSY;
 
 	/* if this is S3 then set regions to MAC */
-	if (shutdown_type == TB_SHUTDOWN_S3)
-		if (tboot_setup_sleep())
-			return;
+	if (shutdown_type == TB_SHUTDOWN_S3) {
+		int err = tboot_setup_sleep();
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static void __tboot_shutdown(u32 shutdown_type)
+{
+	void (*shutdown)(void);
 
 	tboot->shutdown_type = shutdown_type;
 
@@ -248,6 +256,13 @@ void tboot_shutdown(u32 shutdown_type)
 	while (1)
 		halt();
 }
+void tboot_shutdown(u32 shutdown_type)
+{
+	if (!tboot_check(shutdown_type))
+		return;
+
+	__tboot_shutdown(shutdown_type);
+}
 
 static void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
 {
@@ -279,9 +294,17 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 		/* S3: */ TB_SHUTDOWN_S3,
 		/* S4: */ TB_SHUTDOWN_S4,
 		/* S5: */ TB_SHUTDOWN_S5 };
+	int err;
 
-	if (!tboot_enabled())
-		return 0;
+	if (sleep_state >= ACPI_S_STATE_COUNT ||
+	    acpi_shutdown_map[sleep_state] == -1) {
+		pr_warning("unsupported sleep state 0x%x\n", sleep_state);
+		return -ENOSYS;
+	}
+
+	err = tboot_check(acpi_shutdown_map[sleep_state]);
+	if (!err && err != EBUSY)
+		return err;
 
 	tboot_copy_fadt(&acpi_gbl_FADT);
 	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control;
@@ -289,13 +312,7 @@ static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
 	/* we always use the 32b wakeup vector */
 	tboot->acpi_sinfo.vector_width = 32;
 
-	if (sleep_state >= ACPI_S_STATE_COUNT ||
-	    acpi_shutdown_map[sleep_state] == -1) {
-		pr_warning("unsupported sleep state 0x%x\n", sleep_state);
-		return -1;
-	}
-
-	tboot_shutdown(acpi_shutdown_map[sleep_state]);
+	__tboot_shutdown((acpi_shutdown_map[sleep_state]));
 	return 0;
 }
 
