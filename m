From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH V4 3/7] PCI: tegra: Remove PCI_REASSIGN_ALL_BUS flag for
 Tegra PCIe
Date: Wed, 3 Jan 2018 21:54:03 +0530
Message-ID: <25d10221-67c8-59c4-46d1-9bff239bd6bd@nvidia.com>
References: <1512723493-865-1-git-send-email-mmaddireddy@nvidia.com>
 <1512723493-865-4-git-send-email-mmaddireddy@nvidia.com>
 <20171215173643.GA1050@red-moon> <20171220193011.GA31757@ulmo>
 <20171221104630.GB24280@red-moon>
 <20180103155149.GA8929@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180103155149.GA8929-4tUPXFaYRHv6sAKXYmQ0tx/iLCjYCKR+VpNB7YpNyf8@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: cyndis-/1wQRMveznE@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 03-Jan-18 9:21 PM, Lorenzo Pieralisi wrote:
> On Thu, Dec 21, 2017 at 10:46:30AM +0000, Lorenzo Pieralisi wrote:
>> On Wed, Dec 20, 2017 at 08:30:11PM +0100, Thierry Reding wrote:
>>> On Fri, Dec 15, 2017 at 05:36:43PM +0000, Lorenzo Pieralisi wrote:
>>>> On Fri, Dec 08, 2017 at 02:28:09PM +0530, Manikanta Maddireddy wrote:
>>>>> Primary, secondary and subordinate default bus numbers are 0 in Tegra and
>>>>> it is expecting SW to program these numbers in configration space.
>>>>>
>>>>> pci_scan_bridge_extend() function programs these numbers in configuration
>>>>> space if secondary & subordinate bus numbers are 0 or PCI_REASSIGN_ALL_BUS
>>>>> flag is set. Since secondary & subordinate default bus numbers are 0,
>>>>> PCI_REASSIGN_ALL_BUS flag can be removed for Tegra PCIe.
>>>>>
>>>>> Signed-off-by: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>>>> ---
>>>>> V3:
>>>>> * new patch in V3
>>>>> V4:
>>>>> * no change in this patch
>>>>>
>>>>>  drivers/pci/host/pci-tegra.c | 1 -
>>>>>  1 file changed, 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/pci/host/pci-tegra.c b/drivers/pci/host/pci-tegra.c
>>>>> index a549c5899e26..0d91f1a3a6b4 100644
>>>>> --- a/drivers/pci/host/pci-tegra.c
>>>>> +++ b/drivers/pci/host/pci-tegra.c
>>>>> @@ -2604,7 +2604,6 @@ static int tegra_pcie_probe(struct platform_device *pdev)
>>>>>  
>>>>>  	tegra_pcie_enable_ports(pcie);
>>>>>  
>>>>> -	pci_add_flags(PCI_REASSIGN_ALL_BUS);
>>>>
>>>> This looks obviously OK to me but I need Thierry's ACK to queue it.
>>>
>>> Just as an additional note: I think the real reason why this is okay to
>>> do is because we reset the PCI host controller in the kernel driver, so
>>> any bus assignments done by the firmware are reset as well.
>>>
>>> Acked-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
>>
>> Thank you. This series needs rebasing, we should try to untangle
>> the dependencies between series so that I can actually apply some
>> of these patches that make sense on their own.
> 
> Manikanta, would you be able to decouple this series from:
> 
> https://patchwork.ozlabs.org/patch/832053/
> 
> so that we can make forward progress ? There are some patches in
> this series that I could apply - if rebased.
> 
> Lorenzo
> 

Sure, I will decouple and send this series again.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
