From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Sat, 24 Jun 2006 18:10:54 -0700
Message-ID: <200606241810.55800.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606232155160.6483@g5.osdl.org>
	<1151131283.10141.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_fKenEenSDoXD+Em"
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151131283.10141.79.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--Boundary-00=_fKenEenSDoXD+Em
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 23 June 2006 11:41 pm, Benjamin Herrenschmidt wrote:
> Also note that it might be useful to implement something I've been
> carrying around as a patch for debugging suspend on the mac, is what I
> call "fake suspend". I did it as a kernel argument that turns the real
> suspend into a fake suspend, but we should be smarter.
>
> The idea is, as I may have described already, to do the whole driver
> suspend/resume without actually putting the system to sleep ...

Wouldn't the most natural way to implement that be to arrange that
the platform's pm_ops.enter(PM_SUSPEND_ON) just does the right thing?
So test-by "echo on > /sys/power/state".

See the attached (but untested) patch; arch/arm/mach-at91rm9200/pm.c
in current GIT shows one way to handle such enter() calls.  Maybe
it's a bit more than what you were thinking of, since it requires
real wakeup events to leave that "on" state ... you might be thinking
more like just returning immediately, as if such an event had been
issued.  (Arguably both test modes would be useful and there should
be another PM_SUSPEND_* code.)

- Dave

--Boundary-00=_fKenEenSDoXD+Em
Content-Type: text/x-diff;
  charset="us-ascii";
  name="pmstate.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="pmstate.patch"

Index: pm-tmp/kernel/power/main.c
===================================================================
--- pm-tmp.orig/kernel/power/main.c	2006-06-24 17:46:31.000000000 -0700
+++ pm-tmp/kernel/power/main.c	2006-06-24 17:50:27.000000000 -0700
@@ -146,6 +146,7 @@ static void suspend_finish(suspend_state
 
 
 static char *pm_states[PM_SUSPEND_MAX] = {
+	[PM_SUSPEND_ON]		= "on",
 	[PM_SUSPEND_STANDBY]	= "standby",
 	[PM_SUSPEND_MEM]	= "mem",
 #ifdef CONFIG_SOFTWARE_SUSPEND

--Boundary-00=_fKenEenSDoXD+Em
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Boundary-00=_fKenEenSDoXD+Em--
