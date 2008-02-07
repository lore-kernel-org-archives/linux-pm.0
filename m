From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rft] s2ram wakeup moves to .c,
	could fix few machines
Date: Thu, 07 Feb 2008 15:14:15 -0800
Message-ID: <47AB90C7.2070205@zytor.com>
References: <20080205190600.GB11613@elf.ucw.cz>
	<20080207222845.GA6096@elf.ucw.cz> <47AB8A41.3040008@zytor.com>
	<200802072357.33293.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060101040700030303080000"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802072357.33293.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This is a multi-part message in MIME format.
--------------060101040700030303080000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Okay, this uses the iodelay as the timesource... here is the total 
silliness (and totally untested, of course.)

	-hpa


--------------060101040700030303080000
Content-Type: text/x-csrc;
 name="beep.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="beep.c"

static inline void io_delay(void)
{
	outb(0, 0x80);
}

static void udelay(int loops)
{
	while (loops--)
		io_delay();	/* Approximately 1 us */
}

static void beep(unsigned int hz)
{
	u8 enable;

	if (!hz) {
		enable = 0x00;		/* Turn off speaker */
	} else {
		u16 div = 1193181/hz;

		outb(0xb6, 0x43);	/* Ctr 2, squarewave, load, binary */
		io_delay();
		outb(div, 0x42);	/* LSB of counter */
		io_delay();
		outb(div >> 8, 0x42);	/* MSB of counter */
		io_delay();

		enable = 0x03;		/* Turn on speaker */
	}
	inb(0x61);		/* Dummy read of System Control Port B */
	io_delay();
	outb(enable, 0x61);	/* Enable timer 2 output to speaker */
	io_delay();
}

#define DOT_HZ		880
#define DASH_HZ		587
#define US_PER_DOT	125000

/* Okay, this is totally silly, but it's kind of fun. */
void send_morse(const char *pattern)
{
	char s;

	while ((s = *pattern++)) {
		switch (s) {
		case '.':
			beep(DOT_HZ);
			udelay(US_PER_DOT);
			beep(0);
			udelay(US_PER_DOT);
			break;
		case '-':
			beep(DASH_HZ);
			udelay(US_PER_DOT*3);
			beep(0);
			udelay(US_PER_DOT);
			break;
		default:	/* Assume it's a space */
			udelay(US_PER_DOT*3);
			break;
		}
	}
}



--------------060101040700030303080000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060101040700030303080000--
