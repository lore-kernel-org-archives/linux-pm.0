From: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH/RFC] PCI prepare/activate instead of enable to avoid IRQ
 storm and rogue DMA access
Date: Thu, 15 Mar 2007 11:39:58 +0900
Message-ID: <45F8B1FE.5060406@gmail.com>
References: <20070314152302.GB15600@htj.dyndns.org> <p73fy878pmg.fsf@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <p73fy878pmg.fsf@bingen.suse.de>
Sender: linux-ide-owner@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: gregkh@suse.de, Jeff Garzik <jeff@garzik.org>, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, michal.k.k.piotrowski@gmail.com, linux-ide@vger.kernel.org, tglx@linutronix.de, shemminger@linux-foundation.org, mlord@pobox.com, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Andi Kleen wrote:
> Tejun Heo <htejun@gmail.com> writes:
>> Let's assume there's a device which shares its INTX IRQ line with
>> another device and the other one is already initialized.  During boot,
>> due to BIOS's fault, bad hardware design or sheer bad luck, the device
>> has got a pending IRQ.
> 
> This seems to be also common after kexec during kexec crashdumps
> where the device just continues doing what it did before the crash.
> 
>> This patch expands the pci_set_master() approach.  Instead of enabling
>> the device in one go, it's done in two steps - prepare and activate.
>> 'prepare' enables access to PCI configuration,
> 
> I hope there aren't any new erratas triggered by this. Perhaps it would
> make sense to add some paranoia sleeps at least before touching other
> state? 

Do you mean between disabling IRQ mechanisms and enabling PCI device in 
pcim_prepare_device()?

Thanks.

-- 
tejun
