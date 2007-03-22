From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 14:05:31 -0500 (CDT)
Message-ID: <200703221905.l2MJ5VEU017196@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: Pavel Machek's message of Thu, 22 Mar 2007 15:01:38 +0100
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: pavel@ucw.cz
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


| From: Pavel Machek<pavel@ucw.cz>
| =

| Hi!
| =

| > | > Yes, we may just not close a sound device file, but phone
| > | > applications I've seen, do close the file.
| > | =

| > | Fix the app, then.
| > ---
| > =

| > I would normally call designs that expect important functions (like
| > power on/power off) to happen as side effects of other operations (like
| > opening and closing files) broken to begin with. It's still a bad idea
| > to hide policy inside the driver.
| =

| Then you are welcome to go design your own operating system.
| =

| I certinaly do not want open() on powered down /dev/dsp to succeed
| with /dev/dsp powered down.
---

I don't, either. I just don't want it to power down unless I've said
it's OK. I would be fine with an API that cleanly tells the device not
to power down on its own. =


You said "let's not break our designs for corner cases"; I simply
expressed the opinion that that aspect of the design seemed broken, by
normal software design criteria - don't let important things happen as
side effects.

---
| =

| > There's nothing contrived or corner-case-ish about cyclic operations in
| > a world where media players, animations, etc., are utterly
| > commonplace.
| =

| Yep? And you close your sound device between those?
---

We close it between some kinds of cyclic operations. We'd like to be
able to be finer grained in the future.

---
| > And latency may be ignorable in a laptop environment, but it absolutely
| > isn't in embedded devices, which users expect to operate immediately, as
| > though they were gear-driven rather than computer-driven.
| =

| What latency are you talking about? Powering up piece of hw takes one
| milisecond or something. If your /dev/dsp takes 3 seconds to power up,
| you probably need userspace policy daemon. But that is not the case,
| hw takes few miliseconds to wake up.
---

Sure, but *some* devices take substantially longer to power up or
down.  If you insist that the driver should make the power down
decision, then you lump high-latency and low-latency devices together,
even though high-latency devices might be better served by separating
the semantics.

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
