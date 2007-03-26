From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [3/6] 2.6.21-rc4: known regressions
Date: Mon, 26 Mar 2007 09:25:51 +0800
Message-ID: <b6a2187b0703251825l2b2ab9d3j43e17523cbca87ac@mail.gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	 <20070318184919.GW752@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070318184919.GW752@stusta.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Jones <davej@redhat.com>, Jeremy Fitzhardinge <jeremy@goop.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Maxim Levitsky <maximlevitsky@gmail.com>, Mike Harris <atarimike@wavecable.com>, Marcus Better <marcus@better.se>, Ray Lee <ray-lk@madrabbit.org>, Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Thomas Meyer <thomas@m3y3r.de>, jgarzik@pobox.com, linux-ide@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Soeren Sonnenburg <kernel@nn7.de>
List-Id: linux-pm@vger.kernel.org

On 3/19/07, Adrian Bunk <bunk@stusta.de> wrote:

> Subject    : ThinkPad doesn't resume from suspend to RAM
> References : http://lkml.org/lkml/2007/2/27/80
>              http://lkml.org/lkml/2007/2/28/348
> Submitter  : Jens Axboe <jens.axboe@oracle.com>
>              Jeff Chua <jeff.chua.linux@gmail.com>
> Status     : unknown
>
>
> Subject    : suspend to disk hangs
> References : http://lkml.org/lkml/2007/3/6/142
> Submitter  : Jeff Chua <jeff.chua.linux@gmail.com>
> Status     : unknown

The good news is on 2.6.21-rc5, suspend to disk, and resume from disk works.
But, it only works with CONFIG_NO_HZ unset.

Setting CONFIG_NO_HZ will cause suspend to disk to hang just before
saving memory to disk.

Resume from RAM (s2ram) still broke (tried with or without
CONFIG_NO_HZ). Suspend to RAM seems ok, but upon resume, the screen
will only display "inu" and only after pressing the power button will
the system return to console. But "date" still doesn't advance.

Thanks,
Jeff.
