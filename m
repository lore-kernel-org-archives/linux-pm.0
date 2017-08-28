From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: Re: [PATCH v2 2/5] nvmem: core: Add nvmem_cell_read_u32
Date: Mon, 28 Aug 2017 13:51:11 +0300
Message-ID: <1503917471.22307.9.camel@nxp.com>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
         <eedf98ecb5d9d47f3c8b9ffbf58e03c7a2fb8db4.1500041281.git.leonard.crestez@nxp.com>
         <2744539a-d729-2568-47f0-42ba90036639@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-co1nam03on0066.outbound.protection.outlook.com ([104.47.40.66]:19584
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751152AbdH1KvT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Aug 2017 06:51:19 -0400
In-Reply-To: <2744539a-d729-2568-47f0-42ba90036639@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>

On Fri, 2017-08-25 at 10:07 +0100, Srinivas Kandagatla wrote:
> On 14/07/17 15:11, Leonard Crestez wrote:
> > 
> > This function does a quick and easy read of an u32 value without any
> > kind of resource management code on the consumer side.
> > 
> > Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> > ---
> Sorry about the long delay, I was expecting this patch to go via Greg KH 
> tree to an rc, which seems to be very late now, so here is my Ack so 
> that you could pick this patch from other tree along with this series.
> 
> I will resend my fixes to Greg without this patch.
> 
Ok. Should I resend my series? It's been a while since it was first
posted.
