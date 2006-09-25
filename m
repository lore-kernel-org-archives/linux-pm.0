From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: community PM requirements/issues and PowerOP [Was:
	Re: So, what's the status on the recent patches here?]
Date: Mon, 25 Sep 2006 07:43:41 -0500 (CDT)
Message-ID: <200609251243.k8PChf6N014935@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Pavel Machek's message of Sun, 24 Sep 2006 01:39:28 +0200
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
Cc: linux-pm@lists.osdl.org, matthew.a.locke@comcast.net, scott.preece@motorola.com
List-Id: linux-pm@vger.kernel.org

| From pavel@ucw.cz Sat Sep 23 18:42:14 2006
| =

| Hi!
| =

| > There are also, of course, contractual issues with carriers and
| > content owners, who could also sue if a manufacturer didn't make a
| > sufficient effort to protect the terms of the contract. The
| > carriers and content owners are continually raising the bar on the
| > level of protection they require.
| =

| Yep, I see it sucks being phone manufacturer. But you have separate
| CPU doing GSM stack in current cellphones, right? I believe you even
| use AT commands for communication... That should be about as hard as
| pcmcia card to "harden", and yes, people are routinelly selling pcmcia
| GSM cards.
---

Yes, as I've said elsewhere, I believe the modem software and
communication between the applications and modem processors could be
hardened to a point where it would be safe to make the kernel
replaceable. However, the folks who designed the current product didn't
have that as a requirement, so it wasn't designed that way...

scott
-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
