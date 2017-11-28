From: Marc Zyngier <marc.zyngier-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH 01/10] genirq: Export irq_set_msi_desc()
Date: Tue, 28 Nov 2017 10:00:32 +0000
Message-ID: <be79bf6f-b24a-6292-5eb1-3bcf97890421@arm.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-2-git-send-email-mmaddireddy@nvidia.com>
 <alpine.DEB.2.20.1711250050520.2316@nanos>
 <600a7b65-670e-b164-913c-99e18ae593d2@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <600a7b65-670e-b164-913c-99e18ae593d2-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Content-Language: en-GB
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Cc: thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 25/11/17 19:41, Manikanta Maddireddy wrote:
> 
> 
> On 25-Nov-17 5:25 AM, Thomas Gleixner wrote:
>> On Fri, 24 Nov 2017, Manikanta Maddireddy wrote:
>>
>> Please CC the proper mailing list for irq related changes.
>>
>>> PCI bus support MSI interrupts, allow PCI host driver to set MSI descriptor
>>> data for an irq.
>>
>> This is not really an explanation why this export is needed.
>>
>> Thanks,
>>
>> 	tglx
>>
> Updated the commit log with why Tegra PCIe driver is using this function in V2.
> Please review.

Well, to review it, I would like to be on Cc.

My current position on this is that if you need to export this function,
then you're using a deprecated API, and you should instead consider
moving to the generic MSI model, which doesn't need any of this.

I've done that a distant past, but never actually published the patch
(not tested it):

https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/kill-msi-controller&id=83b3602fcee7972b9d549ed729b56ec28de16081

But without seeing the patches, I may be barking up the wrong tree...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
