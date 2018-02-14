From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 0/2] mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers
Date: Wed, 14 Feb 2018 15:57:42 +0200
Message-ID: <1518616664-14342-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Sender: linux-mmc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi

Here is a small fix (cc stable) and a subsequent tidy-up.


Adrian Hunter (2):
      mmc: sdhci-pci: Fix S0i3 for Intel BYT-based controllers
      mmc: sdhci-pci: Get rid of glk_cqe_enable()

 drivers/mmc/host/sdhci-pci-core.c | 55 +++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 23 deletions(-)


Regards
Adrian
