From: Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH v3] clk: qoriq: add support for lx2160a
Date: Thu, 25 Apr 2019 11:22:23 -0700
Message-ID: <155621654326.15276.741983919838675194@swboyd.mtv.corp.google.com>
References: <1556200638-24066-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556200638-24066-1-git-send-email-vabhav.sharma@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "mturquette@baylibre.com" <mturquette@baylibre.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Andy Tang <andy.tang@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
List-Id: linux-pm@vger.kernel.org

Quoting Vabhav Sharma (2019-04-25 06:57:05)
> From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>=20
> Add clockgen support and configuration for NXP SoC lx2160a in qoriq
> clock driver with compatible property as "fsl,lx2160a-clockgen".
>=20
> qoriq-cpufreq driver is based on qoriq clock driver, enable support
> of NXP SoC lx2160a in qoriq cpufreq driver to handle the lx2160a SoC.
>=20
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Acked-by: Scott Wood <oss@buserror.net>
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes for v3:
> - Incorporated review comments of Rafael J. Wysocki
> - Updated commit message

If you can split it into clk and cpufreq that would be preferred. Then I
can take the clk part and PM tree can take the cpufreq part. Otherwise,
you have sent other patches to drivers/clk/clk-qoriq.c and I'm worried
there will be cross tree conflicts if I take those other patches this
cycle.
