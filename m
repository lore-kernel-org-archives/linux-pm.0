From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] KVM: T60 resume fix
Date: Mon, 5 Mar 2007 11:33:52 +0100
Message-ID: <20070305103352.GA18852@elte.hu>
References: <20070302102018.GA11549@elte.hu> <20070302102216.GA13575@elte.hu> <45E93012.4000100@qumranet.com> <20070305082251.GA23366@elte.hu> <45EBD9BC.4030801@qumranet.com> <20070305084449.GA1706@elte.hu> <20070305085718.GA2513@elte.hu> <45EBE288.8010101@qumranet.com> <20070305100537.GA9175@elte.hu> <45EBF1E3.4030003@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933064AbXCEKnq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <45EBF1E3.4030003@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jens Axboe <jens.axboe@oracle.com>, Pavel Machek <pavel@ucw.cz>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.osdl.org, Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, Daniel Walker <dwalker@mvista.com>, Len Brown <lenb@kernel.org>
List-Id: linux-pm@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> >it's just the simple hack below.
> 
> Thanks, I'll put it to good use.  Are you planning to upstream it?  
> Not for 2.6.21, presumably ;)

it needs an essential cleanup: instead of modifying 'mem' behavior, it 
should be a 'testmem' thing and no acpi_ flag.

	Ingo
