From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 22:52:34 +0200
Message-ID: <200504062252.34867.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============40942057184688041=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============40942057184688041==
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Wednesday, 6 of April 2005 21:06, Alan Stern wrote:
> On Wed, 6 Apr 2005, Nigel Cunningham wrote:
> 
> > I don't think Rafael is suggesting ignoring them. He's suggesting what
> > I'm already doing:
> > - Signal so they enter the freezer if they leave the state;
> > - Don't count them when deciding whether freezing failed;
> > - Handle the case where they don't leave the state until post resume (I
> > let them enter the refrigerator, but have code in there to check whether
> > the freezer is still on).
> > 
> > In this way, I handle kseriod and anything else uninterruptible without
> > any problems.
> 
> What happens if a process owns a lock needed to suspend a device and it is 
> waiting in TASK_UNINTERRUPTIBLE?

Well, we're in trouble. :-)

However, if any process that we have frozen owns such a lock, we're in trouble
too.  Thus it won't help if we forcibly freeze the uninterruptible process.
Worse yet, there won't be any way to wake it up afterwards.  OTOH, if we leave
it in TASK_UNINTERRUPTIBLE, it may (potentially) be woken up by an interrupt
handler (as you pointed out previously :-)) and release the lock.

Frankly, I can't see any probable scenario leading to this kind of trouble.
Seemingly, it would require someone to take a lock and (knowingly) do
something that could end up in uninterruptible sleep, which IMHO is not
a good idea.

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"

--===============40942057184688041==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============40942057184688041==--
