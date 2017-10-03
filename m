From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC hack dont apply] intel_idle: support running within
 a VM
Date: Tue, 3 Oct 2017 23:02:55 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1710032254020.2278@nanos>
References: <20170930005046-mutt-send-email-mst@kernel.org> <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com> <20171002101249.69b5611a@jacob-builder>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:54891 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbdJCVDL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Oct 2017 17:03:11 -0400
In-Reply-To: <20171002101249.69b5611a@jacob-builder>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>

On Mon, 2 Oct 2017, Jacob Pan wrote:
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
> level? perhaps just a pv idle driver that decide whether to vmexit
> based on something like local per vCPU timer expiration? I guess we
> can't predict other wake events such as interrupts.
> e.g.
> if (get_next_timer_interrupt() > kvm_halt_target_residency)

Bah. no. get_next_timer_interrupt() is not available for abuse in random
cpuidle driver code. It has state and its tied to the nohz code.

There is the series from Audrey which makes use of the various idle
prediction mechanisms, scheduler, irq timings, idle governor to get an idea
about the estimated idle time. Exactly this information can be fed to the
kvmidle driver which can act accordingly.

Hacking a random hardware specific idle driver is definitely the wrong
approach. It might be useful to chain the kvmidle driver and hardware
specific drivers at some point, i.e. if the kvmdriver decides not to exit
it delegates the mwait decision to the proper hardware driver in order not
to reimplement all the required logic again. But that's a different story.

See http://lkml.kernel.org/r/1506756034-6340-1-git-send-email-aubrey.li@intel.com

Thanks,

	tglx
