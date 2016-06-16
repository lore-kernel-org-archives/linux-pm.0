From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [QUERY] AMBA: PM domains when !CONFIG_PM
Date: Thu, 16 Jun 2016 12:19:13 +0100
Message-ID: <57628B31.3090901@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@baylibre.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi Ulf, Kevin,

I have a situation where we need to enable the power domain to access an
AMBA device. This is all fine with patches from Ulf and Marek in amba/bus.c

The problem is when we disable CONFIG_PM, dev_pm_domain_attach
returns -ENODEV irrespective of whether a DT node has a PM domain
in it or not. If dev_pm_domain_attach returns anything other than
-EPROBE_DEFER, we ignore the error and proceed to access the device
which will explode.

Basically, we need a way to prevent addition of that amba device if DT
node has PD specified but CONFIG_PM=n. Any thoughts ?

-- 
Regards,
Sudeep
