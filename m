From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v1] cpufreq: qcom: Read voltage LUT and populate OPP
Date: Fri, 21 Dec 2018 13:45:53 -0800
Message-ID: <154542875327.13075.3548703610883534822@swboyd.mtv.corp.google.com>
References: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545415608-15163-1-git-send-email-tdas@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, amit.kucheria@linaro.org, Matthias Kaehlcke <mka@chromium.org>, evgreen@google.com, Taniya Das <tdas@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

Quoting Taniya Das (2018-12-21 10:06:48)
> Add support to read the voltage look up table and populate OPP for all
> corresponding CPUS.

Yes, but why? Please specify the motivations in the commit text.
