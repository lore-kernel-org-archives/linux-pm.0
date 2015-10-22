From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 1/2] dt-bindings: Sync the dts to this document
Date: Wed, 21 Oct 2015 20:18:54 -0500
Message-ID: <CAL_JsqJFO8u0-3BSwBrBh4m7z4iEDPYLeEM9Ef8SLvuj1FYXmg@mail.gmail.com>
References: <1445395380-5365-1-git-send-email-wxt@rock-chips.com>
 <1445395380-5365-2-git-send-email-wxt@rock-chips.com> <CAL_JsqJ6ZRjZbtc7dqo-g=CzO+H_FWcRqs2gBGH2HMBBM1xU3g@mail.gmail.com>
 <5627B309.9080309@gmail.com> <CAL_JsqJcwWkMXQzo6PbO2kfv3h7hkqtq6CJW0+W4Wc3eh6RTuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43506 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753405AbbJVBTR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 Oct 2015 21:19:17 -0400
In-Reply-To: <CAL_JsqJcwWkMXQzo6PbO2kfv3h7hkqtq6CJW0+W4Wc3eh6RTuQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Caesar Wang <caesar.upstream@gmail.com>
Cc: Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Heiko Stuebner <heiko@sntech.de>, Pawel Moll <pawel.moll@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Kumar Gala <galak@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Wed, Oct 21, 2015 at 11:48 AM, Rob Herring <robh+dt@kernel.org> wrot=
e:
> On Wed, Oct 21, 2015 at 10:45 AM, Caesar Wang <caesar.upstream@gmail.=
com> wrote:
>> Hi Rob,
>>
>> =E5=9C=A8 2015=E5=B9=B410=E6=9C=8821=E6=97=A5 23:18, Rob Herring =E5=
=86=99=E9=81=93:
>>>
>>> On Tue, Oct 20, 2015 at 9:42 PM, Caesar Wang <wxt@rock-chips.com> w=
rote:
>>>>
>>>> Add the OTP gpio state, we need switch the pin to gpio state
>>>> before the TSADC controller is reset.

Also, please fix the subject to be specific what binding you are changi=
ng.

dt-bindings: rockchip-thermal: <what the change is>

Rob
