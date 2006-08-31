From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 31 Aug 2006 10:14:30 -0500 (CDT)
Message-ID: <200608311514.k7VFEUgl003359@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Thu, 31 Aug 2006 14:04:54 +0200
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: pavel@suse.cz
Cc: linux-pm@lists.osdl.org, matthew.a.locke@comcast.net, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org


| From: Pavel Machek<pavel@suse.cz>
| ...
| > I'm not sure how you distinguish between a "system" sleep state =

| > and a "CPU" sleep state - seems like there's a collection of =

| > things that can be shut down or not; except for true OFF, there's
| > always something on.
| =

| Well, even in "true OFF", RTC keeps ticking. And in "disk" state
| (swsusp), machine is basically "true OFF" but it still retains state.
---

In our sleep state (which I would aligned with "mem", in the previous
list), the application processor part of the system is basically true
off, but retains state in memory. In our systems, of course, there's a
second processor that is independently going in and out of its own
low-power modes while waking up every so many milliseconds to stay
camped on a cellular network.

One "interesting" diffference between "disk" and "mem" (as we would use
them, though we don't have a disk, so we don't have a "disk" state), is
that suspend-to-disk today requires rebooting, while suspend-to-RAM
doesn't.  I don't see why that distinction can't still be below the
interface abstraction presented to a user-space power manager, but it's
the most qualitative difference across the range of proposed operating
points...

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
