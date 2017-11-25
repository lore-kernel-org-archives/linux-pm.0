From: Manikanta Maddireddy <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 03/10] PM / QoS: Fix device resume latency for non PM QoS
 devices
Date: Sun, 26 Nov 2017 01:16:42 +0530
Message-ID: <d6abebcf-5397-33d4-f41f-a96f3c81ac14@nvidia.com>
References: <1511538800-8275-1-git-send-email-mmaddireddy@nvidia.com>
 <1511538800-8275-4-git-send-email-mmaddireddy@nvidia.com>
 <CAJZ5v0ghcwSHdrbZd_=XA=tHz7=aTUVd66dHkMYRNyXpnqP84w@mail.gmail.com>
 <20171124203940.GA12811@mithrandir>
 <CAJZ5v0h1EdMV5u-5noMv_1_OpS13nH2NW_6Aua9+LMoWH0tL2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJZ5v0h1EdMV5u-5noMv_1_OpS13nH2NW_6Aua9+LMoWH0tL2w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Jon Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, vidyas-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, kthota-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PCI <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 25-Nov-17 5:32 AM, Rafael J. Wysocki wrote:
> On Fri, Nov 24, 2017 at 9:39 PM, Thierry Reding
> <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> On Fri, Nov 24, 2017 at 05:50:42PM +0100, Rafael J. Wysocki wrote:
>>> On Fri, Nov 24, 2017 at 4:53 PM, Manikanta Maddireddy
>>> <mmaddireddy-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> wrote:
>>>> In 'commit 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")'
>>>> PM QoS resume latency modified 0 as "no latency at all". However
>>>> dev_pm_qos_raw_read_value() returns 0 for devices which doesn't have
>>>> PM QoS constraints. This is blocking runtime suspend for these devices
>>>> in rpm_check_suspend_allowed(). Return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT
>>>> when PM QoS constraints are not available for a particular device.
>>>>
>>>> Fixes: 0cc2b4e5a020 ("PM / QoS: Fix device resume latency PM QoS")
>>>
>>> That commit has been reverted, so this patch is not applicable and
>>> therefore the whole series isn't.
>>>
>>> What kernel is it based off?
>>
>> It looks like this might have crept in via commit 0759e80b84e3 ("PM /
>> QoS: Fix device resume latency framework"). But checking more closely,
>> that commit actually incorporates this change already.
>>
>> According to the git log the correct commit for this showed up in
>> linux-next only today, which is probably why Manikanta missed it.
> 
> Well, it's been in the Linus' tree for a week, though.
> 
> Thanks,
> Rafael
> 
I dropped this patch in V2.

Thanks,
Manikanta
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
