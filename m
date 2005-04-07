From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Thu, 7 Apr 2005 14:29:12 +0200
Message-ID: <200504071429.12687.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
	<200504062335.34143.rjw@sisk.pl> <20050407091157.GB1541@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9352725571372652=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050407091157.GB1541@elf.ucw.cz>
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

--===============9352725571372652==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Thursday, 7 of April 2005 11:11, Pavel Machek wrote:
> Hi!
> 
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
> > I didn't mean a lock in general, but a lock that is needed to
> > suspend a device.
> 
> Processes in refrigerator are not allowed to own any locks. That means
> they may not own a lock that is needed to suspend a device ;-).

I am confused now.  AFAICS, we don't check anywhere if a process we
are going to freeze holds any locks.  If we have a task in
TASK_INTERRUPTIBLE, we just send it a fake signal which causes it to go
to the refrigerator().  Could you please tell me how we prevent such a task
from holding any locks?  [It probably doesn't matter, at least practically,
but ...? :-)]

> OTOH... we may want to move completely away from refrigerator. Its
> quite a hack, and it device support is okay, we'll not really need it.

Still, it won't happen soon, I guess. :-)  As of today, we have the
refrigerator and the processes in TASK_UNINTERRUPTIBLE are mishandled.
I think we should do something about it, at least for now, until we drop
the refrigerator altogether (if we are going to drop it).  That's why I
started the discussion and sent the patch.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============9352725571372652==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============9352725571372652==--
