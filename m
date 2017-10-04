From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH RFC hack dont apply] intel_idle: support running within a
 VM
Date: Wed, 4 Oct 2017 05:09:09 +0300
Message-ID: <20171004050706-mutt-send-email-mst@kernel.org>
References: <20170930005046-mutt-send-email-mst@kernel.org>
 <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com>
 <20171002101249.69b5611a@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171002101249.69b5611a@jacob-builder>
Sender: linux-kernel-owner@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yang Zhang <yang.zhang.wz@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Oct 02, 2017 at 10:12:49AM -0700, Jacob Pan wrote:
> On Sat, 30 Sep 2017 01:21:43 +0200
> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> 
> > On Sat, Sep 30, 2017 at 12:01 AM, Michael S. Tsirkin <mst@redhat.com>
> > wrote:
> > > intel idle driver does not DTRT when running within a VM:
> > > when going into a deep power state, the right thing to
> > > do is to exit to hypervisor rather than to keep polling
> > > within guest using mwait.
> > >
> > > Currently the solution is just to exit to hypervisor each time we go
> > > idle - this is why kvm does not expose the mwait leaf to guests even
> > > when it allows guests to do mwait.
> > >
> > > But that's not ideal - it seems better to use the idle driver to
> > > guess when will the next interrupt arrive.  
> > 
> > The idle driver alone is not sufficient for that, though.
> > 
> I second that. Why try to solve this problem at vendor specific driver
> level?

Well we still want to e.g. mwait if possible - saves power.

> perhaps just a pv idle driver that decide whether to vmexit
> based on something like local per vCPU timer expiration? I guess we
> can't predict other wake events such as interrupts.
> e.g.
> if (get_next_timer_interrupt() > kvm_halt_target_residency)
> 	vmexit
> else
> 	poll
> 
> Jacob

It's not always a poll, on x86 putting the CPU in a low power state
is possible within a VM.

Does not seem possible on other CPUs that's why it's vendor specific.

-- 
MST
