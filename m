From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
Date: Mon, 17 Feb 2014 10:40:41 +0000
Message-ID: <20140217104040.GB20125@e102568-lin.cambridge.arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140216013956.GV4451@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140216013956.GV4451@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 16, 2014 at 01:39:56AM +0000, Mark Brown wrote:
> On Tue, Feb 11, 2014 at 02:17:53PM +0000, Lorenzo Pieralisi wrote:
> 
> > +According to the Server Base System Architecture document (SBSA, [3]), the
> > +power states an ARM CPU can be put into are identified by the following list:
> 
> > +1 - Running
> > +2 - Idle_standby
> > +3 - Idle_retention
> > +4 - Sleep
> > +5 - Off
> 
> > +ARM platforms implement the power states specified in the SBSA through power
> > +management schemes that allow an OS PM implementation to put the processor in
> > +different idle states (which include states 1 to 4 above; "off" state is not
> > +an idle state since it does not have wake-up capabilities, hence it is not
> > +considered in this document).
> 
> This is explicitly talking about SBSA - is there any restriction with
> regard to non-SBSA systems?  I can't think of any right now and this
> seems purely informational but it might be worth mentioning that
> non-SBSA systems might potentially have other states if the intention is
> to allow that.

It is informational, for nomenclature reasons. I do not think we have a
problem here, I will check if rewording is necessary.

> > +- state node
> > +
> > +	Description: must be child of either the cpu-idle-states node or
> > +		     a state node.
> > +
> > +	The state node name shall be "stateN", where N = {0, 1, ...} is
> > +	the node number; state nodes which are siblings within a single common
> > +	parent node must be given a unique and sequential N value, starting
> > +	from 0.
> 
> This came up with the CPU bindings as well but I'm really not convinced
> that making the naming of the nodes important is great - it's not normal
> for DT and it makes the usual enumeration code not work.  Can we not
> just have a property for state number in the node instead and allow the
> name to be anything?  It seems we even have the index property
> already...

Name can be anything now, acked.
 
> > +	- compatible
> > +		Usage: Required
> > +		Value type: <stringlist>
> > +		Definition: Must be "arm,cpu-idle-state".
> 
> Do we really need this given that the location in the tree is fixed -
> what would we extend it with in future?

I do not think it hurts either, honestly. Unless there is a strong
reason to remove it I would leave it there.

> > +	- index
> > +		Usage: Required
> > +		Value type: <u32>
> > +		Definition: It represents an idle state index, starting from 2.
> > +			    Index 0 represents the processor state "running"
> > +			    and index 1 represents processor mode
> > +			    "idle_standby", entered by executing a wfi
> > +			    instruction (SBSA,[3]); indexes 0 and 1 are
> > +			    standard ARM states that need not be described.
> 
> ...but other numbers are valid.

Now it is sequential {0,1,....} and I defined what it means in terms of
power consumption (ordering).

> > +	- entry-method
> > +		Usage: Required
> > +		Value type: <stringlist>
> > +		Definition: Describes the method by which a CPU enters the
> > +			    idle state. This property is required and must be
> > +			    one of:
> > +
> > +			    - "arm,psci-cpu-suspend"
> > +			      ARM PSCI firmware interface, CPU suspend
> > +			      method[2].
> > +
> > +			    - "[vendor],[method]"
> > +			      An implementation dependent string with
> > +			      format "vendor,method", where vendor is a string
> > +			      denoting the name of the manufacturer and
> > +			      method is a string specifying the mechanism
> > +			      used to enter the idle state.
> 
> Might be worth reversing these - arm,psci-cpu-suspend is just an example
> of a (hopefully very widely used) vendor method.  Given that everyone is
> supposed to be using PSCI might it even be worth making it the default
> and the property optional?

I think it is ok as it is, honestly. It is certainly not through this
property that psci will be mandated, it is just a way to describe an
entry method and it seems fine to me.

> > +	- power-state
> > +		Usage: See definition.
> > +		Value type: <u32>
> > +		Definition: Depends on the entry-method property value.
> > +			    If entry-method is "arm,psci-cpu-suspend":
> > +				# Property is required and represents
> > +				  psci-power-state parameter. Please refer to
> > +				  [2] for PSCI bindings definition.
> 
> Should we just have the entry method nodes define their own properties
> for this stuff?  I guess this goes back to the comment I made on some
> other binding that it might be cleaner to have an explicit PSCI binding
> rather than put PSCI explicitly in indiidual bindings.

I added to the PSCI bindings in this series. OK, I can add something like:
"Refer to entry-method bindings for the property value definition".

> > +	- entry-latency
> > +		Usage: Required
> > +		Value type: <prop-encoded-array>
> > +		Definition: u32 value representing worst case latency
> > +			    in microseconds required to enter the idle state.
> 
> Why is this defined as an array?

For possible extensions.

> > +	- cache-state-retained
> > +		Usage: See definition
> > +		Value type: <none>
> > +		Definition: if present cache memory is retained on power down,
> > +			    otherwise it is lost.
> 
> Might be better to define which caches?
> 
> > +		STATE1: state1 {
> > +			compatible = "arm,cpu-idle-state";
> 
> Even if we stick with the node name being meaningful it'd be nice to
> replace the STATEN here with a meaningful state name to improve
> legibility.  

Ok I will add this to v4.

Thanks,
Lorenzo
