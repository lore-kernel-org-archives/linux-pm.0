From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] usb: xhci-mtk: fixup mouse wakeup failure during system suspend
Date: Wed, 04 May 2016 14:56:34 +0300
Message-ID: <87mvo6dojx.fsf@intel.com>
References: <1461204293-18243-1-git-send-email-chunfeng.yun@mediatek.com> <1462261458.11651.7.camel@mhfsdcap03> <87vb2vfujq.fsf@intel.com> <1462266591.11651.34.camel@mhfsdcap03> <87mvo7fpuc.fsf@intel.com> <1462324873.11651.57.camel@mhfsdcap03> <871t5ifdxk.fsf@intel.com> <1462359261.11651.69.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:13156 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752357AbcEDL6n (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 May 2016 07:58:43 -0400
In-Reply-To: <1462359261.11651.69.camel@mhfsdcap03>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chunfeng yun <chunfeng.yun@mediatek.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> > On Tue, 2016-05-03 at 12:33 +0300, Felipe Balbi wrote:
>> >> Hi,
>> >>=20
>> >> chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> >> >> chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> >> >> > On Thu, 2016-04-21 at 10:04 +0800, Chunfeng Yun wrote:
>> >> >> >> Click mouse after xhci suspend completion but before system sus=
pend
>> >> >> >> completion, system will not be waken up by mouse if the duratio=
n of
>> >> >> >> them is larger than 20ms which is the device UFP's resume signa=
ling
>> >> >>=20
>> >> >> what is "them" here ? The duration of what is longer than 20ms ?
>> >> > They are "xhci suspend completion" and "system suspend completion";
>> >> >
>> >> > It's time duration
>> >>=20
>> >> okay. So if xhci suspend takes longer than 20ms your SPM doesn't see a
>> >> wakeup ?
>> > It is not the time of xhci suspend consumed, but is the time of durati=
on
>> > from xhci suspend completion to system suspend completion(after BOOT-C=
PU
>> > is turned off, SPM will be enabled to receive wakeup event)
>>=20
>> Okay, so SPM will be the entity actually handling wakeups, right ? I'm
>> assuming something like this happens:
>>=20
>> echo mem > /sys/power/state
>>  /* start suspending devices */
>>   xhci_suspend()
>>  /* all devices suspended */
>>  enable_spm()
>>=20
>> so, if a mouse button is pressed after xhci_suspend() returns but before
>> enable_spm() runs, then we're gonna miss that event, am I right ?
> Yes, you are right.
>>=20
>> I can't think of any way to sort this out. Let's ask on linux-pm (I've
>> added linux-pm to Cc list)
> Thanks
>>=20
>> >> >> >> lasted. Another reason is that the SPM is not enabled before sy=
stem
>> >> >>=20
>> >> >> what's SPM ?
>> >> > It is System Power Management which is powered off when system is
>> >> > running in normal mode, and is powered on when system enters suspend
>> >> > mode. It is used to wakeup system when some wakeup sources, such as
>> >> > bluetooth or powerkey etc, tigger wakeup event.
>> >>=20
>> >> okay, thanks
>> >>=20
>> >> >> >> suspend compeltion, this causes SPM also not notice the resume =
signal.
>> >> >>            ^^^^^^^^^^
>> >> >>            completion
>> >> >>=20
>> >> >> >> So in order to reduce the duration less than 20ms, make use of
>> >> >> >> syscore's suspend/resume interface.
>> >> >>=20
>> >> >> no, this is the wrong approach
>> >> > But it seems only one workable approach from software side
>> >>=20
>> >> I wouldn't say that. It seems to me SPM should be enabled earlier.
>> > Yes, but normally SPM should be enabled after all CPUS are turned off,
>> > so it's difficult to do that, I mean enable SPM before turning off CPUS
>>=20
>> is it a requirement that SPM should be enabled only after all CPUs are
>> turned off ? If that's the case, then any device in the system might
>> have missed wakeups. This doesn't seem like a good design to me; unless
>> I'm missing something...
> Yes, it's a requirement.
>
> If the wakeup source is level trigger, and will keep it until SPM notice
> it. Although USB wakeup is level trigger, but it just last at most 20ms
> and clear itself automatically.

who's clearing USB wakeup after 20ms ? Sure, it's a requirement by the
USB spec that host should drive reset for *at least* 20ms, but I don't
remember the exact wordings WRT remote wakeup

/me reads

Okay, here it is, section 7.1.7.7 of USB 2.0 Spec states:

	"The remote wakeup device must hold the resume signaling for at
        least 1 ms but for no more than 15 ms (TDRSMUP). At the end of
        this period, the device stops driving the bus (puts its drivers
        into the high-impedance state and does not drive the bus to the
        J state)."

IOW, the mouse is not at fault here. Remote wakeup can last anywhere
between 1ms and 15ms. If your system can't cope with it, then I'd say
it's a problem with your system and you shouldn't allow XHCI to go to
such deep power states until SPM is enabled.

I really tried finding the correct piece of code which does this for PCI
devices, but basically it's treated as an IRQ and as long as
enable_irq_wake() or the sysfs file is set to true, then PME gets
enabled (hopefully PCI folks can confirm this statement).

Very recently Tony Lindgren added proper handling of wakeup signals as
IRQs for non-PCI systems too (see 4990d4fe327b PM / Wakeirq: Add
automated device wake IRQ handling), wonder if you could treat SPM
similarly.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXKeNzAAoJEIaOsuA1yqRENG0P/1gs4U6jurng0gk37oDVaqYi
LBw1VijiSTSgEuikApr+L52plvlMPKd/NbLQSj51bsrXtOH79H9MmCUK0tYY2YZ0
Fw9xhIJtjaKuG5TJYXtz/s8SRANAPq0B2MjmWS4O/pNgh3JuPJMCriqwpDPE9ArC
j8knk/PGd0AV8UnyrA9Q7JtpH0lA0AkohJUBa4DQC82/NOpT6wHe09HvKR1io6MO
hLNKnfPxyhl/PJsNzX9GV/LsHa6xYeJSMHCDXzqDAu3A6oJhhRUTAnyAfa91rHmy
34q7WEuqq+zexjgfhMhC1yZ/eL0Y/cyv1hYKmwvgIyVJyCB6YwNmd8GtJ5c0Tfyc
pB0/jQVclNRVWni/0Keof+F+6KOB+3jdqFU+sPQdi6vt90Nwm2pkTCUJCuEBY/gc
s7+UxmCvbcCukuVBhzRd8W6dEN+WXQda2OdFPUrxw3JYu7nmzu7YfXlOOkzsnbse
wQY03ZSG87uFvUB3UWoFGYZCYFqi/sqcuSjN/kWNIbAIAPXpP+7yM73eQnIC0Sq9
0mK7XgguxvALbFGhLHSuAocFiIZBTfdxDce7YlYSyvFAzYn4ukObQhx+Dl5VZd70
0zMNi7xTGwU0c1jwI+0Pru3qTkz5NRHj2TPLMGOMvHCGeIM9NXpK0dz59WuW523S
eUb0+369Vn3FtcBSFFP4
=1+G6
-----END PGP SIGNATURE-----
--=-=-=--
