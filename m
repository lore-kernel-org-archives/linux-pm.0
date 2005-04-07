From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 20:03:01 +0200
Message-ID: <200504072003.02105.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504071031440.989-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============09902267801561182=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504071031440.989-100000@ida.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============09902267801561182==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of April 2005 16:36, Alan Stern wrote:
> On Thu, 7 Apr 2005, Rafael J. Wysocki wrote:
> 
> > I am confused now.  AFAICS, we don't check anywhere if a process we
> > are going to freeze holds any locks.
> 
> You're not supposed to check.  If the process is running in userspace then 
> it can't be holding any locks, by definition.  If it's running in the 
> kernel then it's supposed to do its own checking.  It won't call 
> refrigerator() unless it knows that no locks are held.

Oh, well.  The processes that are running in the kernel always enter the
refrigerator voluntarily ...

]--snip--[
> > > OTOH... we may want to move completely away from refrigerator. Its
> > > quite a hack, and it device support is okay, we'll not really need it.
> > 
> > Still, it won't happen soon, I guess. :-)  As of today, we have the
> > refrigerator and the processes in TASK_UNINTERRUPTIBLE are mishandled.
> > I think we should do something about it, at least for now, until we drop
> > the refrigerator altogether (if we are going to drop it).  That's why I
> > started the discussion and sent the patch.
> 
> It's very simple.  Processes in TASK_UNINTERRUPTIBLE can't be put in the
> refrigerator, so you have to wait until they can be put there.

It seems that if a process calls wait_for_completion() right before suspend,
the other task supposed to complete its completion may be accidentally frozen
before it's able to do this.  It looks like this happens to kseroid sometimes
on suspend-during-resume.

> If that means waiting more than 10 seconds or so, you should just give up.  
> Return an error and put a message in the log saying something like "Can't
> suspend because process XXX is busy".

OK, that's what we do now.  Except that IMO we should clear the PF_FREEZE flag
for this process and do recalc_sigpending() for it after we give up, because
otherwise it will enter the refrigerator sooner or later and it will stay there.
Alternatively, we can disable the "freezing loop" in refrigerator() as soon as
thaw_processes() is started.  Also, we can avoid setting PF_FREEZE for
processes in TASK_UNINTERRUPTIBLE, but count them as "freezable".  Etc.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============09902267801561182==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============09902267801561182==--
