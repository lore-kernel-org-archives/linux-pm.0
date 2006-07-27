From: David Brownell <david-b@pacbell.net>
Subject: Re: sysfs power/state file & dpm_runtime_suspend()
Date: Thu, 27 Jul 2006 08:53:53 -0700
Message-ID: <200607270853.54674.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0607271027400.6315-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0607271027400.6315-100000@iolanthe.rowland.org>
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
To: linux-pm@lists.osdl.org
Cc: ??? <ikhwan.lee@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 27 July 2006 7:43 am, Alan Stern wrote:
> =

> 	Proper runtime power management requires drivers to change their
> 	devices' power states as needed, with no intervention of the PM
> 	core.  Neither power/state nor power.power_state.event is really
> 	necessary for this purpose.

That's a key point that I think was not widely understood early on.  The
driver APIs exist to make sure systems can be cleanly shut down ... not
to reduce power usage.  At best, that sysfs power/state thing is a big
distraction from actually trying to make drivers be power-efficient.

See list archives for the "RFC -- updated Documentation/power/devices.txt"
thread; one of my last posts there has a version of that document with lots
of examples of how runtime power saving works; it does NOT need to involve
any kind of public power state updating.  Things like cpufreq and dynamic
tick, or power-aware idle tasks, don't need to change externally visible
state any more than per-device power saving policies do.

- Dave
