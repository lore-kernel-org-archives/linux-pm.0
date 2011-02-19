From: Rabin Vincent <rabin@rab.in>
Subject: Re: platform/i2c busses: pm runtime and system sleep
Date: Sat, 19 Feb 2011 12:54:52 +0530
Message-ID: <AANLkTinb0zVSUyNBAySH7K7=3bX-ecoQa--CzPJ+OM_b__1924.56937297738$1298100411$gmane$org@mail.gmail.com>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
	<20110218202744.GA19427@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110218202744.GA19427@n2100.arm.linux.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.ml.walleij@gmail.com>, LKML <linux-kernel@vger.kernel.org>, linux-i2c@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 19, 2011 at 01:57, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Do we have any pressing need to convert AMBA stuff? =A0I haven't heard any
> reason yet to convert them to runtime PM - they don't even make any
> runtime PM calls.
>
> Maybe Linus can comment on the PM stuff as he has SoCs with these in.
> As my boards don't have any sensible PM support, I don't have any
> visibility of what PM facilities would be required.

The rationale for runtime power control is the same as that for
65500fa94aaeb3 "ARM: 6467/1: amba: optional PrimeCell core voltage
switch".

As compared to the regulator API which that patch is using, the runtime
pm usage is more flexible (for example allowing certain power control
APIs to be called from atomic context), provides callbacks for
asynchronous turnoff with callbacks back to the driver to save/restore
state (runtime_suspend()/runtime_resume()), and provides core support
for things like "autosuspend" which allows delaying suspend until some
time after last inactivity.  Using runtime PM also allows use of the new
device-level power domain support ("PM: Add support for device power
domains", in -next) to easily implement SoC-specific handling.

We need to first add bus support for this to allow drivers to use this
API.  It is possible to make the AMBA patch smaller and touch only the
AMBA bus code by implementing support for the legacy bus-specific
suspend/resume calls, and drivers can be later converted to pm-ops as
needed.
