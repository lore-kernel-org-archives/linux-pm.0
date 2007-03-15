From: "Scott E. Preece" <preece@motorola.com>
Subject: Re: Alternative Concept
Date: Thu, 15 Mar 2007 09:00:16 -0500 (CDT)
Message-ID: <200703151400.l2FE0GhR004563@olwen.urbana.css.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-reply-to: Igor Stoppa's message of Thu, 15 Mar 2007 15:04:49 +0200
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: igor.stoppa@nokia.com
Cc: linux-pm@lists.osdl.org, linux@dominikbrodowski.net, pavel@ucw.cz
List-Id: linux-pm@vger.kernel.org


| From: Igor Stoppa<igor.stoppa@nokia.com>
| =

| What's wrong with expanding the clk_fw?
| All is needed is:
| clk_set_rate_buffered(clk1, 300);
| clk_set_rate_buffered(clk2, 600);
| clk_rate_flush(); /* can include validation of the set */
| =

| Which is, incidentally, what OMAP2 does in hw for all the relevant clk
| dividers and it also provides validation for the new set of values.
| =

| Furthermore if the original assumption that complex transitions are
| allowed only atomically (p1A, p1B) =3D> (p2A, p2B), hw support is
| mandatory, otherwise the transition is impossible, no matter what fancy
| sw fw is performing it.
---

If you did it this way:

tid1 =3D power_transaction_start();
clk_set_rate_pending(clk1, 300, tid1);
clk_set_rate_pending(clk1, 600, tid1);
power_transaction_commit(tid1);

Then you can conveniently be constructing more than one transaction at a
time and would have a little more information for debugging and for
canceling partial transactions.

I agree that there needs to be some use of hardware magic underneath to
make the changes truly atomic; the flush/commit operation would have to
use that magic. That has the advantage of putting all the complexity of
undedstanding that magic in one place, at the cost of making that one
place possibly arbitrarily complex.

scott

-- =

scott preece
motorola mobile devices, il67, 1800 s. oak st., champaign, il  61820  =

e-mail:	preece@motorola.com	fax:	+1-217-384-8550
phone:	+1-217-384-8589	cell: +1-217-433-6114	pager: 2174336114@vtext.com
