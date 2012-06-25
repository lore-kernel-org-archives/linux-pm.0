From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: cpuidle future and improvements
Date: Mon, 25 Jun 2012 14:54:02 +0200
Message-ID: <4FE85F6A.80307@linaro.org>
References: <4FDEE98D.7010802@linaro.org> <CAMbhsRQRFXcayyWjM1RirgFppVAK23z2+3EbYOCw-qmzuY9_2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <CAMbhsRQRFXcayyWjM1RirgFppVAK23z2+3EbYOCw-qmzuY9_2g@mail.gmail.com>
Sender: linux-next-owner@vger.kernel.org
To: Colin Cross <ccross@android.com>
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Lists Linaro-dev <linaro-dev@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Amit Kucheria <amit.kucheria@linaro.org>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>, "lenb@kernel.org" <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Rob Lee <rob.lee@linaro.org>, rjw@sisk.pl, Kevin Hilman <khilman@ti.com>, linux-next@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/18/2012 08:15 PM, Colin Cross wrote:
> On Mon, Jun 18, 2012 at 1:40 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> I propose to host a cpuidle-next tree where all these modifications =
will
>> be and where people can send patches against, preventing last minute=
s
>> conflicts and perhaps Lenb will agree to pull from this tree. In the
>> meantime, the tree will be part of the linux-next, the patches will =
be
>> more widely tested and could be fixed earlier.
>=20
> My coupled cpuidle patches were acked and temporarily in Len's
> next/Linus pull branch, but were later dropped when the first pull
> request to Linus was rejected.  I asked Len to either put the coupled
> cpuidle patches into his next branch, or let me host them so people
> could base SoC branches off of them and let Len pull them later, but
> got no response.  If you do start a cpuidle for-next branch, can you
> pull my coupled-cpuidle branch:
>=20
> The following changes since commit 76e10d158efb6d4516018846f60c2ab550=
1900bc:
>=20
>   Linux 3.4 (2012-05-20 15:29:13 -0700)
>=20
> are available in the git repository at:
>   https://android.googlesource.com/kernel/common.git coupled-cpuidle
>=20
> Colin Cross (4):
>       cpuidle: refactor out cpuidle_enter_state
>       cpuidle: fix error handling in __cpuidle_register_device
>       cpuidle: add support for states that affect multiple cpus
>       cpuidle: coupled: add parallel barrier function
>=20
>  drivers/cpuidle/Kconfig   |    3 +
>  drivers/cpuidle/Makefile  |    1 +
>  drivers/cpuidle/coupled.c |  715 +++++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/cpuidle/cpuidle.c |   68 ++++-
>  drivers/cpuidle/cpuidle.h |   32 ++
>  include/linux/cpuidle.h   |   11 +
>  6 files changed, 813 insertions(+), 17 deletions(-)
>  create mode 100644 drivers/cpuidle/coupled.c


Done.

http://git.linaro.org/gitweb?p=3Dpeople/dlezcano/cpuidle-next.git;a=3Ds=
hortlog;h=3Drefs/heads/cpuidle-next


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
