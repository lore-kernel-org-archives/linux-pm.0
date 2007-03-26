From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Mon, 26 Mar 2007 13:37:08 +0800
Message-ID: <b6a2187b0703252237l4f662fb3n7f57dfb10360c4f6@mail.gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	 <20070318184919.GW752@stusta.de>
	 <b6a2187b0703251825l2b2ab9d3j43e17523cbca87ac@mail.gmail.com>
	 <20070326040509.GU16477@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070326040509.GU16477@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On 3/26/07, Adrian Bunk <bunk@stusta.de> wrote:

> > Resume from RAM (s2ram) still broke (tried with or without
> > CONFIG_NO_HZ). Suspend to RAM seems ok, but upon resume, the screen
> > will only display "inu" and only after pressing the power button will
> > the system return to console. But "date" still doesn't advance.
>
> This might be related to the following regression:
>
> Subject    : first disk access after resume takes several minutes
>              ('date' does not advance after resume from RAM, CONFIG_NO_HZ=n)
> References : http://lkml.org/lkml/2007/3/8/117
>              http://lkml.org/lkml/2007/3/25/20
> Submitter  : Michael S. Tsirkin <mst@mellanox.co.il>
> Handled-By : Thomas Gleixner <tglx@linutronix.de>
>              Ingo Molnar <mingo@elte.hu>
> Status     : problem is being debugged

Adrian,

It's related. I tested without CONFIG_HPET_TIMER, and now my X60 can
suspend and resume from RAM (s2ram). Even better, it works
with/without CONFIG_NO_HZ.

But, suspend to disk still broke with CONFIG_NO_HZ set.

Thanks,
Jeff.
