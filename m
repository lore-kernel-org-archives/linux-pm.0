From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 3 Sep 2006 17:40:27 -0500 (CDT)
Message-ID: <200609032240.k83MeRhV014303@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Mon, 4 Sep 2006 00:25:13 +0200
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

| On Sun 2006-09-03 17:12:22, Scott E. Preece wrote:
| > | From: Pavel Machek<pavel@ucw.cz>
| =

| > | > But, surely that distinction can be handled in the implementation b=
ehind
| > | > the interface, rather than exsposed in the interface.  Does that
| > | > distinction matter to the policy manager?  I would argue that it
| > | > increases the latency, which would be important to the policy manag=
er,
| > | > but that the nature of the latency isn't important to making a poli=
cy
| > | > decision,  and the proposed interface already exposes the latency as
| > | > something that can be used in making transition decisions.
| > | =

| > | Are we talking about the same thing?
| > | =

| > | If policy manager decides to suspend-to-RAM, it will freeze
| > | itself. Puff, it is not running any more.
| > ---
| > =

| > Well, I assume the policy manager is telling something in the kernel to
| > actually set the operating point. Once it has made that request, it
| > doesn't need to run any longer.
| =

| And how will it tell the kernel to get back to some _operating_
| point? (As opposed to "off-suspended-to-disk"?)
| =

| You see, that interface even causes problems in our (human!)
| comunication. Some of operating points are not really operating!
---

You mean, how will it initiate the transition out of "suspended"? Well,
obviously, it wouldn't be able to do that until the machine
resumed. But, from the perspective of the policy manager, that doesn't
really matter - no time passes (from its perspective), it just starts
running again, receives some kind of wakeup event from the kernel, and
decides what transition should happen.

---
| =

| > | Of course, we could use same interface for both. No, it is not good
| > | idea. We want reasonably clean interface. If it means rewriting
| > | powerop two or three times... we'll need to do it.
| > ---
| > =

| > Not speaking to either of the current code submissions, I would say that
| > having a kernel interface for defining OPs and a kernel interface for
| > setting the OP, was a reasonably clean interface.
| =

| Well, me and Rafael disagree, and you do not really listen to
| arguments. Now you can either fix the interface, or try to submit code
| to lkml despite our NAKs. Go ahead and prepare for some flaming...
---

I think I'm listening to arguments just as much as you guys are! We just
disagree. What are your criteria for "a clean interface"? Why do you
think that n separate set-parameter() interfaces, with no consistency
relationship between them, are cleaner than one define-op() and one
set-op() interface?

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
