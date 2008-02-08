From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [rft] s2ram wakeup moves to .c, could fix few machines
Date: Fri, 8 Feb 2008 22:35:56 +0100
Message-ID: <20080208213556.GH12923@elf.ucw.cz>
References: <20080205190600.GB11613@elf.ucw.cz> <20080207222845.GA6096@elf.ucw.cz> <47AB8A41.3040008@zytor.com> <200802072357.33293.rjw@sisk.pl> <47AB90C7.2070205@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759668AbYBHVf4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <47AB90C7.2070205@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Okay, this uses the iodelay as the timesource... here is the total 
> silliness (and totally untested, of course.)

Why untested? Testing suspend is easy ;-). s2ram from suspend.sf.net
tends to just work...
								Pavel

> static inline void io_delay(void)
> {
> 	outb(0, 0x80);
> }
> 
> static void udelay(int loops)
> {
> 	while (loops--)
> 		io_delay();	/* Approximately 1 us */
> }
> 
> static void beep(unsigned int hz)
> {
> 	u8 enable;
> 
> 	if (!hz) {
> 		enable = 0x00;		/* Turn off speaker */
> 	} else {
> 		u16 div = 1193181/hz;
> 
> 		outb(0xb6, 0x43);	/* Ctr 2, squarewave, load, binary */
> 		io_delay();
> 		outb(div, 0x42);	/* LSB of counter */
> 		io_delay();
> 		outb(div >> 8, 0x42);	/* MSB of counter */
> 		io_delay();
> 
> 		enable = 0x03;		/* Turn on speaker */
> 	}
> 	inb(0x61);		/* Dummy read of System Control Port B */
> 	io_delay();
> 	outb(enable, 0x61);	/* Enable timer 2 output to speaker */
> 	io_delay();
> }
> 
> #define DOT_HZ		880
> #define DASH_HZ		587
> #define US_PER_DOT	125000
> 
> /* Okay, this is totally silly, but it's kind of fun. */
> void send_morse(const char *pattern)
> {
> 	char s;
> 
> 	while ((s = *pattern++)) {
> 		switch (s) {
> 		case '.':
> 			beep(DOT_HZ);
> 			udelay(US_PER_DOT);
> 			beep(0);
> 			udelay(US_PER_DOT);
> 			break;
> 		case '-':
> 			beep(DASH_HZ);
> 			udelay(US_PER_DOT*3);
> 			beep(0);
> 			udelay(US_PER_DOT);
> 			break;
> 		default:	/* Assume it's a space */
> 			udelay(US_PER_DOT*3);
> 			break;
> 		}
> 	}
> }
> 
> 


-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
