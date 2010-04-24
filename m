From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 8/9] Input: Block suspend while event queue
 is not empty.
Date: Sat, 24 Apr 2010 10:36:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1004241035260.6848-100000__8272.81115712157$1272119901$gmane$org@netrider.rowland.org>
References: <z2wd6200be21004232202me5d59908y25bf9523fd62edce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <z2wd6200be21004232202me5d59908y25bf9523fd62edce@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, =?ISO-8859-1?Q?M=E1rton_N=E9meth?= <nm127@freemail.hu>, Jiri Kosina <jkosina@suse.cz>, Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sven Neumann <s.neumann@raumfeld.com>, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, linux-pm@lists.linux-foundation.org, Tero Saarni <tero.saarni@gmail.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Fri, 23 Apr 2010, Arve Hj=F8nnev=E5g wrote:

> On Fri, Apr 23, 2010 at 2:08 PM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Friday 23 April 2010 01:56:25 pm Randy Dunlap wrote:
> >> On Thu, 22 Apr 2010 18:08:57 -0700 Arve Hj=F8nnev=E5g wrote:
> >> > Add an ioctl, EVIOCSSUSPENDBLOCK, to enable a suspend_blocker that w=
ill
> >> > block suspend while the event queue is not empty. This allows usersp=
ace
> >> > code to process input events while the device appears to be asleep.
> >>
> >> All new ioctls need to be added to Documentation/ioctl/ioctl-number.tx=
t,
> >> please.
> >
> > I do not see the reason for it to be in the kernel still. Have a process
> > that listens to all input devices (or subset of them), once events stop
> > coming initiate suspend.
> >
> =

> I think the document added by the first patch explains this. The
> solution you propose above will ignore a wakeup key pressed right
> after user space decides to initiate suspend.

Is there some reason why this feature needs to be enabled by an =

ioctl?  Why not make this suspend blocker permanently enabled?

Alan Stern
