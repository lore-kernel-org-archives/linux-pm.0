From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [RFC v2]: Issues implementing clock handling
 mechanism within UART driver
Date: Fri, 29 Jul 2011 16:54:44 +0530
Message-ID: <CAAL8m4xjN15RfwbDd_c1HdoKY327CWOn5qwuoUT=fop4J0K5cw__9029.59319432757$1311938772$gmane$org@mail.gmail.com>
References: <1311845395-31917-1-git-send-email-govindraj.raja@ti.com>
	<20110729095512.GE31013@legolas.emea.dhcp.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110729095512.GE31013@legolas.emea.dhcp.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: balbi@ti.com
Cc: Partha Basak <p-basak2@ti.com>, Tero Kristo <t-kristo@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Jul 29, 2011 at 3:25 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>

Thanks for replying.

> On Thu, Jul 28, 2011 at 02:59:55PM +0530, Govindraj.R wrote:
>> Proposal:
>> --------
>> =A0 =A0 =A0 1. For the UART, follow the current approach of locking the =
console in
>> =A0 =A0 =A0 =A0 =A0Idle/Suspend path before cutting the clock but using =
pm_runtime_putsync.
>> =A0 =A0 =A0 =A0 =A0That is, continue using the prepare/resume Idle calls=
 in idle path.
>
> I believe you should be using ->prepare() to prevent that any other
> work on UART won't trigger a console_write() right now. Maybe only
> queueing the work for after ->complete() or, maybe, just ignoring the
> work and loosing some prints, dunno.
>

Yes true, for suspend path but for Idle path we don't have any such
mechanism.

>> =A0 =A0 =A0 2. Other Approach would be adding conditions to debug prints=
 from
>> =A0 =A0 =A0 =A0 =A0omap_device/ omap_hwmod/clock_framework avoid calling=
 these debug
>> =A0 =A0 =A0 =A0 =A0prints for uart.
>> =A0 =A0 =A0 =A0 =A0Or Even a debug macro that would not debug prints if =
the context is
>> =A0 =A0 =A0 =A0 =A0from uart.
>
> yeah, that might work but then again, if we were using 8250.c, would we
> have this limitation ??
>

Its not necessary which driver we use, its about clock handling mechanism
where it has to be done.

if we add clock handling mechanism into the driver, from driver context
handling clocks + managing the printks for the same uart port is a
issue, due to reasons said earlier.

> I think that, maybe, your best call would be to capture console_write()
> calls into an internal temporary buffer on ->prepare() and flush it once
> ->complete() is called ?
>

IIUC ->prepare and -> complete are only for suspend path
when we do system wide suspend

for normal idle path get_sync and put_sycn we dont have any ->prepare
or -> complete where we can buffer the contents and flush later.

> BTW, where are the patches ? :-)

I have done clock gating in idle path integrating irq chaining patches.
hosted in gitorious here[1].

Was consolidating whether this approach is OK,
or
Are there any other approaches that I should consider?

--
Thanks,
Govindraj.R

[1]: https://gitorious.org/runtime_3-0/runtime_3-0/commits/wip_irqchn


>
> --
> balbi
>
