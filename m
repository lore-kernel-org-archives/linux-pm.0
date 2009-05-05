From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Tue, 5 May 2009 16:57:45 -0700
Message-ID: <d6200be20905051657p31349e5ara8ad1ad9eb755c6b__36227.2536069669$1241568027$gmane$org@mail.gmail.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<20090504235405.647772ed.akpm@linux-foundation.org>
	<87ocu7a6ng.fsf@deeprootsystems.com>
	<d6200be20905051358m34c2be02ped84ad4158cd9865@mail.gmail.com>
	<87eiv35eg6.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87eiv35eg6.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

2009/5/5 Kevin Hilman <khilman@deeprootsystems.com>:
> Arve Hj=F8nnev=E5g <arve@android.com> writes:
>
>> On Tue, May 5, 2009 at 8:52 AM, Kevin Hilman
> [...]
>
>> By leaving the interrupt enabled you prevent check_wakeup_irqs from
>> aborting suspend.
>
> Yes, but it doesn't prevent platform-specific code from aborting
> suspend. =A0On OMAP, the platform-specific suspend enter hook does a
> last check for pending enabled interrupts very late in the sequence.
> It seems to me that the platform specific code is the best place to do
> this.

It will not be pending anymore if the interrupt triggered before all
interrupts were masked at the cpu.

> On a related note, what happens if your device triggers an interrupt
> between check_wakeup_irqs() and the actual suspend? =A0Since it is a
> wakeup IRQ, wouldn't you want it to abort the suspend too?
>

check_wakeup_irqs is called after masking interrupts, so your existing
platform specific check should catch it.

-- =

Arve Hj=F8nnev=E5g
