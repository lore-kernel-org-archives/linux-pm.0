From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH v4 0/3] firmware: qcom: scm: Add cpu power on/off support
Date: Fri, 13 Mar 2015 11:16:56 -0600
Message-ID: <20150313171656.GI497@linaro.org>
References: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425339030-45828-1-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, agross@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, khilman@linaro.org
List-Id: linux-pm@vger.kernel.org

Kumar, Stephen, Andy,

Any comments on this patchset?

Thanks,
Lina

On Mon, Mar 02 2015 at 16:30 -0700, Lina Iyer wrote:
>Hi,
>
>This series of patches adds SCM cold boot clean up and support for warm boot
>for QCOM quad core (and dual core) cpus.
>
>v4 Changes:
>- Added QCOM_SCM_CPU_DOWN_ prefix for L2 on/off enums, relocated them to be close
>  to the function declaration.
>
>v3 Changes:
>- Addressed review comments from Kumar.
>	+ Cleaned up the cold boot api and the warm boot api to match
>	+ Uniform qcom_scm_ prefix
>- Add support for cpu power down using scm_call_atomic1() from [1].
>	+ No longer dependent on the series from sboyd.
>
>v2 Changes:
>- Merge the warm boot patches into a single patch.
>
>[1]. https://lkml.org/lkml/2014/8/4/765
>
>Thanks,
>Lina
>
>Lina Iyer (3):
>  firmware: qcom: scm: Clean cold boot entry to export only the API
>  firmware: qcom: scm: Add qcom_scm_set_warm_boot_addr function
>  firmware: qcom: scm: Support cpu power down through SCM
>
> arch/arm/mach-qcom/platsmp.c |  21 +-----
> drivers/firmware/qcom_scm.c  | 154 ++++++++++++++++++++++++++++++++++++++++++-
> include/linux/qcom_scm.h     |  17 +++--
> 3 files changed, 163 insertions(+), 29 deletions(-)
>
>-- 
>2.1.0
>
