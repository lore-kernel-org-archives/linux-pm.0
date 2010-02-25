From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Thu, 25 Feb 2010 23:57:03 +0100
Message-ID: <201002252357.04056.rjw@sisk.pl>
References: <4B86F96A.1010306@maroy.hu> <201002252337.39683.rjw@sisk.pl>
	<4B86FE66.7000901@maroy.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B86FE66.7000901@maroy.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?iso-8859-2?q?=C1kos_Mar=F3y?= <akos@maroy.hu>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday 25 February 2010, =C1kos Mar=F3y wrote:
> Rafael,
> =

> > Please try
> > =

> > # echo core > /sys/power/pm_test
> > # echo disk > /sys/power/state
> > =

> > That should return to the command prompt after ~5 sec.
> =

> thanks. indeed, it does return, this is what I get in /var/log/messages:
> =

> Feb 25 23:46:24 tonkachi kernel: [   77.846865] PM: Syncing filesystems
> ... done.
> Feb 25 23:46:24 tonkachi kernel: [   77.997120] Freezing user space
> processes ... (elapsed 0.00 seconds) done.
> Feb 25 23:46:24 tonkachi kernel: [   77.998042] Freezing remaining
> freezable tasks ... (elapsed 0.00 seconds) done.
> Feb 25 23:46:24 tonkachi kernel: [   77.998269] PM: Preallocating image
> memory... done (allocated 1936029 pages)
> Feb 25 23:46:24 tonkachi kernel: [   80.480913] PM: Allocated 7744116
> kbytes in 2.48 seconds (3122.62 MB/s)
> Feb 25 23:46:24 tonkachi kernel: [   80.480918] Suspending console(s)
> (use no_console_suspend to debug)
> Feb 25 23:46:24 tonkachi kernel: [   81.030959] Registered led device:
> iwl-phy0::radio
> Feb 25 23:46:24 tonkachi kernel: [   81.030989] Registered led device:
> iwl-phy0::assoc
> Feb 25 23:46:24 tonkachi kernel: [   81.031016] Registered led device:
> iwl-phy0::RX
> Feb 25 23:46:24 tonkachi kernel: [   81.031041] Registered led device:
> iwl-phy0::TX
> Feb 25 23:46:24 tonkachi kernel: [   81.166877] Restarting tasks ...
> Feb 25 23:46:24 tonkachi kernel: [   81.169743] done.
> =

> =

> my dmesg is much more talkative - please find it attached.

Hmm.  Then perhaps you need this patch:
http://patchwork.kernel.org/patch/81830/

Rafael
