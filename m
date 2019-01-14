From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 3/9] drivers: cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date: Mon, 14 Jan 2019 15:54:44 -0800
Message-ID: <154751008451.169631.1287877735076391741@swboyd.mtv.corp.google.com>
References: <cover.1547458732.git.amit.kucheria@linaro.org> <bbc4cccbe2931de5f7e07b70a4873624424ac930.1547458732.git.amit.kucheria@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bbc4cccbe2931de5f7e07b70a4873624424ac930.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>, linux-kernel@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org, viresh.kumar@linaro.org, edubezval@gmail.com, andy.gross@linaro.org, tdas@codeaurora.org, dianders@chromium.org, mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Quoting Amit Kucheria (2019-01-14 02:21:05)
> Several cpufreq drivers register themselves as thermal cooling devices.
> Adding a pointer to struct cpufreq_policy removes the need for them to
> store this pointer in a private data structure.
>=20
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
