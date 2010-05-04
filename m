From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PM: suspend_block: Add driver to access
	suspend blockers from user-space
Date: Tue, 4 May 2010 22:02:40 +0200
Message-ID: <201005042202.40197.rjw__12316.4998986342$1273003358$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1005021755320.30701-100000@netrider.rowland.org>
	<201005032349.00876.rjw@sisk.pl>
	<x2id6200be21005031501p7f151324wb8bbf928bc2cb25e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <x2id6200be21005031501p7f151324wb8bbf928bc2cb25e@mail.gmail.com>
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

On Tuesday 04 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/3 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Monday 03 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> On Mon, May 3, 2010 at 8:03 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Sunday 02 May 2010, Alan Stern wrote:
> >> >> On Sun, 2 May 2010, Rafael J. Wysocki wrote:
> >> >>
> >> >> > Hmm.  It doesn't seem to be possible to create two different susp=
end blockers
> >> >> > using the same file handle.  So, what exactly is a process suppos=
ed to do to
> >> >> > use two suspend blockers at the same time?
> >> >>
> >> >> Open the file twice, thereby obtaining two file handles.
> >> >
> >> > Well, that's what I thought.
> >> >
> >> > I must admit I'm not really comfortable with this interface.  IMO it=
 would
> >> > be better if _open() created the suspend blocker giving it a name ba=
sed on
> >> > the name of the process that called it.  Something like
> >> > "<process name>_<timestamp>" might work at first sight.
> >> >
> >> > Alternatively, "<process_name><number>", where <number> is 0 for the=
 first
> >> > suspend blocker created by the given process, 1 for the second one e=
tc., also
> >> > seems to be doable.
> >>
> >> I think it is important to let user-space specify the name. If a
> >> process uses multiple suspend blockers, it is impossible to tell what
> >> each one is used for if they are automatically named.
> >
> > Well, the problem is the only purpose of this is user space debugging, =
isn't it?
> >
> At the moment, yes.

OK

> But having an explicit init call also simplifies future expansion.

That's irrelevant.  Let's focus _only_ on the "at the moment" part, please.

And BTW, a "future expansion" is not relevant at all to the patchset at hand
and let's work with this assumption from now on.  OK?

> If we ever need to add back multiple types of
> suspend blockers, we can add an init call with a type argument and
> have the current init call use the default type. If the past we have
> had types that keeps the screen on and prevented idle sleep modes. In
> the future we could for instance want to specify if a suspend blocker
> should prevent suspend when the battery is low or when the lid is
> closed.

_If_ we ever do anything like thie, _then_ we will extend the interface.

> > Now, while I don't think it's generally bad to provide kernel interfaces
> > helping to debug user space, I'm not quite sure if that should be done =
at the
> > expense of the clarity of kernel-user space interfaces.
> >
> > I wonder how many cases there are in which distinguishing between suspe=
nd
> > blockers used by the same user space task is practically relevant.
> >
> =

> I think all of them (when more than one suspend blocker is used).

So how many user space processes use more than one suspend blocker right
now on Android?  I'm interested only in the order of magnitude.

Rafael
