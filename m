From: Nigel Cunningham <ncunningham@cyclades.com>
Subject: Re: Re: freeze_processes questions
Date: Thu, 07 Apr 2005 08:07:39 +1000
Message-ID: <1112825259.3757.82.camel@desktop.cunningham.myip.net.au>
References: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
	<200504062252.34867.rjw@sisk.pl> <20050406211739.GA1381@elf.ucw.cz>
	<200504062335.34143.rjw@sisk.pl>
Reply-To: ncunningham@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============94953296094298145=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504062335.34143.rjw@sisk.pl>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============94953296094298145==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi.

On Thu, 2005-04-07 at 07:35, Rafael J. Wysocki wrote:
> On Wednesday, 6 of April 2005 23:17, Pavel Machek wrote:
> > > > > I don't think Rafael is suggesting ignoring them. He's suggesting what
> > > > > I'm already doing:
> > > > > - Signal so they enter the freezer if they leave the state;
> > > > > - Don't count them when deciding whether freezing failed;
> > > > > - Handle the case where they don't leave the state until post resume (I
> > > > > let them enter the refrigerator, but have code in there to check whether
> > > > > the freezer is still on).
> > > > > 
> > > > > In this way, I handle kseriod and anything else uninterruptible without
> > > > > any problems.
> > > > 
> > > > What happens if a process owns a lock needed to suspend a device and it is 
> > > > waiting in TASK_UNINTERRUPTIBLE?
> > > 
> > > Well, we're in trouble. :-)
> > > 
> > > However, if any process that we have frozen owns such a lock, we're in trouble
> > > too.
> > 
> > No, we are not. Processes can't own any locks when they are in
> > refrigerator... It is not ok to call refrigerator from any context
> > where you own a lock.
> 
> I didn't mean a lock in general, but a lock that is needed to suspend a device.
> If a process holding that lock is frozen, the _suspend() routine for the device
> won't complete, because it won't be able to get the lock.  IOW it will go to
> sleep and we are single-threaded at that time ...  Or am I missing anything?

Whenever this topic comes up, the discussion is always abstract. If
someone could think of a lock that might actually deadlock suspending,
we look seriously at the issue. In the meantime, all I can say, from
roughly three years of developing and testing, is that it never seems to
happen. And yes, I know that doesn't necessarily mean it can't.

Perhaps it helps to remember that we're using bdev_io routines. All of
the filesystem locking is completely out of the picture. Furthermore, we
flush (well Suspend2 does) all pending I/O before freezing kernel
threads.

Regards,

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net


--===============94953296094298145==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============94953296094298145==--
