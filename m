From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC hack dont apply] intel_idle: support running within
 a VM
Date: Wed, 4 Oct 2017 11:31:43 -0700
Message-ID: <20171004113143.503032f0@jacob-builder>
References: <20170930005046-mutt-send-email-mst@kernel.org>
        <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com>
        <20171002101249.69b5611a@jacob-builder>
        <20171004050706-mutt-send-email-mst@kernel.org>
        <20171004100939.1893e4a7@jacob-builder>
        <20171004201125-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:58744 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750866AbdJDS3J (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 4 Oct 2017 14:29:09 -0400
In-Reply-To: <20171004201125-mutt-send-email-mst@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Yang Zhang <yang.zhang.wz@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, jacob.jun.pan@linux.intel.com, "Raj, Ashok" <ashok.raj@intel.com>

On Wed, 4 Oct 2017 20:12:28 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Oct 04, 2017 at 10:09:39AM -0700, Jacob Pan wrote:
> > On Wed, 4 Oct 2017 05:09:09 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Mon, Oct 02, 2017 at 10:12:49AM -0700, Jacob Pan wrote:  
> > > > On Sat, 30 Sep 2017 01:21:43 +0200
> > > > "Rafael J. Wysocki" <rafael@kernel.org> wrote:
> > > >     
> > > > > On Sat, Sep 30, 2017 at 12:01 AM, Michael S. Tsirkin
> > > > > <mst@redhat.com> wrote:    
> > > > > > intel idle driver does not DTRT when running within a VM:
> > > > > > when going into a deep power state, the right thing to
> > > > > > do is to exit to hypervisor rather than to keep polling
> > > > > > within guest using mwait.
> > > > > >
> > > > > > Currently the solution is just to exit to hypervisor each
> > > > > > time we go idle - this is why kvm does not expose the mwait
> > > > > > leaf to guests even when it allows guests to do mwait.
> > > > > >
> > > > > > But that's not ideal - it seems better to use the idle
> > > > > > driver to guess when will the next interrupt arrive.      
> > > > > 
> > > > > The idle driver alone is not sufficient for that, though.
> > > > >     
> > > > I second that. Why try to solve this problem at vendor specific
> > > > driver level?    
> > > 
> > > Well we still want to e.g. mwait if possible - saves power.
> > >   
> > > > perhaps just a pv idle driver that decide whether to vmexit
> > > > based on something like local per vCPU timer expiration? I
> > > > guess we can't predict other wake events such as interrupts.
> > > > e.g.
> > > > if (get_next_timer_interrupt() > kvm_halt_target_residency)
> > > > 	vmexit
> > > > else
> > > > 	poll
> > > > 
> > > > Jacob    
> > > 
> > > It's not always a poll, on x86 putting the CPU in a low power
> > > state is possible within a VM.
> > >   
> > Are you talking about using mwait/monitor in the user space which
> > are available on some Intel CPUs, such as Xeon Phi? I guess if the
> > guest can identify host CPU id, it is doable.  
> 
> Not really.
> 
> Please take a look at the patch in question - it does mwait in guest
> kernel and no need to identify host CPU id.
> 
I may be missing something, in your patch I only see HLT being used in
the guest OS, that would cause VM exit right? If you do mwait in the
guest kernel, it will also exit. So I don't see how you can enter low
power state within VM guest.

+static int intel_halt(struct cpuidle_device *dev,
+			struct cpuidle_driver *drv, int index)
+{
+	printk_once(KERN_ERR "safe_halt started\n");
+	safe_halt();
+	printk_once(KERN_ERR "safe_halt done\n");
+	return index;
+}
> 
> > > Does not seem possible on other CPUs that's why it's vendor
> > > specific. 
> > 
> > [Jacob Pan]  

[Jacob Pan]
