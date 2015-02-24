From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v5] thermal: Add QPNP PMIC temperature alarm driver
Date: Tue, 24 Feb 2015 09:51:02 +0200
Message-ID: <1424764262.2340.10.camel@mm-sol.com>
References: <1423156376-16041-1-git-send-email-iivanov@mm-sol.com>
	 <20150223205121.GA30865@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150223205121.GA30865@developer.amazonguestwifi.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, David Collins <collinsd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


On Mon, 2015-02-23 at 16:51 -0400, Eduardo Valentin wrote:
> On Thu, Feb 05, 2015 at 07:12:56PM +0200, Ivan T. Ivanov wrote:
> > Add support for the temperature alarm peripheral found inside
> > Qualcomm plug-and-play (QPNP) PMIC chips. The temperature alarm
> > peripheral outputs a pulse on an interrupt line whenever the
> > thermal over temperature stage value changes.
> > 
> > Register a thermal sensor. The temperature reported by this thermal
> > sensor device should reflect the actual PMIC die temperature if an
> > ADC is present on the given PMIC. If no ADC is present, then the
> > reported temperature should be estimated from the over temperature
> > stage value.
> > 
> > Cc: David Collins <collinsd@codeaurora.org>
> > Signed-off-by: Ivan T. Ivanov <iivanov@mm-sol.com>
> 
> Applying to my -linus branch.



Thank you.
Ivan
