From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: Power Domain Framework
Date: Thu, 27 May 2010 12:01:00 +0900
Message-ID: <20100527030059.GA30505__3886.54419589347$1274929419$gmane$org@linux-sh.org>
References: <1274118332.17303.17.camel@bnru01>
	<CEE6BB42CAD6E947908279175AF8470A025A726240@EXDCVYMBSTM006.EQ1STM.local>
	<1274131108.2698.161.camel@finisterre.wolfsonmicro.main>
	<CEE6BB42CAD6E947908279175AF8470A025A72624A@EXDCVYMBSTM006.EQ1STM.local>
	<1274134636.2698.170.camel@finisterre.wolfsonmicro.main>
	<1274162450.17303.35.camel@bnru01>
	<AANLkTinTdTp_X4lGtZ0hCaVJN5GmvI0tXR1RTRkRNkjN@mail.gmail.com>
	<20100524033859.GB24480@opensource.wolfsonmicro.com>
	<33A307AF30D7BF4F811B1568FE7A9B180B67C60C@EXDCVYMBSTM006.EQ1STM.local>
	<20100526210728.GB19188@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100526210728.GB19188@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Viresh KUMAR <viresh.kumar@st.com>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Shiraz HASHIM <shiraz.hashim@st.com>, Armando VISCONTI <armando.visconti@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vipin KUMAR <vipin.kumar@st.com>, STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Wed, May 26, 2010 at 05:07:28PM -0400, Mark Brown wrote:
> On Wed, May 26, 2010 at 10:33:49AM +0200, Sundar R IYER wrote:
> > >needs of the core regulator applications.  As I keep saying I'm just not
> > >seeing much more overlap here with the regulator API than I do with the
> > >clock API: it feels like you've got another use case which needs an API
> > >with a similar structure and the reference counted enable and disable
> > >calls but otherwise very little overlap.
> 
> > As I agreed earlier, its true about requirement. It is also true that the clock API can suffice.
> > But what is essential here is: we are talking about regulators here.
> > Why would we need to model a seemingly similar regulator as a clock?
> 
> You're missing the point here.  I'm not saying use the clock API, I'm
> saying that it feels like you want a parallel API that's aimed at the
> needs of operating points which mirrors the structure of the existing
> clock and regulator APIs.
> 
We did something like this on SH with our hwblk API for dealing with
module power gating, which forms the basis for our runtime PM
implementation. In the SH case we simply have a set of registers that
have on/off control over the bulk of the modules in any given CPU, and we
associate that at the platform device level.

Having said that, building on top of the regulator API for these cases
wouldn't be that much work either, since it largely has all of the
infrastructure in place (ie, the static consumer case).

> It's perfectly sensible for the power domain to be a regulator consumer,
> but having the individual consumer devices be regulator consumers seems
> non-obvious.
> 
The common case on SH is that certain blocks are only available in
certain power domains, while the on/off control remains uniform (albeit
periodically ineffectual) regardless of state. We also don't have any
ability to regulate voltage outside of things like PCMCIA.

On/off control in this context is completely orthoganol from clock
control in that many peripherals without a specific input clock still
implement power gating in the same way as those that do (this is the case
for things like the L2 cache, TLB, breakpoint controller, etc). These are
presently handled through the clock API largely because there was really
no better fit for them at the time.
