From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v3 1/6] Documentation: arm: define DT idle states
 bindings
Date: Thu, 08 May 2014 16:28:28 -0700
Message-ID: <536c131d.43d7440a.1d61.ffff95ca@mx.google.com>
References: <1399399483-17112-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1399399483-17112-2-git-send-email-lorenzo.pieralisi@arm.com>
 <536ac4ef.6ae7440a.511a.ffffdef8@mx.google.com>
 <20140508085743.GA12860@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140508085743.GA12860@e102568-lin.cambridge.arm.com>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <capellas@broadcom.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Nicolas Pitre <nico@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Antti Miettinen <ananaza@iki.fi>, Sudeep Holla <Sudeep.Holla@arm.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Tomasz Figa <t.figa@samsung.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@a>
List-Id: linux-pm@vger.kernel.org

Quoting Lorenzo Pieralisi (2014-05-08 01:57:43)
> On Thu, May 08, 2014 at 12:43:04AM +0100, Sebastian Capella wrote:
> > Quoting Lorenzo Pieralisi (2014-05-06 11:04:38)
> > > diff --git a/Documentation/devicetree/bindings/arm/idle-states.txt b/Documentation/devicetree/bindings/arm/idle-states.txt
> > > new file mode 100644
> > > index 0000000..196ef52
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/idle-states.txt
> > > @@ -0,0 +1,508 @@
...
> > > +
> > > +The nodes describing the idle states (state) can only be defined within the
> > > +idle-states node.
> > > +
> > > +Any other configuration is consider invalid and therefore must be ignored.
> > 
> > consider -> considered
> > must be -> shall?
> > 
> > Is the reference to "any other configuration" referring to state nodes
> > not in the idle states node?  If so, maybe this sentence should go
> > together with that one.
> 
> Yes, it makes sense.
> 

With this small change you can add my Reviewed-by

Thanks!

Sebastian
