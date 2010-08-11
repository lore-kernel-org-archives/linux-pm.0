From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Wed, 11 Aug 2010 20:43:02 +0100
Message-ID: <20100811194301.GA14509__13706.0251589448$1281555875$gmane$org@sirena.org.uk>
References: <20100807061558.GA28087@thunk.org>
	<AANLkTi=sMVjya9CH6UoZwJCXJTDRgBhnPXmApU_RHVTi@mail.gmail.com>
	<20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<20100809201822.441905f7@lxorguk.ukuu.org.uk>
	<20100810044541.GA2817@linux.vnet.ibm.com>
	<AANLkTing0RpAoYstVs1G5v-eZ0q6qGjrGiphUvBdOsaS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTing0RpAoYstVs1G5v-eZ0q6qGjrGiphUvBdOsaS@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: peterz@infradead.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, galibert@pobox.com, florian@mickler.org, linux-pm@lists.linux-foundation.org, paulmck@linux.vnet.ibm.com, James.Bottomley@suse.de, tglx@linutronix.de, swmike@swm.pp.se, david@lang.hm, Ted Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, menage@google.com, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 11, 2010 at 10:25:04PM +0300, Felipe Contreras wrote:
> On Tue, Aug 10, 2010 at 7:45 AM, Paul E. McKenney

> > Android is certainly where suspend blockers originated, and is to the best
> > of my knowledge is still the only platform that uses them. ??But there is
> > a first user of every new mechanism, and for some time that first user
> > will by definition be the only user of that mechanism. ??So the fact
> > that Android is most probably the only user of suspend blockers does
> > not prove anything about whether or not suspend blockers are sensible.

> No, it's the fact that *nobody* else has said: hey, that looks like a
> good idea, we should use that in our mobile platform (or any
> platform).

I don't think lack of external adoption is a terribly useful data point
either way at the minute.  While the feature is controversial a lot of
the OSs will probably hold off on it (because it's effort to handle out
of tree stuff and folks are really busy) and there's not that many out
there which support random externally written packages (which is the
major push for exporting the feature to userspace) in the first place.
