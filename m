From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/8] x86: Use syscore_ops instead of sysdev
 classes and sysdevs
Date: Sun, 13 Mar 2011 15:23:54 +0100 (CET)
Message-ID: <alpine.LFD.2.00.1103131500340.2787__49481.9297026426$1300026324$gmane$org@localhost6.localdomain6>
References: <201103100131.58206.rjw@sisk.pl> <201103122212.40828.rjw@sisk.pl>
	<201103122215.48206.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103122215.48206.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, mingo@redhat.com, Avi Kivity <avi@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Kay Sievers <kay.sievers@suse.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 12 Mar 2011, Rafael J. Wysocki wrote:
> -static int lapic_resume(struct sys_device *dev)
> +static void lapic_resume(void)
>  {
>  	unsigned int l, h;
>  	unsigned long flags;
> @@ -2083,7 +2083,7 @@ static int lapic_resume(struct sys_devic
>  	struct IO_APIC_route_entry **ioapic_entries = NULL;
>  
>  	if (!apic_pm_state.active)
> -		return 0;
> +		return;
>  
>  	local_irq_save(flags);

That want's the following on top:

@@ -2079,8 +2079,7 @@ static void lapic_resume(void)
 {
 	unsigned int l, h;
 	unsigned long flags;
-	int maxlvt;
-	int ret = 0;
+	int maxlvt, ret;
 	struct IO_APIC_route_entry **ioapic_entries = NULL;
 
 	if (!apic_pm_state.active)
@@ -2091,7 +2090,6 @@ static void lapic_resume(void)
 		ioapic_entries = alloc_ioapic_entries();
 		if (!ioapic_entries) {
 			WARN(1, "Alloc ioapic_entries in lapic resume failed.");
-			ret = -ENOMEM;
 			goto restore;
 		}

Otherwise, Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Thanks,

	tglx
