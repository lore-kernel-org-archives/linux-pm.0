From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 23:17:39 +0200
Message-ID: <20050406211739.GA1381@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0504061505350.1511-100000@ida.rowland.org>
	<200504062252.34867.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============89777313461971842=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504062252.34867.rjw@sisk.pl>
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

--===============89777313461971842==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > I don't think Rafael is suggesting ignoring them. He's suggesting what
> > > I'm already doing:
> > > - Signal so they enter the freezer if they leave the state;
> > > - Don't count them when deciding whether freezing failed;
> > > - Handle the case where they don't leave the state until post resume (I
> > > let them enter the refrigerator, but have code in there to check whether
> > > the freezer is still on).
> > > 
> > > In this way, I handle kseriod and anything else uninterruptible without
> > > any problems.
> > 
> > What happens if a process owns a lock needed to suspend a device and it is 
> > waiting in TASK_UNINTERRUPTIBLE?
> 
> Well, we're in trouble. :-)
> 
> However, if any process that we have frozen owns such a lock, we're in trouble
> too.

No, we are not. Processes can't own any locks when they are in
refrigerator... It is not ok to call refrigerator from any context
where you own a lock.

OTOH it is okay to enter TASK_UNINTERRUPTIBLE with locks held.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============89777313461971842==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============89777313461971842==--
