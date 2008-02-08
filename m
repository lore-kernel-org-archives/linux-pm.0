From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:31:50 +0100
Message-ID: <20080208213150.GF12923@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl> <200802072312.31430.rjw@sisk.pl> <20080207222833.GA23004@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761210AbYBHVcb@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080207222833.GA23004@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-02-07 23:28:33, Sam Ravnborg wrote:
> > ===================================================================
> > --- /dev/null
> > +++ linux-2.6/arch/x86/kernel/acpi/realmode/wakeup.ld
> > @@ -0,0 +1,51 @@
> > +/*
> > + * wakeup.ld
> > + *
> > + * Linker script for the real-mode wakeup code
> > + */
> > +OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
> > +OUTPUT_ARCH(i386)
> > +ENTRY(_start)
> > +
> > +SECTIONS
> > +{
> > +	. = 0x3f00;
> > +	.header		: { *(.header) }
> 
> Can we please use C style in this file.
> Like this:

Commiting now :-).
						Pavel

diff --git a/arch/x86/kernel/acpi/realmode/wakeup.ld b/arch/x86/kernel/acpi/realmode/wakeup.ld
index 5dff2f0..1a1e755 100644
--- a/arch/x86/kernel/acpi/realmode/wakeup.ld
+++ b/arch/x86/kernel/acpi/realmode/wakeup.ld
@@ -10,31 +10,38 @@ ENTRY(_start)
 SECTIONS
 {
 	. = 0x3f00;
-	.header		: { *(.header) }
+	.header : {
+		 *(.header)
+	}
 
 	. = 0;
-	.text		: { *(.text*) }
+	.text : {
+		 *(.text*)
+	}
 
 	. = ALIGN(16);
-	.rodata		: { *(.rodata*) }
+	.rodata : {
+		*(.rodata*)
+	}
 
-	.videocards	: {
+	.videocards : {
 		video_cards = .;
 		*(.videocards)
 		video_cards_end = .;
 	}
 
 	. = ALIGN(16);
-	.data		: { *(.data*) }
+	.data : {
+		 *(.data*)
+	}
 
-	.signature	: {
+	.signature : {
 		end_signature = .;
 		LONG(0x65a22c82)
 	}
 
 	. = ALIGN(16);
-	.bss		:
-	{
+	.bss :	{
 		__bss_start = .;
 		*(.bss)
 		__bss_end = .;
@@ -43,7 +50,9 @@ SECTIONS
 	. = ALIGN(16);
 	_end = .;
 
-	/DISCARD/ : { *(.note*) }
+	/DISCARD/ : {
+		*(.note*)
+	}
 
 	/* Adjust this as appropriate */
 	/* This allows 4 pages (16K) */



> 
> {
> 	.header : {
> 		*(.header)
> 	}
> 
> It is not as short as the above but it pays of to keep
> an consistent style in the whole file and across
> different .lds files.
> 
> And for good measure name it wakeup.lds.
> 
> Do we never need data from a .h file?
> If we do name it wakeup.lds.S and kbuild
> will fix it (assuming we have wakeup.lds
> as a prerequisite where it is needed.
> 
> > +
> > +	. = 0;
> > +	.text		: { *(.text*) }
> > +
> > +	. = ALIGN(16);
> Why?
> > +	.rodata		: { *(.rodata*) }
> > +
> > +	.videocards	: {
> > +		video_cards = .;
> > +		*(.videocards)
> > +		video_cards_end = .;
> > +	}
> > +
> > +	. = ALIGN(16);
> Why?
> > +	.data		: { *(.data*) }
> > +
> > +	.signature	: {
> > +		end_signature = .;
> > +		LONG(0x65a22c82)
> > +	}
> > +
> > +	. = ALIGN(16);
> Why?
> > +	.bss		:
> > +	{
> > +		__bss_start = .;
> > +		*(.bss)
> > +		__bss_end = .;
> > +	}
> > +
> > +	. = ALIGN(16);
> Why?
> > +	_end = .;
> > +
> > +	/DISCARD/ : { *(.note*) }
> > +
> > +	/* Adjust this as appropriate */
> > +	/* This allows 4 pages (16K) */
> > +	. = ASSERT(_end <= 0x4000, "Wakeup too big!");
> PAGE_SIZE * 4?
> 
> 
> 	Sam

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
