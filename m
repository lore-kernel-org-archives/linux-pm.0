From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [GIT PULL] cpuidle: new driver for Cirrus Logic for 3.16
Date: Fri, 16 May 2014 10:23:41 +0200
Message-ID: <5375CB0D.2080309@linaro.org>
References: <5360CF57.9050202@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5360CF57.9050202@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Alexander Shiyan <shc_work@mail.ru>, Linux PM mailing list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


Hi Rafael,

just a head up in case you missed it.

Thanks
   -- Daniel

On 04/30/2014 12:24 PM, Daniel Lezcano wrote:
>
> Hi Rafael,
>
> this pull request is based on top 3.15-rc3
>
>   * Alexander Shiyan added a new driver for the Cirrus Logic clps711x
>
> Thanks
>    -- Daniel
>
> The following changes since commit
> d1db0eea852497762cab43b905b879dfcd3b8987:
>
>    Linux 3.15-rc3 (2014-04-27 19:29:27 -0700)
>
> are available in the git repository at:
>
>    git://git.linaro.org/people/daniel.lezcano/linux.git cpuidle/3.16
>
> for you to fetch changes up to 7c7f8f7f2c6bf078874e5de35d7e2c66467fc6=
64:
>
>    ARM: clps711x: Add cpuidle driver (2014-04-30 01:33:02 +0200)
>
> ----------------------------------------------------------------
> Alexander Shiyan (1):
>        ARM: clps711x: Add cpuidle driver
>
>   drivers/cpuidle/Kconfig.arm        |    6 ++++
>   drivers/cpuidle/Makefile           |    1 +
>   drivers/cpuidle/cpuidle-clps711x.c |   64
> ++++++++++++++++++++++++++++++++++++
>   3 files changed, 71 insertions(+)
>   create mode 100644 drivers/cpuidle/cpuidle-clps711x.c
>


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
