From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 3 Sep 2006 17:12:22 -0500 (CDT)
Message-ID: <200609032212.k83MCMdR010881@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Sun, 3 Sep 2006 23:43:40 +0200
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@ucw.cz
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



| From: Pavel Machek<pavel@ucw.cz>
| =

| Hi!
| =

| > | > > That depends on the definition, but I think of suspend states as =
the ones
| > | > > that require processes to be frozen before they can be entered.  =
IMHO it is
| > | > > quite clear that such states cannot be handled in the same way as=
 those
| > | > > that do not require the freezing of processes, so they are not th=
e same.
| > | > =

| > | > You are correct, processes do need to be frozen before a suspend.
| > | > That's the prepare to suspend part of the suspend process, and
| > | > the transtition is the suspending and finish is the un-freezing
| > | > of the processes to resume execution.
| > | > =

| > | > And those same steps are the same steps required to transition the
| > | > system to a new operating point, whether it's suspend or change
| > | > from 1.4GHz to 600MHz.
| > | =

| > | There are only a few states that require the processes to be frozen a=
nd I
| > | think that's a good enough reason to handle them separately.
| > =

| > ---
| > =

| > But, surely that distinction can be handled in the implementation behind
| > the interface, rather than exsposed in the interface.  Does that
| > distinction matter to the policy manager?  I would argue that it
| > increases the latency, which would be important to the policy manager,
| > but that the nature of the latency isn't important to making a policy
| > decision,  and the proposed interface already exposes the latency as
| > something that can be used in making transition decisions.
| =

| Are we talking about the same thing?
| =

| If policy manager decides to suspend-to-RAM, it will freeze
| itself. Puff, it is not running any more.
---

Well, I assume the policy manager is telling something in the kernel to
actually set the operating point. Once it has made that request, it
doesn't need to run any longer.

---
| =

| Yes, it is important that interfaces are different. Would you argue
| for using same interface for slowing down machine and for turning
| machine off?
| =

| And suspend-to-disk *is* turning machine off.
---

An interesting question. While it's turning the machine off, it's not
turning it off in the same sense as shutdown, because otherwise you
wouldn't come back via resume.

In any case, I could imagine OFF being another point in the operating
point continuum, except that it's not something I would expect to be
part of the range available to a policy manager (probably; I guess there
are emergency situations where the policy manager might want to shut the
machine down).

---
| =

| Of course, we could use same interface for both. No, it is not good
| idea. We want reasonably clean interface. If it means rewriting
| powerop two or three times... we'll need to do it.
---

Not speaking to either of the current code submissions, I would say that
having a kernel interface for defining OPs and a kernel interface for
setting the OP, was a reasonably clean interface.

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
