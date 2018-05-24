From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v7 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Thu, 24 May 2018 11:16:13 +0200
Message-ID: <CAPDyKFoZ16vhVvriLjyUSKwfym7HxHwn6Y92Q2ukXu9BG5GykA@mail.gmail.com>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <ilina@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Sudeep, Lorenzo, Mark

On 12 April 2018 at 13:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v7:
>  - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
>    the psci firmware driver to a new firmware subdir and change to force PSCI PC
>    mode during boot to cope with kexec'ed booted kernels.

Are you guys happy in general with the PSCI specific parts from this
series? It would be nice if you could provide me with acks or
reviewed-by tags for the rest of them in such case.

I intend to re-post a new version very soon.

[...]

Kind regards
Uffe
