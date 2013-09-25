From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 16/21] cpuidle: avoid unnecessary kzalloc/free of struct
 cpuidle_device_kobj
Date: Thu, 26 Sep 2013 00:12:50 +0200
Message-ID: <52435FE2.20805@linaro.org>
References: <cover.1379779777.git.viresh.kumar@linaro.org> <fb67ff6fa01bde06aeab43c4a02da2923615e6ef.1379779777.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fb67ff6fa01bde06aeab43c4a02da2923615e6ef.1379779777.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 09/22/2013 03:21 AM, Viresh Kumar wrote:
> We always need to allocate struct cpuidle_device_kobj for all CPUs an=
d so there
> is no real need to have a pointer to it inside struct cpuidle_device.
>=20
> This patch makes a object instance of struct cpuidle_device_kobj insi=
de struct
> cpuidle_device instead of a pointer.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

nack, it was made in purpose for kobject_init_and_add.

see commit 728ce22b696f9f1404a74d7b2279a65933553a1b



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
