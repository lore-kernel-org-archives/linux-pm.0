From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 3/3] cpufreq: dt: add support for rockchip rv1108
Date: Wed, 23 Aug 2017 03:08:49 +0200
Message-ID: <CAJZ5v0jGn7YBw37MWoDVXRH36gJ4bSWmEizu04u4HauwnPcvBw@mail.gmail.com>
References: <1503407515-13943-1-git-send-email-andy.yan@rock-chips.com>
 <1503407722-14056-1-git-send-email-andy.yan@rock-chips.com>
 <1949899.3GLvcOh6S6@aspire.rjw.lan> <9923a1d0-2794-834b-855e-4131287e4b75@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9923a1d0-2794-834b-855e-4131287e4b75@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 23, 2017 at 2:49 AM, Andy Yan <andy.yan@rock-chips.com> wrote:
> Hi Rafael:
>
>
> On 2017=E5=B9=B408=E6=9C=8822=E6=97=A5 21:44, Rafael J. Wysocki wrote:
>>
>> On Tuesday, August 22, 2017 3:15:22 PM CEST Andy Yan wrote:
>>>
>>> Add the compatible string to support the generic device tree
>>> cpufreq-dt driver on rockchip rv1108 soc.
>>>
>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>
>> This is a [3/3] in a series, so presumably it depends on something, so I
>> guess
>> it should be applied along with the thing it depends on.  Right?
>
>
>     The other two are dts parts [1] [2], they have been taken to arm-soc =
by
> Heiko.
> And Heiko also gave a Reviewed-by for this patch in v1[3].
>
>     [1] https://patchwork.kernel.org/patch/9915139/
>     [2] https://patchwork.kernel.org/patch/9915145/
>     [3] https://patchwork.kernel.org/patch/9911907/

So please ask Viresh for an ACK on this one and route it through
arm-soc as well.

Thanks,
Rafael
