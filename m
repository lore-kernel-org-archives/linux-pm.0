From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: make table sentinal macros unsigned to match use
Date: Mon, 30 Jun 2014 10:25:20 +0530
Message-ID: <CAKohpo=qB3nB+ZNKE4Y94m6gPWZZ4YZEU_WOA=s5DB8apxUQGQ@mail.gmail.com>
References: <20140627210939.GB24604@oc3347516403.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f54.google.com ([209.85.219.54]:38579 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbaF3EzU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 Jun 2014 00:55:20 -0400
Received: by mail-oa0-f54.google.com with SMTP id eb12so8200707oac.13
        for <linux-pm@vger.kernel.org>; Sun, 29 Jun 2014 21:55:20 -0700 (PDT)
In-Reply-To: <20140627210939.GB24604@oc3347516403.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Brian W Hart <hartb@linux.vnet.ibm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, Stratos Karafotis <stratosk@semaphore.gr>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>

On 28 June 2014 02:39, Brian W Hart <hartb@linux.vnet.ibm.com> wrote:
> Commit 5eeaf1f18973 (cpufreq: Fix build error on some platforms that
> use cpufreq_for_each_*) moved function cpufreq_next_valid() to a publ=
ic
> header.  Warnings are now generated when objects including that heade=
r
> are built with -Wsign-compare (as an out-of-tree module might be):
>
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
>
> Constants CPUFREQ_ENTRY_INVALID and CPUFREQ_TABLE_END are signed, but
> are used with unsigned member 'frequency' of cpufreq_frequency_table.
> Update the macro definitions to be explicitly unsigned to match their
> use.
>
> This also corrects potentially wrong behavior of clk_rate_table_iter(=
)
> if unsigned long is wider than usigned int.
>
> Signed-off-by: Brian W Hart <hartb@linux.vnet.ibm.com>
> ---
> These macros are fairly broadly used in the kernel so I was bit leery
> of changing them, but after inspection I think it's fine.  I found 10=
2
> uses of the macros, of which:
>
> 99 are uses with cpufreq_frequency_table.frequency (95) or with local
>    variables of the same type as frequency (4).  These should be just
>    fine with this change--we're just making explicit a conversion tha=
t
>    was previously implicit.
>
>  2 are uses with a local variable of different type (unsigned long) t=
han
>    'frequency' (in drivers/sh/clk/core.c).  One of these uses is safe=
;
>    the other (in clk_rate_table_iter()) is broken if unsigned long
>    is wider than unsigned int.  As a side-effect, this patch corrects
>    the potential misbehavior there.
>
>  1 is a use in macro cpufreq_for_each_entry() with what _should_ be t=
he
>    frequency member of a cpufreq_frequency_table, provided the caller=
 it
>    well-behaved.  There are 18 callers of this macro; all are well-be=
haved.
>    So these should also be safe.

I would have moved some of it to logs, they look good.

>  include/linux/cpufreq.h |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
> index ec4112d..8f8ae95 100644
> --- a/include/linux/cpufreq.h
> +++ b/include/linux/cpufreq.h
> @@ -482,8 +482,8 @@ extern struct cpufreq_governor cpufreq_gov_conser=
vative;
>   *******************************************************************=
**/
>
>  /* Special Values of .frequency field */
> -#define CPUFREQ_ENTRY_INVALID  ~0
> -#define CPUFREQ_TABLE_END      ~1
> +#define CPUFREQ_ENTRY_INVALID  ~0u
> +#define CPUFREQ_TABLE_END      ~1u
>  /* Special Values of .flags field */
>  #define CPUFREQ_BOOST_FREQ     (1 << 0)

Thanks.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
