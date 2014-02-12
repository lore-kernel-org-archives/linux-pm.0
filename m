From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
Date: Wed, 12 Feb 2014 14:34:46 +0000
Message-ID: <20140212143446.GD28661@e102568-lin.cambridge.arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CADGdYn6O6Vpye8knxXdpGzVQNy9p6mM1Sf-bBs7aQtQv6ReoHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CADGdYn6O6Vpye8knxXdpGzVQNy9p6mM1Sf-bBs7aQtQv6ReoHQ@mail.gmail.com>
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
To: Amit Kachhap <amit.kachhap@gmail.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

Hi Amit,

On Wed, Feb 12, 2014 at 11:39:28AM +0000, Amit Kachhap wrote:
> Hi Lorenzo,
> 
> This patch series looks nice and explains the ARM C state DT bindings clearly.
Thank you.

[...]

> > +     - entry-latency
> > +             Usage: Required
> > +             Value type: <prop-encoded-array>
> > +             Definition: u32 value representing worst case latency
> > +                         in microseconds required to enter the idle state.
> I liked your V2 version of OPP based latency more. However in this way
> also latency supplied can correspond to max OPP and based on the
> current OPP, the cpuidle driver can compute the new latency
> proportionately. In case of frequency this can be linear but may not
> be linear for residency.

I understand that, but the bindings do not preclude having a list instead of
just worst case value. Let's go for the worst case and build on it
(when we have a decent method to express OPP dependencies in the DT bindings,
that is not the case at present). Your point is taken, I just want a first
version that provides the groundwork on top of which more complex
bindings can be defined.

> > +
> > +     - exit-latency
> > +             Usage: Required
> > +             Value type: <prop-encoded-array>
> > +             Definition: u32 value representing worst case latency
> > +                         in microseconds required to exit the idle state.
> > +
> > +     - min-residency
> > +             Usage: Required
> > +             Value type: <prop-encoded-array>
> > +             Definition: u32 value representing time in microseconds
> > +                         required for the CPU to be in the idle state to
> > +                         make up for the dynamic power consumed to
> > +                         enter/exit the idle state in order to break even
> > +                         in terms of power consumption compared to idle
> > +                         state index 1 (idle_standby).
> > +
> > +     - power-domains
> > +             Usage: Optional
> > +             Value type: <prop-encoded-array>
> > +             Definition: List of power domain specifiers ([1]) describing
> > +                         the power domains that are affected by the idle
> > +                         state entry.
> I can see power-domains used in 2 places. First in C state definitions
> and second in cpu node cache descriptions. I am not sure but if
> possible than this can be put in one place.

Power domain specifiers are there to link devices (ie caches) to the
idle states. We have to know which devices are affected by an idle state
entry, and that's done through the power-domain (ie all devices that
belong to a power domain affected by the idle state entry must be acted
upon).

All devices have to be linked to the power domain they belong to,
possibly by using a hierarchical representation (to group devices under
a power domain and avoid duplicating the power domain specifier).

> > +
> > +     - cache-state-retained
> > +             Usage: See definition
> > +             Value type: <none>
> > +             Definition: if present cache memory is retained on power down,
> > +                         otherwise it is lost.
> Can the DT bindings support both retained and non-retained with
> different C states? The example shown does not use the retained flag.
> I guess than many combinations are possible.
> Processor retained, cache non-retained = C state 2
> Processor non retained , cache retained = C state 3
> Processor non retained, cache non retained = C state 4

Yes. Those are per idle state properties so the can be used as you defined,
I cannot think of any issue regarding those boolean properties at the
moment, but if you do please flag it up.

Thanks !
Lorenzo
