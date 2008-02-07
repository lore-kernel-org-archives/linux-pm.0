From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Thu, 7 Feb 2008 23:51:21 +0100
Message-ID: <20080207225121.GE6096@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <200802060227.14385.rjw@sisk.pl> <200802070049.00461.rjw@sisk.pl> <200802072312.31430.rjw@sisk.pl> <20080207222845.GA6096@elf.ucw.cz> <47AB8A41.3040008@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761961AbYBGWvV@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47AB8A41.3040008@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Thu 2008-02-07 14:46:25, H. Peter Anvin wrote:
> Pavel Machek wrote:
>>
>> This is probably more acceptable version of beep; but there are
>> probably even better ways to clean it...
>>
>>         if (wakeup_header.realmode_flags & 4) {
>>                 inb(97);
>>                 outb(0, 0x80);
>>                 outb(3, 97);
>>                 outb(0, 0x80);
>>                 outb(-74, 67);
>>                 outb(0, 0x80);
>>                 outb(-119, 66);
>>                 outb(0, 0x80);
>>                 outb(15, 66);
>>         }
>>
>
> What is available at this point -- are BIOS calls still accessible; are 
> interrupts running?

No interrupts. BIOS calls work on some machines, but I'd like this to
work when bios does not.

Actually, matthieu's code is probably better to start from:

+/* one ISA cycle @8Mhz */
+#define PAUSE outb %al, $0x80
+#define WAIT_100MS \
+       movl $800000, %eax; \
+       2: \
+       PAUSE; \
+       dec %eax; \
+       jne 2b
+
+/* What's the PIT rate */
+#define COUNT 0xf89
 #define BEEP \
-       inb     $97, %al;       \
-       outb    %al, $0x80;     \
-       movb    $3, %al;        \
-       outb    %al, $97;       \
-       outb    %al, $0x80;     \
-       movb    $-74, %al;      \
-       outb    %al, $67;       \
-       outb    %al, $0x80;     \
-       movb    $-119, %al;     \
-       outb    %al, $66;       \
-       outb    %al, $0x80;     \
-       movb    $15, %al;       \
-       outb    %al, $66;
+       /* enable counter 2 */ \
+       inb             $0x61, %al;     \
+       PAUSE;  \
+       orb     $3, %al; \
+       outb    %al, $0x61;     \
+       PAUSE;  \
+       /* set command for counter 2, 2 byte write */ \
+       movb    $0xB6, %al;     \
+       outb    %al, $0x43;     \
+       PAUSE;  \
+       /* select desired HZ */ \
+       movb    $(COUNT & 0xff), %al; \
+       outb    %al, $0x42;     \
+       PAUSE;  \
+       movb    $(COUNT >> 8), %al;     \
+       outb    %al, $0x42; \
+       WAIT_100MS; \
+       /* disable counter 2 */ \
+       inb             $0x61, %al;     \
+       PAUSE;  \
+       andb    $0xFC, %al; \
+       outb    %al, $0x61; \
+       WAIT_100MS
+
+#define CBEEP \
+       testl   $4, realmode_flags - wakeup_code; \
+       jz      1f; \
+       BEEP; \
+1:

...because it allows user to compute number of beeps.
							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
