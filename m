From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Tue, 27 Mar 2007 01:46:28 +0800
Message-ID: <b6a2187b0703261046r46782eedv64464ceddb44bc27@mail.gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	 <20070318184919.GW752@stusta.de>
	 <b6a2187b0703251825l2b2ab9d3j43e17523cbca87ac@mail.gmail.com>
	 <20070326040509.GU16477@stusta.de>
	 <b6a2187b0703252237l4f662fb3n7f57dfb10360c4f6@mail.gmail.com>
	 <1174926407.7911.1.camel@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1174926407.7911.1.camel@chaos>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Adrian Bunk <bunk@stusta.de>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On 3/27/07, Thomas Gleixner <tglx@linutronix.de> wrote:

> > It's related. I tested without CONFIG_HPET_TIMER, and now my X60 can
> > suspend and resume from RAM (s2ram). Even better, it works
> > with/without CONFIG_NO_HZ.
>
> Does the patch below fix the HPET_TIMER=y case ?

Thomas, I tried, but it didn't help. Upon resume from ram, "date"
still didn't advance.

Thanks,
Jeff.
