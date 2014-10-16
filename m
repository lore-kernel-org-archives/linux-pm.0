From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: allow powersave governor as the default without
 expert mode
Date: Thu, 16 Oct 2014 15:57:35 +0530
Message-ID: <CAKohpokvx5G5JU_KYePOecRfAgXrOrOt__iagMcHQ2iy05gZLQ@mail.gmail.com>
References: <1413454804-19370-1-git-send-email-jgeboski@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413454804-19370-1-git-send-email-jgeboski@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: James Geboski <jgeboski@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 16 October 2014 15:50, James Geboski <jgeboski@gmail.com> wrote:
> The intel_pstate driver only supports the performance and the powersave
> governors. With the performance governor ensuring the highest possible
> performance settings, userspace tools fail to make any lasting changes.
> In order to allow userspace tools to make modifications to the settings,
> the powersave governor must be in use. This makes having the powersave
> governor as the default convenient for systems where the intel_pstate
> driver is being employed. Having to enable expert mode in the kernel
> configuration is just a headache for such a trivial task.
>
> This patch applies to all kernel versions 2.6.38 or greater after the
> migration from CONFIG_EMBEDDED to CONFIG_EXPERT (6a108a14fa35). Most
> importantly, this applies to kernel versions 3.9 or greater when the
> intel_pstate driver was introduced.
>
> Signed-off-by: James Geboski <jgeboski@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Why did you resent it? Without any information at all about what has changed?
