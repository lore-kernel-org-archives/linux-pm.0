From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 20:34:05 +0100
Message-ID: <200611012034.06128.ak@suse.de>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org> <200611011825.47710.ak@suse.de> <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Ernst Herzberg <earny@net4u.de>, Len Brown <lenb@kernel.org>, Adrian Bunk <bunk@stusta.de>, Hugh Dickins <hugh@veritas.com>, Pavel Machek <pavel@suse.cz>, Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linux-pm@osdl.org, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 01 November 2006 19:25, Linus Torvalds wrote:
> 
> On Wed, 1 Nov 2006, Andi Kleen wrote:
> >
> > Ok please revert the i386 patch for now then if it fixes the ThinkPads. 
> > The x86-64 version should be probably fixed too, but doesn't cleanly. I will 
> > send you later a patch to fix this there properly.
> 
> Actually, I should have just fixed the ordering. I did some cleanups too, 
> but those are unrelated (except in the sense that I wanted to look at the 
> assembly code, and the cleanups made the code generation at least half-way 
> sane!)

Thanks.

Some of them are still different than the old code now, but that's probably
ok.

But the irq race you pointed out is still there (unless you fixed it in a differnet patch) 
I don't know if it makes
a difference, but here is a patch to fix it.

-Andi

Fix race in IO-APIC routing entry setup.

Interrupt could happen between setting the IO-APIC entry
and setting its interrupt data.

Pointed out by Linus.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/arch/i386/kernel/io_apic.c
===================================================================
--- linux.orig/arch/i386/kernel/io_apic.c
+++ linux/arch/i386/kernel/io_apic.c
@@ -1298,10 +1298,12 @@ static void __init setup_IO_APIC_irqs(vo
 			if (!apic && (irq < 16))
 				disable_8259A_irq(irq);
 		}
+		local_irq_save(flags);
 		ioapic_write_entry(apic, pin, entry);
-		spin_lock_irqsave(&ioapic_lock, flags);
+		spin_lock(&ioapic_lock);
 		set_native_irq_info(irq, TARGET_CPUS);
-		spin_unlock_irqrestore(&ioapic_lock, flags);
+		spin_unlock(&ioapic_lock);
+		local_irq_restore(flags);
 	}
 	}
 
