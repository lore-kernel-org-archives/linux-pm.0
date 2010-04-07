From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: Regulators vis-a-vis Power Domains
Date: Wed, 07 Apr 2010 10:38:07 +0100
Message-ID: <1270633087.3248.27.camel__12535.5691220195$1270633265$gmane$org@odin>
References: <33A307AF30D7BF4F811B1568FE7A9B180320EBB6@EXDCVYMBSTM006.EQ1STM.local>
	<20100404131058.GA11705@opensource.wolfsonmicro.com>
	<20100406155812.GR31126@trinity.fluff.org>
	<1270586640.3229.72.camel@odin>
	<20100406215725.GA11983@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100406215725.GA11983@sirena.org.uk>
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
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 2010-04-06 at 22:57 +0100, Mark Brown wrote:
> On Tue, Apr 06, 2010 at 09:44:00PM +0100, Liam Girdwood wrote:
> > On Tue, 2010-04-06 at 16:58 +0100, Ben Dooks wrote: 
> > > On Sun, Apr 04, 2010 at 02:10:58PM +0100, Mark Brown wrote:
> 
> > > > Nor does the SH stuff.  With the power domains of a CPU it often doesn't
> > > > buy terribly much to use the regulator framework - the power domains are
> 
> > > I personally think there is merit to having the regulator framework at
> > > least play a part in these, as is possible the powerdomains are being
> > > fed from external regulators and/or power switches. I see it as good
> > > way of using existing support to do useful work.
> 
> > I tend to agree here, although I think it's still early days for this
> > technology and maybe some hybrid approach will eventually emerge.
> 
> Yes, once the control goes off chip the regulator framework definitely
> makes sense.  It's only for things on the same die where there may be
> less of a clear separation for the power supplies and where there's
> likely to not be much more than simple power switching that it *might*
> be worth doing something custom which more directly represents what's
> going on.

I agree, although the concepts are pretty much the same wrt software in
that both external PMIC regulators and internal on die voltage domains
both control power to their consumers. We already have supply dependency
support and consumer ref counting in regulator core so voltage domain
support _may_ work well by adding a simplified method to register a
domain graph with the regulator core. There may be other small bits and
pieces to add too but I cant think of anything major atm.

Liam

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
