From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 00:04:17 +0100
Message-ID: <200902190004.18878.rjw__15365.5156995685$1234998515$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0902162156380.24097-100000@netrider.rowland.org>
	<200902182217.48321.rjw@sisk.pl>
	<d6200be20902181435o1794007bpfbab1f9e41979bad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20902181435o1794007bpfbab1f9e41979bad@mail.gmail.com>
Content-Disposition: inline
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
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 18 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Wed, Feb 18, 2009 at 1:17 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Wednesday 18 February 2009, Arve Hj=F8nnev=E5g wrote:
> >> On Tue, Feb 17, 2009 at 3:21 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Tuesday 17 February 2009, Alan Stern wrote:
> =

> >> >> Kernel wakelocks are a separate matter.  They are more like a form =
of
> >> >> optimization, preventing the kernel from starting an auto-suspend w=
hen
> >> >> some driver knows beforehand that it will return -EBUSY.
> >> >
> >> > I think kernel-side autosuspend (or rather autosleep) should only ha=
ppen
> >> > after certain subset of devices have been suspended using a per-devi=
ce
> >> > run-time autosuspend mechanism.
> >>
> >> When the last wakelock is released the task that we woke up to perform
> >> has finished. Why wait to re-enter suspend.
> >
> > I don't really understand this comment.  Could you please explain a bit?
> =

> If some devices are autosuspended after a local inactivity timeout, I
> don't want to wait for those devices to autosuspend if I know the code
> that needed to run is done. This could cause delays in the normal
> case,

Isn't it a matter of adjusting the inactivity timeouts in a suitable way?

> and it could prevent suspend if a background process (not using
> wakelocks) is accessing a disk more frequently than its idle timeout.

Well, actually, shouldn't it prevent suspend from happening?  Arguably, it =
just
means that the disk is continuously being accessed with respect to the inac=
tive
timeout granularity.

Rafael
