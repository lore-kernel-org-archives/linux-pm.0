From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: freeze_processes questions
Date: Tue, 5 Apr 2005 11:53:11 +0200
Message-ID: <200504051153.11481.rjw@sisk.pl>
References: <200504051120.44496.rjw@sisk.pl> <20050405092742.GA1327@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============53421719516190236=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050405092742.GA1327@elf.ucw.cz>
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

--===============53421719516190236==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Tuesday, 5 of April 2005 11:27, Pavel Machek wrote:
> Hi!
> > 
> > I have two questions regarding freeze_processes():
> > 
> > 1) Shouldn't we take the TASK_UNINTERRUPTIBLE state into consideration?  Now
> > we will fail if a process is sleeping when we try to freeze it.
> 
> We can't allow processes to sleep at arbitrary places. Therefore we
> send UNINTERRUPTIBLE task a signal, and hope it can get into
> refrigerator in time.

Hm, AFAIK we can't kill an UNINTERRUPTIBLE process, can we?  Which means that
we can't deliver a signal to it too ...


> > 2) Is it necessary to check p->state == TASK_STOPPED and
> > p->state == TASK_TRACED twice in a row (once in freezable() and
> > then again in the next if ())?
> 
> Those tests should probably be killed from if() below. As far as I can
> see, they can not trigger there.

OK, patch follows. :-)

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- old/kernel/power/process.c	2005-04-05 11:43:56.000000000 +0200
+++ linux-2.6.12-rc2-new/kernel/power/process.c	2005-04-05 11:45:06.000000000 +0200
@@ -70,9 +70,7 @@ int freeze_processes(void)
 			unsigned long flags;
 			if (!freezeable(p))
 				continue;
-			if ((p->flags & PF_FROZEN) ||
-			    (p->state == TASK_TRACED) ||
-			    (p->state == TASK_STOPPED))
+			if (p->flags & PF_FROZEN)
 				continue;
 
 			/* FIXME: smp problem here: we may not access other process' flags

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============53421719516190236==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============53421719516190236==--
