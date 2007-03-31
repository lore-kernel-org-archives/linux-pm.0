From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 10:08:56 -0700
Message-ID: <20070331170856.GA14959@suse.de>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org> <460BBD1B.4040308@ru.mvista.com> <200703291531.18253.maximlevitsky@gmail.com> <200703291546.48996.maximlevitsky@gmail.com> <1175356272.28263.27.camel@localhost.localdomain> <Pine.LNX.4.64.0703310908160.6730@woody.linux-foundation.org> <1175358800.28263.36.camel@localhost.localdomain> <Pine.LNX.4.64.0703310943190.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0703310943190.6730@woody.linux-foundation.org>
Sender: linux-ide-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Maxim Levitsky <maximlevitsky@gmail.com>, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Ingo Molnar <mingo@elte.hu>, Jeff Chua <jeff.chua.linux@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: linux-pm@vger.kernel.org

On Sat, Mar 31, 2007 at 09:53:43AM -0700, Linus Torvalds wrote:
> Make them be at the top of the device tree by adding them early. That's 
> the whole point of the device tree after all - we have an ordering that is 
> enforced by its topology, and that we sort by when things were added.
> 
> Right now the way things work is (iirc - somebody like Greg should 
> double-check me) is that we add all devices to the power list at 
> device_add() time by traversing the devices fromt he root all the way out, 
> and doing a device_add() which does a device_pm_add(), which in turn adds 
> it to the power-management list - so that the list is always topologically 
> sorted.

Yes, this is how it works (or if not, then there's a bug that needs to
be fixed, as that is how it _should_ work...)

thanks,

greg k-h
