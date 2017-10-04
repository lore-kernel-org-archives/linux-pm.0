From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC hack dont apply] intel_idle: support running within
 a VM
Date: Wed, 4 Oct 2017 09:56:42 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710040955450.1878@nanos>
References: <20170930005046-mutt-send-email-mst@kernel.org> <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com> <20171002101249.69b5611a@jacob-builder> <alpine.DEB.2.20.1710032254020.2278@nanos>
 <20171004050939-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171004050939-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Yang Zhang <yang.zhang.wz@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 4 Oct 2017, Michael S. Tsirkin wrote:
> On Tue, Oct 03, 2017 at 11:02:55PM +0200, Thomas Gleixner wrote:
> > There is the series from Audrey which makes use of the various idle
> > prediction mechanisms, scheduler, irq timings, idle governor to get an idea
> > about the estimated idle time. Exactly this information can be fed to the
> > kvmidle driver which can act accordingly.
> > 
> > Hacking a random hardware specific idle driver is definitely the wrong
> > approach. It might be useful to chain the kvmidle driver and hardware
> > specific drivers at some point, i.e. if the kvmdriver decides not to exit
> > it delegates the mwait decision to the proper hardware driver in order not
> > to reimplement all the required logic again.
> 
> By making changes to idle core to allow that chaining?
> Does this sound like something reasonable?

At least for me it makes sense to avoid code duplication. But thats up to
the cpuidle maintainers to decide at the end.

Thanks,

	tglx
