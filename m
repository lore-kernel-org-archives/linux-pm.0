From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Wakeup-events implementation
Date: Wed, 18 Aug 2010 11:32:19 +0100
Message-ID: <20100818103219.GA10255@sirena.org.uk>
References: <Pine.LNX.4.44L0.1008171109030.1656-100000@iolanthe.rowland.org>
	<201008172121.50319.rjw@sisk.pl>
	<AANLkTinNHR0ZkzrtD6xuR5fCrY2FBc7apUUAw1tc58pZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTinNHR0ZkzrtD6xuR5fCrY2FBc7apUUAw1tc58pZ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arve Hj?nnev?g <arve@android.com>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 17, 2010 at 05:40:37PM -0700, Arve Hj?nnev?g wrote:
> 2010/8/17 Rafael J. Wysocki <rjw@sisk.pl>:

> >> On the other hand, a driver generally doesn't
> >> know until a suspend starts whether or not its devices should be
> >> enabled for wakeup.

> Why? How is the driver notified on suspend that it needs to be enabled
> for wakeup.

There's the wakeup API in pm_wakeup.h, plus subsystem specific knowledge
about what sensible defaults for the hardware in much the same way as we
handle what to do when we suspend.

> >> In addition, you retain all these debugging facilities in your
> >> production builds, not just in the debug kernels. ?Doesn't this seem
> >> excessive?

> > It definitely seems so.

> There are two reasons for keeping the debugging facilities in production builds.
> 1. The debugging information is useful for debugging problems in the field.
> 2. We want to test with the same code we ship.

Plus the fact that power usage tends to be very dynamic often with
strong dependencies on usage patterns.  Power usage is something that
end users will want to debug as well as developers, though most likely
not in the same detail.
