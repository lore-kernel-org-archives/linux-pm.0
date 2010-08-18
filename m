From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] SATA / AHCI: Do not play with the link PM during suspend
 to RAM
Date: Wed, 18 Aug 2010 08:12:24 +0200
Message-ID: <4C6B79C8.7080602@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C6A6145.7020707@gmail.com> <201008171229.28917.stephan.diestelhorst@amd.com> <201008171251.29441.stephan.diestelhorst@amd.com> <4C6AA50F.3090801@gmail.com> <AANLkTin2XPHXL_o9hHz9f4beTYEx+isX+PaFRkMMiYHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <AANLkTin2XPHXL_o9hHz9f4beTYEx+isX+PaFRkMMiYHQ@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Stephan Diestelhorst <stephan.diestelhorst@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, stephan.diestelhorst@amd.com
List-Id: linux-pm@vger.kernel.org

Hello,

On 08/17/2010 11:28 PM, Stephan Diestelhorst wrote:
> 2010/8/17 Tejun Heo <htejun@gmail.com>:
>> On 08/17/2010 12:51 PM, Stephan Diestelhorst wrote:
>>> I *think* I have applied the patch correctly. Please find a copy of
>>> "git show" in the build directory attached. This should be the right
>>> thing, shouldn't it?
>>
>>> Maybe I forgot to speify a particular debug option / verbosity?
>>
>>> I've also confirmed that the "XXX ahci_set_ipm" is present in
>>> libahci.ko. So either I've screwed up badly when compiling the initrd,
>>> the code is not executed or the printout does not make it into any
>>> logfile anymore.
>>
>> Yeah, that's weird.  You're enabling IPM, right?
> 
> Erm... Honestly, I have no clue. What is IPM? How do I enable it? This is a
> Kubuntu Lucid 10.04 distribution, and I have not touched too much. In
> particular, the kernels have been from upstream git, just with the Ubuntu config
> copied over.
> 
> Maybe it is just not enabled? I am guessing that IPM might be IDE power
> management? Or intelligent, integrated? Google turns up this email thread
> as one of the first hits and nothing else conclusive.

It's interface power management, also called link power management.
You can check whether it's enabled by

$ cat /sys/class/scsi_host/host0/link_power_management_policy

If it says max_performance, it's disabled.  If it says anything else,
it's enabled.

Thanks.

-- 
tejun
