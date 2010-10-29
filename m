From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] power: Fix typo in status comparison causing
	warning
Date: Fri, 29 Oct 2010 10:08:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010291006340.1588-100000__5243.83036322451$1288361536$gmane$org@iolanthe.rowland.org>
References: <201010290949.11833.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010290949.11833.rjw@sisk.pl>
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
Cc: Kevin Winchester <kjwinchester@gmail.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 29 Oct 2010, Rafael J. Wysocki wrote:

> On Friday, October 29, 2010, Kevin Winchester wrote:
> > GCC version 4.5.1 gives the following warning:
> > =

> > 	drivers/base/power/runtime.c: In function =E2=80=98rpm_check_suspend_a=
llowed=E2=80=99:
> > 	drivers/base/power/runtime.c:146:25: warning: comparison between =E2=
=80=98enum dpm_state=E2=80=99 and =E2=80=98enum rpm_status=E2=80=99
> > =

> > which seems to be a typo in that dev->power.runtime_status
> > should be compared instead of dev->power.status.
> > =

> > Signed-off-by: Kevin Winchester <kjwinchester@gmail.com>
> > ---
> >  drivers/base/power/runtime.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > =

> > diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> > index 126ca49..02c652b 100644
> > --- a/drivers/base/power/runtime.c
> > +++ b/drivers/base/power/runtime.c
> > @@ -143,7 +143,7 @@ static int rpm_check_suspend_allowed(struct device =
*dev)
> >  =

> >  	/* Pending resume requests take precedence over suspends. */
> >  	else if ((dev->power.deferred_resume
> > -			&& dev->power.status =3D=3D RPM_SUSPENDING)
> > +			&& dev->power.runtime_status =3D=3D RPM_SUSPENDING)
> >  	    || (dev->power.request_pending
> >  			&& dev->power.request =3D=3D RPM_REQ_RESUME))
> >  		retval =3D -EAGAIN;
> =

> Ouch, this actually is a serious bug.

Yes indeed.  I should have caught it while reviewing the patch.  A =

quick check shows there are no other similar typos.

> Thanks a lot for the fix, will push to Linus shortly.
> =

> Rafael

Alan Stern
