From: Caesar Wang <caesar.upstream@gmail.com>
Subject: Re: [PATCH 3/4] thermal: rockchip: change the TSHUT default state
Date: Wed, 21 Oct 2015 10:16:55 +0800
Message-ID: <5626F597.8060601@gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
 <1445332264-6054-4-git-send-email-wxt@rock-chips.com>
 <CAD=FV=Vo1Wf6opTc5jQjm-nXd=BCJxeggipPj4ER9Ehutxs_6w@mail.gmail.com>
 <5626EEB2.50101@gmail.com>
 <CAD=FV=UNyjJmN4TtZ+1DOeM_OYikRAUhYsN=F_f-q5MA_MVFag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:35061 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbbJUCRB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2015 22:17:01 -0400
In-Reply-To: <CAD=FV=UNyjJmN4TtZ+1DOeM_OYikRAUhYsN=F_f-q5MA_MVFag@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Doug,

=E5=9C=A8 2015=E5=B9=B410=E6=9C=8821=E6=97=A5 10:14, Doug Anderson =E5=86=
=99=E9=81=93:
> Caesar,
>
> On Tue, Oct 20, 2015 at 6:47 PM, Caesar Wang <caesar.upstream@gmail.c=
om> wrote:
>> Doug,
>>
>> =E5=9C=A8 2015=E5=B9=B410=E6=9C=8821=E6=97=A5 00:01, Doug Anderson =E5=
=86=99=E9=81=93:
>>
>> Caesar,
>>
>> On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wr=
ote:
>>
>> As the TRM says, the TSHUT default state is high active.
>> In general, the TSHUT state can get from the dts. Otherwise
>> it gets the state from this.
>>
>> Can you point at where the TRM says that the default state is high a=
ctive?
>>
>> With the manual I have, I look at TSADC_AUTO_CON and I look at the
>> description of "Bit 8".  It says that "tshut polarity" is 0 for low
>> active and 1 for high active.  It then said that the Reset Value is =
0.
>>
>> ...the "Reset Value" in tables like this is notoriously unreliable, =
so
>> I can totally believe that it's wrong.  If you can point me at the
>> part of the TRM that says that TSHUT is high active by default then =
I
>> can confirm that for you.  ;)
>>
>>
>> Okay, I know that's my wrong, the polarity is high or low can be sel=
ected.
>> :-(
>>
>> I remember the veyron why is the default HiGH active, since the opt =
is
>> connected to the PMIC.(we need think about the devices)
>>
>> Why is the evb board LOW active, since the opt didn't connected to t=
he
>> devices. TSHUT is depend on the CRU to work.
> I think we can drop this patch then, right?  Any boards that need a
> change from the default can just set "rockchip,hw-tshut-polarity",
> right?
Yep, we should drop this patch.
I'm ready resend the patchs.


> -Doug
>

--=20
Thanks,
Caesar

