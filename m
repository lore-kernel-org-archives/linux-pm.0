From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Wed, 30 Aug 2006 19:52:24 -0500 (CDT)
Message-ID: <200608310052.k7V0qOZS017752@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Thu, 31 Aug 2006 00:43:52 +0200
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



| From linux-pm-bounces@lists.osdl.org Wed Aug 30 17:48:27 2006
| =

| On Tue 2006-08-29 21:52:26, David Singleton wrote:
| > >> >>         /sys/power/operating_points/mem
| > >> >>         /sys/power/operating_points/standby
| ....
| > >That does not make mixing them right.
| > =

| > Both OpPoint and PowerOp are going to 'mix' frequency, voltage
| > and sleep states into their operating point concepts.
| > =

| > The point was not to make it look like I was mixing sleep states and
| > CPU frequency states, but to present all the power states
| > supported by the system in one place and with one interface.  It simpli=
fies
| > not only kernel code, but power manager code as well.
| =

| It is also wrong. And no, I do not think your power manager can
| properly use "mem" state.
| =

| You see, "mem" is very different from lowest. To exit lowest, you have
| to "echo highest > state". To exit "mem", you need power
| button. That's very different operation.
---

Not sure exactly what is meant by "mem" operating point. I was assuming
it meant "suspend-to-RAM" (almost everything shut down, memory self
refreshing). In my world, our current policy manager does manage mem
(which we call "sleep" and is the deepest suspend we do) separately from
frequency changes, but that's accident rather than intention.

I agree that there is some difference between them, since we do
frequency changes in response to load, but sleep-state changes based on
idleness. However, there's no real reason why those can't be inputs to
the same policy manager. We actually do make both decisions in the Idle
handler (well, there's more plumbing than that, but they're both driven
by going idle).

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
