From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread,
	take three
Date: Wed, 11 Aug 2010 20:44:35 -0700
Message-ID: <20100812034435.GA7403__30658.7782725275$1281584789$gmane$org@linux.vnet.ibm.com>
References: <20100808155719.GB3635@thunk.org>
	<AANLkTinM5e2HGOFavODPZNzZx4KshDSjsvKN4pLpGGgr@mail.gmail.com>
	<20100808213821.GD3635@thunk.org>
	<20100809112453.77210acc@lxorguk.ukuu.org.uk>
	<20100809181638.GI3026@linux.vnet.ibm.com>
	<AANLkTikwHaKpLdRdxmZj6JDJnsZ+o-jzbVcXhRW3Jmd9@mail.gmail.com>
	<20100811222854.GJ2516@linux.vnet.ibm.com>
	<AANLkTimahmGikeai8QnAxCy45deT00-6T7h-eA-NqL4G@mail.gmail.com>
	<20100812010612.GL2516@linux.vnet.ibm.com>
	<AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinVV1NVHFPeO0p_e2pCtNwTNB932q9tbu9MMD3_@mail.gmail.com>
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
Cc: david@lang.hm, Ted Ts'o <tytso@mit.edu>, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, James.Bottomley@suse.de, galibert@pobox.com, florian@mickler.org, menage@google.com, linux-pm@lists.linux-foundation.org, swmike@swm.pp.se, tglx@linutronix.de, Alan Cox <alan@lxorguk.ukuu.org.uk>, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 12, 2010 at 04:25:21AM +0300, Felipe Contreras wrote:
> On Thu, Aug 12, 2010 at 4:06 AM, Paul E. McKenney
> <paulmck@linux.vnet.ibm.com> wrote:
> > On Thu, Aug 12, 2010 at 03:28:00AM +0300, Felipe Contreras wrote:
> >> On Thu, Aug 12, 2010 at 1:28 AM, Paul E. McKenney
> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> > On Wed, Aug 11, 2010 at 10:18:51PM +0300, Felipe Contreras wrote:
> >> >> On Mon, Aug 9, 2010 at 9:16 PM, Paul E. McKenney
> >> >> <paulmck@linux.vnet.ibm.com> wrote:
> >> >> > But wouldn't an office suite run as a power-oblivious application=
 on an
> >> >> > Android device? =A0After all, office applications do not need to =
run when
> >> >> > the screen is turned off, so these the applications do not need t=
o use
> >> >> > suspend blockers.
> >> >>
> >> >> Ideally the system would be suspended even when the screen is on. If
> >> >> there are no "trusted" applications running at the same time, then
> >> >> openoffice wouldn't load at all. Right?
> >> >
> >> > My understanding is that Android systems in fact do not suspend when
> >> > the screen is on, and that most (perhaps all) other systems do not
> >> > opportunistically suspend at all. =A0There has been some speculation=
 about
> >> > what a hypothetical Android having a non-volatile display might do,
> >> > but as far as I know, this is just speculation.
> >>
> >> I have a desktop system in mind. If opportunistic suspend is only
> >> triggered when the display is off, then it's no good for normal usage,
> >> and therefore dynamic PC needs to get its act together... specially
> >> for laptops.
> >
> > If I understand you correctly, you are saying that both opportunistic
> > suspend and dynamic power control should be used together, with dynamic
> > power control being used for short non-busy periods (as in between
> > keystrokes) and opportunistic suspend being used for longer non-busy
> > periods (as in while grabbing a coffee). =A0That combination of usage
> > sounds promising to me.
> =

> No. In the future x86 will be fixed, but for now let's imagine an ARM lap=
top.

Hmmm...  OK...

> > That said, I don't know that anyone has really sat down and thought
> > through how one might apply suspend blockers to a desktop system.
> > I suspect that there are several ways to go about it.
> =

> Think in terms of an ARM laptop. What good is opportunistic suspend if
> it's not going to help when the laptop is being used?

For when the laptop is not being used, presumably.

							Thanx, Paul
