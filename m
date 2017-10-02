From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH RFC hack dont apply] intel_idle: support running within
 a VM
Date: Mon, 2 Oct 2017 10:12:49 -0700
Message-ID: <20171002101249.69b5611a@jacob-builder>
References: <20170930005046-mutt-send-email-mst@kernel.org>
        <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:21954 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751065AbdJBRKR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Oct 2017 13:10:17 -0400
In-Reply-To: <CAJZ5v0hz+KDGVdz+X=98p51fOpk6AAa3CmL-asWw3uZg12X-Lw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhang <yang.zhang.wz@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org, Wanpeng Li <wanpeng.li@hotmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, rkrcmar@redhat.com, dmatlack@google.com, agraf@suse.de, Peter Zijlstra <peterz@infradead.org>, Len Brown <lenb@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, jacob.jun.pan@linux.intel.com

On Sat, 30 Sep 2017 01:21:43 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Sat, Sep 30, 2017 at 12:01 AM, Michael S. Tsirkin <mst@redhat.com>
> wrote:
> > intel idle driver does not DTRT when running within a VM:
> > when going into a deep power state, the right thing to
> > do is to exit to hypervisor rather than to keep polling
> > within guest using mwait.
> >
> > Currently the solution is just to exit to hypervisor each time we go
> > idle - this is why kvm does not expose the mwait leaf to guests even
> > when it allows guests to do mwait.
> >
> > But that's not ideal - it seems better to use the idle driver to
> > guess when will the next interrupt arrive.  
> 
> The idle driver alone is not sufficient for that, though.
> 
I second that. Why try to solve this problem at vendor specific driver
level? perhaps just a pv idle driver that decide whether to vmexit
based on something like local per vCPU timer expiration? I guess we
can't predict other wake events such as interrupts.
e.g.
if (get_next_timer_interrupt() > kvm_halt_target_residency)
	vmexit
else
	poll

Jacob
