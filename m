From: Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sat, 31 Mar 2007 10:58:29 -0700
Message-ID: <1175363910.12252.196.camel@imap.mvista.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	 <200703291546.48996.maximlevitsky@gmail.com>
	 <1175356272.28263.27.camel@localhost.localdomain>
	 <200703311956.35922.maximlevitsky@gmail.com>
	 <Pine.LNX.4.64.0703311004310.6730@woody.linux-foundation.org>
	 <20070331171740.GA11750@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20070331171740.GA11750@elte.hu>
Sender: linux-ide-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Maxim Levitsky <maximlevitsky@gmail.com>, tglx@linutronix.de, Sergei Shtylyov <sshtylyov@ru.mvista.com>, Jeff Chua <jeff.chua.linux@gmail.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Eric W. Biederman" <ebiederm@xmission.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, pavel@suse.cz, linux-pm@lists.osdl.org, gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, Jens Axboe <jens.axboe@oracle.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, jgarzik@pobox.com, linux-ide@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
List-Id: linux-pm@vger.kernel.org

On Sat, 2007-03-31 at 19:17 +0200, Ingo Molnar wrote:

> yeah. There's some practical problems that need to be sorted out: much 
> of the current GTOD code is irq-driven (and all GTOD locks are 
> irq-safe), while the sysfs code needs to run in process-context level. 
> 
> Clocksources 'arrive' and 'depart' in hardirq context (which is the 
> primary place where we notice their breakage, determine that they are 
> now verified to be usable, etc.). This came partly from legacy: the 
> gradual conversion of the monolithic time code, and the need to preserve 
> GTOD and non-GTOD architectures without too much duplication. It also 
> came partly because there's also a fundamental need to have accurate 
> time, which is better served from irq context.
> 

Is this in reference to the irq-context clocksource polling stuff? I
don't see a dire reason to keep that code, and I agree removing that is
a certainly a worth while cleanup .. I added this cleanup to one of my
trees when you first suggested it , and there is some infrastructure
that really should be added to facilitate it.

Daniel

