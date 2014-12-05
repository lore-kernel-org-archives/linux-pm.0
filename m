From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] PCI: Add disabling pm async quirk for JMicron chips
Date: Fri, 5 Dec 2014 09:45:44 -0500
Message-ID: <20141205144544.GH4080@htj.dyndns.org>
References: <1417763857-11993-1-git-send-email-chuansheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417763857-11993-1-git-send-email-chuansheng.liu@intel.com>
Sender: linux-pci-owner@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: bhelgaas@google.com, rjw@rjwysocki.net, mister.freeman@laposte.net, aaron.lu@intel.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Dec 05, 2014 at 03:17:37PM +0800, Chuansheng Liu wrote:
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB360, quirk_jmicron_ata);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB361, quirk_jmicron_ata);
>  DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB362, quirk_jmicron_ata);
> @@ -1519,6 +1534,8 @@ DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB3
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB366, quirk_jmicron_ata);
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB368, quirk_jmicron_ata);
>  DECLARE_PCI_FIXUP_RESUME_EARLY(PCI_VENDOR_ID_JMICRON, PCI_DEVICE_ID_JMICRON_JMB369, quirk_jmicron_ata);
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_JMICRON, PCI_ANY_ID,
> +		pci_async_suspend_fixup);

Why is this being done through pci quirks?  e6b7e41cdd8 implements the
same quirk in the respective drivers.  What's the difference here?

Thanks.

-- 
tejun
