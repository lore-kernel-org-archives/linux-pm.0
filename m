From: Michael Turquette <mturquette@baylibre.com>
Subject: Re: [RFC PATCH 0/8] clk: qoriq: Move chip-specific knowledge into
 driver
Date: Thu, 22 Oct 2015 03:11:16 -0700
Message-ID: <20151022101116.20687.55089@quantum>
References: <1434682158-7243-1-git-send-email-scottwood@freescale.com>
 <20150811182535.31346.52965@quantum>
 <1443745589.5336.185.camel@freescale.com>
 <1444435064.5185.16.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1444435064.5185.16.camel@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Scott Wood <scottwood@freescale.com>
Cc: devicetree@vger.kernel.org, Liberman Igal-B31950 <Igal.Liberman@freescale.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>, Tang Yuantian <Yuantian.Tang@freescale.com>, linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Bucur Madalin-Cristian-B32716 <madalin.bucur@freescale.com>
List-Id: linux-pm@vger.kernel.org

Quoting Scott Wood (2015-10-09 16:57:44)
> On Thu, 2015-10-01 at 19:26 -0500, Scott Wood wrote:
> > [Resending to updated e-mail address]
> > 
> > On Tue, 2015-08-11 at 11:25 -0700, Michael Turquette wrote:
> > > Hi Scott,
> > > 
> > > Quoting Scott Wood (2015-06-18 19:49:10)
> > > > The existing device tree bindings are error-prone and inflexible. 
> > > > Correct the mistake by moving the knowledge into the driver, which
> > > > has more flexibility in describing the quirks of each chip.  This leaves
> > > > the device tree to its proper role of identifying a programming 
> > > > interface
> > > > rather than describing its individual registers.
> > > 
> > > Sorry for not responding to this one sooner. Fell through the cracks.
> > > 
> > > All of the changes to drives/clk/clk-qoriq.c look great to me. I assume
> > > you need to keep all of these patches together and want to the take
> > > through the freescale tree? If so feel free to add,
> > > 
> > > Acked-by: Michael Turquette <mturquette@baylibre.com>
> > 
> > Is the ack still valid for the v3 patchset?

Yes. Looks Stephen beat me to it though.

Regards,
Mike

> 
> ping
> 
> -Scott
> 
