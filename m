From: Javi Merino <javi.merino@kernel.org>
Subject: Re: [RFC PATCH v3 03/10] PM: Introduce an Energy Model management
 framework
Date: Sat, 9 Jun 2018 10:13:57 +0200
Message-ID: <20180609081357.GC4359@tesla>
References: <20180521142505.6522-1-quentin.perret@arm.com>
 <20180521142505.6522-4-quentin.perret@arm.com>
 <20180607144409.GB3311@localhost.localdomain>
 <20180607151954.GA3597@e108498-lin.cambridge.arm.com>
 <20180607160419.GD3311@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180607160419.GD3311@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Quentin Perret <quentin.perret@arm.com>, peterz@infradead.org, rjw@rjwysocki.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, mingo@redhat.com, dietmar.eggemann@arm.com, morten.rasmussen@arm.com, chris.redpath@arm.com, patrick.bellasi@arm.com, valentin.schneider@arm.com, vincent.guittot@linaro.org, thara.gopinath@linaro.org, viresh.kumar@linaro.org, tkjos@google.com, joelaf@google.com, smuckle@google.com, adharmap@quicinc.com, skannan@quicinc.com, pkondeti@codeaurora.org, edubezval@gmail.com, srinivas.pandruvada@linux.intel.com, currojerez@riseup.net
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 07, 2018 at 06:04:19PM +0200, Juri Lelli wrote:
> On 07/06/18 16:19, Quentin Perret wrote:
> > Hi Juri,
> > 
> > On Thursday 07 Jun 2018 at 16:44:09 (+0200), Juri Lelli wrote:
> > > On 21/05/18 15:24, Quentin Perret wrote:
> 
> [...]
> 
> > > > +static void fd_update_cs_table(struct em_cs_table *cs_table, int cpu)
> > > > +{
> > > > +	unsigned long cmax = arch_scale_cpu_capacity(NULL, cpu);
> > > > +	int max_cap_state = cs_table->nr_cap_states - 1;
> > >                  ^
> > > You don't need this on the stack, right?
> > 
> > Oh, why not ?
> > 
> 
> Because you use it only once here below? Anyway, more a (debatable)
> nitpick than anything.

The compiler optimizes that for you because it knows that it is used
only once.  It doesn't put it in the stack, it uses a register.  As it
is, it's more readable so I'd rather keep it.

For reference, this is the code gcc 7.3 generates for arm64 for
fd_update_cstable() (which is inlined in em_rescale_cpu_capacity():

x27 holds the address to cs_table

 1ac:	b9400b63 	ldr	w3, [x27, #8]   ; w3 = cs_table->nr_cap_states
 1b0:	b9406fa4 	ldr	w4, [x29, #108] ; w4 = 0x18 (sizeof(struct em_cap_state))
 1b4:	f9400362 	ldr	x2, [x27]       ; x2 = &cs_table[state]
 1b8:	51000461 	sub	w1, w3, #0x1    ; w1 max_cap_state = cs_table->nr_cap_states - 1
[...]
 1cc:	9b240821 	smaddl	x1, w1, w4, x2  ; x1 = &cs_table->state[max_cap_state]
[...]
 1d4:	f9400427 	ldr	x7, [x1, #8]    ; x7 fmax = cs_table->state[max_cap_state].frequency
[...]                                           ; calculates cmax * cs_table->state[i].frequency in x0
 200:	9ac70800 	udiv	x0, x0, x7      ; x0 = x0 / fmax
                                                ; x0 is then stored to cs_table->state[i].capacity
