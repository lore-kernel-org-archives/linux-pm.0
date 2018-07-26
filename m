From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] turbostat: Read extended processor family from CPUID
Date: Thu, 26 Jul 2018 15:08:22 -0400
Message-ID: <CAJvTdKmA=18nqHh0QFMb+P=41YfQA1Jc3EC8_qWfjOGfjSNP6g@mail.gmail.com>
References: <20180718222656.11795-1-calvin.walton@kepstin.ca> <20180718222656.11795-2-calvin.walton@kepstin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718222656.11795-2-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: calvin.walton@kepstin.ca
Cc: Linux PM list <linux-pm@vger.kernel.org>, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi Calvin,

Your patch looks correct on both AMD and Intel.
Thanks for noticing this, and taking the extra step to fix it!

Please re-send your patch with a Signed-off-by: line, so that I can apply it.

Note that first running checkpatch.pl on patches before submitting
will point out such issues, so they are easily avoided.

thanks,
-Len
On Wed, Jul 18, 2018 at 6:27 PM Calvin Walton <calvin.walton@kepstin.ca> wrote:
>
> This fixes the reported family on modern AMD processors (e.g. Ryzen,
> which is family 0x17). Previously these processors all showed up as
> family 0xf.
>
> See the document
> https://support.amd.com/TechDocs/56255_OSRR.pdf
> section CPUID_Fn00000001_EAX for how to calculate the family
> from the BaseFamily and ExtFamily values.
> ---
>  tools/power/x86/turbostat/turbostat.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index bd9c6b31a504..f404d67fda92 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -4031,7 +4031,9 @@ void process_cpuid()
>         family = (fms >> 8) & 0xf;
>         model = (fms >> 4) & 0xf;
>         stepping = fms & 0xf;
> -       if (family == 6 || family == 0xf)
> +       if (family == 0xf)
> +               family += ((fms >> 20) & 0xff);
> +       if (family == 6 || family >= 0xf)
>                 model += ((fms >> 16) & 0xf) << 4;
>
>         if (!quiet) {
> --
> 2.18.0
>


-- 
Len Brown, Intel Open Source Technology Center
