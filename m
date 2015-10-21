From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/4] thermal: rockchip: change the TSHUT default state
Date: Tue, 20 Oct 2015 19:14:29 -0700
Message-ID: <CAD=FV=UNyjJmN4TtZ+1DOeM_OYikRAUhYsN=F_f-q5MA_MVFag@mail.gmail.com>
References: <1445332264-6054-1-git-send-email-wxt@rock-chips.com>
	<1445332264-6054-4-git-send-email-wxt@rock-chips.com>
	<CAD=FV=Vo1Wf6opTc5jQjm-nXd=BCJxeggipPj4ER9Ehutxs_6w@mail.gmail.com>
	<5626EEB2.50101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5626EEB2.50101@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Caesar,

On Tue, Oct 20, 2015 at 6:47 PM, Caesar Wang <caesar.upstream@gmail.com=
> wrote:
> Doug,
>
> =E5=9C=A8 2015=E5=B9=B410=E6=9C=8821=E6=97=A5 00:01, Doug Anderson =E5=
=86=99=E9=81=93:
>
> Caesar,
>
> On Tue, Oct 20, 2015 at 2:11 AM, Caesar Wang <wxt@rock-chips.com> wro=
te:
>
> As the TRM says, the TSHUT default state is high active.
> In general, the TSHUT state can get from the dts. Otherwise
> it gets the state from this.
>
> Can you point at where the TRM says that the default state is high ac=
tive?
>
> With the manual I have, I look at TSADC_AUTO_CON and I look at the
> description of "Bit 8".  It says that "tshut polarity" is 0 for low
> active and 1 for high active.  It then said that the Reset Value is 0=
=2E
>
> ...the "Reset Value" in tables like this is notoriously unreliable, s=
o
> I can totally believe that it's wrong.  If you can point me at the
> part of the TRM that says that TSHUT is high active by default then I
> can confirm that for you.  ;)
>
>
> Okay, I know that's my wrong, the polarity is high or low can be sele=
cted.
> :-(
>
> I remember the veyron why is the default HiGH active, since the opt i=
s
> connected to the PMIC.(we need think about the devices)
>
> Why is the evb board LOW active, since the opt didn't connected to th=
e
> devices. TSHUT is depend on the CRU to work.

I think we can drop this patch then, right?  Any boards that need a
change from the default can just set "rockchip,hw-tshut-polarity",
right?

-Doug
