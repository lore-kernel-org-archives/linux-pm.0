From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: [RFC] dynamic device power management proposal
Date: Thu, 22 Mar 2007 14:18:25 -0500 (CDT)
Message-ID: <200703221918.l2MJIPJM018761@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: Alan Stern's message of Thu, 22 Mar 2007 10:45:22 -0400 (EDT)
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


| From: Alan Stern<stern@rowland.harvard.edu>
| =

| On Thu, 22 Mar 2007, Scott E. Preece wrote:
| =

| > I would normally call designs that expect important functions (like
| > power on/power off) to happen as side effects of other operations (like
| > opening and closing files) broken to begin with. It's still a bad idea
| > to hide policy inside the driver.
| =

| Even though other people have already answered this, I'd like to add my =

| own comments.
| =

| Firstly, doing power on/power off as side effects of other operations is =

| _not_ a policy choice.  It is a design principle:
| =

| 	When device D has been idle for more than N ms, it should be
| 	put in a low-power state (unless such state changes have been
| 	disabled for D by userspace).
| =

| Of course N will vary for different D's, and the exact choice of N _is_
| policy.  Thus N should be exposed and configurable by userspace.  So
| should the ability to disable the state changes.  But the principle
| above isn't a policy, it is part of the design.
| =

| Secondly, this principle _requires_ that power on/power off occur as side =

| effects of other operations, since those other operations affect whether =

| or not the device is idle.
| =

| If anybody wants to argue against the principle itself, then go ahead and
| say so.  I, for one, don't see anything objectionable about it.
---

I have absolutely no problem with the principle, as long as things are
as you describe - the timing is exposed and configurable and there is
the ability to disable the transitions.

I also have no problem with operations interacting with power on/off
when they clearly have to (sure, if the device is off and the user
writes to it, you probably want to turn it on), but open and close are
different in that respect from read and write - they simply delimit the
time over which operations may be requested and don't inherently imply
anything about the power-state of the device. There is no reason
whatever that a device has to be powered on all the time its driver has
it recorded as open and there's no reason to assume it's OK to power it
off when it's closed.

I disagree with you about whether it's policy (it seems to me that
deciding when to apply a mechanism is exactly what policy is), but it's
not worth arguing about.

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
