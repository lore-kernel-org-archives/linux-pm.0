From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] OPP: Fix handling of multiple power domains
Date: Wed, 06 Mar 2019 10:02:58 -0800
Message-ID: <155189537895.20095.130363485109002162@swboyd.mtv.corp.google.com>
References: <20190306040726.1930-1-rnayak@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190306040726.1930-1-rnayak@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: nm@ti.com, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Rajendra Nayak (2019-03-05 20:07:26)
> We seem to rely on the number of phandles specified in the
> 'required-opps' property to identify cases where a device is
> associated with multiple power domains and hence would have
> multiple virtual devices that have to be dealt with.
>=20
> In cases where we do have devices with multiple power domains
> but with only one of them being scalable, this logic seems to
> fail.
>=20
> Instead read the number of power domains from DT to identify
> such cases.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
