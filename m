From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 02/20] cpufreq: acpi-cpufreq: Use cpufreq_for_each_entry
 macro for iteration
Date: Tue, 15 Apr 2014 11:02:43 +0530
Message-ID: <CAKohpok5+Eai=OOs9J+uYp4NaYmovXqkkg_Bvx0025_XyS4xTQ@mail.gmail.com>
References: <534C4E36.9060208@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:61430 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751446AbaDOFco (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Apr 2014 01:32:44 -0400
Received: by mail-oa0-f49.google.com with SMTP id o6so10242737oag.36
        for <linux-pm@vger.kernel.org>; Mon, 14 Apr 2014 22:32:43 -0700 (PDT)
In-Reply-To: <534C4E36.9060208@semaphore.gr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stratos Karafotis <stratosk@semaphore.gr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 15 April 2014 02:38, Stratos Karafotis <stratosk@semaphore.gr> wrote:
> The cpufreq core supports the cpufreq_for_each_entry macro helper
> for iteration over the cpufreq_frequency_table, so use it.
>
> It should have no functional changes.
>
> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
> ---
>  drivers/cpufreq/acpi-cpufreq.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 000e4e0..12a5750 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -213,7 +213,7 @@ static unsigned extract_io(u32 value, struct acpi_cpufreq_data *data)
>
>  static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
>  {
> -       int i;
> +       struct cpufreq_frequency_table *pos;
>         struct acpi_processor_performance *perf;
>
>         if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)
> @@ -223,11 +223,11 @@ static unsigned extract_msr(u32 msr, struct acpi_cpufreq_data *data)
>
>         perf = data->acpi_data;
>
> -       for (i = 0; data->freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
> -               if (msr == perf->states[data->freq_table[i].driver_data].status)
> -                       return data->freq_table[i].frequency;
> +       cpufreq_for_each_entry(pos, data->freq_table) {
> +               if (msr == perf->states[pos->driver_data].status)
> +                       return pos->frequency;
>         }
> -       return data->freq_table[0].frequency;
> +       return data->freq_table->frequency;

This isn't a related change, isn't it? Also it make it less readable.
So probably
just leave it as is.
