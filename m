From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] cpuidle: A few improvements for ARM cpuidle via DT
Date: Fri, 21 Nov 2014 17:13:45 +0100
Message-ID: <546F64B9.8060300@linaro.org>
References: <546C6DEB.8060204@linaro.org> <17509116.2bjC4d8bef@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <17509116.2bjC4d8bef@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm >> Linux PM mailing list" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 11/21/2014 04:56 PM, Rafael J. Wysocki wrote:
> On Wednesday, November 19, 2014 11:16:11 AM Daniel Lezcano wrote:
>>
>> Hi Rafael,
>>
>> this pull request, based on 3.18-rc5, contains a set of changes from
>> Lorenzo Pieralisi.
>>
>>    * Added a 'status' definition flag in the DT to specify the
>> unsupported firmware idle states and ignore those states in the pars=
ing
>> code when initializing the cpuidle driver
>>
>>    * Added an idle state description in the DT. As the idle states a=
re
>> not standardized on ARM, the description gives information about the
>> idle state
>>
>>    * Removed duplicate error message in the arm64 cpuidle drivers
>>
>> Thanks !
>>
>>     -- Daniel
>>
>>
>> The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d=
9af50f9:
>>
>>     Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)
>>
>> are available in the git repository at:
>>
>>     http://git.linaro.org/git-ro/people/daniel.lezcano/linux.git cpu=
idle/3.19
>>
>> for you to fetch changes up to 18f95a3640dbf421ab9532e517070a0c1cd4d=
582:
>>
>>     drivers: cpuidle: Remove cpuidle-arm64 duplicate error messages
>> (2014-11-19 10:16:28 +0100)
>
> Pulled, but I had a conflict with one patch from you I'd already queu=
ed up for
> 3.19-rc1.
>
> Can you please have a look at my bleeding-edge branch and check if I =
resolved
> the conflict correctly?

Hi Rafael,

yes the conflict is correctly resolved.

Thanks
   -- Daniel



--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
