From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: BISECTED: 2.6.29-rc2 regression: hibernation hang on
	eeepc-701
Date: Thu, 22 Jan 2009 13:23:05 +0000
Message-ID: <49787339.7080900__28615.6676630073$1232630870$gmane$org@tuffmail.co.uk>
References: <9b2b86520901180345j434eacbdn7386958991ee50b@mail.gmail.com>
	<497858E1.5070303@tuffmail.co.uk> <200901221344.16178.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901221344.16178.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org, kernel-testers@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Thursday 22 January 2009, Alan Jenkins wrote:
>   
>> Alan Jenkins wrote:
>>     
>>> Hibernation hangs just after writing the image.  With s2disk I can see
>>> this from the console messages.  The same hang happens with kernel
>>> swsusp ('echo disk | sudo tee /sys/power/state'), and I can see that
>>> the image has been written from the HDD led.
>>>
>>> In either case, I can still hard-power-off and resume from hibernation.
>>>
>>> It doesn't hang if I use the shutdown method (either 'echo shutdown |
>>> sudo tee /sys/power/disk' or  's2disk -P "shutdown method=shutdown"').
>>>   
>>>       
>> I've bisected this to commit 571ff7584bb9e05fca0eb79752ae55a46faf3a98. 
>> It doesn't revert cleanly from RC2.
>>
>> I think it's distinct from the other two reported suspend regressions. 
>> I'm not using acpi-cpufreq, and the issue doesn't affect resume.
>>     
>
> It looks distinct.
>
> Do you suspend this box to RAM and does it work?
>   
Yes, I do use STR on it occasionally, and it still works in RC2.

> Please retest with the appended patch applied.
>   

That fixes it.

Thanks!
Alan

> Thanks,
> Rafael
>
>
> ---
>  drivers/pci/pci-driver.c |    5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> Index: linux-2.6/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-2.6.orig/drivers/pci/pci-driver.c
> +++ linux-2.6/drivers/pci/pci-driver.c
> @@ -660,7 +660,10 @@ static int pci_pm_poweroff(struct device
>  	if (pci_has_legacy_pm_support(pci_dev))
>  		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
>  
> -	if (drv && drv->pm && drv->pm->poweroff) {
> +	if (!drv || !drv->pm)
> +		return 0;
> +
> +	if (drv->pm->poweroff) {
>  		error = drv->pm->poweroff(dev);
>  		suspend_report_result(drv->pm->poweroff, error);
>  	}
>
>   
