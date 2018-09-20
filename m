From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v3] cpufreq: qcom-kryo: Fix section annotations
Date: Thu, 20 Sep 2018 09:13:08 -0700
Message-ID: <20180920161308.bitlceo2czyzomsg@vireshk-mac-ubuntu>
References: <20180920002220.16644-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180920002220.16644-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Ilia Lin <ilia.lin@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>
List-Id: linux-pm@vger.kernel.org

On 19-09-18, 17:22, Nathan Chancellor wrote:
> There is currently a warning when building the Kryo cpufreq driver into
> the kernel image:
> 
> WARNING: vmlinux.o(.text+0x8aa424): Section mismatch in reference from
> the function qcom_cpufreq_kryo_probe() to the function
> .init.text:qcom_cpufreq_kryo_get_msm_id()
> The function qcom_cpufreq_kryo_probe() references
> the function __init qcom_cpufreq_kryo_get_msm_id().
> This is often because qcom_cpufreq_kryo_probe lacks a __init
> annotation or the annotation of qcom_cpufreq_kryo_get_msm_id is wrong.
> 
> Remove the '__init' annotation from qcom_cpufreq_kryo_get_msm_id
> so that there is no more mismatch warning.
> 
> Additionally, Nick noticed that the remove function was marked as
> '__init' when it should really be marked as '__exit'.

I know Rafael asked to merge the two patches into a single one, but I still
believe its the best to have two separate patches to fix these two separate
issues. For example, picking this patch for an earlier kernel may produce
conflicts because the exit code was written at a later point of time and also
that the below Fixes tag applies only to the first problem only. And the
individual patch for the exit problem is already on the list.

> Fixes: 46e2856b8e18 ("cpufreq: Add Kryo CPU scaling driver")
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Anyway I am fine if Rafael wants to pick it up this way only.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
