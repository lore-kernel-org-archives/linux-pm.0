From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: So, what's the status on the recent patches here?
Date: Tue, 5 Sep 2006 22:42:16 +0200
Message-ID: <200609052242.17220.rjw@sisk.pl>
References: <200609051603.k85G3Xsm017278@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200609051603.k85G3Xsm017278@olwen.urbana.css.mot.com>
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

On Tuesday, 5 September 2006 18:03, Scott E. Preece wrote:
> =

> | From: "Rafael J. Wysocki" <rjw@sisk.pl>
> | =

> | On Monday, 4 September 2006 01:00, Scott E. Preece wrote:
> | > policy decision to suspend is based on factors that are wholly differ=
ent
> | > than the factors that drive frequency/voltage changes. If that were t=
he
> | > case, then there would be no point to making the decisions in the same
> | > place.  Honestly, I'm not sure of the answer to that...
> | =

> | I think the decision to suspend is made
> | a) by the user,
> | b) by a policy manager in case when, for example, the battery is running
> | critical (ie. on emergency).
> | and the decision to change a frequency/voltage is usually based on some
> | efficiency factors.
> | =

> | Also, the suspend "transitions" are never transparent to the user and t=
he
> | changes of frequency/voltage usually are, at least as far as CPUs are
> | concerned.
> ---
> =

> Your scope is too narrow. In our domain (mobile phones) the user has no
> control at all over power management and decisions to suspend are always
> transparent.
> =

> In our own implementation, the user-space policy manager initiates
> frequency and voltage changes and enabled suspends, but doesn't actually
> initiate them. That is, the policy manager says "based on current user
> activity, it would be OK to suspend now", and a kernel component then
> looks for a good time to do it, based on the system being idle.

Okay, but it's not like that on a PC.

IMHO there are architectures on which suspend states are distinct and
therefore they should be treated as such in general.

> We have thought about merging the decisions into a single range of
> operating points, but the added plumbing to get idle information back to
> the policy manager seemed unappealing.
> =

> We don't use cpufreq, so Pavel's arguments about not changing the kernel
> interface weren't a concern, for us. We're using a kernel interface that
> is all our own (and unappealingly ioctl-based).

Fine, as far as I'm concerned.  ;-)

Greetings,
Rafael


-- =

You never change things by fighting the existing reality.
		R. Buckminster Fuller
