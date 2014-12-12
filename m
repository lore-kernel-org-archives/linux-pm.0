From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] ACPI and power management updates for 3.19-rc1
Date: Fri, 12 Dec 2014 15:42:07 +0100
Message-ID: <1589257.Va5eEYbcUY@vostro.rjw.lan>
References: <CAJZ5v0i3UhvaAu9JV_BuB0fPFmHAa_NdX+eXYBnAHcsiaVOw9g@mail.gmail.com> <CA+55aFx+8gKsDSDKSAxB4+JuL_M22uuHDmzSfsv1qJ=dSZ3-ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+55aFx+8gKsDSDKSAxB4+JuL_M22uuHDmzSfsv1qJ=dSZ3-ww@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, December 11, 2014 07:59:20 PM Linus Torvalds wrote:
> On Mon, Dec 8, 2014 at 4:21 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > Also the ACPI core is now going to support the _DEP configuration
> > information in a limited way.
> 
> Hmm. That seems to be the cause of this annoying new message:
> 
>     ...
>     ACPI: Using IOAPIC for interrupt routing
>     PCI: Using host bridge windows from ACPI; if necessary, use
> "pci=nocrs" and report a bug
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:00: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:01: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:02: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:03: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:04: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:05: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:06: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb200)
>     acpi LNXCPU:07: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb840)
>     acpi device:27: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb840)
>     acpi device:3f: Failed to evaluate _DEP.
>     ACPI: [Package] has zero elements (ffff88040ccdb8c0)
>     acpi LNXVIDEO:00: Failed to evaluate _DEP.
>     ACPI: Power Resource [FN00] (off)
>     ...
> 
> which doesn't seem to hinder anything from working, but is extremely
> annoying because it's printed out as some super-important "KERN_ERR
> message of Doom!"
> 
> I don't see why incomplete ACPI tables would *ever* be "KERN_ERR"
> level messages, but I particularly don't see it when it seems to be
> our own meaningless fake entries.

Right the KERN_ERR level in there is silly.  Overlooked in review, sorry
about that.  The patch below should take care of it.

Some of the messages you're seeing are from acpi_evaluate_reference(),
though, and are not really useful too.  I'll cut a separate patch for
these.

Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / scan: Change the level of _DEP-related messages to KERN_DEBUG

Two _DEP-related failure messages are printed as dev_err() which is
unnecessary and annoying.  Use dev_dbg() to print them.

While at it, one of the messages should actually say it is related
to _DEP, so modify it to that effect.

Fixes: 40e7fcb19293 (ACPI: Add _DEP support to fix battery issue on Asus T100TA)
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/scan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/acpi/scan.c
===================================================================
--- linux-pm.orig/drivers/acpi/scan.c
+++ linux-pm/drivers/acpi/scan.c
@@ -2214,7 +2214,7 @@ static void acpi_device_dep_initialize(s
 	status = acpi_evaluate_reference(adev->handle, "_DEP", NULL,
 					&dep_devices);
 	if (ACPI_FAILURE(status)) {
-		dev_err(&adev->dev, "Failed to evaluate _DEP.\n");
+		dev_dbg(&adev->dev, "Failed to evaluate _DEP.\n");
 		return;
 	}
 
@@ -2224,7 +2224,7 @@ static void acpi_device_dep_initialize(s
 
 		status = acpi_get_object_info(dep_devices.handles[i], &info);
 		if (ACPI_FAILURE(status)) {
-			dev_err(&adev->dev, "Error reading device info\n");
+			dev_dbg(&adev->dev, "Error reading _DEP device info\n");
 			continue;
 		}
 

