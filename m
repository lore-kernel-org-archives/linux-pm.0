From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] PM / Domains: Improve support for multi PM domains
Date: Thu, 18 Apr 2019 12:27:54 +0200
Message-ID: <20190418102757.1246-1-ulf.hansson@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Hunter <jonathanh@nvidia.com>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

It's been a while since the introduction for the support for multi PM domains
per device in genpd. In this small series, a couple of different improvement
are being made to this code in genpd.

Ulf Hansson (3):
  PM / Domains: Don't kfree() the virtual device in the error path
  PM / Domains: Allow OF lookup for multi PM domain case from
    ->attach_dev()
  PM / Domains: Enable genpd_dev_pm_attach_by_id|name() for single PM
    domain

 drivers/base/power/domain.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.17.1
