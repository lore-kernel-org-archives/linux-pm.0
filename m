From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: linux-5.1/drivers/thermal/qcom/tsens-v2.c:54]: bad assignment ?
Date: Tue, 7 May 2019 15:59:34 +0530
Message-ID: <CAP245DXfm-1U34UOsFio7ZQwoiEaecW9cC4ghmXrzTJPVbs0dA@mail.gmail.com>
References: <DB7PR08MB3801953BFC1A48BC8F9F83679C310@DB7PR08MB3801.eurprd08.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB7PR08MB3801953BFC1A48BC8F9F83679C310@DB7PR08MB3801.eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Binderman <dcb314@hotmail.com>
Cc: "andy.gross@linaro.org" <andy.gross@linaro.org>, "david.brown@linaro.org" <david.brown@linaro.org>, "rui.zhang@intel.com" <rui.zhang@intel.com>, "edubezval@gmail.com" <edubezval@gmail.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, May 7, 2019 at 3:40 PM David Binderman <dcb314@hotmail.com> wrote:
>
> Hello there,
>
>
> linux-5.1/drivers/thermal/qcom/tsens-v2.c:54]: (style) Assignment 'last_temp=last_temp2' is redundant with condition 'last_temp==last_temp2'.
>
> Source code is
>
>
>         if (last_temp == last_temp2)
>                 last_temp = last_temp2;
>
> Suggest code rework.
>
> Regards
>
> David Binderman

Hi David,

Thanks for the report. That was an old version of the function from
downstream. I've now refactored it and resubmitted it here:

https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1922871.html

Regards,
Amit
