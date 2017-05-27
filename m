From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v1 1/1] intel_telemetry_debugfs: fix oops found while
 load/unload module test
Date: Fri, 26 May 2017 22:49:29 -0700
Message-ID: <20170527054929.GA118811@localhost.localdomain>
References: <6718d6200ee45ae58b496225d148d275a2776756.1495897832.git.priyalee.kushwaha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6718d6200ee45ae58b496225d148d275a2776756.1495897832.git.priyalee.kushwaha@intel.com>
Sender: platform-driver-x86-owner@vger.kernel.org
To: priyalee.kushwaha@intel.com
Cc: souvik.k.chakravarty@intel.com, andy@infradead.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org, Rafael Wysocki <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, May 27, 2017 at 08:17:39AM -0700, priyalee.kushwaha@intel.com wrote:
> From: Priyalee Kushwaha <priyalee.kushwaha@intel.com>
> 
> This fix oops found while testing load/unload test of
> intel_telemetry_debugfs module. Module_init uses register_pm_notifier
> for PM callbacks, but unregister_pm_notifier was missing from
> module_exit.
> 
>  [ 97.481860] BUG: unable to handle kernel paging request at ffffffffa006f010
>  [ 97.489742] IP: blocking_notifier_chain_register+0x3a/0xa0
>  [ 97.495898] PGD 2e0a067
>  [ 97.495899] PUD 2e0b063
>  [ 97.498737] PMD 179e29067
>  [ 97.501573] PTE 0
> 
>  [ 97.508423] Oops: 0000 1 PREEMPT SMP
>  [ 97.512724] Modules linked in: intel_telemetry_debugfs intel_rapl gpio_keys dwc3 udc_core intel_telemetry_pltdrv intel_punit_ipc intel_telemetry_core rtc_cmos efivars x86_pkg_temp_thermal iwlwifi snd_hda_codec_hdmi soc_button_array btusb cfg80211 btrtl mei_me hci_uart btbcm mei btintel i915 bluetooth intel_pmc_ipc snd_hda_intel spi_pxa2xx_platform snd_hda_codec dwc3_pci snd_hda_core tpm_tis tpm_tis_core tpm efivarfs
>  [ 97.558453] CPU: 0 PID: 889 Comm: modprobe Not tainted 4.11.0-rc6-intel-dev-bkc #1
>  [ 97.566950] Hardware name: Intel Corp. Joule DVT3/SDS, BIOS GTPP181A.X64.0143.B30.1701132137 01/13/2017
>  [ 97.577518] task: ffff8801793a21c0 task.stack: ffff8801793f0000
>  [ 97.584162] RIP: 0010:blocking_notifier_chain_register+0x3a/0xa0
>  [ 97.590903] RSP: 0018:ffff8801793f3c58 EFLAGS: 00010286
>  [ 97.596802] RAX: ffffffffa006f000 RBX: ffffffff81e3ea20 RCX: 0000000000000000
>  [ 97.604812] RDX: ffff880179eaf210 RSI: ffffffffa0131000 RDI: ffffffff81e3ea20
>  [ 97.612821] RBP: ffff8801793f3c68 R08: 0000000000000006 R09: 000000000000005c
>  [ 97.620847] R10: 0000000000000000 R11: 0000000000000006 R12: ffffffffa0131000
>  [ 97.628855] R13: 0000000000000000 R14: ffff880176e35f48 R15: ffff8801793f3ea8
>  [ 97.636865] FS: 00007f7eeba07700(0000) GS:ffff88017fc00000(0000) knlGS:0000000000000000
>  [ 97.645948] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  [ 97.652423] CR2: ffffffffa006f010 CR3: 00000001775ef000 CR4: 00000000003406f0
>  [ 97.660423] Call Trace:
>  [ 97.663166] ? 0xffffffffa0031000
>  [ 97.666885] register_pm_notifier+0x18/0x20
>  [ 97.671581] telemetry_debugfs_init+0x92/0x1000
> 
> Signed-off-by: Priyalee Kushwaha <priyalee.kushwaha@intel.com>

Hi Priyalee,

Thanks for catching this, we should get a fix into the RC cycle. but I think we
can make some small changes that will improve legibility here.

> ---
>  drivers/platform/x86/intel_telemetry_debugfs.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel_telemetry_debugfs.c b/drivers/platform/x86/intel_telemetry_debugfs.c
> index ef29f18..0f93975 100644
> --- a/drivers/platform/x86/intel_telemetry_debugfs.c
> +++ b/drivers/platform/x86/intel_telemetry_debugfs.c
> @@ -966,8 +966,12 @@ static int __init telemetry_debugfs_init(void)
>  #endif /* CONFIG_PM_SLEEP */
>  
>  	debugfs_conf->telemetry_dbg_dir = debugfs_create_dir("telemetry", NULL);
> -	if (!debugfs_conf->telemetry_dbg_dir)
> +	if (!debugfs_conf->telemetry_dbg_dir) {
> +#ifdef CONFIG_PM_SLEEP
> +		unregister_pm_notifier(&pm_notifier);
> +#endif /* CONFIG_PM_SLEEP */
>  		return -ENOMEM;
> +	}

As a general rule, we try to avoid peppering code with #ifdef blocks, and prefer
to create no-op functions, or similar. CONFIG_PM_SLEEP unfortunately doesn't
have such no-op functions.

Rather than add the CONFIG_PM_SLEEP block above, please convert the above to use
an err= and goto statement, and create the appropriate labels below.

+Rafael, Len, Pavel, linux-pm: Is there a preferred approach for dealing with
                               CONFIG_PM_SLEEP?

>  
>  	f = debugfs_create_file("pss_info", S_IFREG | S_IRUGO,
>  				debugfs_conf->telemetry_dbg_dir, NULL,
> @@ -1014,6 +1018,9 @@ static int __init telemetry_debugfs_init(void)
>  out:
>  	debugfs_remove_recursive(debugfs_conf->telemetry_dbg_dir);
>  	debugfs_conf->telemetry_dbg_dir = NULL;

  e.g.

   out_pm:

> +#ifdef CONFIG_PM_SLEEP
> +	unregister_pm_notifier(&pm_notifier);
> +#endif /* CONFIG_PM_SLEEP */
>  
>  	return err;
>  }
> @@ -1022,6 +1029,9 @@ static void __exit telemetry_debugfs_exit(void)
>  {
>  	debugfs_remove_recursive(debugfs_conf->telemetry_dbg_dir);
>  	debugfs_conf->telemetry_dbg_dir = NULL;
> +#ifdef CONFIG_PM_SLEEP
> +	unregister_pm_notifier(&pm_notifier);
> +#endif /* CONFIG_PM_SLEEP */
>  }
>  
>  late_initcall(telemetry_debugfs_init);
> -- 
> 2.10.0
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
