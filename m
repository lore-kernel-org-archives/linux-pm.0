From: Jeff Garzik <jeff@garzik.org>
Subject: Re: [RFC PATCH] AHCI: speed up resume
Date: Fri, 11 Jul 2008 09:49:45 -0400
Message-ID: <487764F9.20908@garzik.org>
References: <1215074882.3214.15.camel@rzhang-dt.sh.intel.com>	
	<486D8F88.9000904@kernel.org>
	<1215149537.3068.18.camel@rzhang-dt.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1215149537.3068.18.camel@rzhang-dt.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Tejun Heo <tj@kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Zhang Rui wrote:
> On Fri, 2008-07-04 at 10:48 +0800, Tejun Heo wrote:
>> Hello, Zhang.
>>
>> Zhang Rui wrote:
>>> During S3 resume, AHCI driver sleeps 1 second to wait for the HBA
>> reset
>>> to finish. This is luxurious, :)
>>>
>>> According to the AHCI 1.2 spec, We should poll the HOST_CTL
>> register,
>>> and return error if the host reset is not finished within 1 second.
>>>
>>> Test results show that the HBA reset can be done quickly(in usecs).
>>> And this patch may save nearly 1 second during resume.
>>>
>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>> --
>>>  drivers/ata/ahci.c |   17 ++++++++++++++---
>>>  1 file changed, 14 insertions(+), 3 deletions(-)
>>>
>>> Index: linux-2.6/drivers/ata/ahci.c
>>> ===================================================================
>>> --- linux-2.6.orig/drivers/ata/ahci.c 2007-05-03 11:06:33.000000000
>> +0800
>>> +++ linux-2.6/drivers/ata/ahci.c      2008-07-02 16:25:54.000000000
>> +0800
>>> @@ -1073,18 +1073,29 @@
>>>
>>>       /* global controller reset */
>>>       if (!ahci_skip_host_reset) {
>>> +             int delay = msecs_to_jiffies(1000);
>>> +             int timeout;
>>> +
>>>               tmp = readl(mmio + HOST_CTL);
>>>               if ((tmp & HOST_RESET) == 0) {
>>>                       writel(tmp | HOST_RESET, mmio + HOST_CTL);
>>>                       readl(mmio + HOST_CTL); /* flush */
>>>               }
>>>
>>> -             /* reset must complete within 1 second, or
>>> +             /*
>>> +              * to perform host reset, OS should set HOST_RESET
>>> +              * and poll until this bit is read to be "0"
>>> +              * reset must complete within 1 second, or
>>>                * the hardware should be considered fried.
>>>                */
>>> -             ssleep(1);
>>> +             timeout = jiffies + delay;
>>> +             while (jiffies < timeout) {
>>> +                     tmp = readl(mmio + HOST_CTL);
>>> +                     if (!(tmp & HOST_RESET))
>>> +                             break;
>>> +                     cpu_relax();
>>> +             }
>> Looks good in principle.  Just two things...
>>
>> 1. Please don't busy-loop.  e.g. No one would notice 10ms delay
>> between
>> polls.
>>
>> 2. Please use ata_wait_register().
>>
> Thanks for review, refreshed patch attached. :)
> 
> From: Zhang Rui <rui.zhang@intel.com>
> 
> During resume, sleep 1 second to wait for the HBA reset
> to finish is a waste of time.
> 
> According to the AHCI 1.2 spec,
> We should poll the HOST_CTL register,
> and return error if the host reset is not
> finished within 1 second.
> 
> Test results show that the HBA reset can be done quickly(in usecs).
> And this patch may save nearly 1 second during resume.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> --
>  drivers/ata/ahci.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6/drivers/ata/ahci.c
> ===================================================================
> --- linux-2.6.orig/drivers/ata/ahci.c	2008-07-04 09:49:05.000000000 +0800
> +++ linux-2.6/drivers/ata/ahci.c	2008-07-04 11:31:30.000000000 +0800
> @@ -1079,12 +1079,15 @@
>  			readl(mmio + HOST_CTL); /* flush */
>  		}
>  
> -		/* reset must complete within 1 second, or
> +		/*
> + 		 * to perform host reset, OS should set HOST_RESET
> +		 * and poll until this bit is read to be "0".
> + 		 * reset must complete within 1 second, or
>  		 * the hardware should be considered fried.
>  		 */
> -		ssleep(1);
> +		tmp = ata_wait_register(mmio + HOST_CTL, HOST_RESET,
> +					HOST_RESET, 10, 1000);
>  
> -		tmp = readl(mmio + HOST_CTL);
>  		if (tmp & HOST_RESET) {
>  			dev_printk(KERN_ERR, host->dev,
>  				   "controller reset failed (0x%x)\n", tmp);
> 

applied
