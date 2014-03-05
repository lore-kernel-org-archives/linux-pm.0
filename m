From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH v6 2/2] ARM hibernation / suspend-to-disk
Date: Tue, 04 Mar 2014 16:18:15 -0800
Message-ID: <53166d4d.6289420a.3401.2109@mx.google.com>
References: <1393545478-14908-1-git-send-email-sebastian.capella@linaro.org>
 <1393545478-14908-3-git-send-email-sebastian.capella@linaro.org>
 <20140228095022.GA25090@e102568-lin.cambridge.arm.com>
 <20140228201557.29118.62126@capellas-linux>
 <20140228224933.GA11040@e102568-lin.cambridge.arm.com>
 <53111e0f.a50a430a.6ef6.ffff99ae@mx.google.com>
 <5315a319.a3b2440a.039b.ffffc66e@mx.google.com>
 <20140304111745.GB21431@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140304111745.GB21431@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Len Brown <len.brown@intel.com>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Jonathan Austin <Jonathan.Austin@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Will Deacon <Will.Deacon@arm.com>, Nicolas Pitre <nico@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>, Russ Dill <Russ.Dill@ti.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Quoting Lorenzo Pieralisi (2014-03-04 03:17:46)
> On Tue, Mar 04, 2014 at 09:55:31AM +0000, Sebastian Capella wrote:
> > Quoting Sebastian Capella (2014-02-28 15:38:54)
> > > Quoting Lorenzo Pieralisi (2014-02-28 14:49:33)
> > > > On Fri, Feb 28, 2014 at 08:15:57PM +0000, Sebastian Capella wrote:
> > > > > > 
> > > > > > This does not guarantee your stack is 8-byte aligned, that's not AAPCS
> > > > > > compliant and might buy you trouble.
> > > > > > 
> > > > > > Either you align the stack or you align the pointer you are passing.
> > > > > > 
> > > > > > Please have a look at kernel/process.c
> > > > > 
> > > > > I've added this for now, do you see any issues?
> > > > > 
> > > > > -static u8 resume_stack[PAGE_SIZE/2] __nosavedata;
> > > > > +static u64 resume_stack[PAGE_SIZE/2/sizeof(u64)] __nosavedata;
> > > > > -               resume_stack + sizeof(resume_stack));
> > > > > +               resume_stack + ARRAY_SIZE(resume_stack));
> > > > 
> > > > I do not see why the stack depends on the PAGE_SIZE. I would be surprised
> > > > if you need more than a few bytes (given that soft_restart switches stack
> > > > again...), go through it with a debugger, it is easy to check the stack
> > > > usage and allow for some extra buffer (but half a page is not needed).
> > > 
> > > I assuming this is becase the no-save region is one page anyway (we skip
> > > restoring the no-save region physical page).  So maybe 1/2 is a way to
> > > leave some room for whatever else may need to be here, but in any case
> > > the 4k is used for nosave.  I think you're right that it can be much less.
> > 
> > Hi Lorenzo,
> > 
> > Are you ok with this just being half a page?  Or do you want me to try
> > to reduce the stack size?  I am at Connect without my debugger, so in
> > that case it would have to wait until next week.
> 
> I am ok, either you leave that as it is (that multiple division looks
> horrible but it is just nitpicking on my side) or define it as an u8 array,
> stick __attribute__((aligned(8)) to the definition (and explain why) and be
> done with it.
> 
> You can add my:
> 
> Reviewed-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Thanks Lorenzo!

Sebastian
