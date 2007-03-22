From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 08:39:40 -0500 (CDT)
Message-ID: <200703221339.l2MDdejg007459@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: Pavel Machek's message of Wed, 21 Mar 2007 23:54:29 +0100
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

| On Thu 2007-03-22 00:49:51, Dmitry Krivoschekov wrote:
| > Amit Kucheria wrote:
| > > On 3/21/07, Shaohua Li <shaohua.li@intel.com> wrote:
| > >> On Wed, 2007-03-21 at 02:30 +0800, Pavel Machek wrote:
| > >
| > >>> No, that's not how it works; look at hda_audio, it already has
| > >>> powersave. Just power down audio card 5 seconds after its control f=
ile
| > >>> is closed.
| > >> It's another case of doing policy in a driver.
| > >>
| > >
| > > IMHO, this kind of policy is best handled inside the driver because it
| > > is specific to the hardware. This will ensure that the driver will
| > > just work on every distro without some userspace policy being present
| > > and setup _correctly_.
| > =

| > It some circumstances this policy may increase power consumption
| > but not decrease it. Consider the case of repeatable operation,
| =

| And what... that happens. Lets not break our design because you can
| think of very contrieved corner case.
| =

| > something like periodic sound beep, with period of 5s.
| > In this case, a driver implementing the policy will periodically
| > suspend/resume a number of devices - audio controller, codec, ADC,
| > but the operation  itself (suspending/resuming) will consume
| > more power than power consumed by these devices in case they
| > left running for a 5s. In such a case you may want to change
| > the predefined  value or  just  disable the policy.
| =

| > Yes, we may just not close a sound device file, but phone
| > applications I've seen, do close the file.
| =

| Fix the app, then.
---

I would normally call designs that expect important functions (like
power on/power off) to happen as side effects of other operations (like
opening and closing files) broken to begin with. It's still a bad idea
to hide policy inside the driver.

There's nothing contrived or corner-case-ish about cyclic operations in
a world where media players, animations, etc., are utterly commonplace.
And latency may be ignorable in a laptop environment, but it absolutely
isn't in embedded devices, which users expect to operate immediately, as
though they were gear-driven rather than computer-driven.

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
