From: Maxim <maximlevitsky@gmail.com>
Subject: Re: [linux-pm] [3/6] 2.6.21-rc4: known regressions
Date: Wed, 28 Mar 2007 22:19:59 +0200
Message-ID: <200703282220.00199.maximlevitsky@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <Pine.LNX.4.64.0703280931520.6730@woody.linux-foundation.org> <200703281238.57811.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <200703281238.57811.david-b@pacbell.net>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>, linux-ide@vger.kernel.org, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, jgarzik@pobox.com, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 28 March 2007 21:38:55 David Brownell wrote:
> On Wednesday 28 March 2007 9:38 am, Linus Torvalds wrote:
> 
> > It's a *device*, dammit. It should save and resume like one (probably as a 
> > system device). The "set_mode()" etc stuff is at a completely different 
> > (higher) conceptual level.
> 
> Agreed, except about "probably as a system device".
> 
> Last I checked, there was no good reason to use sysdev suspend()/resume()
> rather than platform_device suspend_late()/early_resume().  Which more
> or less means no good reason to use sysdev in new code...
> 
> 
> Also, making HPET use the legacy mode seems like a step backwards.
> 
> - Dave
> 


Hi,
	It is not 'legacy' mode,
It is a legacy replacement mode.
It this mode HPET takes over IRQ0 and IRQ 8 and provides this way replacement for PIT and RTC periodic function

	Best regards,
		Maxim Levitsky

