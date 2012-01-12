From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 2/7] tboot: Add return values for tboot_sleep
Date: Thu, 12 Jan 2012 12:49:58 -0500
Message-ID: <20120112174958.GA22515@phenom.dumpdata.com>
References: <1324075099-11397-1-git-send-email-konrad.wilk@oracle.com>
	<1324075099-11397-3-git-send-email-konrad.wilk@oracle.com>
	<9F57BF860713DF4BA3EFA4F8C6DFEDAC2420CBB9@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <9F57BF860713DF4BA3EFA4F8C6DFEDAC2420CBB9@ORSMSX101.amr.corp.intel.com>
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

On Tue, Jan 10, 2012 at 08:10:53PM +0000, Cihula, Joseph wrote:
> ACK, but tboot_sleep() calls tboot_shutdown() and there are error conditions in that which you are not reflecting upward--i.e. you should make tboot_shutdown() return an 'int' and propagate its errors through tboot_sleep().

Hey Joe,

Thanks for looking at the patches.

Right now [with this patch applied] the code looks as so:

297 
298         tboot_shutdown(acpi_shutdown_map[sleep_state]);
299         return 0;
300 }


If we do make tboot_shutdown() return an int, there will be a need to modify
other callers: native_machine_emergency_restart, native_machine_halt, 
native_machine_power_off, and native_play_dead as well.

Perhaps that could be done in another patch and leave this one as is
where the 'tboot_sleep' would just return 0 instead of
'return tboot_shutdown(...)' ?

Perhaps another way to do this is to extract the common code of tboot_sleep
and tboot_shutdown?

> 
> Joe
> 
> > -----Original Message-----
> > From: Konrad Rzeszutek Wilk [mailto:konrad.wilk@oracle.com]
> > Sent: Friday, December 16, 2011 2:38 PM
> > To: linux-kernel@vger.kernel.org; rjw@sisk.pl; x86@kernel.org; Brown, Len; Cihula, Joseph; linux-
> > pm@lists.linux-foundation.org; tboot-devel@lists.sourceforge.net; linux-acpi@vger.kernel.org;
> > liang.tang@oracle.com
> > Cc: hpa@zytor.com; Konrad Rzeszutek Wilk
> > Subject: [PATCH 2/7] tboot: Add return values for tboot_sleep
> > 
> > . as appropiately. As tboot_sleep now returns values.
> > remove tboot_sleep_wrapper.
> > 
> > Suggested-by: "Rafael J. Wysocki" <rjw@sisk.pl>
> > CC: Joseph Cihula <joseph.cihula@intel.com>
> > [v1: Return -1/0/+1 instead of ACPI_xx values]
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > ---
> >  arch/x86/kernel/tboot.c |   13 ++++---------
> >  1 files changed, 4 insertions(+), 9 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c index 1a4ab7d..6410744 100644
> > --- a/arch/x86/kernel/tboot.c
> > +++ b/arch/x86/kernel/tboot.c
> > @@ -272,7 +272,7 @@ static void tboot_copy_fadt(const struct acpi_table_fadt *fadt)
> >  		offsetof(struct acpi_table_facs, firmware_waking_vector);  }
> > 
> > -void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
> > +static int tboot_sleep(u8 sleep_state, u32 pm1a_control, u32
> > +pm1b_control)
> >  {
> >  	static u32 acpi_shutdown_map[ACPI_S_STATE_COUNT] = {
> >  		/* S0,1,2: */ -1, -1, -1,
> > @@ -281,7 +281,7 @@ void tboot_sleep(u8 sleep_state, u32 pm1a_control, u32 pm1b_control)
> >  		/* S5: */ TB_SHUTDOWN_S5 };
> > 
> >  	if (!tboot_enabled())
> > -		return;
> > +		return 0;
> > 
> >  	tboot_copy_fadt(&acpi_gbl_FADT);
> >  	tboot->acpi_sinfo.pm1a_cnt_val = pm1a_control; @@ -292,15 +292,10 @@ void tboot_sleep(u8
> > sleep_state, u32 pm1a_control, u32 pm1b_control)
> >  	if (sleep_state >= ACPI_S_STATE_COUNT ||
> >  	    acpi_shutdown_map[sleep_state] == -1) {
> >  		pr_warning("unsupported sleep state 0x%x\n", sleep_state);
> > -		return;
> > +		return -1;
> >  	}
> > 
> >  	tboot_shutdown(acpi_shutdown_map[sleep_state]);
> > -}
> > -static int tboot_sleep_wrapper(u8 sleep_state, u32 pm1a_control,
> > -			       u32 pm1b_control)
> > -{
> > -	tboot_sleep(sleep_state, pm1a_control, pm1b_control);
> >  	return 0;
> >  }
> > 
> > @@ -352,7 +347,7 @@ static __init int tboot_late_init(void)
> >  	atomic_set(&ap_wfs_count, 0);
> >  	register_hotcpu_notifier(&tboot_cpu_notifier);
> > 
> > -	acpi_os_set_prepare_sleep(&tboot_sleep_wrapper);
> > +	acpi_os_set_prepare_sleep(&tboot_sleep);
> >  	return 0;
> >  }
> > 
> > --
> > 1.7.7.4
