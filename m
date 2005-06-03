From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: chainsawing disk.c, need discussion
Date: Fri, 03 Jun 2005 14:28:19 +1000
Message-ID: <1117772899.31082.126.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53295217165012243=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============53295217165012243==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Pavel !

I'm in the middle of killing the pile of junk that is
kernel/power/disk.c but I think we need to discuss some of this on irc,
as email has a too much latency here.

It's just a big nonsense that we duplicate so much code between
kernel/power/main.c and don't have consistency in the callbacks. The
whole in_suspend trick is also disgusting (but may need some low level
fixes to be removed) and I think not calling the arch callbacks when
they exist when the "mode" is reboot or shutdown simply makes no sense.

So please, let me know when you can be around, I'd really want to clean
that up, I don't plan to touch the guts of swsusp itself (except maybe
for removing that in_suspend thing by having swsusp_suspend() return 1
for the "in suspend" case and 0 for the "resumed" case, which may
require some arch small fixes, but that's pretty much all), I really
only want to fix & consolidate main.c and disk.c which are needlessly
inconsitent at the moment.

Cheers,
Ben.



--===============53295217165012243==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53295217165012243==--
