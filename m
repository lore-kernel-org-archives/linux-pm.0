From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [ath5k-devel]  PCI hotplug v.s. suspend
Date: Thu, 18 Jun 2009 12:51:26 +0100
Message-ID: <4A3A2A3E.7090300__28881.1537357562$1245325964$gmane$org@tuffmail.co.uk>
References: <Pine.LNX.4.44L0.0906151035560.5057-100000@iolanthe.rowland.org>
	<200906152158.30989.rjw@sisk.pl>
	<20090616010101.GA11412@hash.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090616010101.GA11412@hash.localnet>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bob Copeland <me@bobcopeland.com>
Cc: linux-pci@vger.kernel.org, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, ath5k-devel@venema.h4ckr.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Bob Copeland wrote:
> On Mon, Jun 15, 2009 at 09:58:30PM +0200, Rafael J. Wysocki wrote:
>   
>> On Monday 15 June 2009, Alan Stern wrote:
>>     
>>> I'm not sure whether the example is trustworthy.  There was some
>>> discussion quite a while ago regarding whether drivers should free
>>> their IRQs during suspend, but I don't remember what the outcome was.
>>>       
>> No, they shouldn't.
>>
>> That's why we do the entire suspend_device_irqs() thing etc.
>>     
>
> So, ath5k needs something like the following?
>
> diff --git a/drivers/net/wireless/ath/ath5k/base.c b/drivers/net/wireless/ath/ath5k/base.c
> index 55f7de0..0107cd6 100644
> --- a/drivers/net/wireless/ath/ath5k/base.c
> +++ b/drivers/net/wireless/ath/ath5k/base.c
> @@ -665,7 +665,6 @@ ath5k_pci_suspend(struct pci_dev *pdev, pm_message_t state)
>  
>  	ath5k_led_off(sc);
>  
> -	free_irq(pdev->irq, sc);
>  	pci_save_state(pdev);
>  	pci_disable_device(pdev);
>  	pci_set_power_state(pdev, PCI_D3hot);
> @@ -686,18 +685,8 @@ ath5k_pci_resume(struct pci_dev *pdev)
>  	if (err)
>  		return err;
>  
> -	err = request_irq(pdev->irq, ath5k_intr, IRQF_SHARED, "ath", sc);
> -	if (err) {
> -		ATH5K_ERR(sc, "request_irq failed\n");
> -		goto err_no_irq;
> -	}
> -
>  	ath5k_led_enable(sc);
>  	return 0;
> -
> -err_no_irq:
> -	pci_disable_device(pdev);
> -	return err;
>  }
>  #endif /* CONFIG_PM */
>  
>   

Unfortunately this makes it worse.  My eeepc-laptop hacks are now in
wireless-testing.  If I apply the above patch to wireless-testing and
"remove" the device while suspended, I get a soft hang on resume. 
Suspending without removal works fine.

I can see a BUG if I boot with no_console_suspend

Unable to handle kernel NULL pointer dereference
IP: klist_put
Tainted: G W
Process s2disk

Call trace:
? klist_del
? device_del
? device_unregister
? pci_stop_dev
? pci_stop_bus
? pci_remove_device
? eeepc_rfkill_hotplug [eeepc_laptop]
? eeepc_hotk_resume [eeepc_laptop]
? acpi_device_resume
? device_resume
? hibernation_snapshot
? release_console_sem
? snapshot_ioctl
? snapshot_ioctl
? vfs_ioctl
? do_vfs_ioctl
? n_tty_write
? vfs_write
? sys_ioctl
? syscall_call
