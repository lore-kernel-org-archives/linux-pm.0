From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Suspend "core": what to do now ?
Date: Mon, 27 Jun 2005 15:49:54 +1000
Message-ID: <1119851395.5133.112.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86748740151638482=="
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
To: Linux-pm mailing list <linux-pm@lists.osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============86748740151638482==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi !

So I'm still sitting on that rewrite of the pmac suspend code including
suspend to disk consolidation etc... that I would really like to get
upstream. However, I'm still having a problem:

 - I'm still adding all those callbacks to pm_ops, Patrick wants to get
the stuff out of the core, which I agree, but I don't feel like "fixing"
x86 neither :) Pavel wants to keep the existing stuff.

 - If I keep my callbacks addition, we need to consolidate
kernel/power/disk.c with kernel/power/main.c. I need all callbacks in
both cases. The current inconsistency makes little sense.

 - I want that in 2.6.13 final, so please, let's decide something :)

Ben.



--===============86748740151638482==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86748740151638482==--
