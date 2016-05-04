From: Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: Re: [PATCH] usb: xhci-mtk: fixup mouse wakeup failure during system suspend
Date: Wed, 04 May 2016 11:03:03 +0300
Message-ID: <871t5ifdxk.fsf@intel.com>
References: <1461204293-18243-1-git-send-email-chunfeng.yun@mediatek.com> <1462261458.11651.7.camel@mhfsdcap03> <87vb2vfujq.fsf@intel.com> <1462266591.11651.34.camel@mhfsdcap03> <87mvo7fpuc.fsf@intel.com> <1462324873.11651.57.camel@mhfsdcap03>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45822 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478AbcEDIFW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 4 May 2016 04:05:22 -0400
In-Reply-To: <1462324873.11651.57.camel@mhfsdcap03>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: chunfeng yun <chunfeng.yun@mediatek.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

chunfeng yun <chunfeng.yun@mediatek.com> writes:
> On Tue, 2016-05-03 at 12:33 +0300, Felipe Balbi wrote:
>> Hi,
>>=20
>> chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> >> chunfeng yun <chunfeng.yun@mediatek.com> writes:
>> >> > On Thu, 2016-04-21 at 10:04 +0800, Chunfeng Yun wrote:
>> >> >> Click mouse after xhci suspend completion but before system suspend
>> >> >> completion, system will not be waken up by mouse if the duration of
>> >> >> them is larger than 20ms which is the device UFP's resume signaling
>> >>=20
>> >> what is "them" here ? The duration of what is longer than 20ms ?
>> > They are "xhci suspend completion" and "system suspend completion";
>> >
>> > It's time duration
>>=20
>> okay. So if xhci suspend takes longer than 20ms your SPM doesn't see a
>> wakeup ?
> It is not the time of xhci suspend consumed, but is the time of duration
> from xhci suspend completion to system suspend completion(after BOOT-CPU
> is turned off, SPM will be enabled to receive wakeup event)

Okay, so SPM will be the entity actually handling wakeups, right ? I'm
assuming something like this happens:

echo mem > /sys/power/state
 /* start suspending devices */
  xhci_suspend()
 /* all devices suspended */
 enable_spm()

so, if a mouse button is pressed after xhci_suspend() returns but before
enable_spm() runs, then we're gonna miss that event, am I right ?

I can't think of any way to sort this out. Let's ask on linux-pm (I've
added linux-pm to Cc list)

>> >> >> lasted. Another reason is that the SPM is not enabled before system
>> >>=20
>> >> what's SPM ?
>> > It is System Power Management which is powered off when system is
>> > running in normal mode, and is powered on when system enters suspend
>> > mode. It is used to wakeup system when some wakeup sources, such as
>> > bluetooth or powerkey etc, tigger wakeup event.
>>=20
>> okay, thanks
>>=20
>> >> >> suspend compeltion, this causes SPM also not notice the resume sig=
nal.
>> >>            ^^^^^^^^^^
>> >>            completion
>> >>=20
>> >> >> So in order to reduce the duration less than 20ms, make use of
>> >> >> syscore's suspend/resume interface.
>> >>=20
>> >> no, this is the wrong approach
>> > But it seems only one workable approach from software side
>>=20
>> I wouldn't say that. It seems to me SPM should be enabled earlier.
> Yes, but normally SPM should be enabled after all CPUS are turned off,
> so it's difficult to do that, I mean enable SPM before turning off CPUS

is it a requirement that SPM should be enabled only after all CPUs are
turned off ? If that's the case, then any device in the system might
have missed wakeups. This doesn't seem like a good design to me; unless
I'm missing something...

>> >> >> Because the syscore runs on irq disabled context, and xhci's
>> >> >> suspend/resume calls some sleeping functions, enable local irq
>> >> >> and then disable it during suspend/resume. This may be not a probl=
em,
>> >> >> since only boot CPU is runing.
>> >>=20
>> >> another problem :) calling local_irq_{enable,disable}() is an indicat=
ion
>> >> that something's wrong.
>> > Oh!
>> >
>> > BTW: There will be warning logs if they are not called.
>>=20
>> yeah, I got that :-) But it's still wrong to use
>> local_irq_{enable,disable}() the way you're using them :-)
> Yes
>
> Thank you very much.
>>=20
>
>

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXKay4AAoJEIaOsuA1yqREX9oP/AvWOYVgqhiBKyJZ7PqVFuL8
tPRhhGMA+/48xuanbvfYiWpvIyj67Pc9Rn+x3bdo//FJ2TsspsQHZsttTFB74f5k
082Nqggvw07u922VKgnjFzFTKsmCcl96hPvx8ItPuCxF3N0xx1X7kt0A/+52+Kan
mzk3ut/qI1zH8+SRl5dsHh/wZkZP1NNogcebGFgsJQxcQy3uWkVzNG7WUexjuT8r
mN3m90guGK7zrZr/atNjK65tUH//E29C7VLfWMCUEgyziOq87ChUac5JpAmDFGh3
qNRr33z0VC2yVVTygPn4GOsIsLoZc+86S2mSHfO0Mvxt/+GvIS3BGE8Wj+bp3RUR
wgouPsF1tv6qPsVUB8lxjNSrL2IJqmr6TPSsPnQRaniCUeVpHyfsCoOf4eSP9u0k
GPZ8ap5ILCtqpNnICKFwZZMUaiuAAQ1DhJdgrNijXT9WfE7mDIfZoU5qlm4GS2KP
k6e1zAb1gTnNnpVvMsVXsgrmsgf/8sfVo/xFjuNIMpM2QW5L7D+2SRYn9vYV6iSA
y/9jIq9Yl1OwJKvbhrAOLybWtcoM300GS27RNC0s8dZsl4W6QZjbm+sT9c1ESQhb
T5J5LmZ+Qmsl4D6f9PwBMpJ1OtZgQJGElysV6QNCkJsEI2H+WAqU6Qjx5rWvVjNM
YFM2bnqONqSidSbxwick
=fl1n
-----END PGP SIGNATURE-----
--=-=-=--
