From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: So, what's the status on the recent patches here?
Date: Mon, 4 Sep 2006 10:43:13 -0500 (CDT)
Message-ID: <200609041543.k84FhDAe019372@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Mon, 4 Sep 2006 11:12:40 +0200
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
| >... =

| > My question is whether there are aspects of suspending, other than
| > latency, that the policy manager would need to consider in deciding
| > whether to suspend or not.
| > =

| > Look at it this way. In one scheme the policy manager code is:
| > =

| >    new_OP =3D select_transition(current_OP, decision_factors);
| >    set_OP(new_OP);
| =

| No, it would be =

| =

|     new_OP =3D select_transition(current_OP, decision_factors);
| if (new_OP =3D=3D SUSPEND) {
| 	setup wakeup events ...
| }
|     set_OP(new_OP);
---

Sorry; in our implementation, the devices are responsible for
configuring the wakeup events, either globally or in their suspend
routines, so it would look like my example code.  However, I would have
expected the setup of wakeup events to happen in the kernel's set_OP
implementation, rather than in the policy manager, anyway.

Again, this model puts the decision to change in user space and the
implementation of the decision in the kernel.

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
