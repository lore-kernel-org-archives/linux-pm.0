From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 3 Sep 2006 16:21:34 -0500 (CDT)
Message-ID: <200609032121.k83LLYjK004651@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Sat, 2 Sep 2006 13:17:40 +0200
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



| From: Pavel Machek<pavel@ucw.cz>
| =

| Hi!
| =

| On Thu 2006-08-31 16:44:12, Amit Kucheria wrote:
| > On Thu, 2006-08-31 at 00:36 +0200, ext Pavel Machek wrote:
| > > On Wed 2006-08-30 14:00:53, Amit Kucheria wrote:
| > > > But PowerOP would allow SoC-based systems to tune the operating poi=
nts
| > > > to get the most out of their top-10 use-cases and sleep modes.
| > > =

| > > Question is: can we get similar savings without ugly interface powerop
| > > presents?
| > =

| > If I have understood correctly, your main objection is to defining new
| > operating points from userspace?
| =

| Well, that is big objection, but not my main one. I believe that "new
| operating points from userspace" are non-starter. "So obviously wrong
| that noone would merge that".
---

Why? Are you interpreting "from user space" as "under user control"? A
lot of us have been taught for some time that it's a good thing to move
stuff out of the kernel, unless it really needs to be there. Is there
some reason, in your perception, why definition of operating points
really needs to be in the kernel?  Definition of the operating points,
as opposed to changing from one OP to another, shouldn't have any timing
issues, so why isn't a privileged user-space manager a reasonable
approach?

---
| =

| > The only other interface is the actually setting of a (named) operating
| > point and that is _required_ to do anything useful.
| =

| No, they are not.
| =

| We already have interface for selecting cpu frequency. Lets keep it.
---

As noted previously, OPs bundle together more than just the
frequency. Those of us supporting the OP model believe that you can't
intelligently change CPU frequency in isolation and you can't change
some of those parameters independently, because only certain
combinations work.

---
| ...
| Now, it should be up-to the powerop framework to select best operating
| point given "cpu speed, dsp speed, usb on/off" state. But I argue that
| this should be done in-kernel and hidden from user.
---

Well, I agree with hiding it from the user, but there's no particular
reason that means it needs to be done in the kernel. Again, we like to
have it run from user-space, so we can replace it easily (without
recompiling/restarting the kernel) in development.

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
