From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 00:41:45 +0200
Message-ID: <200504070041.46418.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
	<200504062335.34143.rjw@sisk.pl>
	<1112825259.3757.82.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============14421954737389253=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112825259.3757.82.camel@desktop.cunningham.myip.net.au>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============14421954737389253==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of April 2005 00:07, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2005-04-07 at 07:35, Rafael J. Wysocki wrote:
> > On Wednesday, 6 of April 2005 23:17, Pavel Machek wrote:
> > > > > > I don't think Rafael is suggesting ignoring them. He's suggesting what
> > > > > > I'm already doing:
> > > > > > - Signal so they enter the freezer if they leave the state;
> > > > > > - Don't count them when deciding whether freezing failed;
> > > > > > - Handle the case where they don't leave the state until post resume (I
> > > > > > let them enter the refrigerator, but have code in there to check whether
> > > > > > the freezer is still on).
> > > > > > 
> > > > > > In this way, I handle kseriod and anything else uninterruptible without
> > > > > > any problems.
> > > > > 
> > > > > What happens if a process owns a lock needed to suspend a device and it is 
> > > > > waiting in TASK_UNINTERRUPTIBLE?
> > > > 
> > > > Well, we're in trouble. :-)
> > > > 
> > > > However, if any process that we have frozen owns such a lock, we're in trouble
> > > > too.
> > > 
> > > No, we are not. Processes can't own any locks when they are in
> > > refrigerator... It is not ok to call refrigerator from any context
> > > where you own a lock.
> > 
> > I didn't mean a lock in general, but a lock that is needed to suspend a device.
> > If a process holding that lock is frozen, the _suspend() routine for the device
> > won't complete, because it won't be able to get the lock.  IOW it will go to
> > sleep and we are single-threaded at that time ...  Or am I missing anything?
> 
> Whenever this topic comes up, the discussion is always abstract. If
> someone could think of a lock that might actually deadlock suspending,
> we look seriously at the issue.

Well, (having thought about it for a while) why, actually, a device's _suspend()
routine would need such a lock?  Devices are suspended on one CPU in
a single thread which can only (potentially) race with interrupt handlers ...

> In the meantime, all I can say, from roughly three years of developing
> and testing, is that it never seems to happen.

Well, I have much less experience, but I don't think it's likely to happen,
too. :-)

Greets,
Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============14421954737389253==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============14421954737389253==--
