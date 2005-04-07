From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 10:36:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504071031440.989-100000@ida.rowland.org>
References: <200504071429.12687.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============092398774273406481=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504071429.12687.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============092398774273406481==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:

> I am confused now.  AFAICS, we don't check anywhere if a process we
> are going to freeze holds any locks.

You're not supposed to check.  If the process is running in userspace then 
it can't be holding any locks, by definition.  If it's running in the 
kernel then it's supposed to do its own checking.  It won't call 
refrigerator() unless it knows that no locks are held.

>  If we have a task in
> TASK_INTERRUPTIBLE, we just send it a fake signal which causes it to go
> to the refrigerator().  Could you please tell me how we prevent such a task
> from holding any locks?  [It probably doesn't matter, at least practically,
> but ...? :-)]

You can't prevent it, and what you're doing is a mistake.

> > OTOH... we may want to move completely away from refrigerator. Its
> > quite a hack, and it device support is okay, we'll not really need it.
> 
> Still, it won't happen soon, I guess. :-)  As of today, we have the
> refrigerator and the processes in TASK_UNINTERRUPTIBLE are mishandled.
> I think we should do something about it, at least for now, until we drop
> the refrigerator altogether (if we are going to drop it).  That's why I
> started the discussion and sent the patch.

It's very simple.  Processes in TASK_UNINTERRUPTIBLE can't be put in the
refrigerator, so you have to wait until they can be put there.  If that
means waiting more than 10 seconds or so, you should just give up.  
Return an error and put a message in the log saying something like "Can't
suspend because process XXX is busy".

Alan Stern


--===============092398774273406481==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============092398774273406481==--
