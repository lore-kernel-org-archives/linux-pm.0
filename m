From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 13:59:26 -0700
Message-ID: <200703281359.29009.david-b@pacbell.net>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <200703281238.57811.david-b@pacbell.net> <200703282220.00199.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200703282220.00199.maximlevitsky@gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Maxim <maximlevitsky@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 March 2007 1:19 pm, Maxim wrote:
> On Wednesday 28 March 2007 21:38:55 David Brownell wrote:

> > 
> > Also, making HPET use the legacy mode seems like a step backwards.

> 	It is not 'legacy' mode,
> It is a legacy replacement mode.

Typo, sorry.


> It this mode HPET takes over IRQ0 and IRQ 8 and provides this way
> replacement for PIT and RTC periodic function 

It's that RTC periodic thing that bothers me, I don't mind about
the PIT.  Remember that IRQ8 is also used for other RTC functions.

Now, if there were a way to tell rtc-cmos that HPET is active,
and arrange some kind of handshake ... that would be different.

- Dave
