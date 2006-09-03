From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 4 Sep 2006 00:10:47 +0200
Message-ID: <200609040010.48556.rjw@sisk.pl>
References: <200609032134.k83LYk3G006249@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200609032134.k83LYk3G006249@olwen.urbana.css.mot.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 September 2006 23:34, Scott E. Preece wrote:
> =

> | From: "Rafael J. Wysocki" <rjw@sisk.pl>
> | =

> | On Sunday, 3 September 2006 18:25, David Singleton wrote:
> | > On 9/2/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> | > >
> | > > That depends on the definition, but I think of suspend states as th=
e ones
> | > > that require processes to be frozen before they can be entered.  IM=
HO it is
> | > > quite clear that such states cannot be handled in the same way as t=
hose
> | > > that do not require the freezing of processes, so they are not the =
same.
> | > =

> | > You are correct, processes do need to be frozen before a suspend.
> | > That's the prepare to suspend part of the suspend process, and
> | > the transtition is the suspending and finish is the un-freezing
> | > of the processes to resume execution.
> | > =

> | > And those same steps are the same steps required to transition the
> | > system to a new operating point, whether it's suspend or change
> | > from 1.4GHz to 600MHz.
> | =

> | There are only a few states that require the processes to be frozen and=
 I
> | think that's a good enough reason to handle them separately.
> =

> ---
> =

> But, surely that distinction can be handled in the implementation behind
> the interface, rather than exsposed in the interface.

I don't think you can handle that behind the interface in a satisfactory wa=
y.
For example during a suspend to disk we carry out several transitions of
devices within the suspend-resume cycle.

> Does that distinction matter to the policy manager?

I think so.

> I would argue that it =

> increases the latency, which would be important to the policy manager,
> but that the nature of the latency isn't important to making a policy
> decision,  and the proposed interface already exposes the latency as
> something that can be used in making transition decisions.

>From the policy manager perspective it may be just a latency fator,
but for all of the things _outside_ of the policy manager it's much more
than that.

For example transitions like a CPU frequency change are transparent for ker=
nel
threads, but the suspend "transitions" are not, because the kernel threads =
need
to be informed that the system is suspending and they are expected to freeze
themselves voluntarily.

Really, I think that the "states" which are entered only after tasks are
frozen should be considered as special and handled separately.

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
