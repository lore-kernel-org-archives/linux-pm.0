From: Maxim <maximlevitsky@gmail.com>
Subject: Re: [3/5] 2.6.21-rc4: known regressions (v2)
Date: Fri, 23 Mar 2007 21:07:33 +0200
Message-ID: <200703232107.34020.maximlevitsky@gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <20070323185022.GQ752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070323185022.GQ752@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.c, pavel@suse.cz, linux-pm@lists.osdl.org, =?utf-8?q?Fr=C3=A9d=C3=A9ric_RISS?= <frederic.riss@gmail.com>, Tino Keitel <tino.keitel@gmx.de>, Bob Moore <robert.moore@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, Tobias Doerffel <tobias.doerffel@gmail.com>, Jens Axboe <jens.axboe@oracle.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Mike Harris <atarimike@wavecable.com>, Marcus Better <marcus@better.se>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Meyer <thomas@m3y3r.de>, Thomas Gleixner <tglx@linutronix.de>S
List-Id: linux-pm@vger.kernel.org

On Friday 23 March 2007 20:50:22 Adrian Bunk wrote:

> Subject    : suspend to disk hangs
> References : http://lkml.org/lkml/2007/3/16/126
> Submitter  : Maxim Levitsky <maximlevitsky@gmail.com>
> Caused-By  : Rafael J. Wysocki <rjw@sisk.pl>
>              commit e3c7db621bed4afb8e231cb005057f2feb5db557
>              commit ed746e3b18f4df18afa3763155972c5835f284c5
>              commit 259130526c267550bc365d3015917d90667732f1
> Status     : unknown
> 
> 

Hello, 
	It is fixed

	The problem is that now cpu_up/cpu_down is called with tasks frozen,
	and this can lead to deadlock if some driver that registered cpu up/down notifier, sleeps,

	On my system it froze in two places, one in XFS due to freezable workqueues, and in
	microcode update driver that ask the "frozen" userspace for firmware.

	Fix for XFS is already in mainline, and Rafael J. Wysocki. already posted a patch that fixes microcode issue,
	I will test it.

	But I feel that there are more drivers that can deadlock system in same way, on my system S3/S4 works perfect :-)
	Even the weird  hang i had disappeared.

	Big thanks to Rafael J. Wysocki.


	Best regards,
		Maxim Levitsky
