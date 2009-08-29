From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: ACPI locks hardware devices when it doesn't detect
	vista
Date: Sat, 29 Aug 2009 03:40:53 +0300
Message-ID: <1251506453.28828.0.camel__30705.6580124938$1251506519$gmane$org@maxim-laptop>
References: <1250945310.14167.150.camel@maxim-laptop>
	<1251503638.17451.14.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1251503638.17451.14.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.linux-foundation.org>
Cc: Mairo <rety@poczta.onet.pl>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Oh, and cc linux-acpi....

On Sat, 2009-08-29 at 02:53 +0300, Maxim Levitsky wrote:
> On Sat, 2009-08-22 at 15:48 +0300, Maxim Levitsky wrote:
> > Hi,
> > 
> > <joke>
> > This should be brought to a Microsoft antitrust case...
> > </joke>
> > 
> > 
> > Today many notebooks ship with a embedded infrared receiver.
> > In Vista there is new subsystem that decodes these signals.
> > (of course it works only with Microsoft Certificated Remotes (TM)...)
> > 
> > The receiver is usually presented to system as a pnp device 
> > (using acpi tables)
> > 
> > It turns out that some bioses actually use the OSI, ACPI feature of the
> > operation system to detect if running inside Vista. If not they disable
> > the infrared receiver.
> > 
> >             Device (MIR)
> >             {
> >                 Name (_HID, EisaId ("ENE0100"))
> >                 Method (_STA, 0, NotSerialized)
> >                 {
> >                     If (LAnd (MCIR, LEqual (OSYS, 0x07D6)))
> >                     {
> >                         Return (0x0F)
> >                     }
> >                     Else
> >                     {
> >                         Store (Zero, ^^LPCB.IOR2)
> >                         Return (Zero)
> >                     }
> >                 }
> > 
> > 	.......
> > 
> 
> >     Scope (_SB)
> >     {
> >         Method (_INI, 0, NotSerialized)
> >         {
> 		....
> 
> >             If (CondRefOf (_OSI, Local0))
> >             {
> >                 If (_OSI ("Linux"))
> >                 {
> >                     Store (One, LINX)
> >                     Store (Zero, ECDY)
> >                 }
> 
>                   ..........
> > 
> 
> >                 If (_OSI ("Windows 2006"))
> >                 {
> >                     Store (0x07D6, OSYS)
> >                 }
>                   .......
> 
> 
> I have finally managed to find root case of this problem.
> 
> Indeed the _STA method of infrared receiver is called before the _INI of
> _SB.
> 
> The problem lies in acpi_bus_init()
> 	/*
> 	 * ACPI 2.0 requires the EC driver to be loaded and work before
> 	 * the EC device is found in the namespace (i.e. before acpi_initialize_objects()
> 	 * is called).
> 	 *
> 	 * This is accomplished by looking for the ECDT table, and getting
> 	 * the EC parameters out of that.
> 	 */
> 
> 	status = acpi_ec_ecdt_probe();
> 	/* Ignore result. Not having an ECDT is not fatal. */
> 
> 	status = acpi_initialize_objects(ACPI_FULL_INITIALIZATION);
> 	if (ACPI_FAILURE(status)) {
> 		printk(KERN_ERR PREFIX "Unable to initialize ACPI objects\n");
> 		goto error1;
> 	}
>         .......
> 
> 
> on Mairo's system (just as well as on mine) there is no ECDT.
> Thus, acpi_ec_ecdt_probe() triggers a acpi namespace walk, 
> which in turn triggers invocation on _STA (which is supposed to be
> harmless, but the <beep>, the bios developers produce doesn't seem to
> meet this criteria....).
> 
> And this is done before running _INI methods, which are run just later,
> in acpi_initialize_objects.
> 
> I suspect that many systems use _SB._INI to test the OS version, thus
> this behavior needs to be revised.
> 
> The fact that this (as usual) works in windows suggest that it might  be
> good to look up the ECDT table before acpi_initialize_objects, but if
> not found, look up the EC later.
> 
> On my system, although I have tried to reproduce this bug, I couldn't,
> and I know now why: It just so happens that on my system CIR device is
> listed in acpi tables after the EC, but on Mairo's system EC is just
> first device.
> 
> Maybe we can add a 'walk only' function, that walks the namespace, but
> doesn't touch the _STA, and use it to find the EC there?
> 
> Looking for comments,
> 	Best regards,
> 		Maxim Levitsky
> 
