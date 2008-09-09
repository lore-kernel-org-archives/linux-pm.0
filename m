From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [RFC 3/5] pci wakeup handler
Date: Tue, 9 Sep 2008 09:44:03 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C01AC7F30F3__19345.70243252$1220924883$gmane$org@PDSMSX501.ccr.corp.intel.com>
References: <20080908091926.785882370@sli10-desk.sh.intel.com>
	<20080908092305.438330804@sli10-desk.sh.intel.com>
	<200809081509.52070.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200809081509.52070.rjw@sisk.pl>
Content-Language: en-US
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
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "dbrownell@users.sourceforge.net" <dbrownell@users.sourceforge.net>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org



>-----Original Message-----
>From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
>owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
>Sent: Monday, September 08, 2008 9:10 PM
>To: Li, Shaohua
>Cc: linux-pm@lists.linux-foundation.org; linux-acpi@vger.kernel.org;
>stern@rowland.harvard.edu; dbrownell@users.sourceforge.net; Jesse Barnes
>Subject: Re: [RFC 3/5] pci wakeup handler
>
>On Monday, 8 of September 2008, shaohua.li@intel.com wrote:
>> pci subsystem wakeup handler.
>> ---
>>  drivers/pci/pci-driver.c |   46
>++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 46 insertions(+)
>>
>> Index: linux/drivers/pci/pci-driver.c
>> ===================================================================
>> --- linux.orig/drivers/pci/pci-driver.c       2008-09-08
>13:55:56.000000000 +0800
>> +++ linux/drivers/pci/pci-driver.c    2008-09-08 14:24:42.000000000 +0800
>> @@ -472,12 +472,57 @@ static int pci_pm_resume_noirq(struct de
>>       return error;
>>  }
>>
>> +/*
>> + * Called when dev is suspected to invoke a wakeup event, return 0 if
>yes
>> + * */
>> +static int pci_pm_wakeup_event(struct device *dev)
>> +{
>> +     struct pci_dev *pdev = to_pci_dev(dev);
>> +     int pme_pos = pci_find_capability(pdev, PCI_CAP_ID_PM);
>
>Pleae use dev->pm_cap instead.
Ok, I'll address your other comments too.

>        if (drv && drv->pm && drv->pm->base.wakeup_event) {
>                int dev_ret = drv->pm->base.wakeup_event(&pdev->dev);
>                if (ret)
>                        ret = dev_ret;
>        }
>
>Also, why do you think we should ignore the returned value if ret is zero?
Because we already identified the device which invokes PME. Even the .wakeup_event() returns an error, we should populate It's this device which has wakeup event. In my mind, driver isn't required to provide .wakeup_event() unless device has non-standard regs for wakeup event or some special to handle. Generic PME handling should be fine for most devices (for PCI devices).

Thanks,
Shaohua
