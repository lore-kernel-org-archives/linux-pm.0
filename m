From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 2/4] thermal: rockchip: ensure the otp state before
 resetting the controller
Date: Wed, 21 Oct 2015 09:41:09 +0800
Message-ID: <5626ED35.3010403@gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
 <1445332264-6054-3-git-send-email-wxt@rock-chips.com>
 <CAD=FV=WHvwNGdRZ4Yjwk0zB00o2gFHXLfbAYHai1kM_oBAR4_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAD=FV=WHvwNGdRZ4Yjwk0zB00o2gFHXLfbAYHai1kM_oBAR4_g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Doug,

=E5=9C=A8 2015=E5=B9=B410=E6=9C=8820=E6=97=A5 23:52, Doug Anderson =E5=86=
=99=E9=81=93:
> Caesar,
>
> On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wro=
te:
>> We need the OTP pin is gpio state before resetting the TSADC control=
ler,
>> since the tshut polarity will generate a high signal.
>>
>> Says:
>> The TSHUT temperature is setting more than 80 degree, the default ts=
hut
>> polarity is high.
>>
>> If T > 80C, the OTP output the High Signal.
>> If T < 80C, the OTP output the Low Signal.
>>
>> On the moment, the TSADC controller is reset, the tshut polarity wil=
l be
>> low in a short period of time.
>> So:
>>
>> If T < 80C, the OTP output the High Signal.
>> If T > 80C, the OTP output the Low Signal.
>>
>> In some cases, the OTP pin is connected to the PMIC, maybe the PMIC =
can
>> accept the reset response time to avoid this issue.
>> In other words, the system will be always reboot if we make the OTP =
pin
>> is connected the others IC to control the power.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>>   drivers/thermal/rockchip_thermal.c | 32 ++++++++++++++++++++++++++=
++++++
>>   1 file changed, 32 insertions(+)
> I think you could do this with no code changes to the thermal driver
> if we simply convince Linus W. to apply a change that I posted up jus=
t
> about a year ago.  See:
>
> https://patchwork.kernel.org/patch/5055741/
>
> In v1 of that patch at <https://patchwork.kernel.org/patch/5049041/>
> Linus said he liked it "A lot" and was willing to merge it with Greg
> KH's Ack and with a small comment fix.  I obtained the Ack and fixed
> the comment, but then the patch didn't end up being needed for me and
> so I never bumped it and it got lost...
>
> Maybe you could re-test that patch?  It looks like it has a merge
> conflict with current linuxnext but it looks trivial to resolve.  You
> could re-post my patch or I could repost it and you could add your
> Tested-by.
>
> You'd still want to have a bindings change to describe "init", but at
> least you shouldn't need any code changes.

Okay, https://patchwork.kernel.org/patch/5055741/ that's working for me=
=2E
=46ell free add my  test tag if you resend the patch. (Tested-by: Caesa=
r=20
Wang <wxt@rock-chips.com>)


1634ed8 FROMLIST: drivers/pinctrl: Add the concept of an "init" state
15158f8 FROMLIST: ARM: dts: rockchip: Add the OTP gpio pinctrl
e7d3b88 FROMLIST: thermal: rockchip: change the TSHUT default state
184b154 FROMLIST: thermal: rockchip: ensure the otp state before=20
resetting the controller
9edbe15 FROMLIST: dt-bindings: Sync the dts to this document

Meanwhile, I change the dts as follows.

-               pinctrl-names =3D "default", "otp_out";
+               pinctrl-names =3D "init", "default";
                 pinctrl-0 =3D <&otp_gpio>;
                 pinctrl-1 =3D <&otp_out>;

>
> -Doug
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip


--=20
Thanks,
Caesar
