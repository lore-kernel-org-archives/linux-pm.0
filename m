From: "Michael S. Tsirkin" <mst@mellanox.co.il>
Subject: Re: [patch] KVM: T60 resume fix
Date: Fri, 2 Mar 2007 13:39:20 +0200
Message-ID: <20070302113920.GB9367@mellanox.co.il>
References: <20070227105922.GD2250@kernel.dk> <20070227111515.GA4271@kernel.dk> <20070301093450.GA8508@elte.hu> <20070301104117.GA22788@elte.hu> <20070301145204.GA25304@elte.hu> <Pine.LNX.4.64.0703011536450.12485@woody.linux-foundation.org> <20070302072100.GB30634@elte.hu> <20070302080441.GA12785@elte.hu> <20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <git-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070302102216.GA13575@elte.hu>
Sender: git-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.osdl.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Daniel Walker <dwalker@mvista.com>, Len Brown <lenb@kernel.org>, git@vger.kernel.org, Avi Kivity <avi@qumranet.com>
List-Id: linux-pm@vger.kernel.org

> Quoting Ingo Molnar <mingo@elte.hu>:
> Subject: [patch] KVM: T60 resume fix
> From: Ingo Molnar <mingo@elte.hu>
> 
> my T60 laptop does not resume correctly due to KVM attempting to send an 
> IPI to a CPU that might be down (or not up yet). (Doing so also triggers 
> the send_IPI_mask_bitmask() warning in arch/i386/kernel/smp.c, line 
> 732.)
> 
> with this fix applied my laptop does not hang during resume.
> 
> [ KVM will have to disable/enable virtualization on the CPU itself that
>   goes down / comes up, not via an IPI sent from the requesting CPU. ]
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>

Since I don't normally have kvm loaded, this patch is unlikely
to help me, is that right?

-- 
MST
