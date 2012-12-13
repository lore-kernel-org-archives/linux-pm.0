From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH] cpuidle - remove the power_specified field in the driver
Date: Thu, 13 Dec 2012 08:30:27 +0100
Message-ID: <50C98413.5050707@linaro.org>
References: <1355325801-1317-1-git-send-email-daniel.lezcano@linaro.org> <CAODwPW81fXDNMTvG8juR6iAGFeDV9PXE-65Wp+dAE-mcKYU2nw@mail.gmail.com> <50C8E275.9050308@linaro.org> <2077776.UzqC1zVIVr@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2077776.UzqC1zVIVr@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Julius Werner <jwerner@chromium.org>, Francesco Lavra <francescolavra.fl@gmail.com>, linux-pm@vger.kernel.org, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, Trinabh Gupta <g.trinabh@gmail.com>, Lists Linaro-dev <linaro-dev@lists.linaro.org>, len.brown@intel.com, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sameer Nanda <snanda@chromium.org>
List-Id: linux-pm@vger.kernel.org

On 12/12/2012 11:42 PM, Rafael J. Wysocki wrote:
> On Wednesday, December 12, 2012 09:00:53 PM Daniel Lezcano wrote:
>> On 12/12/2012 07:50 PM, Julius Werner wrote:
>>> Thanks again for making this happen, Daniel. I like this version,
>>> except for the small nitpick that I still think it would make sense=
 to
>>> also turn the loop in menu.c around. How about something like this:
>>>
>>>        for (i =3D drv->state_count - 1; i >=3D CPUIDLE_DRIVER_STATE=
_START; i++) {
>>>                 struct cpuidle_state *s =3D &drv->states[i];
>>>                 if (!s->disable && s->exit_latency <=3D latency_req=
 &&
>>>                     s->target_residency <=3D data->predicted_us &&
>>>                     s->exit_latency * multiplier <=3D data->predict=
ed_us) {
>>>                         data->last_state_idx =3D i;
>>>                         data->exit_us =3D s->exit_latency;
>>>                         break;
>>>                 }
>>>         }
>>
>> Actually I was planning to do that in a separate patch.
>=20
> Can you submit that second patch too, please, so that people don't ha=
ve to
> wonder?

Sure.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
