From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [patch update 2 fix] PM: Introduce core framework
	for run-time PM of I/O devices
Date: Mon, 22 Jun 2009 16:27:29 +0900
Message-ID: <aec7e5c30906220027v63c88e8aj32950a8d84558cce@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906192141380.4003-100000@netrider.rowland.org>
	<Pine.LNX.4.44L0.0906201010590.12994-100000@netrider.rowland.org>
	<aec7e5c30906212320v3e3e991fyd028d005675f1e25@mail.gmail.com>
	<20090621234324.06fda564@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090621234324.06fda564@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 22, 2009 at 3:43 PM, Arjan van de Ven<arjan@infradead.org> wrot=
e:
> On Mon, 22 Jun 2009 15:20:43 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> On Sat, Jun 20, 2009 at 11:30 PM, Alan
>> Stern<stern@rowland.harvard.edu> wrote:
>> > Some more thoughts...
>> >
>> > Magnus, you might have some insights here. =A0It occurred to me that
>> > some devices can switch power levels very quickly, and the drivers
>> > might therefore want the runtime suspend and resume methods to be
>> > called as soon as possible, even in interrupt context.
>>
>> I'd like to call pm_request_suspend() from interrupt context. I don't
>
> there are some really strong reasons to at least be able to call the
> resume function from an interrupt handler.... shared interrupts are one
> of them.

I suppose you mean that you need to resume the hardware device before
you can check if it has a pending interrupt source? If so then you
also mean that suspended hardware devices may generate interrupts, no?

My plan for SuperH SoC is that runtime suspend always stops the clock,
but register save and power off may happen. Regardless, interrupts are
not generated from suspended hardware devices.

In the rare case of shared interrupts on SuperH we can just skip over
the platform devices that have been runtime suspended since they will
not have generated any interrupt.

But yes, if there is hardware than can generate interrupts from
suspended state then we need to resume from interrupt context. This
probably means that the entire bus hierarchy must resume from
interrupt context as well.

/ magnus
