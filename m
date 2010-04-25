From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue
	is not empty.
Date: Sun, 25 Apr 2010 04:30:30 +0200
Message-ID: <201004250430.31054.rjw__47853.6866525703$1272165368$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1004241035260.6848-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1004241035260.6848-100000@netrider.rowland.org>
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
Cc: Randy Dunlap <randy.dunlap@oracle.com>, =?iso-8859-1?q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Jiri Kosina <jkosina@suse.cz>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Saturday 24 April 2010, Alan Stern wrote:
> On Fri, 23 Apr 2010, Arve Hj=F8nnev=E5g wrote:
> =

> > On Fri, Apr 23, 2010 at 2:08 PM, Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > > On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
> > >> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
> > >> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that=
 will
> > >> > block suspend while the event queue is not empty. This allows user=
space
> > >> > code to process input events while the device appears to be asleep.
> > >>
> > >> All new ioctls need to be added to Documentation/ioctl/ioctl-number.=
txt,
> > >> please.
> > >
> > > I do not see the reason for it to be in the kernel still. Have a proc=
ess
> > > that listens to all input devices (or subset of them), once events st=
op
> > > coming initiate suspend.

This solution is not practical with the Android user space AFAICT.
 =

> > I think the document added by the first patch explains this. The
> > solution you propose above will ignore a wakeup key pressed right
> > after user space decides to initiate suspend.
> =

> Is there some reason why this feature needs to be enabled by an =

> ioctl?  Why not make this suspend blocker permanently enabled?

The ioctl is there so that user space can use suspend blockers, which is
needed because only user space know that some activities are going to conti=
nue
and therefore the system should not be suspended (like playing music "in the
background").

>From all of the interfaces that could be used for this purpose ioctl appear=
s to
be the most convenient (we need something that is per process and allows us
to carry out four operations: creat, destroy, activate, deactivate).

Rafael
