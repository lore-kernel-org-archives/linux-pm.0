From: Pierre Tardy <tardyp@gmail.com>
Subject: Re: [RFC,
	PATCHv3 3/3] mmc: sdhci: handle wake-up from runtime_pm
Date: Tue, 1 Mar 2011 21:48:37 +0100
Message-ID: <AANLkTi=nWXad7WMRYxu7cvC478qy7ptpotR4K_ATNt_J__23529.0207238451$1299012588$gmane$org@mail.gmail.com>
References: <AANLkTikt1r3j99_ub0ce3_3snjoDXvR2+x6RxcjGfMK8@mail.gmail.com>
	<Pine.LNX.4.44L0.1103011525040.2034-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1103011525040.2034-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Mar 1, 2011 at 9:27 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Tue, 1 Mar 2011, Pierre Tardy wrote:
>
>> >> + =A0 =A0 if (pm_runtime_suspended()) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->waking_up =3D 1;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* Note that we disable temporarly the inte=
rrupt until we do the
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* resume. If we don't then we'll get con=
stantly interrupted
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* until we actually resume.
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* as the irq is shared, this might not b=
e very friendly to our
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* irq sharers but the pm_runtime workque=
ue should really be
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* called soon.
>> >
>> > Instead of disabling the IRQ, would it be possible to tell the device
>> > to stop generating an interrupt request?
>>
>> Well, the device is power gated, so any access to it will cause a bus
>> timeout (depending of the platform)
>
> But could you gate the power back on and then turn off the interrupt
> request?
That's the role of runtime_resume... On some platform, this may need
up to sending some SPI commands to the PMIC, to get those power rails
back on.
Something that you cannot do in interrupt context.

>
> It seems like a foolish design to have an interrupt request that can't
> be turned off by an interrupt handler.
It's what we have for now ( looks like I need to go back to my system
architects to see if we can change that...)

Alan,
thanks for all this feedback. I have now a much more clear view on how
this is working on ACPI, I'll try to see how we can mimic this
behaviour on intel_mid.
