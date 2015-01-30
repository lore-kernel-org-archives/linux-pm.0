From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH] thermal: Add msm tsens thermal sensor driver
Date: Fri, 30 Jan 2015 10:39:08 +0200
Message-ID: <1422607148.11083.10.camel@mm-sol.com>
References: <1422331786-19620-1-git-send-email-nrajan@codeaurora.org>
	 <20150129223946.GD29837@developer.amazonguestwifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20150129223946.GD29837@developer.amazonguestwifi.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Narendran Rajan <nrajan@codeaurora.org>, Zhang Rui <rui.zhang@intel.com>, Linux ARM MSM <linux-arm-msm@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Siddartha Mohanadoss <smohanad@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: linux-pm@vger.kernel.org


On Thu, 2015-01-29 at 18:39 -0400, Eduardo Valentin wrote:
> On Mon, Jan 26, 2015 at 08:09:46PM -0800, Narendran Rajan wrote:
> > TSENS supports reading temperature from multiple thermal
> > sensors present in QCOM SOCs.
> > TSENS HW is enabled only when the main sensor is requested.
> > The TSENS block is disabled if the main senors is disabled
> > irrespective of any other sensors that are being enabled.
> > TSENS driver supports configurable threshold for temperature
> > monitoring in which case it can generate an interrupt when specific
> > thresholds are reached
> >=20
> > Based on code by Siddartha Mohanadoss and Stephen Boyd.
> >=20
> > Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > Cc: Stephen Boyd <sboyd@codeaurora.org>
> > Signed-off-by: Narendran Rajan=C2=A0=C2=A0<nrajan@codeaurora.org>
>=20
> I know this might not be completely related, but since you are sendin=
g
> QCOM code, can you please check my comments on your PMIC thermal code=
?
> https://patchwork.kernel.org/patch/5013021/
>=20
> Ivan seams to have disappeared.



Mm no, sorry, just distracted by other tasks. PMIC thermal driver is in=
 the
road map. I will try to accelerate rework.

Regards,
Ivan
