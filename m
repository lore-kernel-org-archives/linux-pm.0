From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/3] PM / Domains: Enable name based lookup at attach
Date: Fri, 29 Jun 2018 13:04:29 +0200
Message-ID: <20180629110432.5179-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <dev@lynxeye.de>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Jon Hunter <jonathanh@nvidia.com>, Todor Tomov <todor.tomov@linaro.org>, linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Recently we added support to manage multiple PM domains per device. Consumer
drivers were provided an API, dev_pm_domain_attach_by_id() to associate its
device with one of its PM domain, by using an index.

Let's extend this to allow the association to be done using a name based
lookup, which follows the similar concept as for other resource types, such as
clocks for example.

Ulf Hansson (3):
  PM / Domains: dt: Add a power-domain-names property
  PM / Domains: Introduce option to attach a device by name to genpd
  PM / Domains: Introduce dev_pm_domain_attach_by_name()

 .../bindings/power/power_domain.txt           |  8 +++++++
 drivers/base/power/common.c                   | 17 +++++++++++++
 drivers/base/power/domain.c                   | 24 +++++++++++++++++++
 include/linux/pm_domain.h                     | 15 ++++++++++++
 4 files changed, 64 insertions(+)

-- 
2.17.1
