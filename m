From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 6/9] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date: Mon, 14 Jan 2019 15:58:57 -0800
Message-ID: <154751033725.169631.501138616256305502@swboyd.mtv.corp.google.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <b5e5698973c156f16af825ee92b8c94af224e634.1547458732.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b5e5698973c156f16af825ee92b8c94af224e634.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:08)
> Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
> to auto-register the driver as a cooling device.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
