From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 08/16] thermal: mvebu: Fix temperature output formula
 for kirkwood
Date: Thu, 21 Mar 2013 19:20:46 +0000
Message-ID: <20130321192046.GQ4977@n2100.arm.linux.org.uk>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1363818997-23137-9-git-send-email-ezequiel.garcia@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Lior Amsalem <alior@marvell.com>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, Florian Fainelli <florian@openwrt.org>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Mar 20, 2013 at 07:36:29PM -0300, Ezequiel Garcia wrote:
> The temperature formula was taken from the Armada 510 datasheet.
> This is wrong because the Kirkwood SoC thermal sensor has
> different coefficients.
> 
> Fix it using values from 88F682/88F683 Kirkwood datasheet.

Err, hang on.  You've changed this from being a Kirkwood specific
driver to being a "mvebu" driver, which I had understood was being
done to cover all Kirkwood, Dove, etc SoCs.

If that's the case, then this change is wrong because you break it
for Dove.

If the coefficients are different between Kirkwood and Dove, then
it needs to be adapted at run time depending on whether it's running
on Kirkwood or Dove - not just having the coefficients changed at
compile time to suit a different set of platforms.

If it's worth making a change, do it *properly*.
