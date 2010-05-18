From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 7)
Date: Tue, 18 May 2010 23:14:08 +0200
Message-ID: <201005182314.08761.rjw__37232.6392950073$1274217318$gmane$org@sisk.pl>
References: <1273810273-3039-1-git-send-email-arve@android.com>
	<201005182138.04610.rjw@sisk.pl>
	<AANLkTileYiu6pL4eX3lpvpYLuu76A8auZp4xrcDX94BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTileYiu6pL4eX3lpvpYLuu76A8auZp4xrcDX94BQ@mail.gmail.com>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> 2010/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Tuesday 18 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> On Mon, May 17, 2010 at 2:44 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >> > On Monday 17 May 2010, Brian Swetland wrote:
> >> >> On Mon, May 17, 2010 at 1:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wr=
ote:
> >> >> > On Monday 17 May 2010, Arve Hj=F8nnev=E5g wrote:
> >> >> >>
...
> =

> > Now, to make it more "user-friendly", we can simply use
> > queue_delayed_work() with a reasonable delay instead of queue_work() to=
 queue
> > the suspend work (the delay may be configurable via sysfs).
> >
> =

> I can add a delay (and the timeout support code does add a delay as an
> optimization) to the unknown wakeup case, but this does not fix the
> problem of a user turning on opportunistic suspend with a user space
> framework that does not use suspend blockers. If the kernel uses
> suspend blockers to make sure the wakeup event makes it to user space,
> but user space does not block suspend, then the system will suspend
> before the event is processed.

But the user can still manually write to /sys/power/state. :-)

Rafael
