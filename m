From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH v3 1/3] cpufreq: imx6q: check speed grades for i.MX6ULL
Date: Thu, 28 Jun 2018 08:48:38 +0800
Message-ID: <20180628004837.GB22683@dragon>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
 <20180611053826.GC16091@dragon>
 <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2d63a25f-7265-7aa7-a7dc-fd2379240804@armadeus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Stefan Agner <stefan@agner.ch>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 25, 2018 at 10:01:44AM +0200, Sébastien Szymanski wrote:
> Hi,
> 
> On 06/11/2018 07:38 AM, Shawn Guo wrote:
> > On Tue, May 22, 2018 at 08:28:51AM +0200, Sébastien Szymanski wrote:
> >> Check the max speed supported from the fuses for i.MX6ULL and update the
> >> operating points table accordingly.
> >>
> >> Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
> > 
> > Acked-by: Shawn Guo <shawnguo@kernel.org>
> > 
> 
> Thanks, but what about the two others patches ? Now that patch 1 is in
> 4.18-rc1, should I resend the two others patches ? Should I merge them
> together ?

Yes, please.  That's what Viresh and Stefan were asking in the review.

Shawn
