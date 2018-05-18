From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 0/9] PM / Domains: Add support for multi PM domains per device
Date: Fri, 18 May 2018 12:31:21 +0200
Message-ID: <1526639490-12167-1-git-send-email-ulf.hansson@linaro.org>
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rajendra Nayak <rnayak@codeaurora.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Jon Hunter <jonathanh@nvidia.com>, Todor Tomov <todor.tomov@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-tegra@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

There are devices that are partitioned across multiple PM domains. Currently
these can't be supported well by the available PM infrastructures we have in
the kernel. This series is an attempt to address this.

The interesting parts happens from patch 5 an onwards, including a minor DT
update to the existing power-domain bindings, the 4 earlier are just trivial
clean-ups of some related code in genpd, which I happened to stumble over.

Some additional background:

One existing case where devices are partitioned across multiple PM domains, is
the Nvida Tegra 124/210 X-USB subsystem. A while ago Jon Hunter (Nvidia) sent a
series, trying to address these issues, however this is a new approach, while
it re-uses the same concepts from DT point of view.

The Tegra 124/210 X-USB subsystem contains of a host controller and a device
controller. Each controller have its own independent PM domain, but are being
partitioned across another shared PM domain for the USB super-speed logic.

Currently to make the drivers work, either the related PM domains needs to stay
powered on always or the PM domain topology needs to be in-correctly modelled
through sub-domains. In both cases PM domains may be powered on while they
don't need to be, so in the end this means - wasting power -.

As stated above, this series intends to address these problem from a PM
infrastructure point of view. More details are available in each changelog.

It should be noted that this series has been tested on HW, however only by using
a home-cooked test PM domain driver for genpd and together with a test driver.
This allowed me to play with PM domain (genpd), runtime PM and device links.

Any further deployment for real use cases are greatly appreciated. I am happy to
to help, if needed!

Kind regards
Ulf Hansson


Ulf Hansson (9):
  PM / Domains: Drop extern declarations of functions in pm_domain.h
  PM / Domains: Drop __pm_genpd_add_device()
  PM / Domains: Drop genpd as in-param for pm_genpd_remove_device()
  PM / Domains: Drop unused parameter in genpd_allocate_dev_data()
  PM / Domains: dt: Allow power-domain property to be a list of phandles
  PM / Domains: Don't attach devices in genpd with multi PM domains
  PM / Domains: Split genpd_dev_pm_attach()
  PM / Domains: Add support for multi PM domains per device to genpd
  PM / Domains: Add dev_pm_domain_attach_by_id() to manage multi PM
    domains

 .../devicetree/bindings/power/power_domain.txt     |  18 ++-
 drivers/base/power/common.c                        |  33 ++++-
 drivers/base/power/domain.c                        | 154 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c            |   2 +-
 include/linux/pm_domain.h                          |  79 +++++------
 5 files changed, 208 insertions(+), 78 deletions(-)

-- 
2.7.4
