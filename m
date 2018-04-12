From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] checkpatch: Add a --strict test for structs with bool
 member definitions
Date: Thu, 12 Apr 2018 10:13:23 +0200
Message-ID: <20180412081323.GV4082@hirez.programming.kicks-ass.net>
References: <e22fb871b1b7f2fda4b22f3a24e0d7f092eb612c.camel@perches.com>
 <95477c93db187bab6da8a8ba7c57836868446179.camel@perches.com>
 <20180410143950.4b8526073b4e3e34689f68cb@linux-foundation.org>
 <b3d75281c3a7b4b217b612913894b346eaa3288b.camel@perches.com>
 <20180410150011.df9e036f57b5bcac7ac19686@linux-foundation.org>
 <20180411081502.GJ4082@hirez.programming.kicks-ass.net>
 <20180411092959.e666ec443e4d3bb6f43901d7@linux-foundation.org>
 <1c9f185f6086e9d89659f93720a27b660ee17c13.camel@perches.com>
 <alpine.DEB.2.20.1804120816130.3559@hadrien>
 <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b2087cac13c3a1d01ebe1a17e66351f3777bc397.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Andy Whitcroft <apw@canonical.com>, yuankuiz@codeaurora.org, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, paulmck@linux.vnet.ibm.com, Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 11, 2018 at 11:42:20PM -0700, Joe Perches wrote:
> I personally do not find a significant issue with
> uncontrolled sizes of bool in kernel structs as
> all of the kernel structs are transitory and not
> written out to storage.

People that care about cache locality, false sharing and other such
things really care about structure layout.

Growing a structure into another cacheline can be a significant
performance hit -- cache misses hurt.
