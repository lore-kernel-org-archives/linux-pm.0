From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,06/14] thermal: mvebu: Fix license declaration
Date: Thu, 11 Apr 2013 12:40:14 -0400
Message-ID: <5166E76E.5020104@ti.com>
References: <1363991114-4225-7-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363991114-4225-7-git-send-email-ezequiel.garcia@free-electrons.com>
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
Cc: Lior Amsalem <alior@marvell.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-pm@vger.kernel.org, eduardo.valentin@ti.com, Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@free-electrons.com>, Zhang Rui <rui.zhang@intel.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi Rui,

On 22-03-2013 18:25, Ezequiel Garcia wrote:
> The license text declared in the header explicit says GPL v2 only,
> but the MODULE_LICENSE macro says GPL, which means GPL v2 or later. Fix it.
>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>

This specific patch is fine to me.

Acked-by: Eduardo Valentin <eduardo.valentin@ti.com>

> ---
> drivers/thermal/mvebu_thermal.c |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index 2aeaf75..0c9344d 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -128,4 +128,4 @@ module_platform_driver(mvebu_thermal_driver);
>
>   MODULE_AUTHOR("Nobuhiro Iwamatsu <iwamatsu@nigauri.org>");
>   MODULE_DESCRIPTION("mvebu thermal driver");
> -MODULE_LICENSE("GPL");
> +MODULE_LICENSE("GPL v2");
>

Side question, while here:
Ezequiel, does this driver need a MODULE_ALIAS
