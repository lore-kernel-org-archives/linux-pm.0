From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v4 0/6] thermal: tsens: Refactoring for TSENSv2 IP
Date: Mon, 9 Jul 2018 17:00:46 +0530
Message-ID: <CAHLCerM1t-xO-zpYn3twb14VMGoC3+Pyv8LHuzYt7NVJWF0n4w@mail.gmail.com>
References: <cover.1530533998.git.amit.kucheria@linaro.org> <20180702175357.GA28713@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702175357.GA28713@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, smohanad@codeaurora.org, Vivek Gautam <vivek.gautam@codeaurora.org>, Andy Gross <andy.gross@linaro.org>, Kees Cook <keescook@chromium.org>, Rob Herring <robh@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, lakml <linux-arm-kernel@lists.infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 2, 2018 at 11:23 PM, Eduardo Valentin <edubezval@gmail.com> wrote:
> On Mon, Jul 02, 2018 at 06:14:03PM +0530, Amit Kucheria wrote:
>> This series is a mixed bag:
>> - Some code moves to allow code sharing between various v2.x.y versions of
>>   the TSENS IP,
>> - new qcom,tsens-v2.4.0 DT property for SDM845 and a generic qcom,tsens-v2
>>   property as a fallback compatible for all v2.x.y platforms,
>> - new platform support (sdm845)
>> - a cleanup patch and
>> - a DT change to have a common way to deal with the SROT and TM registers
>>   despite slightly different features across the IP family and different
>>   register offsets.
>>
>> Rob mentioned offline that we should expose the full version string of the
>> TSENS IP (x.y.z) and have a fallback compatible. I hope patch 4 does what
>> you were looking for.
>
> Applied patches 1, 3, and 4. Patch 5 needs a description. Patches 2 and
> 6 go via your arch tree.

Hi Eduardo,

I've sent v5 for this series. It fixes a breakage for old DTs with new
code. Also, Rob decided he was happier with the earlier single
fallback binding. Please consider applying the new series.

Regards,
Amit
