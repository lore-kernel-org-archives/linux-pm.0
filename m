From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] time: tick-sched: use bool for tick_stopped
Date: Fri, 20 Apr 2018 12:24:32 -0700
Message-ID: <9447358d3f7cda9032b24d62dd79dacfca73fc30.camel@perches.com>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
         <CAJZ5v0h=Jeb5JjjE9vNQM29xYAy-Ogmx1mycRv-hPJ1+m=edzw@mail.gmail.com>
         <f253686d26b3470f0e9b60502eb62315@codeaurora.org>
         <alpine.DEB.2.21.1804101110080.2058@nanos.tec.linutronix.de>
         <a7d6dddd7d4f9fdc0be8f94251af237f@codeaurora.org>
         <alpine.DEB.2.21.1804101242110.2058@nanos.tec.linutronix.de>
         <2f7755fae34bb65ef0a4b5a11c67f431@codeaurora.org>
         <c3e05a4aad4895046401519dc83fa623@codeaurora.org>
         <a98928c4a1ee719aba5f00932a41a2c3@codeaurora.org>
         <c08f28e5c0461384c8d9a9d2d8b04799@codeaurora.org>
         <aaa5ae49ff33ce9c83c6cf520cc83c0b@codeaurora.org>
         <41aec3337f05316de118357fcbd9d175@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <41aec3337f05316de118357fcbd9d175@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: yuankuiz@codeaurora.org, Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Len Brown <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm-owner@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2018-04-20 at 14:44 +0800, yuankuiz@codeaurora.org wrote:
> On 2018-04-20 09:47 AM, yuankuiz@codeaurora.org wrote:
[]
> > [ZJ] Further prototyping has been given based on gcc for both of
> > x86_64 and armv8-a,
> >      unsigned int and bool share the same 1 bytes without the
> > addtional storage for sure.
> >      Open this and welcome if any other difference behaviour could be 
> > captured.
> 
> [ZJ] Typo.. change 4 bytes above to 1 byte actually.

Not really.

unsigned int is 4 and bool is generally 1.
Alignment padding after a bool may exist.
