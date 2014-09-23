From: Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v3] power: reset: use restart_notifier mechanism for msm-poweroff
Date: Tue, 23 Sep 2014 13:20:50 -0500
Message-ID: <C6FFC8E5-EDF0-4248-BE4B-AF4EB8533CCB@codeaurora.org>
References: <1411452520-29589-1-git-send-email-pramod.gurav@smartplayin.com> <542112FD.7080302@smartplayin.com> <2C40727B-BF1E-46AC-9189-6B35E358220E@codeaurora.org> <20140923175556.GG868@joshc.qualcomm.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140923175556.GG868@joshc.qualcomm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Josh Cartwright <joshc@codeaurora.org>
Cc: Pramod Gurav <pramod.gurav@smartplayin.com>, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@codeaurora.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Sep 23, 2014, at 12:55 PM, Josh Cartwright <joshc@codeaurora.org> wr=
ote:

> On Tue, Sep 23, 2014 at 12:48:42PM -0500, Kumar Gala wrote:
>>=20
>> On Sep 23, 2014, at 1:28 AM, Pramod Gurav <pramod.gurav@smartplayin.=
com> wrote:
>>=20
>>> +linux-arm-msm
>>> On Tuesday 23 September 2014 11:38 AM, Pramod Gurav wrote:
>>>> This change replaces use of arm_pm_restart with recently introduce=
d
>>>> reset mechanism in Linux kernel called restart_notifier.
>>=20
>> Can you update the commit message to include details about the prior=
ity level we are setting it to.
>>=20
>> Probably something like Josh had:
>>=20
>> Choose priority 128, as according to documentation, this mechanism "=
is
>> sufficient to restart the entire system?.
>>=20
>> Hmm, what happens if we have ps_hold restart and msm-poweroff enable=
d.
>> Which one should have priority?
>=20
> I would hope we would avoid a situation where both this driver is
> probed, and the pinctrl-msm driver has registered a restart handler?
>=20
> That is, we wouldn't ever mix the pinctrl-msm ps_hold mechanism (for
> MSM8660/MSM8960/APQ8064, etc) and msm-poweroff (APQ8074 and later).  =
Is
> this a case you're worried about?

Yes, I=92m worried about possibly case of having both solutions on a de=
vice.

- k

--=20
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, host=
ed by The Linux Foundation
