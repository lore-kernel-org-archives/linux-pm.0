From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] thermal: imx: Fix race condition in imx_thermal_probe()
Date: Tue, 20 Mar 2018 10:13:01 -0300
Message-ID: <CAOMZO5CU-X7i7jMTHnSVzK0OiuEC5rEbPh9X_rjypN105R4S8g@mail.gmail.com>
References: <1517595466-23465-1-git-send-email-festevam@gmail.com>
 <CAOMZO5D5rRask0pGQBFf+47sG0XURj17=pO4hMiAh4MZa4nkJQ@mail.gmail.com>
 <CAOMZO5A7vqGffkj0qHUQo7MXVQMfy5Om7yw1YCs6ZR_0aOE37A@mail.gmail.com>
 <1519792963.2797.20.camel@intel.com> <CAOMZO5CZ5bMKFLuZYcwqwSgL2yLzUL_Dv1xD8_F2sBCGBOLPsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CAOMZO5CZ5bMKFLuZYcwqwSgL2yLzUL_Dv1xD8_F2sBCGBOLPsw@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>
Cc: Mikhail Lappo <mikhail.lappo@esrlabs.com>, linux-pm@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>, Philipp Zabel <p.zabel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, stable <stable@vger.kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

Hi Rui,

On Wed, Mar 7, 2018 at 4:55 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Rui,
>
> On Wed, Feb 28, 2018 at 1:42 AM, Zhang Rui <rui.zhang@intel.com> wrote:
>
>> interesting, this problem should be covered by this patch https://patch
>> work.kernel.org/patch/10242483/, together with some driver code change.
>>
>> anyway, as that is not a complete solution yet, I will apply this patch
>> as a quick solution.
>
> Thanks, but I still don't see this one in your tree.

Sorry to bother you, but is it possible to get this one to 4.17, please?
