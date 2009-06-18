From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [ath5k-devel]  PCI hotplug v.s. suspend
Date: Thu, 18 Jun 2009 22:18:02 +0100
Message-ID: <4A3AAF0A.9020707__41477.6095458821$1245359958$gmane$org@tuffmail.co.uk>
References: <Pine.LNX.4.44L0.0906181437090.3129-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0906181437090.3129-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Bob Copeland <me@bobcopeland.com>, ath5k-devel@venema.h4ckr.net, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, linux-pci@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Alan Stern wrote:
> On Thu, 18 Jun 2009, Alan Jenkins wrote:
>
>   
>> Unfortunately this makes it worse.  My eeepc-laptop hacks are now in
>> wireless-testing.  If I apply the above patch to wireless-testing and
>> "remove" the device while suspended, I get a soft hang on resume. 
>>     
>
> Is this different from the behavior without the patch?  (I don't see 
> how it could be.)
>   

Ow.  No, the free_irq patch doesn't cause this bug.  I missed testing
this case after adding a workaround for an even more obscure issue :-(.

I have a good idea how eeepc-laptop could cause a double-free error.  I
suspect we originally got away with trying to call pci_remove_device()
twice, but it's not actually legal, and my workaround caused two
attempts to happen much closer together.

I'll fix it tomorrow and re-test.  With _both_ of my nasty scenarios
this time (and the normal ones) - I should really make a checklist :-).

>> Suspending without removal works fine.
>>
>> I can see a BUG if I boot with no_console_suspend
>>
>> Unable to handle kernel NULL pointer dereference
>> IP: klist_put
>> Tainted: G W
>> Process s2disk
>>
>> Call trace:
>> ? klist_del
>> ? device_del
>> ? device_unregister
>> ? pci_stop_dev
>> ? pci_stop_bus
>> ? pci_remove_device
>> ? eeepc_rfkill_hotplug [eeepc_laptop]
>> ? eeepc_hotk_resume [eeepc_laptop]
>> ? acpi_device_resume
>> ? device_resume
>> ? hibernation_snapshot
>>     
>
> This should be doing more or less the same thing as if you removed the 
> device while the system was running.  Or is it not hot-unpluggable?
>
> Alan Stern
>   

Outside of suspend, I can hot-unplug the device alright.  I'm blaming my
hotplug driver resume handler.

Thanks
Alan
