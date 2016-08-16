From: Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 00/10] PM / Domains: Add support for removing PM domains
Date: Tue, 16 Aug 2016 10:49:26 +0100
Message-ID: <1471340976-5379-1-git-send-email-jonathanh@nvidia.com>
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
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, Alexander Aring <alex.aring@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, Kukjin Kim <kgene@kernel.org>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

In order to safely remove PM domains there are a few changes that need to be
made to ensure that no one is holding an external reference to a PM domain
after it has been removed. One solution, implemented here, solves this by
eliminating external references to PM domain.

This is a follow-up to the initial RFC I sent out [0].

Changes from initial RFC:
- Renamed functions made static per Ulf's feedback.
- Added patch to clean-up provider/xlate APIs per Ulf's feedback
- Re-worked and simplified the association between PM domains and PM
  domain providers. Dropped the 'provider_data' variable from the
  generic_pm_domain structure in favour of using the fwnode_handle.
- Split patch for removing PM domains into multiple patches per Ulf's
  feedback.

[0] http://marc.info/?l=linux-pm&m=145709064407085&w=2

Jon Hunter (10):
  PM / Domains: Add new helper functions for device-tree
  ARM: EXYNOS: Remove calls to of_genpd_get_from_provider()
  staging: board: Remove calls to of_genpd_get_from_provider()
  PM / Domains: Don't expose generic_pm_domain structure to clients
  PM / Domains: Don't expose xlate and provider helper functions
  PM / Domains: Verify the PM domain is present when adding a provider
  PM / Domains: Prepare for adding support to remove PM domains
  PM / Domains: Add support for removing PM domains
  PM / Domains: Store the provider in the PM domain structure
  PM / Domains: Add support for removing nested PM domains by provider

 drivers/base/power/domain.c      | 361 +++++++++++++++++++++++++++++++++++----
 drivers/soc/samsung/pm_domains.c |  23 +--
 drivers/staging/board/board.c    |   9 +-
 include/linux/pm_domain.h        |  73 ++++----
 4 files changed, 371 insertions(+), 95 deletions(-)

-- 
2.1.4
