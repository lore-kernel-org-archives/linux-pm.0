From: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Date: Thu, 12 Apr 2018 09:03:25 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1804120901220.3559@hadrien>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>   <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>   <20180410123305.GF4082@hirez.programming.kicks-ass.net>   <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>  
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>   <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>   <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>   <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>  
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>   <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>  <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>  <alpine.DEB.2.20.1804120816130.3559@hadrien>
 <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Wed, 11 Apr 2018, Joe Perches wrote:

> On Thu, 2018-04-12 at 08:22 +0200, Julia Lawall wrote:
> > On Wed, 11 Apr 2018, Joe Perches wrote:
> > > On Wed, 2018-04-11 at 09:29 -0700, Andrew Morton wrote:
> > > > We already have some 500 bools-in-structs
> > >
> > > I got at least triple that only in include/
> > > so I expect there are at probably an order
> > > of magnitude more than 500 in the kernel.
> > >
> > > I suppose some cocci script could count the
> > > actual number of instances.  A regex can not.
> >
> > I got 12667.
>
> Could you please post the cocci script?

Sure.

julia


Command line:
spatch.opt boolinstruct.cocci -j 40 --very-quiet --no-includes --include-headers /run/shm/linux-next --use-idutils

This was tested on:

struct foo {
  bool a;
  bool b,c;
  int r;
};

struct {
  bool a;
  bool b,c;
  int r;
} x;

----------------------

@initialize:ocaml@
@@
let ctr = ref 0

@r@
identifier i,x;
position p;
@@

struct i {
  ...
  bool x@p;
  ...
}

@script:ocaml@
_p << r.p;
@@

ctr := !ctr + 1

@s@
identifier x;
position p;
@@

struct {
  ...
  bool x@p;
  ...
}

@script:ocaml@
_p << s.p;
@@

ctr := !ctr + 1

@finalize:ocaml@
ctrs << merge.ctr;
@@

ctr := 0;
List.iter (function c -> ctr := !c + !ctr) ctrs;
Printf.printf "%d\n" !ctr
