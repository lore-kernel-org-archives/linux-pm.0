From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
Date: Fri, 13 Jun 2014 18:16:18 +0100
Message-ID: <20140613171618.GB16745@e102568-lin.cambridge.arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
 <20140612090339.GB29295@e102568-lin.cambridge.arm.com>
 <539A7480.20606@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <539A7480.20606@linux.vnet.ibm.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, "paul.burton@imgtec.com" <paul.burton@imgtec.com>, Peter De Schrijver <pdeschrijver@n>
List-Id: linux-pm@vger.kernel.org

Hi Preeti,

On Fri, Jun 13, 2014 at 04:48:16AM +0100, Preeti U Murthy wrote:

[...]

> >> Do you want this to be generally useful or is it just ARM-specific?
> > 
> > The first series was targeting ARM64, then I noticed that it might be
> > used for ARM too (Daniel is working on that). Actually, I discovered
> > that Power and MIPS can reuse at least the code that initializes the
> > states data too, but I have to point out three things:
> > 
> > 1) state enter function method: in my bindings it is common for all
> >    idle states, need to check if it applies to Power and MIPS too.
> 
> On PowerPC, we have a state enter function for each idle state. It will
> not be too difficult to consolidate them into one, but that is not on
> the cards right now.

Ok, understood, it can become trickier to do when DT bindings for ARM are
merged though, but I understand it is not your priority now.

> > 2) CPUIDLE_FLAG_TIMER_STOP and how to set it. It is non-trivial to
> >    add code that detects what idle states lose the tick device context.
> >    At the moment I am adding the flag by default to all idle states
> >    apart from standbywfi on ARM, but that can be optimised. Unless we
> >    resort to power domains (but that's not trivial), we can add a flag
> >    to the idle states in DT (ie local-timer-stop or suchlike) to support
> >    that. I think that it will be frowned upon but it is worth trying, would
> >    like to know what other people think about this.
> 
> On PowerPC we have a bit in flag property of the idle state device node,
> which determines if timers will stop. Yes, maybe we can fix it at a
> specific bit but it may be messy.

It is the same information defined differently, and TIMER_STOP on Power
is inferred from the entry method. I think that with a bit of work we
could make ends meet, not sure it has to be done now though.

> > 3) idle states bindings should be reviewed, I expect them to be valid
> >    on other architectures too, but I need acknowledgments.
> 
> The major difference as I see it is the idle state bindings. In your
> patch there is a device node for each idle state. On PowerPC however,
> currently we have a single node with the property values of this node
> determining the idle states' name, desc etc..
> 
> Besides this, the names of the device tree nodes for idle states could
> be arch specific to meet some hierarchical requirements in the device
> tree. This would make it difficult for this driver to parse the idle
> states based on a generic idle state node name.
> > 
> > I think this series is not far from being ready to be upstreamed, I
> > would be certainly happy if it can be reused for other archs too so
> > just let me know.
> 
> On PowerPC there are a couple of other sanity checks that we ought to do
> before initializing the driver.
> 
> So IMO, although we can press out the above mentioned differences in one
> way or the other to make way for a generic idle driver which reads from
> the device tree, I am not in favour of it since it has to concern itself
> with quite a bit of arch-specific stuff. This would anyway make it less
> and less of a generic idle driver. So its best to push this patch to be
> ARM specific.

We are not talking about having a common idle driver for all archs, we are
talking about having a common way to initialize idle states data and I think,
as you mentioned that it could be done (from what I read in your driver).
I understand it is not a priority so I will go ahead and leave it ARM
specific for now.

Thanks,
Lorenzo
