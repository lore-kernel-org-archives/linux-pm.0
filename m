From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Mon, 3 May 2010 23:49:00 +0200
Message-ID: <201005032349.00876.rjw__12090.4138930657$1272923445$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005021755320.30701-100000@netrider.rowland.org>
	<201005031703.11448.rjw@sisk.pl>
	<m2yd6200be21005031426n87ea43a0k968fd5898ce0b873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m2yd6200be21005031426n87ea43a0k968fd5898ce0b873@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Len Brown <len.brown@intel.com>, Jim Collar <jim.collar@eqware.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Avi Kivity <avi@redhat.com>, Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 03 May 2010, Arve Hj=F8nnev=E5g wrote:
> On Mon, May 3, 2010 at 8:03 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Sunday 02 May 2010, Alan Stern wrote:
> >> On Sun, 2 May 2010, Rafael J. Wysocki wrote:
> >>
> >> > Hmm.  It doesn't seem to be possible to create two different suspend=
 blockers
> >> > using the same file handle.  So, what exactly is a process supposed =
to do to
> >> > use two suspend blockers at the same time?
> >>
> >> Open the file twice, thereby obtaining two file handles.
> >
> > Well, that's what I thought.
> >
> > I must admit I'm not really comfortable with this interface.  IMO it wo=
uld
> > be better if _open() created the suspend blocker giving it a name based=
 on
> > the name of the process that called it.  Something like
> > "<process name>_<timestamp>" might work at first sight.
> >
> > Alternatively, "<process_name><number>", where <number> is 0 for the fi=
rst
> > suspend blocker created by the given process, 1 for the second one etc.=
, also
> > seems to be doable.
> =

> I think it is important to let user-space specify the name. If a
> process uses multiple suspend blockers, it is impossible to tell what
> each one is used for if they are automatically named.

Well, the problem is the only purpose of this is user space debugging, isn'=
t it?

Now, while I don't think it's generally bad to provide kernel interfaces
helping to debug user space, I'm not quite sure if that should be done at t=
he
expense of the clarity of kernel-user space interfaces.

I wonder how many cases there are in which distinguishing between suspend
blockers used by the same user space task is practically relevant.

Thanks,
Rafael
