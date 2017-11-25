From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 01/10] genirq: Export irq_set_msi_desc()
Date: Sun, 26 Nov 2017 01:11:05 +0530
Message-ID: <600a7b65-670e-b164-913c-99e18ae593d2@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-2-git-send-email-mmaddireddy@nvidia.com>
 <alpine.DEB.2.20.1711250050520.2316@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.20.1711250050520.2316@nanos>
Content-Language: en-US
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 25-Nov-17 5:25 AM, Thomas Gleixner wrote:
> On Fri, 24 Nov 2017, Manikanta Maddireddy wrote:
> 
> Please CC the proper mailing list for irq related changes.
> 
>> PCI bus support MSI interrupts, allow PCI host driver to set MSI descriptor
>> data for an irq.
> 
> This is not really an explanation why this export is needed.
> 
> Thanks,
> 
> 	tglx
> 
Updated the commit log with why Tegra PCIe driver is using this function in V2.
Please review.
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>> ---
>>  kernel/irq/chip.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> index 5a2ef92c2782..bfbd17386bc4 100644
>> --- a/kernel/irq/chip.c
>> +++ b/kernel/irq/chip.c
>> @@ -136,6 +136,7 @@ int irq_set_msi_desc(unsigned int irq, struct msi_desc *entry)
>>  {
>>  	return irq_set_msi_desc_off(irq, 0, entry);
>>  }
>> +EXPORT_SYMBOL(irq_set_msi_desc);
>>  
>>  /**
>>   *	irq_set_chip_data - set irq chip data for an irq
>> -- 
>> 2.1.4
>>
>>
