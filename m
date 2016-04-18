From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v5 03/11] soc: renesas: rcar-sysc: Add DT support for SYSC
 PM domains
Date: Mon, 18 Apr 2016 16:02:32 +0200
Message-ID: <CAPDyKFoNQ1VrheQ4Ak_fu85OswCdV4nmPNky98X7d_FoyMdAzA@mail.gmail.com>
References: <1460558672-10290-1-git-send-email-geert+renesas@glider.be>
	<1460558672-10290-4-git-send-email-geert+renesas@glider.be>
	<CAPDyKFrQtX3-7GodrXV2zp4wHBgbWBOVKyE0XoeWaaxhZ2kUuw@mail.gmail.com>
	<CAMuHMdW+PboSz-u2dV=rmNFkd4qsEhm-O_4Ewdn_-H62gwq7Ng@mail.gmail.com>
	<CAMuHMdUHPLRrOLO_qio80YHPye1tmrr=Fq9kpDg+Q0aVDycFiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdUHPLRrOLO_qio80YHPye1tmrr=Fq9kpDg+Q0aVDycFiA@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-renesas-soc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 18 April 2016 at 15:39, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Mon, Apr 18, 2016 at 2:59 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Apr 18, 2016 at 2:21 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> [...]
>>>
>>>> +
>>>> +static bool rcar_sysc_active_wakeup(struct device *dev)
>>>> +{
>>>> +       return true;
>>>
>>> I am interested to know why this is always returning true. Perhaps you
>>> can elaborate a bit on that?
>>
>> Too many copying from old shmobile PM Domain code?
>> Honestly, I don't know...
>>
>> Perhaps Rafael still remembers the original rationale, as git history for
>> commit e3e0109138376bb2 ("ARM / shmobile: Support for I/O power domains for
>> SH7372 (v9)") doesn't have it.
>>
>> Google did find: https://lkml.org/lkml/2011/6/30/471
>>
>> Do we still need this at all? I.e. aren't PM Domains containing wake-up
>> devices kept powered automatically during system suspend?
>
> No they aren't. So for pm-rmobile we do need it.

I don't quite understand why genpd should need to treat all devices
within the same domain exactly the same, it seems suboptimal.

I guess it would be more clever to allow this to be controlled on per
device basis instead, so let's say from each driver.

>
> For rcar-sysc it's different: as no PM Domain contains wake-up devices
> (all I/O devices are in the always-on power area), we don't need the callback.
> Will drop it in v6.

Okay, great!

Kind regards
Uffe
