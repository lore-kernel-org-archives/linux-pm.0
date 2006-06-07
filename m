From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rft 2.6.17-rc5-git 2/6] add PM_EVENT_PRETHAW
Date: Tue, 6 Jun 2006 18:02:06 -0700
Message-ID: <200606061802.07083.david-b@pacbell.net>
References: <200604241429.52022.david-b@pacbell.net>
	<200606050937.07871.david-b@pacbell.net>
	<20060530191741.GB4017@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060530191741.GB4017@ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 30 May 2006 12:17 pm, Pavel Machek wrote:
> Hi!
> =

> Looks mostly good...
> =

> > This adds a new pm_message_t event type to use when preparing to switch
> > into a swsusp snapshot.  Devices that have been initialized by Linux
> > after resume (rather than left in power-up-reset state) may need to be
> > reset; this new event type gives drivers the chance to do that.
> > =

> > The drivers that will care about this are those which understand more
> > hardware states than just "on" and "reset", and read the hardware state
> > during resume().   ...
> =

> ...should this go to Documentation/ somewhere?

I have a separate doc patch, which I will send once the code passes
sufficient muster.


> > + * Other transitions are triggered by messages sent using suspend().  =
All
> > + * these transitions quiesce the driver, so that I/O queues are inacti=
ve.
> > + * That commonly entails turning off IRQs and DMA; there may be rules
> =

> Actually all DMAs must always be turned off. Otherwise swsusp can't
> get consistent image. IRQs can be disabled or not (they usually are), how=
ever driver
> prefers... but DMA must be off.

I think there are cases where DMA should still be active, but didn't want to
go into them.  For FREEZE, DMA should stop, yes.

Surely there'd be no point in **disllowing** system states where almost
everything is idled (CPU, most peripherals, etc) but the I/O is flowing?
Normally it's felt to be a _good_ thing to get the system into modes
like that.

- Dave
