From: Saravana Kannan <skannan@codeaurora.org>
Subject: Re: [PATCH] PM / devfreq: Fix out of bounds access of transition
 table array
Date: Wed, 26 Feb 2014 16:45:13 -0800
Message-ID: <530E8A99.50402@codeaurora.org>
References: <19338058.266151393391521988.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <19338058.266151393391521988.JavaMail.weblogic@epml02>
Sender: linux-arm-msm-owner@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: =?EUC-KR?B?udqw5rnO?= <kyungmin.park@samsung.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 02/25/2014 09:12 PM, =C7=D4=B8=ED=C1=D6 wrote:
>> On 02/23/2014 11:15 PM, Saravana Kannan wrote:
>>> The previous_freq value for a device could be an invalid frequency =
that
>>> results in a error value being returned from devfreq_get_freq_level=
().
>>> Check for an error value before using that to index into the transi=
tion
>>> table.
>>>
>>> Not doing this check will result in memory corruption when previous=
_freq is
>>> not a valid frequency.
>>>
>>> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
>>
>> MyungJoo/Kyungmin,
>>
>> Would either of you have some time to respond to this?
>>
>> Thanks,
>> Saravana
>=20
> Dear Saravana,
>=20
>>> +	prev_lev =3D devfreq_get_freq_level(devfreq, devfreq->previous_fr=
eq);
>>> +	if (prev_lev < 0)
>>> +		return 0;
>=20
> If devfreq_get_freq_level returned error, please return that error
> to the caller. You are retuning 0 in that case.
>=20
> Plus, do you think we are going to change profile->freq_table in run-=
time?
> (by accidently? or intentionally?)

Hi MyungJoo,

The reason for this fix is that some devices can't reliably detect thei=
r
current frequency. So, we set the initial freq to 0 so that the first
request from the default governor actually goes through.

If we randomly pick one of the valid frequencies, then the initial
request could get short circuited by devfreq, cause wrong stats, the
device itself might short circuit it after comparing it to prev freq, e=
tc.

The reason I intentionally ignored the error was to prevent printing an
error at boot every time for such devices. I could do better with more
complicated code, but I couldn't imagine any other case where
previous_freq could actually end up being an invalid value.

Hold on, I just realized that the stats code is completely wrong! Isn't
the current code updating the time_in_state[] of the wrong level? It's
updating the new level's time in state instead of the previous one?

I'll send out a patch that fixes all this with in a couple of days.

Thanks,
Saravana

--=20
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora For=
um,
hosted by The Linux Foundation
