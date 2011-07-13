From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] mrst_pmu: driver for Intel Moorestown Power
 Management Unit
Date: Wed, 13 Jul 2011 10:51:05 +0100
Message-ID: <20110713105105.63e2fbcb__20440.1275645525$1310550948$gmane$org@lxorguk.ukuu.org.uk>
References: <alpine.LFD.2.02.1107122328180.4502@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1107122328180.4502@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> +static struct mrst_device *pci_id_2_mrst_dev(u16 pci_dev_num)
> +{
> +	int index;
> +
> +	if ((pci_dev_num >= 0x0800) && (pci_dev_num <= 0x815))
> +		index = pci_dev_num - 0x800;
> +	else if (pci_dev_num == 0x084F)
> +		index = 22;
> +	else if (pci_dev_num == 0x4102)
> +		index = 23;
> +	else if (pci_dev_num == 0x4110)
> +		index = 24;
> +	else
> +		BUG();
> +
> +	BUG_ON(pci_dev_num != mrst_devs[index].pci_dev_num);

That strikes me as needlessly unfriendly, you could warn/return NULL and
propogate a WARN_ONCE back to the user.

> +static int __init scu_fw_check(void)
> +{
> +	int ret;
> +	u32 fw_version;
> +
> +	sfi_table_parse("OEMB", NULL, NULL, pmu_sfi_parse_oem);
> +
> +	if (ia_major < 0x6005 || ia_minor < 0x1525) {
> +		WARN(1, "mrst_pmu: IA FW version too old\n");
> +		return -1;
> +	}
> +
> +	ret = intel_scu_ipc_command(IPCMSG_FW_REVISION, 0, NULL, 0,
> +					&fw_version, 1);
> +
> +	if (ret) {
> +		WARN(1, "mrst_pmu: IPC FW version? %d\n", ret);
> +	} else {
> +		int scu_major = (fw_version >> 8) & 0xFF;
> +		int scu_minor = (fw_version >> 0) & 0xFF;
> +
> +		printk(KERN_INFO "mrst_pmu: firmware v%x\n", fw_version);
> +
> +		if ((scu_major >= 0xC0) && (scu_minor >= 0x49)) {
> +			printk(KERN_INFO "mrst_pmu: enabling S0i3\n");
> +			mrst_pmu_s0i3_enable = true;
> +		} else {
> +			WARN(1, "mrst_pmu: S0i3 disabled, old firmware %X.%X",
> +					scu_major, scu_minor);
> +		}
> +	}
> +	return 0;
> +}
> +late_initcall(scu_fw_check);

NAK. I pointed this problem with the driver to you way back - this code
gets run always - even on machines that are not in fact Moorestown which
are then going to crash.

You need to check that the platform is Moorestown (not just the CPU
either because of Oaktrail)
