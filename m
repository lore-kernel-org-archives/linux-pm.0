From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 18/21] cpuidle: don't call poll_idle_init() for every
 cpu
Date: Thu, 26 Sep 2013 10:28:27 +0200
Message-ID: <5243F02B.2030302@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org>	<495ffb1175175b0180ca3da96eb5ed72a8280364.1379779777.git.viresh.kumar@linaro.org>	<52436237.3040500@linaro.org> <CAKohpokBPD35pBpCt-x0KGNvy3hxmYGPxXpSBJZcgo7ir8L3hA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokBPD35pBpCt-x0KGNvy3hxmYGPxXpSBJZcgo7ir8L3hA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Patch Tracking <patches@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 09/26/2013 08:09 AM, Viresh Kumar wrote:
> On 26 September 2013 03:52, Daniel Lezcano <daniel.lezcano@linaro.org=
> wrote:
>> On 09/22/2013 03:21 AM, Viresh Kumar wrote:
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> This deserved a log, sorry for missing that :(
>
>> The optimization sounds good but IMHO if we can move this state out =
of
>> the cpuidle common framework that would be nicer.
>>
>> The poll_idle is only applicable for x86 (acpi_driver and intel_idle=
),
>> hence I suggest we move this state to these drivers, that will clean=
up
>> the framework code and will remove index shift macro
>> CPUIDLE_DRIVER_STATE_START which IMHO is weid and prone-to-error.
>
> Lets see what X86 folks have to say about it and then we can do it..
> Btw, wouldn't that add some code duplication in those two drivers?

Yes, certainly and that will impact also the menu select governor funct=
ion:

  ...

         /*
          * We want to default to C1 (hlt), not to busy polling
          * unless the timer is happening really really soon.
          */
         if (data->expected_us > 5 &&
             !drv->states[CPUIDLE_DRIVER_STATE_START].disabled &&
                 dev->states_usage[CPUIDLE_DRIVER_STATE_START].disable =
=3D=3D 0)
                 data->last_state_idx =3D CPUIDLE_DRIVER_STATE_START;

         /*
          * Find the idle state with the lowest power while satisfying
          * our constraints.
          */
         for (i =3D CPUIDLE_DRIVER_STATE_START; i < drv->state_count; i=
++) {
                 struct cpuidle_state *s =3D &drv->states[i];
                 struct cpuidle_state_usage *su =3D &dev->states_usage[=
i];

                 if (s->disabled || su->disable)
                         continue;
                 if (s->target_residency > data->predicted_us)
                         continue;
                 if (s->exit_latency > latency_req)
                         continue;
                 if (s->exit_latency * multiplier > data->predicted_us)
                         continue;

                 data->last_state_idx =3D i;
                 data->exit_us =3D s->exit_latency;
         }

=2E...

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
