From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Regulators vis-a-vis Power Domains
Date: Tue, 6 Apr 2010 22:57:26 +0100
Message-ID: <20100406215725.GA11983@sirena.org.uk>
References: <33A307AF30D7BF4F811B1568FE7A9B180320EBB6@EXDCVYMBSTM006.EQ1STM.local>
	<20100404131058.GA11705@opensource.wolfsonmicro.com>
	<20100406155812.GR31126@trinity.fluff.org>
	<1270586640.3229.72.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1270586640.3229.72.camel@odin>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: STEricsson_nomadik_linux <STEricsson_nomadik_linux@list.st.com>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Ben Dooks <ben-linux@fluff.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 06, 2010 at 09:44:00PM +0100, Liam Girdwood wrote:
> On Tue, 2010-04-06 at 16:58 +0100, Ben Dooks wrote: 
> > On Sun, Apr 04, 2010 at 02:10:58PM +0100, Mark Brown wrote:

> > > Nor does the SH stuff.  With the power domains of a CPU it often doesn't
> > > buy terribly much to use the regulator framework - the power domains are

> > I personally think there is merit to having the regulator framework at
> > least play a part in these, as is possible the powerdomains are being
> > fed from external regulators and/or power switches. I see it as good
> > way of using existing support to do useful work.

> I tend to agree here, although I think it's still early days for this
> technology and maybe some hybrid approach will eventually emerge.

Yes, once the control goes off chip the regulator framework definitely
makes sense.  It's only for things on the same die where there may be
less of a clear separation for the power supplies and where there's
likely to not be much more than simple power switching that it *might*
be worth doing something custom which more directly represents what's
going on.
