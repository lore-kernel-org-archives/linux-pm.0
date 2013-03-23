From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v2 00/14] Marvell EBU thermal sensor consolidation
Date: Sat, 23 Mar 2013 14:16:38 -0400
Message-ID: <20130323181638.GN13280@titan.lakedaemon.net>
References: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1363991114-4225-1-git-send-email-ezequiel.garcia@free-electrons.com>
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
Cc: Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2013 at 07:25:00PM -0300, Ezequiel Garcia wrote:
...
> Ezequiel Garcia (14):
>   thermal: Rename driver 'kirkwood' -> 'mvebu'
>   thermal: mvebu: Rename symbols 'kirkwood' -> 'mvebu'
>   thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
>   thermal: mvebu: Remove unneeded variable initialization
>   thermal: mvebu: Convert to devm_ioremap_resource()
>   thermal: mvebu: Fix license declaration
>   thermal: mvebu: Rename kirkwood definitions to mvebu
>   thermal: mvebu: Add infrastructure to support more multiple SoC
>     variants
>   thermal: mvebu: Add support for Armada XP thermal sensor
>   thermal: mvebu: Add support for Armada 370 thermal sensor
>   thermal: mvebu: Add support for Marvell Dove SoC family

Once the thermal maintainers agree to take this in, I'll take the three
below through mvebu/arm-soc.  This shouldn't cause any dependency
headaches, and will reduce the possibility of merge conflicts.

>   ARM: mvebu: Add thermal support to Armada XP device tree
>   ARM: mvebu: Add thermal support to Armada 370 device tree
>   ARM: configs: Update mvebu, dove and kirkwood defconfigs for thermal

thx,

Jason.
