From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Tue, 10 Aug 2010 15:15:00 +0100
Message-ID: <20100810141459.GD4020__23023.2574548156$1281449775$gmane$org@sirena.org.uk>
References: <20100806225453.GA3947@linux.vnet.ibm.com>
	<alpine.DEB.2.00.1008061651530.30564@asgard.lang.hm>
	<AANLkTikyRhtfX4R3x_NDgHnXssmfVuhjC5PbhRZ0a7su@mail.gmail.com>
	<alpine.DEB.2.00.1008062010510.30564@asgard.lang.hm>
	<20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100809112453.77210acc@lxorguk.ukuu.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: peterz@infradead.org, Felipe Contreras <felipe.contreras@gmail.com>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 09, 2010 at 11:24:53AM +0100, Alan Cox wrote:

> > I have to worry about manually killing off applications when memory
> > gets low, I actually thought it was incredibly sucky.  It was a
> > miniature, badly done laptop.

> Likewise I thought the lack of proper multi-tasking apps in Android was
> comically bad. Nice device completely wrecked by the inability to flip
> between running apps each with their own screen - something that was old
> tech in 1990.

Rather beside the point for this thread and it's perhaps not so
intuitive as it ought to be but holding down the home button should do
what you're looking for here.
