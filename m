From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
	=?iso-8859-1?q?SMP_suspend_broken_due_to_=22swsusp=3A_?=
	=?iso-8859-1?q?Change_code=09ordering_in_disk=2Ec=22_et_al=2E?=
Date: Mon, 12 Mar 2007 19:14:16 +0100
Message-ID: <200703121914.16625.rjw@sisk.pl>
References: <1172201385.15769.32.camel@johannes.berg>
	<200702242154.27167.rjw@sisk.pl>
	<loom.20070312T173052-675@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <loom.20070312T173052-675@post.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
Cc: Roman Jarosz <kedgedev@centrum.cz>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 12 March 2007 17:57, Roman Jarosz wrote:
> Rafael J. Wysocki <rjw <at> sisk.pl> writes:
> =

> > =

> > On Saturday, 24 February 2007 09:57, Rafael J. Wysocki wrote:
> > > On Saturday, 24 February 2007 01:31, Johannes Berg wrote:
> > > > Hi,
> > > > =

> > > > > Could you please try the appended patch?  It's somewhat hackish, =
but =

> may work.
> > > > =

> > > > Not before Monday or Tuesday unfortunately, I'm away from the machi=
ne.
> > > =

> > > Okay, no big deal.  I think I'll be able to reproduce the problem her=
e. =

> > > =

> > > > Maybe I can find someone else willing to test who has the same box.
> > > > =

> > > > > The idea is to do nothing on CPU unplug if the CPU's worker threa=
d is =

> frozen
> > > > > and later check in the thread itself if it has been replaced by a=
nother =

> one.
> > > > =

> > > > Yeah that should work. That patch won't apply to my tree though unl=
ess I
> > > > actually go to -mm2 as well :)
> > > =

> > > Ah, sorry.  I'll prepare a version against 2.6.21-rc1.  Apart from th=
is, I
> > > think there's a better solution, but I have to verify that.
> > =

> > No, this one is better IMO.
> > =

> > Appended is the version against 2.6.21-rc1.  It seems to work for me, b=
ut I'd
> > like someone else to confirm it.
> > =

> =

> I had the same problem as Johannes and I can confirm that your patch work=
s.

Thanks for testing, but I'm afraid it won't be merged.  Instead, we have
decided to make the XFS workqueues nonfreezable again, but the patch for
that hasn't made it to the mainline yet (it was sent to the XFS maintainers
some time ago).

> Though I'm not sure if it's caused by XFS because I don't have any XFS =

> partitions, but I have XFS support compiled in kernel.

This probably is enough to trigger the problem.

> My root partition is reiserfs.
> =

> Tested with suspend to ram on:
> kernel 2.6.21-rc3-git7
> Notebook ASUS A6JC, Intel Core Duo

Greetings,
Rafael
