From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 2/5] cpufreq: tegra20: Support OPP, thermal cooling and
 Tegra30
Date: Wed, 17 Oct 2018 09:47:16 +0100
Message-ID: <50a5b783-d865-c1a6-bfa3-7b38a5ad2a01@nvidia.com>
References: <20180830194356.14059-1-digetx@gmail.com>
 <20180830194356.14059-3-digetx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830194356.14059-3-digetx@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Osipenko <digetx@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


On 30/08/2018 20:43, Dmitry Osipenko wrote:
> Add support for thermal throttling and Operating Performance Points.
> Driver now relies on OPP's supplied via device tree and therefore will
> work only on devices that use the updated device tree. The generalization
> of the driver allows to transparently support Tegra30.

Thierry, can we or should we do this?

Cheers
Jon

-- 
nvpublic
