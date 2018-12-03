From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC 06/15] cpufreq: replace **** with a hug
Date: Mon, 3 Dec 2018 10:08:16 +0100
Message-ID: <CAJZ5v0gH_VMoi+KFoy0kPUu435yjXUnhc9XeJQc61t34yrkJJg@mail.gmail.com>
References: <20181130192737.15053-1-jarkko.sakkinen@linux.intel.com> <20181130192737.15053-7-jarkko.sakkinen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130192737.15053-7-jarkko.sakkinen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Nov 30, 2018 at 8:28 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> In order to comply with the CoC, replace **** with a hug.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  drivers/cpufreq/powernow-k7.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/powernow-k7.c b/drivers/cpufreq/powernow-k7.c
> index d6cb052b0a75..302315ad3786 100644
> --- a/drivers/cpufreq/powernow-k7.c
> +++ b/drivers/cpufreq/powernow-k7.c
> @@ -574,7 +574,7 @@ static int acer_cpufreq_pst(const struct dmi_system_id *d)
>  }
>
>  /*
> - * Some Athlon laptops have really fucked PST tables.
> + * Some Athlon laptops have really hugged PST tables.

Can we just say "broken"?

>   * A BIOS update is all that can save them.
>   * Mention this, and disable cpufreq.
>   */
> --
> 2.19.1
>
