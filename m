From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 18/21] cpuidle: don't call poll_idle_init() for every
 cpu
Date: Thu, 03 Oct 2013 13:46:33 +0200
Message-ID: <524D5919.5060103@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<495ffb1175175b0180ca3da96eb5ed72a8280364.1379779777.git.viresh.kumar@linaro.org>	<52436237.3040500@linaro.org>	<CAKohpokBPD35pBpCt-x0KGNvy3hxmYGPxXpSBJZcgo7ir8L3hA@mail.gmail.com>	<5243F02B.2030302@linaro.org> <CAKohponH-oEagm9E2r+XLRJpY7rgmjjoJjcQHtMpMckDW_q8VQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohponH-oEagm9E2r+XLRJpY7rgmjjoJjcQHtMpMckDW_q8VQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 10/03/2013 12:33 PM, Viresh Kumar wrote:
> On 26 September 2013 13:58, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> Yes, certainly and that will impact also the menu select governor fu=
nction:
>>
>>   ...
>>
>>          /*
>>           * We want to default to C1 (hlt), not to busy polling
>>           * unless the timer is happening really really soon.
>>           */
>>          if (data->expected_us > 5 &&
>>              !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
>>                  dev->states_usage[CPUIDLE_DRIVER_STATE_START].disab=
le =3D=3D 0)
>>                  data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START=
;
>>
>>          /*
>>           * Find the idle state with the lowest power while satisfyi=
ng
>>           * our constraints.
>>           */
>>          for (i =3D CPUIDLE_DRIVER_STATE_START; i < drv->state_count=
; i++) {
>>                  struct cpuidle_state *s =3D &drv->states[i];
>>                  struct cpuidle_state_usage *su =3D &dev->states_usa=
ge[i];
>>
>>                  if (s->disabled || su->disable)
>>                          continue;
>>                  if (s->target_residency > data->predicted_us)
>>                          continue;
>>                  if (s->exit_latency > latency_req)
>>                          continue;
>>                  if (s->exit_latency * multiplier > data->predicted_=
us)
>>                          continue;
>>
>>                  data->last_state_idx =3D i;
>>                  data->exit_us =3D s->exit_latency;
>>          }
>
> Hmm.. For now I will repost this patch as is and then you can go ahea=
d
> for this bigger change.. I wouldn't be able to do this change now, as=
 I
> would be rushing for my 2 weeks vacations :)
>
> If this patch looked okay to you, can you please Ack it ?

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
