From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: Re: [v2,07/14] thermal: mvebu: Rename kirkwood definitions to mvebu
Date: Thu, 11 Apr 2013 12:43:43 -0400
Message-ID: <5166E83F.4050800@ti.com>
References: <1363991114-4225-8-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1363991114-4225-8-git-send-email-ezequiel.garcia@free-electrons.com>
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

On 22-03-2013 18:25, Ezequiel Garcia wrote:
> This definitions will be also valid for other SoC,
> such as Armada 370 and Armada XP. Therefore we rename them as 'mvebu'.
>

I believe it is appropriated to squash this one to your patch v2 02/14.

> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
>
> ---
> drivers/thermal/mvebu_thermal.c |   16 ++++++++--------
>   1 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> index 0c9344d..39ddded 100644
> --- a/drivers/thermal/mvebu_thermal.c
> +++ b/drivers/thermal/mvebu_thermal.c
> @@ -22,10 +22,10 @@
>   #include <linux/platform_device.h>
>   #include <linux/thermal.h>
>
> -#define KIRKWOOD_THERMAL_VALID_OFFSET	9
> -#define KIRKWOOD_THERMAL_VALID_MASK	0x1
> -#define KIRKWOOD_THERMAL_TEMP_OFFSET	10
> -#define KIRKWOOD_THERMAL_TEMP_MASK	0x1FF
> +#define MVEBU_THERMAL_VALID_OFFSET	9
> +#define MVEBU_THERMAL_VALID_MASK	0x1
> +#define MVEBU_THERMAL_TEMP_OFFSET	10
> +#define MVEBU_THERMAL_TEMP_MASK		0x1FF
>
>   /* Marvell EBU Thermal Sensor Dev Structure */
>   struct mvebu_thermal_priv {
> @@ -41,8 +41,8 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
>   	reg = readl_relaxed(priv->sensor);
>
>   	/* Valid check */
> -	if (!((reg >> KIRKWOOD_THERMAL_VALID_OFFSET) &
> -	    KIRKWOOD_THERMAL_VALID_MASK)) {
> +	if (!((reg >> MVEBU_THERMAL_VALID_OFFSET) &
> +	    MVEBU_THERMAL_VALID_MASK)) {
>   		dev_err(&thermal->device,
>   			"Temperature sensor reading not valid\n");
>   		return -EIO;
> @@ -53,8 +53,8 @@ static int mvebu_get_temp(struct thermal_zone_device *thermal,
>   	 * documentation the formula for this is:
>   	 * Celsius = (322-reg)/1.3625
>   	 */
> -	reg = (reg >> KIRKWOOD_THERMAL_TEMP_OFFSET) &
> -		KIRKWOOD_THERMAL_TEMP_MASK;
> +	reg = (reg >> MVEBU_THERMAL_TEMP_OFFSET) &
> +		MVEBU_THERMAL_TEMP_MASK;
>   	*temp = ((3220000000UL - (10000000UL * reg)) / 13625);
>
>   	return 0;
>
