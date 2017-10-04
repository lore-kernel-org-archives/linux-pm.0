From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC hack dont apply] intel_idle: support running within a
 VM
Date: Wed, 4 Oct 2017 05:11:21 +0300
Message-ID: <20171004050939-mutt-send-email-mst@kernel.org>
References: <20170930005046-mutt-send-email-mst@kernel.org>
 <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com>
 <20171002101249.69b5611a@jacob-builder>
 <alpine.DEB.2.20.1710032254020.2278@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1710032254020.2278@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Yang Zhang <yang.zhang.wz@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 03, 2017 at 11:02:55PM +0200, Thomas Gleixner wrote:
> On Mon, 2 Oct 2017, Jacob Pan wrote:
> > On Sat, 30 Sep 2017 01:21:43 +0200
> > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > 
> > > On Sat, Sep 30, 2017 at 12:01 AM, Michael S. Tsirkin <mst@redhat.com>
> > > wrote:
> > > > intel idle driver does not DTRT when running within a VM:
> > > > when going into a deep power state, the right thing to
> > > > do is to exit to hypervisor rather than to keep polling
> > > > within guest using mwait.
> > > >
> > > > Currently the solution is just to exit to hypervisor each time we go
> > > > idle - this is why kvm does not expose the mwait leaf to guests even
> > > > when it allows guests to do mwait.
> > > >
> > > > But that's not ideal - it seems better to use the idle driver to
> > > > guess when will the next interrupt arrive.  
> > > 
> > > The idle driver alone is not sufficient for that, though.
> > > 
> > I second that. Why try to solve this problem at vendor specific driver
> > level? perhaps just a pv idle driver that decide whether to vmexit
> > based on something like local per vCPU timer expiration? I guess we
> > can't predict other wake events such as interrupts.
> > e.g.
> > if (get_next_timer_interrupt() > kvm_halt_target_residency)
> 
> Bah. no. get_next_timer_interrupt() is not available for abuse in random
> cpuidle driver code. It has state and its tied to the nohz code.
> 
> There is the series from Audrey which makes use of the various idle
> prediction mechanisms, scheduler, irq timings, idle governor to get an idea
> about the estimated idle time. Exactly this information can be fed to the
> kvmidle driver which can act accordingly.
> 
> Hacking a random hardware specific idle driver is definitely the wrong
> approach. It might be useful to chain the kvmidle driver and hardware
> specific drivers at some point, i.e. if the kvmdriver decides not to exit
> it delegates the mwait decision to the proper hardware driver in order not
> to reimplement all the required logic again.

By making changes to idle core to allow that chaining?
Does this sound like something reasonable?

> But that's a different story.
> 
> See http://lkml.kernel.org/r/1506756034-6340-1-git-send-email-aubrey.li@intel.com

Will read that, thanks a lot.

> Thanks,
> 
> 	tglx
> 
> 
> 
