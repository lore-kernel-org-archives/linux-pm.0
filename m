From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v13 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Thu, 13 Dec 2018 21:36:20 -0800
Message-ID: <154476578010.19322.1755200407546472686@swboyd.mtv.corp.google.com>
References: <1544760624-12874-1-git-send-email-tdas@codeaurora.org> <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544760624-12874-3-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, Taniya Das <tdas@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-12-13 20:10:24)
> The CPUfreq HW present in some QCOM chipsets offloads the steps necessary
> for changing the frequency of CPUs. The driver implements the cpufreq
> driver interface for this hardware engine.
>=20
> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Tested-by: Stephen Boyd <swboyd@chromium.org>
