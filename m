From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 17:38:58 +0300
Message-ID: <45F95A82.9030405@gmail.com>
References: <200703151400.l2FE0GhR004563@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200703151400.l2FE0GhR004563@olwen.urbana.css.mot.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Scott E. Preece" <preece@motorola.com>
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

Scott E. Preece wrote:
> | From: Igor Stoppa<igor.stoppa@nokia.com>
> | =

> | What's wrong with expanding the clk_fw?
> | All is needed is:
> | clk_set_rate_buffered(clk1, 300);
> | clk_set_rate_buffered(clk2, 600);
> | clk_rate_flush(); /* can include validation of the set */
> | =

> | Which is, incidentally, what OMAP2 does in hw for all the relevant clk
> | dividers and it also provides validation for the new set of values.
> | =

> | Furthermore if the original assumption that complex transitions are
> | allowed only atomically (p1A, p1B) =3D> (p2A, p2B), hw support is
> | mandatory, otherwise the transition is impossible, no matter what fancy
> | sw fw is performing it.
> ---
> =

> If you did it this way:
> =

> tid1 =3D power_transaction_start();
> clk_set_rate_pending(clk1, 300, tid1);
> clk_set_rate_pending(clk1, 600, tid1);
> power_transaction_commit(tid1);
> =

> Then you can conveniently be constructing more than one transaction at a
> time and would have a little more information for debugging and for
> canceling partial transactions.
> =

> I agree that there needs to be some use of hardware magic underneath to
> make the changes truly atomic; the flush/commit operation would have to
> use that magic. =


i was talking about absolutely concrete example of SH7722 where you have 3 =

clocks managed via one register FRQCR. With this hw you:

1) have to keep predefined ratio between clocks like 1:n:n
2) can write the whole register at once (is it that hw magic you are talkin=
g about?)

So I want this hw to be supported by the framework. The transaction approac=
h =

pointed by Scott could be one of possible solution while I'd hardly accept =

"anonymous" (not coupled with switching clocks) clk_rate_flush() approach.

Meanwhile we are proposing an alternative concept which completely hides su=
ch =

clocks dependency inside the framework, behind the API: the dependency is c=
oded =

via clock tree structure (such clocks are linked with an arc), Further, ass=
uming =

clk_set() accepting variable number of clk_id/rate pairs as input parameter=
s =

such approach eliminates a need in adding transaction concept to the framew=
ork API.

The latter approach significantly simplify building group layer (operating =

points) on top of parameter framework. Indeed, while with transaction appro=
ach =

the knowledge of clocks dependencies in order to properly set up transactio=
ns =

has to be exported to the group layer with our concept the group layer woul=
d be =

as simple as mapping between a string name ("mp3") to single call to =

clk_set_rate() (actually param_set()) where the whole list of parameters an =

operating point is constructed from is passed to such a call.


> That has the advantage of putting all the complexity of
> undedstanding that magic in one place, at the cost of making that one
> place possibly arbitrarily complex.

yes, we are looking towards hiding this completely inside parameter framewo=
rk.

Eugeny
> =

> scott
> =
