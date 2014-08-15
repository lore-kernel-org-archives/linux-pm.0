From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v7 2/8] Documentation: arm: define DT idle states bindings
Date: Fri, 15 Aug 2014 18:51:52 +0100
Message-ID: <20140815175152.GA8803@e102568-lin.cambridge.arm.com>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-3-git-send-email-lorenzo.pieralisi@arm.com>
 <20140815172030.GA45197@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140815172030.GA45197@ilina-mac.local>
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
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 15, 2014 at 06:20:30PM +0100, Lina Iyer wrote:

[...]

> >+===========================================
> >+3 - idle-states node
> >+===========================================
> >+
> >+ARM processor idle states are defined within the idle-states node, which is
> >+a direct child of the cpus node [1] and provides a container where the
> >+processor idle states, defined as device tree nodes, are listed.
> >+
> >+- idle-states node
> >+
> >+      Usage: Optional - On ARM systems, it is a container of processor idle
> >+                        states nodes. If the system does not provide CPU
> >+                        power management capabilities or the processor just
> >+                        supports idle_standby an idle-states node is not
> >+                        required.
> >+
> >+      Description: idle-states node is a container node, where its
> >+                   subnodes describe the CPU idle states.
> >+
> >+      Node name must be "idle-states".
> >+
> >+      The idle-states node's parent node must be the cpus node.
> >+
> >+      The idle-states node's child nodes can be:
> >+
> >+      - one or more state nodes
> >+
> >+      Any other configuration is considered invalid.
> >+
> >+      An idle-states node defines the following properties:
> >+
> >+      - entry-method
> >+              Value type: <stringlist>
> >+              Usage and definition depend on ARM architecture version.
> >+                      # On ARM v8 64-bit this property is required and must
> >+                        be one of:
> >+                         - "psci" (see bindings in [2])
> >+                      # On ARM 32-bit systems this property is optional
> >+
> >+The nodes describing the idle states (state) can only be defined within the
> >+idle-states node, any other configuration is considered invalid and therefore
> >+must be ignored.
> >+
> >+===========================================
> >+4 - state node
> >+===========================================
> >+
> >+A state node represents an idle state description and must be defined as
> >+follows:
> >+
> >+- state node
> >+
> >+      Description: must be child of the idle-states node
> >+
> >+      The state node name shall follow standard device tree naming
> >+      rules ([5], 2.2.1 "Node names"), in particular state nodes which
> >+      are siblings within a single common parent must be given a unique name.
> >+
> >+      The idle state entered by executing the wfi instruction (idle_standby
> >+      SBSA,[3][4]) is considered standard on all ARM platforms and therefore
> >+      must not be listed.
> >+
> >+      With the definitions provided above, the following list represents
> >+      the valid properties for a state node:
> >+
> >+      - compatible
> >+              Usage: Required
> >+              Value type: <stringlist>
> >+              Definition: Must be "arm,idle-state".
> >+
> >+      - local-timer-stop
> >+              Usage: See definition
> >+              Value type: <none>
> >+              Definition: if present the CPU local timer control logic is
> >+                          lost on state entry, otherwise it is retained.
> >+
> >+      - entry-latency-us
> >+              Usage: Required
> >+              Value type: <prop-encoded-array>
> >+              Definition: u32 value representing worst case latency in
> >+                          microseconds required to enter the idle state.
> >+                          The exit-latency-us duration may be guaranteed
> >+                          only after entry-latency-us has passed.
> >+
> >+      - exit-latency-us
> >+              Usage: Required
> >+              Value type: <prop-encoded-array>
> >+              Definition: u32 value representing worst case latency
> >+                          in microseconds required to exit the idle state.
> >+
> >+      - min-residency-us
> >+              Usage: Required
> >+              Value type: <prop-encoded-array>
> >+              Definition: u32 value representing minimum residency duration
> >+                          in microseconds, inclusive of preparation and
> >+                          entry, for this idle state to be considered
> >+                          worthwhile energy wise (refer to section 2 of
> >+                          this document for a complete description).
> >+
> >+      - wakeup-latency-us:
> >+              Usage: Optional
> >+              Value type: <prop-encoded-array>
> >+              Definition: u32 value representing maximum delay between the
> >+                          signaling of a wake-up event and the CPU being
> >+                          able to execute normal code again. If omitted,
> >+                          this is assumed to be equal to:
> >+
> >+                              entry-latency-us + exit-latency-us
> >+
> >+                          It is important to supply this value on systems
> >+                          where the duration of PREP phase (see diagram 1,
> >+                          section 2) is non-neglibigle.
> >+                          In such systems entry-latency-us + exit-latency-us
> >+                          will exceed wakeup-latency-us by this duration.
> >+
> >+      In addition to the properties listed above, a state node may require
> >+      additional properties specifics to the entry-method defined in the
> >+      idle-states node, please refer to the entry-method bindings
> >+      documentation for properties definitions.
> How are the different idle-states node differenciated?
> Say, I want to choose a different entry point function for each of these
> node sepately.

You add an idle state entry method specific parameter (as PSCI does,
and it's part of this patch already) to each idle state and document it
in the respective binding.

> Also, not all targets may support all idle states. If we do not want to enter
> retention on one target, while an other target might, there is no way
> to know what the idle state node is to set up the correct entry function.

What's a target ? A CPU ? Every CPU lists its idle states through the
cpu-idle-states phandle list. If a CPU does not support an idle state it must
not be there.

Lorenzo
