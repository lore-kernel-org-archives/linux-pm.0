From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v2] thermal: imx: depend on imx SoC arch
Date: Sat, 20 Aug 2016 08:43:44 +0800
Message-ID: <CAAQ0ZWQoF6bw0V841OJoJ+oyV26ocYub80nRPYj-6AYLhQC9TA@mail.gmail.com>
References: <1464183950-7035-1-git-send-email-pbrobinson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464183950-7035-1-git-send-email-pbrobinson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, linux-pm@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, May 25, 2016 at 9:45 PM, Peter Robinson <pbrobinson@gmail.com> wrote:
> Not much use unless the SoC is selected so depend on the ARCH_MXC
> and COMPILE_TEST like all the other thermal drivers.
>
> v2: drop extraneous OF
>
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>
