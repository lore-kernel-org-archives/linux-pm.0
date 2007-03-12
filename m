From: Roman Jarosz <kedgedev@centrum.cz>
Subject: Re:
	=?utf-8?q?SMP_suspend_broken_due_to_=22swsusp=3A_Chang?=
	=?utf-8?q?e_code=09ordering_in_disk=2Ec=22_et_al=2E?=
Date: Mon, 12 Mar 2007 16:57:43 +0000 (UTC)
Message-ID: <loom.20070312T173052-675@post.gmane.org>
References: <1172201385.15769.32.camel@johannes.berg>
	<1172277080.3870.108.camel@johannes.berg>
	<200702240957.22636.rjw@sisk.pl> <200702242154.27167.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
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
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki <rjw <at> sisk.pl> writes:

> =

> On Saturday, 24 February 2007 09:57, Rafael J. Wysocki wrote:
> > On Saturday, 24 February 2007 01:31, Johannes Berg wrote:
> > > Hi,
> > > =

> > > > Could you please try the appended patch?  It's somewhat hackish, bu=
t =

may work.
> > > =

> > > Not before Monday or Tuesday unfortunately, I'm away from the machine.
> > =

> > Okay, no big deal.  I think I'll be able to reproduce the problem here. =

> > =

> > > Maybe I can find someone else willing to test who has the same box.
> > > =

> > > > The idea is to do nothing on CPU unplug if the CPU's worker thread =
is =

frozen
> > > > and later check in the thread itself if it has been replaced by ano=
ther =

one.
> > > =

> > > Yeah that should work. That patch won't apply to my tree though unles=
s I
> > > actually go to -mm2 as well :)
> > =

> > Ah, sorry.  I'll prepare a version against 2.6.21-rc1.  Apart from this=
, I
> > think there's a better solution, but I have to verify that.
> =

> No, this one is better IMO.
> =

> Appended is the version against 2.6.21-rc1.  It seems to work for me, but=
 I'd
> like someone else to confirm it.
> =


I had the same problem as Johannes and I can confirm that your patch works.

Though I'm not sure if it's caused by XFS because I don't have any XFS =

partitions, but I have XFS support compiled in kernel.
My root partition is reiserfs.

Tested with suspend to ram on:
kernel 2.6.21-rc3-git7
Notebook ASUS A6JC, Intel Core Duo

Thanks,
Roman Jarosz
