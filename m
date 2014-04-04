From: Sebastian Capella <sebastian.capella@linaro.org>
Subject: Re: [PATCH RFC v5 3/3] Documentation: arm: define DT idle states
 bindings
Date: Fri, 4 Apr 2014 15:01:06 -0700
Message-ID: <CADHgK6v-t69qLYTcez+m2rE1tRecVsKfgwDdPrNPJOKPbmL-nA@mail.gmail.com>
References: <1395142132-20788-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1395142132-20788-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140404155622.GA4061@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140404155622.GA4061@e102568-lin.cambridge.arm.com>
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
Cc: Mark Rutland <Mark.Rutland@arm.com>, Mike Turquette <mturquette@linaro.org>, Tomasz Figa <t.figa@samsung.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Dave P Martin <Dave.Martin@arm.com>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Antti Miettinen <ananaza@iki.fi>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit
List-Id: linux-pm@vger.kernel.org

Hi Lorenzo,

I like this :)

I was going to suggest linking the tree upside down (starting with the
leaves such that walking the list takes you back to the root node
(system sleep), but I don't think it matters as long as the
relationship is established (which this does).  I tend to think of
these states in that order, starting from the leaf(shallowest idle
state) and working back to the root(system sleep) since it provides a
simple linear view of the sleep states from the cpu perspective, yet
keeps the heirarchy.

Sebastian
