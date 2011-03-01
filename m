From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC,
 PATCHv3 3/3] mmc: sdhci: handle wake-up from runtime_pm
Date: Tue, 1 Mar 2011 15:27:54 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1103011525040.2034-100000__36613.757236819$1299011323$gmane$org@iolanthe.rowland.org>
References: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Tardy <tardyp@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 1 Mar 2011, Pierre Tardy wrote:

> >> + =A0 =A0 if (pm_runtime_suspended()) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->waking_up =3D 1;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Note that we disable temporarly the inter=
rupt until we do the
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* resume. If we don't then we'll get cons=
tantly interrupted
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* until we actually resume.
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* as the irq is shared, this might not be=
 very friendly to our
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* irq sharers but the pm_runtime workqueu=
e should really be
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* called soon.
> >
> > Instead of disabling the IRQ, would it be possible to tell the device
> > to stop generating an interrupt request?
> =

> Well, the device is power gated, so any access to it will cause a bus
> timeout (depending of the platform)

But could you gate the power back on and then turn off the interrupt =

request?

It seems like a foolish design to have an interrupt request that can't
be turned off by an interrupt handler.

Alan Stern
