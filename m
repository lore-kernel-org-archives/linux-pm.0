From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 16:00:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504071549040.1071-100000@ida.rowland.org>
References: <200504072003.02105.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============31696152073724582=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504072003.02105.rjw@sisk.pl>
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

--===============31696152073724582==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:

> > It's very simple.  Processes in TASK_UNINTERRUPTIBLE can't be put in the
> > refrigerator, so you have to wait until they can be put there.
> 
> It seems that if a process calls wait_for_completion() right before suspend,
> the other task supposed to complete its completion may be accidentally frozen
> before it's able to do this.  It looks like this happens to kseroid sometimes
> on suspend-during-resume.

You mean, when a suspend occurs so soon after a resume that the resume has 
fully completed yet?  Aren't there interlocks to prevent that sort of 
thing from happening?

Anyway, if a process is waiting for something that's not going to happen 
because some other process is frozen, then the suspend should fail.  I 
don't see any other choice.  However, it might help in some situations to 
send a FREEZE message to some device drivers before putting processes in 
the refrigerator -- especially drivers that use a kernel thread.

> > If that means waiting more than 10 seconds or so, you should just give up.  
> > Return an error and put a message in the log saying something like "Can't
> > suspend because process XXX is busy".
> 
> OK, that's what we do now.  Except that IMO we should clear the PF_FREEZE flag
> for this process and do recalc_sigpending() for it after we give up, because
> otherwise it will enter the refrigerator sooner or later and it will stay there.
> Alternatively, we can disable the "freezing loop" in refrigerator() as soon as
> thaw_processes() is started.  Also, we can avoid setting PF_FREEZE for
> processes in TASK_UNINTERRUPTIBLE, but count them as "freezable".  Etc.

Yes, all the necessary cleanup steps should be taken.

Alan Stern


--===============31696152073724582==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============31696152073724582==--
