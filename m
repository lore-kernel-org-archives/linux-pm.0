From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 23:35:33 +0200
Message-ID: <200504062335.34143.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
	<200504062252.34867.rjw@sisk.pl> <20050406211739.GA1381@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============35225019078670394=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050406211739.GA1381@elf.ucw.cz>
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
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============35225019078670394==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 6 of April 2005 23:17, Pavel Machek wrote:
> Hi!
> 
> > > > I don't think Rafael is suggesting ignoring them. He's suggesting what
> > > > I'm already doing:
> > > > - Signal so they enter the freezer if they leave the state;
> > > > - Don't count them when deciding whether freezing failed;
> > > > - Handle the case where they don't leave the state until post resume (I
> > > > let them enter the refrigerator, but have code in there to check whether
> > > > the freezer is still on).
> > > > 
> > > > In this way, I handle kseriod and anything else uninterruptible without
> > > > any problems.
> > > 
> > > What happens if a process owns a lock needed to suspend a device and it is 
> > > waiting in TASK_UNINTERRUPTIBLE?
> > 
> > Well, we're in trouble. :-)
> > 
> > However, if any process that we have frozen owns such a lock, we're in trouble
> > too.
> 
> No, we are not. Processes can't own any locks when they are in
> refrigerator... It is not ok to call refrigerator from any context
> where you own a lock.

I didn't mean a lock in general, but a lock that is needed to suspend a device.
If a process holding that lock is frozen, the _suspend() routine for the device
won't complete, because it won't be able to get the lock.  IOW it will go to
sleep and we are single-threaded at that time ...  Or am I missing anything?

Rafael
 

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============35225019078670394==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============35225019078670394==--
