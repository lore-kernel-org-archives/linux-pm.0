From: "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Subject: Re: [PATCH v4 0/5] ARM: K2G: Add support for TI-SCI Generic PM Domains
Date: Mon, 3 Apr 2017 09:58:34 -0700
Message-ID: <1bf8091a-76d2-1b2b-b23d-76d3493eb33c@oracle.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <2133897.t9KqoeriS0@aspire.rjw.lan> <58CAD9F5.7030904@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <58CAD9F5.7030904@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Cc: Nishanth Menon <nm@ti.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Kevin Hilman <khilman@kernel.org>, Keerthy <j-keerthy@ti.com>, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Tero Kristo <t-kristo@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Rob Herring <robh+dt@kernel.org>, Santosh Shilimkar <ssantosh@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Dave,

On 3/16/17 11:31 AM, Dave Gerlach wrote:
> Santosh,
> On 03/12/2017 12:02 PM, Rafael J. Wysocki wrote:

[...]

>>> I did not update the "power-domain" binding document because in regards to
>>> #power-domain-cells it already states "can be any value as specified by device
>>> tree binding documentation of particular provider" which I think already
>>> describes the change in patch 2.
>>
>> I'm assuming that this will go in through the arm-soc tree.
>
> Assuming that Rob is OK with the v5 of patch 3 that I just sent in response to
> the v4 patch email, can this series go through you? We should be good to go with
> v4 of the series + the small v5 update to patch 3 if Rob is ok with it.
>
Yes I can queue this up for arm-soc. Please repost the v5 with all the
patches and acks.


Hi Arnd, Olof,
Is it ok to send this as a single pull request ? Am asking since it
is touching few topics which goes via different heads.

------------------------
Dave Gerlach (5):
   PM / Domains: Add generic data pointer to genpd data struct
   PM / Domains: Do not check if simple providers have phandle cells
   dt-bindings: Add TI SCI PM Domains
   soc: ti: Add ti_sci_pm_domains driver
   ARM: keystone: Drop PM domain support for k2g

  .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |  59 ++++++
  MAINTAINERS                                        |   3 +
  arch/arm/mach-keystone/Kconfig                     |   1 +
  arch/arm/mach-keystone/pm_domain.c                 |   4 +-
  drivers/base/power/domain.c                        |   2 -
  drivers/soc/ti/Kconfig                             |  12 ++
  drivers/soc/ti/Makefile                            |   1 +
  drivers/soc/ti/ti_sci_pm_domains.c                 | 202 
+++++++++++++++++++++
  include/dt-bindings/genpd/k2g.h                    |  90 +++++++++
  include/linux/pm_domain.h                          |   1 +
  10 files changed, 372 insertions(+), 3 deletions(-)
  create mode 100644 
Documentation/devicetree/bindings/soc/ti/sci-pm-domain.txt
  create mode 100644 drivers/soc/ti/ti_sci_pm_domains.c
  create mode 100644 include/dt-bindings/genpd/k2g.h


regards,
Santosh
