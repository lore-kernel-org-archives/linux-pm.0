From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
 suspend blockers from user-space
Date: Wed, 26 May 2010 18:18:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005261815480.1328-100000__9698.16696965626$1274916763$gmane$org@iolanthe.rowland.org>
References: <201005262357.28933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005262357.28933.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 26 May 2010, Rafael J. Wysocki wrote:

> On Wednesday 26 May 2010, Peter Zijlstra wrote:
> > On Fri, 2010-05-21 at 15:46 -0700, Arve Hj=C3=B8nnev=C3=A5g wrote:
> > > +To create a suspend blocker from user space, open the suspend_blocker
> > > special
> > > +device file:
> > > +
> > > +    fd =3D open("/dev/suspend_blocker", O_RDWR | O_CLOEXEC);
> > > +
> > > +then optionally call:
> > > +
> > > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_SET_NAME(strlen(name)), name);
> > > +
> > > +To activate the suspend blocker call:
> > > +
> > > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_BLOCK);
> > > +
> > > +To deactivate it call:
> > > +
> > > +    ioctl(fd, SUSPEND_BLOCKER_IOCTL_UNBLOCK);
> > > +
> > > +To destroy the suspend blocker, close the device:
> > > +
> > > +    close(fd);
> > =

> > Urgh, please let the open() be BLOCK, the close() be UNBLOCK, and keep
> > the SET_NAME thing if you really care.
> =

> SET_NAME wouldn't serve any purpose in that case.
> =

> This whole thing is related to the statistics part, which Arve says is
> essential to him.  He wants to collect statistics for each suspend blocker
> activated and deactivated so that he can tell who's causing problems by
> blocking suspend too often.  The name also is a part of this.
> =

> In fact, without the statistics part the whole thing might be implemented
> as a single reference counter such that suspend would happen when it went=
 down
> to zero.

There's also Arve's other main point: These suspend blockers tend to
get used quite a lot.  Opening and closing a file each time has much
higher overhead than a simple ioctl.

All these topics have been covered earlier in this discussion.  Peter =

should go back and read the emails in the linux-pm archive.

Alan Stern
