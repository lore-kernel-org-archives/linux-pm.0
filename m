From: =?UTF-8?Q?S=c3=a9bastien_Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Date: Mon, 25 Jun 2018 10:01:44 +0200
Message-ID: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611053826.GC16091@dragon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 06/11/2018 07:38 AM, Shawn Guo wrote:
> On Tue, May 22, 2018 at 08:28:51AM +0200, Sébastien Szymanski wrote:
>> Check the max speed supported from the fuses for i.MX6ULL and update the
>> operating points table accordingly.
>>
>> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> 
> Acked-by: Shawn Guo <shawnguo@kernel.org>
> 

Thanks, but what about the two others patches ? Now that patch 1 is in
4.18-rc1, should I resend the two others patches ? Should I merge them
together ?

-- 
Sébastien Szymanski
