From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Power Domain Framework
Date: Thu, 27 May 2010 02:51:29 -0400
Message-ID: <20100527065129.GA22419__9642.76579111374$1274943140$gmane$org@opensource.wolfsonmicro.com>
References: <CEE6BB42CAD6E947908279175AF8470A025A726240@EXDCVYMBSTM006.EQ1STM.local>
	<1274131108.2698.161.camel@finisterre.wolfsonmicro.main>
	<CEE6BB42CAD6E947908279175AF8470A025A72624A@EXDCVYMBSTM006.EQ1STM.local>
	<1274134636.2698.170.camel@finisterre.wolfsonmicro.main>
	<1274162450.17303.35.camel@bnru01>
	<AANLkTinTdTp_X4lGtZ0hCaVJN5GmvI0tXR1RTRkRNkjN@mail.gmail.com>
	<20100524033859.GB24480@opensource.wolfsonmicro.com>
	<33A307AF30D7BF4F811B1568FE7A9B180B67C60C@EXDCVYMBSTM006.EQ1STM.local>
	<20100526210728.GB19188@opensource.wolfsonmicro.com>
	<20100527030059.GA30505@linux-sh.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100527030059.GA30505@linux-sh.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: Viresh KUMAR <viresh.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 27, 2010 at 12:01:00PM +0900, Paul Mundt wrote:

> Having said that, building on top of the regulator API for these cases
> wouldn't be that much work either, since it largely has all of the
> infrastructure in place (ie, the static consumer case).

On the other hand given that all you're really getting here is the
enable/disable tracking it's also pretty easy to just copy.

> > It's perfectly sensible for the power domain to be a regulator consumer,
> > but having the individual consumer devices be regulator consumers seems
> > non-obvious.

> The common case on SH is that certain blocks are only available in
> certain power domains, while the on/off control remains uniform (albeit
> periodically ineffectual) regardless of state. We also don't have any
> ability to regulate voltage outside of things like PCMCIA.

That's also the case for the power domains on ARMs at the minute, though
the bus control element is pretty common and sometimes gets rolled in to
the operating modes since it's the same IP blocks that share the
resources.

> On/off control in this context is completely orthoganol from clock
> control in that many peripherals without a specific input clock still
> implement power gating in the same way as those that do (this is the case
> for things like the L2 cache, TLB, breakpoint controller, etc). These are
> presently handled through the clock API largely because there was really
> no better fit for them at the time.

Yup, that's pretty common.  The clocking stuff mostly comes into play
when your operating points also include an element of control for the
buses that the devices are hanging off - you end up doing DVFS for the
blocks, normally over the full block rather tha individual blocks.  It's
this stuff that usually has some crossover with regulators, though
mostly as consumers.
