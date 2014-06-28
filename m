From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] cpufreq: make table sentinal macros unsigned to match use
Date: Sat, 28 Jun 2014 09:18:50 +0900
Message-ID: <20140628001850.GF27128@verge.net.au>
References: <20140627210939.GB24604@oc3347516403.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140627210939.GB24604@oc3347516403.ibm.com>
Sender: linux-sh-owner@vger.kernel.org
To: Brian W Hart <hartb@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, Stratos Karafotis <stratosk@semaphore.gr>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 27, 2014 at 04:09:39PM -0500, Brian W Hart wrote:
> Commit 5eeaf1f18973 (cpufreq: Fix build error on some platforms that
> use cpufreq_for_each_*) moved function cpufreq_next_valid() to a publ=
ic
> header.  Warnings are now generated when objects including that heade=
r
> are built with -Wsign-compare (as an out-of-tree module might be):
>=20
> .../include/linux/cpufreq.h: In function =E2=80=98cpufreq_next_valid=E2=
=80=99:
> .../include/linux/cpufreq.h:519:27: warning: comparison between signe=
d
> and unsigned integer expressions [-Wsign-compare]
>   while ((*pos)->frequency !=3D CPUFREQ_TABLE_END)
>                            ^
> .../include/linux/cpufreq.h:520:25: warning: comparison between signe=
d
> and unsigned integer expressions [-Wsign-compare]
>    if ((*pos)->frequency !=3D CPUFREQ_ENTRY_INVALID)
>                          ^
>=20
> Constants CPUFREQ_ENTRY_INVALID and CPUFREQ_TABLE_END are signed, but
> are used with unsigned member 'frequency' of cpufreq_frequency_table.
> Update the macro definitions to be explicitly unsigned to match their
> use.
>=20
> This also corrects potentially wrong behavior of clk_rate_table_iter(=
)
> if unsigned long is wider than usigned int.
>=20
> Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

> ---
> These macros are fairly broadly used in the kernel so I was bit leery
> of changing them, but after inspection I think it's fine.  I found 10=
2
> uses of the macros, of which:
>=20
> 99 are uses with cpufreq_frequency_table.frequency (95) or with local
>    variables of the same type as frequency (4).  These should be just
>    fine with this change--we're just making explicit a conversion tha=
t
>    was previously implicit.
>=20
>  2 are uses with a local variable of different type (unsigned long) t=
han
>    'frequency' (in drivers/sh/clk/core.c).  One of these uses is safe=
;
>    the other (in clk_rate_table_iter()) is broken if unsigned long
>    is wider than unsigned int.  As a side-effect, this patch corrects
>    the potential misbehavior there.
>=20
>  1 is a use in macro cpufreq_for_each_entry() with what _should_ be t=
he
>    frequency member of a cpufreq_frequency_table, provided the caller=
 it
>    well-behaved.  There are 18 callers of this macro; all are well-be=
haved.
>    So these should also be safe.
>=20
>  include/linux/cpufreq.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index ec4112d..8f8ae95 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -482,8 +482,8 @@ extern struct cpufreq_governor cpufreq_gov_conser=
vative;
>   *******************************************************************=
**/
> =20
>  /* Special Values of .frequency field */
> -#define CPUFREQ_ENTRY_INVALID	~0
> -#define CPUFREQ_TABLE_END	~1
> +#define CPUFREQ_ENTRY_INVALID	~0u
> +#define CPUFREQ_TABLE_END	~1u
>  /* Special Values of .flags field */
>  #define CPUFREQ_BOOST_FREQ	(1 << 0)
> =20
> --=20
> 1.7.1
>=20
