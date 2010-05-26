From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Thu, 27 May 2010 00:34:44 +0200
Message-ID: <201005270034.44492.rjw__25716.6333533407$1274917255$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005261815480.1328-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1005261815480.1328-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 27 May 2010, Alan Stern wrote:
> On Wed, 26 May 2010, Rafael J. Wysocki wrote:
> =

> > On Wednesday 26 May 2010, Peter Zijlstra wrote:
> > > On Fri, 2010-05-21 at 15:46 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> > > > +To create a suspend blocker from user space, open the suspend_bloc=
ker
> > > > special
> > > > +device file:
> > > > +
> > > > +    fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> > > > +
> > > > +then optionally call:
> > > > +
> > > > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_SET_NAME(strlen(name)), name);
> > > > +
> > > > +To activate the suspend blocker call:
> > > > +
> > > > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_BLOCK);
> > > > +
> > > > +To deactivate it call:
> > > > +
> > > > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_UNBLOCK);
> > > > +
> > > > +To destroy the suspend blocker, close the device:
> > > > +
> > > > +    close(fd);
> > > =

> > > Urgh, please let the open() be BLOCK, the close() be UNBLOCK, and keep
> > > the SET_NAME thing if you really care.
> > =

> > SET_NAME wouldn't serve any purpose in that case.
> > =

> > This whole thing is related to the statistics part, which Arve says is
> > essential to him.  He wants to collect statistics for each suspend bloc=
ker
> > activated and deactivated so that he can tell who's causing problems by
> > blocking suspend too often.  The name also is a part of this.
> > =

> > In fact, without the statistics part the whole thing might be implement=
ed
> > as a single reference counter such that suspend would happen when it we=
nt down
> > to zero.
> =

> There's also Arve's other main point: These suspend blockers tend to
> get used quite a lot.  Opening and closing a file each time has much
> higher overhead than a simple ioctl.
> =

> All these topics have been covered earlier in this discussion.  Peter =

> should go back and read the emails in the linux-pm archive.

Yeah.

Although with a reference counter the special device file won't be necessar=
y.

Rafael
