From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Sun, 1 Feb 2009 02:32:21 +0100
Message-ID: <200902010232.22055.rjw@sisk.pl>
References: <20090131074743.GA13633@bulgaria.corp.google.com>
	<200902010118.25810.rjw@sisk.pl>
	<d6200be20901311717i2c49cd45ged21066df395900b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20901311717i2c49cd45ged21066df395900b@mail.gmail.com>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Sunday 01 February 2009, Arve Hj=F8nnev=E5g wrote:
> On Sat, Jan 31, 2009 at 4:18 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > If the user forcibly puts the device into suspend, it's very much like =
powering
> > off.  The kernel shouldn't prevent that from happening unless in error
> > conditions.
> =

> No, when the phone is powered off, it is not expected to ring. When it
> is suspended it is expected to ring.
> =

> > If incoming calls are supposed to wake up the system, then there are two
> > possibilities:
> > - the already started suspend sequence may be aborted and the system ma=
y be put
> >  into the low power state,
> =

> I assume you mean high power state not low power state, or does low
> power state mean early-suspend state. If so, locking a wakelock will
> accomplish this.

Actually, I meant the working state.  Aborting suspend sequence always means
go back to the working state.

Also, I think the device that detected the incoming call should abort the
suspend sequence by refusing to suspend.

> > - the system may be suspended and then immediately woken up.
> =

> If you mean this as a general strategy, and not a specific outcome,
> then it does not always work (for the reasons I have already stated).

I meant a specific outcome.

It may be impossible to abort suspend if the call comes in sufficiently
late.

Thanks,
Rafael
