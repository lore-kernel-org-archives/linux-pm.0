From: "Victor Porton,,," <porton@ex-code.com>
Subject: standby to disk transition
Date: Mon, 13 Mar 2006 07:34:36 +0500
Message-ID: <E1FIctI-0000jE-00@porton.narod.ru>
Content-Type: multipart/mixed; boundary="===============46184495808022774=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@osdl.org, pavel@suse.cz
List-Id: linux-pm@vger.kernel.org

--===============46184495808022774==

There should be something such which would cause (after user
specified timeout, e.g. a hour) automatically switch the
system from standby to suspend to disk (or suspend to mem).

Probably to make this transition possible without turning HDD
on, there should be a hibrid of standby and suspend to disk:
do suspend to disk but then enter standby instead of shutting
down. This state should be (dependently on whether there was
user input during the timeout) like standby in quick exit from
it and be like suspend to disk in regard that then computer
could be turned off (manually by power button or by timeout).

Do you understand the idea? For me curently standby is useless
as it even does not turn off the fans and computer continues
to produce noise when in standby. Suspend to disk is also not
quite good for me because it takes 40 sec to take it out.
I want the state when computer enters standby automatically
saving state to disk before standby and then if no user input
by timeout either enters real suspend to disk, or if I wake it
exits from this state quickly.

Or as a possible alternative, we could suspend SIMULTANEOUSLY
to disk and to mem (with switching into suspend-to-disk by
timeout), to have both quick restoration and automatically
fully turning it off.

I realize that it may be hard to design and implement, but my
idea is very nice and convenient for users. So it would be
great if you will do it to Linux 2.8...

(To implement switching from standby to an other mode, we
probably can use BIOS wake timer feature. Or for me it would
be currently acceptable if standby would turn off only HDD
instead of real standby so that during standby processor timer
could continue to function.)

--===============46184495808022774==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============46184495808022774==--
