From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Sun, 3 Sep 2006 16:34:46 -0500 (CDT)
Message-ID: <200609032134.k83LYk3G006249@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: "Rafael J. Wysocki"'s message of Sun, 3 Sep 2006 22:57:49 +0200
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rjw@sisk.pl
Cc: scott.preece@motorola.com, matthew.a.locke@comcast.net, linux-pm@lists.osdl.org, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


| From: "Rafael J. Wysocki" <rjw@sisk.pl>
| =

| On Sunday, 3 September 2006 18:25, David Singleton wrote:
| > On 9/2/06, Rafael J. Wysocki <rjw@sisk.pl> wrote:
| > >
| > > That depends on the definition, but I think of suspend states as the =
ones
| > > that require processes to be frozen before they can be entered.  IMHO=
 it is
| > > quite clear that such states cannot be handled in the same way as tho=
se
| > > that do not require the freezing of processes, so they are not the sa=
me.
| > =

| > You are correct, processes do need to be frozen before a suspend.
| > That's the prepare to suspend part of the suspend process, and
| > the transtition is the suspending and finish is the un-freezing
| > of the processes to resume execution.
| > =

| > And those same steps are the same steps required to transition the
| > system to a new operating point, whether it's suspend or change
| > from 1.4GHz to 600MHz.
| =

| There are only a few states that require the processes to be frozen and I
| think that's a good enough reason to handle them separately.

---

But, surely that distinction can be handled in the implementation behind
the interface, rather than exsposed in the interface.  Does that
distinction matter to the policy manager?  I would argue that it
increases the latency, which would be important to the policy manager,
but that the nature of the latency isn't important to making a policy
decision,  and the proposed interface already exposes the latency as
something that can be used in making transition decisions.

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
