From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPI / CPPC: Fix processing for guaranteed performance
Date: Mon, 25 Mar 2019 12:49:59 +0100
Message-ID: <CAJZ5v0g6=QZ7m8phjsYfZOxKNbc0Ny1ySPTScg=yzxOUsGk6HQ@mail.gmail.com>
References: <20190322224520.6740-1-srinivas.pandruvada@linux.intel.com> <20190322224520.6740-2-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322224520.6740-2-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Prashanth Prakash <pprakash@codeaurora.org>, Xiongfeng Wang <wangxiongfeng2@huawei.com>, "4 . 20+" <stable@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2019 at 11:45 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> As per ACPI specification "Guaranteed Performance Register" is a "Buffer"
> field. It can't be "Integer" field. So treat "Integer" type as invalid and
> ignore "Guaranteed Performance Register".
> Also save one cpc_read() call, when "Guaranteed Performance Register" is
> not present, which means register defined as:
> "Register(SystemMemory, 0, 0, 0, 0)".
>
> Fixes: 29523f095397 ("ACPI / CPPC: Add support for guaranteed performance")
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: 4.20+ <stable@vger.kernel.org> # 4.20+
> ---
>  drivers/acpi/cppc_acpi.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 1b207fca1420..3f6c290e06af 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1150,8 +1150,14 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>         cpc_read(cpunum, nominal_reg, &nom);
>         perf_caps->nominal_perf = nom;
>
> -       cpc_read(cpunum, guaranteed_reg, &guaranteed);
> -       perf_caps->guaranteed_perf = guaranteed;
> +       if (guaranteed_reg->type == ACPI_TYPE_INTEGER  ||
> +           (guaranteed_reg->type == ACPI_TYPE_BUFFER &&
> +            IS_NULL_REG(&guaranteed_reg->cpc_entry.reg))) {

AFAICS anything different from a buffer should be rejected here, so
why don't you do

if (guaranteed_reg->type != ACPI_TYPE_BUFFER  ||
IS_NULL_REG(&guaranteed_reg->cpc_entry.reg))

> +               perf_caps->guaranteed_perf = 0;
> +       } else {
> +               cpc_read(cpunum, guaranteed_reg, &guaranteed);
> +               perf_caps->guaranteed_perf = guaranteed;
> +       }
>
>         cpc_read(cpunum, lowest_non_linear_reg, &min_nonlinear);
>         perf_caps->lowest_nonlinear_perf = min_nonlinear;
> --
> 2.17.2
>
