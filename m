From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/3] ACPI / sleep: Support power button wakeup from S2I on recent Dell laptops
Date: Mon, 12 Jun 2017 22:34:57 +0200
Message-ID: <1872413.KDFIRZOQLU@aspire.rjw.lan>
References: <CA+kEDGHNOQboMy34=EmH6zVSgtdVz1afOz5hwx5HBKshWhackA@mail.gmail.com> <88366b425cce41358ae8f88e43f3d201@ausx13mpc120.AMER.DELL.COM> <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <CA+kEDGEXEYEV+tGnswvHsFmOX5W_GAYPTYxk0YUUt0D1pdr92A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: =?ISO-8859-1?Q?J=E9r=F4me?= de Bretagne <jerome.debretagne@gmail.com>
Cc: Mario.Limonciello@dell.com, "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Darren Hart <dvhart@infradead.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Monday, June 12, 2017 10:35:50 PM Jérôme de Bretagne wrote:
> > I don't see HEBC in the ASL for the 7275.  It would be good to provide
> > this information across both of the BIOS versions (working and non-working).
> >
> > As well as what
> >         status = acpi_evaluate_integer(handle, "BTNC", NULL, &button_cap);
> > evaluates as on both too.
> 
> I'll provide both BTNC and HEBC log results to compare, with both BIOS
> versions, a bit later today.
> 
> > Since this platform shipped with Win 8.1 initially rather than Win10,
> > It's possible 5 button array was not part of the INT33D5 spec at that time
> > and wasn't used by the Windows Intel HID filter driver.
> >
> > My suspicion:
> > Win 8.1 didn't support 5 button array definition yet and those events that
> > are normally part of 5 button array (as detected by bit 17) were coming
> > across as regular HID event codes (like you were seeing 0xCE and 0xCF
> > unknown events from debug log when OS was running).
> 
> That was my assumption also, since my earlier 3-liner patch was doing
> this exactly: trying to wake up on a regular 0xCE event. And it did work.

OK

Can you try the patch below, please?

---
 drivers/platform/x86/intel-hid.c |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/platform/x86/intel-hid.c
===================================================================
--- linux-pm.orig/drivers/platform/x86/intel-hid.c
+++ linux-pm/drivers/platform/x86/intel-hid.c
@@ -270,12 +270,17 @@ static int intel_hid_probe(struct platfo
 	}
 
 	/* Setup 5 button array */
-	status = acpi_evaluate_integer(handle, "HEBC", NULL, &event_cap);
-	if (ACPI_SUCCESS(status) && (event_cap & 0x20000)) {
-		dev_info(&device->dev, "platform supports 5 button array\n");
-		err = intel_button_array_input_setup(device);
-		if (err)
-			pr_err("Failed to setup Intel 5 button array hotkeys\n");
+	if (acpi_has_method(handle, "BTNC") && acpi_has_method(handle, "BTNE")) {
+		unsigned long long event_cap;
+
+		status = acpi_evaluate_integer(handle, "HEBC", NULL, &event_cap);
+		if ((ACPI_SUCCESS(status) && (event_cap & 0x20000)) ||
+		    status == AE_NOT_FOUND) {
+			dev_info(&device->dev, "5-button array supported\n");
+			err = intel_button_array_input_setup(device);
+			if (err)
+				dev_dbg(&device->dev, "5-button array setup failure\n");
+		}
 	}
 
 	status = acpi_install_notify_handler(handle,

