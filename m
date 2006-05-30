From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch/rft 2.6.17-rc5-git 2/6] add PM_EVENT_PRETHAW
Date: Tue, 30 May 2006 19:17:41 +0000
Message-ID: <20060530191741.GB4017@ucw.cz>
References: <200604241429.52022.david-b@pacbell.net>
	<20060527163837.GE4242@ucw.cz>
	<200606050937.07871.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606050937.07871.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

Looks mostly good...

> This adds a new pm_message_t event type to use when preparing to switch
> into a swsusp snapshot.  Devices that have been initialized by Linux
> after resume (rather than left in power-up-reset state) may need to be
> reset; this new event type gives drivers the chance to do that.
> =

> The drivers that will care about this are those which understand more
> hardware states than just "on" and "reset", and read the hardware state
> during resume().   Hardware state during resume() should be either the
> state left by the preceding suspend(), or a power-lost reset.  When
> the swsusp freeze/thaw mechanism kicks in, a troublesome third state
> could exist:  one state set up by a different kernel instance, before
> a snapshot image is resumed.  This mechanism helps eliminate that state.

...should this go to Documentation/ somewhere?

> + * ON		Driver starts working again, responding to hardware events
> + * 		and software requests.  The hardware may have gone through
> + * 		a power-off reset, or it may have maintained state from the
> + * 		previous suspend() which the driver will rely on while
> + * 		resuming.  On most platforms, there are no restrictions on
> + * 		availability of resources like clocks during resume().
> + *
> + * Other transitions are triggered by messages sent using suspend().  All
> + * these transitions quiesce the driver, so that I/O queues are inactive.
> + * That commonly entails turning off IRQs and DMA; there may be rules

Actually all DMAs must always be turned off. Otherwise swsusp can't
get consistent image. IRQs can be disabled or not (they usually are), howev=
er driver
prefers... but DMA must be off.
						Pavel
-- =

Thanks for all the (sleeping) penguins.
