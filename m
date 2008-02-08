From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:41:45 +0100
Message-ID: <20080208214145.GJ12923@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl> <200802072312.31430.rjw@sisk.pl> <20080207222833.GA23004@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759815AbYBHVlx@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080207222833.GA23004@uranus.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>, "H. Peter Anvin" <hpa@zytor.com>
List-Id: linux-pm@vger.kernel.org

> Do we never need data from a .h file?
> If we do name it wakeup.lds.S and kbuild
> will fix it (assuming we have wakeup.lds
> as a prerequisite where it is needed.

Ok, I got it to work... but notice the ugly #undef :-(.

							Pavel

diff --git a/arch/x86/kernel/acpi/realmode/Makefile b/arch/x86/kernel/acpi/realmode/Makefile
index b239f0f..0e4742b 100644
--- a/arch/x86/kernel/acpi/realmode/Makefile
+++ b/arch/x86/kernel/acpi/realmode/Makefile
@@ -46,7 +46,10 @@ KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__AS
 WAKEUP_OBJS = $(addprefix $(obj)/,$(wakeup-y))
 
 LDFLAGS_wakeup.elf	:= -T
-$(obj)/wakeup.elf: $(src)/wakeup.ld $(WAKEUP_OBJS) FORCE
+
+CPPFLAGS_wakeup.lds += -P -C
+
+$(obj)/wakeup.elf: $(src)/wakeup.lds $(WAKEUP_OBJS) FORCE
 	$(call if_changed,ld)
 
 OBJCOPYFLAGS_wakeup.bin	:= -O binary
diff --git a/arch/x86/kernel/acpi/realmode/wakeup.ld b/arch/x86/kernel/acpi/realmode/wakeup.ld
deleted file mode 100644
--- /dev/null
+++ b/arch/x86/kernel/acpi/realmode/wakeup.lds.S
@@ -0,0 +1,62 @@
+/*
+ * wakeup.ld
+ *
+ * Linker script for the real-mode wakeup code
+ */
+#undef i386
+
+OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
+OUTPUT_ARCH(i386)
+ENTRY(_start)
+
+SECTIONS
+{
+	. = 0x3f00;
+	.header : {
+		 *(.header)
+	}
+
+	. = 0;
+	.text : {
+		 *(.text*)
+	}
+
+	. = ALIGN(16);
+	.rodata : {
+		*(.rodata*)
+	}
+
+	.videocards : {
+		video_cards = .;
+		*(.videocards)
+		video_cards_end = .;
+	}
+
+	. = ALIGN(16);
+	.data : {
+		 *(.data*)
+	}
+
+	.signature : {
+		end_signature = .;
+		LONG(0x65a22c82)
+	}
+
+	. = ALIGN(16);
+	.bss :	{
+		__bss_start = .;
+		*(.bss)
+		__bss_end = .;
+	}
+
+	. = ALIGN(16);
+	_end = .;
+
+	/DISCARD/ : {
+		*(.note*)
+	}
+
+	/* Adjust this as appropriate */
+	/* This allows 4 pages (16K) */
+	. = ASSERT(_end <= 0x4000, "Wakeup too big!");
+}


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
