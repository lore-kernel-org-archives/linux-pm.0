From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
Date: Wed, 1 Nov 2006 10:25:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611011003270.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
	<20061101055435.GB4933@mellanox.co.il>
	<Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
	<200611011825.47710.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200611011825.47710.ak@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, Ernst Herzberg <earny@net4u.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Hugh Dickins <hugh@veritas.com>, Martin Lorenz <martin@lorenz.eu.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 1 Nov 2006, Andi Kleen wrote:
>
> Ok please revert the i386 patch for now then if it fixes the ThinkPads. =

> The x86-64 version should be probably fixed too, but doesn't cleanly. I w=
ill =

> send you later a patch to fix this there properly.

Actually, I should have just fixed the ordering. I did some cleanups too, =

but those are unrelated (except in the sense that I wanted to look at the =

assembly code, and the cleanups made the code generation at least half-way =

sane!)

I've pushed out the changes, but here is the part that may or may not =

matter for anybody who wants to test it if they don't use git or if it =

hasn't mirrored out yet. Michael? Martin?

Andi: I think the patches should work pretty much as-is for x86-64 too, =

since all the issues would seem to be similar. =


I'm not entirely happy with "ioapic_write_entry()" now either (if we =

change an entry that was already unmasked, we should probably mask it =

first by writing the low word with the mask bit set, then write the high =

word, and then write the low word again), but =


 - this makes us match the ordering we _used_ to have, so if the cleanup =

   broke things for people, this should unbreak it, and at least not be =

   any worse than it used to be.

 - when we write new unmasked entries, they all _should_ have been masked =

   before, so hopefully the "change a unmasked entry while it's unmasked" =

   case doesn't actually ever happen. But I didn't actually _check_.

Somebody should look into that case. Does anybody feel like they want to =

learn more about the IO-APIC? Halloween is over and gone, but if you want =

to scare small children _next_ year, telling them about the IO-APIC is =

likely a good strategy.

		Linus

---
commit f9dadfa71bc594df09044da61d1c72701121d802
Author: Linus Torvalds <torvalds@macmini.osdl.org>
Date:   Wed Nov 1 10:05:35 2006 -0800

    i386: write IO APIC irq routing entries in correct order
    =

    Since the "mask" bit is in the low word, when we write a new entry, we
    need to write the high word first, before we potentially unmask it.
    =

    The exception is when we actually want to mask the interrupt, in which
    case we want to write the low word first to make sure that the high word
    doesn't change while the interrupt routing is still active.
    =

    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

diff --git a/arch/i386/kernel/io_apic.c b/arch/i386/kernel/io_apic.c
index eb10bd5..507983c 100644
--- a/arch/i386/kernel/io_apic.c
+++ b/arch/i386/kernel/io_apic.c
@@ -147,12 +147,34 @@ static struct IO_APIC_route_entry ioapic
 	return eu.entry;
 }
 =

+/*
+ * When we write a new IO APIC routing entry, we need to write the high
+ * word first! If the mask bit in the low word is clear, we will enable
+ * the interrupt, and we need to make sure the entry is fully populated
+ * before that happens.
+ */
 static void ioapic_write_entry(int apic, int pin, struct IO_APIC_route_ent=
ry e)
 {
 	unsigned long flags;
 	union entry_union eu;
 	eu.entry =3D e;
 	spin_lock_irqsave(&ioapic_lock, flags);
+	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
+	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
+	spin_unlock_irqrestore(&ioapic_lock, flags);
+}
+
+/*
+ * When we mask an IO APIC routing entry, we need to write the low
+ * word first, in order to set the mask bit before we change the
+ * high bits!
+ */
+static void ioapic_mask_entry(int apic, int pin)
+{
+	unsigned long flags;
+	union entry_union eu =3D { .entry.mask =3D 1 };
+
+	spin_lock_irqsave(&ioapic_lock, flags);
 	io_apic_write(apic, 0x10 + 2*pin, eu.w1);
 	io_apic_write(apic, 0x11 + 2*pin, eu.w2);
 	spin_unlock_irqrestore(&ioapic_lock, flags);
@@ -274,9 +296,7 @@ static void clear_IO_APIC_pin(unsigned i
 	/*
 	 * Disable it in the IO-APIC irq-routing table:
 	 */
-	memset(&entry, 0, sizeof(entry));
-	entry.mask =3D 1;
-	ioapic_write_entry(apic, pin, entry);
+	ioapic_mask_entry(apic, pin);
 }
 =

 static void clear_IO_APIC (void)
