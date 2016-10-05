From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RESEND PATCH v2 3/3] cpufreq: brcmstb-avs-cpufreq: add debugfs
 support
Date: Wed, 5 Oct 2016 08:57:39 +0530
Message-ID: <20161005032739.GH4664@vireshk-i7>
References: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
 <1475272561-8446-4-git-send-email-mmayer@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475272561-8446-4-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Markus Mayer <mmayer@broadcom.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 30-09-16, 14:56, Markus Mayer wrote:
> In order to aid debugging, we add a debugfs interface to the driver
> that allows direct interaction with the AVS co-processor.
> 
> The debugfs interface provides a means for reading all and writing some
> of the mailbox registers directly from the shell prompt and enables a
> user to execute the communications protocol between ARM CPU and AVS CPU
> step-by-step.
> 
> This interface should be used for debugging purposes only.
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> ---
>  drivers/cpufreq/brcmstb-avs-cpufreq.c | 319 ++++++++++++++++++++++++++++++++++
>  1 file changed, 319 insertions(+)

I am not sure how much useful this is going to be, but I don't have
any concerns against this as well.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
