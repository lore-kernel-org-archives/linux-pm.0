From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 3/3] Documentation: intel_pstate: Add base_frequency information
Date: Mon, 15 Oct 2018 10:53:25 +0200
Message-ID: <CAJZ5v0iXOtcNSqPU7NYwG=S_JCdoTFzLRD1qZocWMnFnVJ-oMQ@mail.gmail.com>
References: <20181012164400.3479-1-srinivas.pandruvada@linux.intel.com> <20181012164400.3479-4-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012164400.3479-4-srinivas.pandruvada@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Juri Lelli <juri.lelli@redhat.com>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, devel@acpica.org, Prashanth Prakash <pprakash@codeaurora.org>, George Cherian <george.cherian@cavium.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12, 2018 at 6:44 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> Updated documentation to explain base_frequency attribute.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  Documentation/admin-guide/pm/intel_pstate.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/admin-guide/pm/intel_pstate.rst b/Documentation/admin-guide/pm/intel_pstate.rst
> index 8f1d3de449b5..14a5505e073e 100644
> --- a/Documentation/admin-guide/pm/intel_pstate.rst
> +++ b/Documentation/admin-guide/pm/intel_pstate.rst
> @@ -465,6 +465,10 @@ Next, the following policy attributes have special meaning if
>         policy for the time interval between the last two invocations of the
>         driver's utilization update callback by the CPU scheduler for that CPU.
>
> +``base_frequency``
> +       When present, shows the base frequency of the CPU. Any frequency above
> +       this will be in the turbo frequency range.
> +

This isn't entirely correct, because base_frequency is not present in
the passive mode (and it is not present for the other drivers for that
matter).

>  The meaning of these attributes in the `passive mode <Passive Mode_>`_ is the
>  same as for other scaling drivers.

Instead, I would say:

"One more policy attribute is present if the `HWP feature is enabled
in the processor <Active Mode With HWP_>`_:"

here and I would add the description of the attribute below.

Thanks,
Rafael
