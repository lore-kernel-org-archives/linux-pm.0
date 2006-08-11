From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: OLS 2006 PM-BOF notes
Date: Fri, 11 Aug 2006 14:14:19 -0500 (CDT)
Message-ID: <200608111914.k7BJEJ0Q029765@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Mark Gross's message of Thu, 10 Aug 2006 14:18:18 -0700
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: mgross@linux.intel.com
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org



| From: Mark Gross<mgross@linux.intel.com>
| =

| OLS 2006 PM BOF notes
| =

| I'm sorry for taking so long to get these out, I misplaced my notes such =
as
| there are.  The discussions where fragmented and hard to keep up with.  =

| ...
| Device / driver Policy manager for application based PM:
| =

| Can drivers be put into lower power states based on application hints, su=
ch as
| I'm doing DVD play back and don't need HD, Ethernet, USB, BT so shut thos=
e down
| for now.
---

Problem, of course, is that in general-use kind of environment, one
application doesn't know what another is doing. So, an app could say "I
need X, Y, Z" or "I don't need X, Y, Z", but something needs to track
the requirements across the system as a whole. And, then, you either
have to trust the applications (which seems unworkable, as long as the
software set can be changed on a deployed system) or else you have to
have a backup approach that controls things by watching the system. And,
if you have that, do you really need the app hints, too?

Now, a narrow consumer device with non-replaceable software might be
able to get away with just voluntary controls, but (a) the FLOSS
community is getting sensitive about whether non-replaceable software is
permissible and (b) a lot of consumer devices are skewing more towards
general use, anyway, so being able to count on cooperative apps is
probably unrealistic.

Look at the narrow case of CPU demand; most apps (other than simple
filter-style apps) have multiple execution regimes while they're
running - the DVD player doesn't need a lit of CPU while it's waiting for
you to press PLAY. So coders would have to remember to change hints as
they changed modes, which seems like a stretch. And you need a means of
expressing your hints in a way that doesn't depend on knowledge of the
platform, or else the developer needs to test on every supported
platform and calculate requirements for that hardware.

The MontaVista/IBM white paper on DPM talked about seeing gains just
from stopping during the inter-frame breaks in video decoding. If you've
got dynamic ticks, and the app is tied to a timer to restart its
activity for the next frame, you can probably do as well by just letting
the scheduler drive that as by asking the app to carefully indicate when
it's not going to need processing.

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
