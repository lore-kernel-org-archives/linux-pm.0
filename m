From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: Add thermal zone to bcm2835-thermal
 example
Date: Sat, 18 Feb 2017 17:13:29 -0800
Message-ID: <20170219011328.GA21016@localhost.localdomain>
References: <1486928328-25870-1-git-send-email-stefan.wahren@i2se.com>
 <878tp9kbt8.fsf@eliezer.anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <878tp9kbt8.fsf-omZaPlIz5HhaEpDpdNBo/KxOck334EZe@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>
Cc: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 13, 2017 at 01:42:11PM -0800, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org> writes:
> 
> > Add a thermal zone in order to make the example complete.
> >
> > Signed-off-by: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
> 
> This looks fine to me.  Eduardo, will this be enough to get the driver
> in?


Well, yes, but the driver needs to support the descriptors by
registering to of-thermal. But that would actually simplify the driver
as follows (patch on bcm2835 patch v9, so it supports the descriptors in
this thread):

 ------------------------8------------------------
diff --git a/drivers/thermal/bcm2835_thermal.c b/drivers/thermal/bcm2835_thermal.c
index 5e2fea9..ffcf847 100644
--- a/drivers/thermal/bcm2835_thermal.c
+++ b/drivers/thermal/bcm2835_thermal.c
@@ -61,14 +61,8 @@
 #define BCM2835_TS_TSENSSTAT_VALID		BIT(10)
 #define BCM2835_TS_TSENSSTAT_INTERRUPT		BIT(11)
 
-struct bcm2835_thermal_info {
-	int offset;
-	int slope;
-	int trip_temp;
-};
-
 struct bcm2835_thermal_data {
-	const struct bcm2835_thermal_info *info;
+	struct thermal_zone_device *tz;
 	void __iomem *regs;
 	struct clk *clk;
 	struct dentry *debugfsdir;
@@ -92,40 +86,9 @@ static int bcm2835_thermal_temp2adc(int temp, int offset, int slope)
 	return temp;
 }
 
-static int bcm2835_thermal_get_trip_type(
-	struct thermal_zone_device *tz, int trip,
-	enum thermal_trip_type *type)
+static int bcm2835_thermal_get_temp(void *d, int *temp)
 {
-	*type = THERMAL_TRIP_CRITICAL;
-	return 0;
-}
-
-static int bcm2835_thermal_get_trip_temp(
-	struct thermal_zone_device *tz, int trip, int *temp)
-{
-	struct bcm2835_thermal_data *data = tz->devdata;
-	u32 val = readl(data->regs + BCM2835_TS_TSENSCTL);
-
-	/* get the THOLD bits */
-	val &= BCM2835_TS_TSENSCTL_THOLD_MASK;
-	val >>= BCM2835_TS_TSENSCTL_THOLD_SHIFT;
-
-	/* if it is zero then use the info value */
-	if (val)
-		*temp = bcm2835_thermal_adc2temp(
-			val,
-			thermal_zone_get_offset(tz),
-			thermal_zone_get_slope(tz));
-	else
-		*temp = data->info->trip_temp;
-
-	return 0;
-}
-
-static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
-				    int *temp)
-{
-	struct bcm2835_thermal_data *data = tz->devdata;
+	struct bcm2835_thermal_data *data = d;
 	u32 val = readl(data->regs + BCM2835_TS_TSENSSTAT);
 
 	if (!(val & BCM2835_TS_TSENSSTAT_VALID))
@@ -135,8 +98,8 @@ static int bcm2835_thermal_get_temp(struct thermal_zone_device *tz,
 
 	*temp = bcm2835_thermal_adc2temp(
 		val,
-		thermal_zone_get_offset(tz),
-		thermal_zone_get_slope(tz));
+		thermal_zone_get_offset(data->tz),
+		thermal_zone_get_slope(data->tz));
 
 	return 0;
 }
@@ -174,10 +137,8 @@ static void bcm2835_thermal_debugfs(struct platform_device *pdev)
 				data->debugfsdir, regset);
 }
 
-static struct thermal_zone_device_ops bcm2835_thermal_ops  = {
+static struct thermal_zone_of_device_ops bcm2835_thermal_ops = {
 	.get_temp = bcm2835_thermal_get_temp,
-	.get_trip_temp = bcm2835_thermal_get_trip_temp,
-	.get_trip_type = bcm2835_thermal_get_trip_type,
 };
 
 static const struct of_device_id bcm2835_thermal_of_match_table[];
@@ -186,10 +147,9 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct thermal_zone_device *tz;
 	struct thermal_zone_params *tzp;
-	const struct bcm2835_thermal_info *ti;
 	struct bcm2835_thermal_data *data;
 	struct resource *res;
-	int err;
+	int err = 0;
 	u32 val;
 	unsigned long rate;
 
@@ -205,10 +165,6 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 				&pdev->dev);
 	if (!match)
 		return -EINVAL;
-	ti = match->data;
-	data->info = ti;
-	tzp->slope = ti->slope;
-	tzp->offset = ti->offset;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->regs = devm_ioremap_resource(&pdev->dev, res);
@@ -236,6 +192,17 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 			 "Clock %pCn running at %pCr Hz is outside of the recommended range: 1.92 to 5MHz\n",
 			 data->clk, data->clk);
 
+	/* register of thermal sensor and get info from DT */
+	tz = thermal_zone_of_sensor_register(&pdev->dev, 0, data,
+					     &bcm2835_thermal_ops);
+	if (IS_ERR(tz)) {
+		err = PTR_ERR(tz);
+		dev_err(&pdev->dev,
+			"Failed to register the thermal device: %d\n",
+			err);
+		goto err_clk;
+	}
+
 	/*
 	 * right now the FW does set up the HW-block, so we are not
 	 * touching the configuration registers.
@@ -244,6 +211,23 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 	 */
 	val = readl(data->regs + BCM2835_TS_TSENSCTL);
 	if (!(val & BCM2835_TS_TSENSCTL_RSTB)) {
+		int trip_temp, offset, slope;
+
+		slope = thermal_zone_get_slope(tz);
+		offset = thermal_zone_get_offset(tz);
+		/*
+		 * For now we deal only with critical, otherwise
+		 * would need to iterate
+		 */
+		err = tz->ops->get_trip_temp(tz, 0, &trip_temp);
+		if (err < 0) {
+			err = PTR_ERR(tz);
+			dev_err(&pdev->dev,
+				"Not able to read trip_temp: %d\n",
+				err);
+			goto err_tz;
+		}
+
 		/* the basic required flags */
 		val = (BCM2835_TS_TSENSCTL_CTRL_DEFAULT <<
 		       BCM2835_TS_TSENSCTL_CTRL_SHIFT) |
@@ -256,9 +240,9 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		val |= (14 << BCM2835_TS_TSENSCTL_RSTDELAY_SHIFT);
 
 		/*  trip_adc value from info */
-		val |= bcm2835_thermal_temp2adc(data->info->trip_temp,
-						data->info->offset,
-						data->info->slope)
+		val |= bcm2835_thermal_temp2adc(trip_temp,
+						offset,
+						slope)
 			<< BCM2835_TS_TSENSCTL_THOLD_SHIFT;
 
 		/* write the value back to the register as 2 steps */
@@ -267,26 +251,18 @@ static int bcm2835_thermal_probe(struct platform_device *pdev)
 		writel(val, data->regs + BCM2835_TS_TSENSCTL);
 	}
 
-	/* register thermal zone with 1 trip point an 1s polling */
-	tz = thermal_zone_device_register("bcm2835_thermal",
-					  1, 0, data,
-					  &bcm2835_thermal_ops,
-					  tzp,
-					  0, 1000);
-	if (IS_ERR(tz)) {
-		clk_disable_unprepare(data->clk);
-		err = PTR_ERR(tz);
-		dev_err(&pdev->dev,
-			"Failed to register the thermal device: %d\n",
-			err);
-		return err;
-	}
+	data->tz = tz;
 
 	platform_set_drvdata(pdev, tz);
 
 	bcm2835_thermal_debugfs(pdev);
 
-	return 0;
+err_tz:
+	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
+err_clk:
+	clk_disable_unprepare(data->clk);
+
+	return err;
 }
 
 static int bcm2835_thermal_remove(struct platform_device *pdev)
@@ -295,7 +271,7 @@ static int bcm2835_thermal_remove(struct platform_device *pdev)
 	struct bcm2835_thermal_data *data = tz->devdata;
 
 	debugfs_remove_recursive(data->debugfsdir);
-	thermal_zone_device_unregister(tz);
+	thermal_zone_of_sensor_unregister(&pdev->dev, tz);
 	clk_disable_unprepare(data->clk);
 
 	return 0;
@@ -312,28 +288,12 @@ static int bcm2835_thermal_remove(struct platform_device *pdev)
 static const struct of_device_id bcm2835_thermal_of_match_table[] = {
 	{
 		.compatible = "brcm,bcm2835-thermal",
-		.data = &(struct bcm2835_thermal_info) {
-			.offset = 407000,
-			.slope = -538,
-			.trip_temp = 80000
-		}
 	},
 	{
 		.compatible = "brcm,bcm2836-thermal",
-		.data = &(struct bcm2835_thermal_info) {
-			.offset = 407000,
-			.slope = -538,
-			.trip_temp = 80000
-		}
 	},
 	{
 		.compatible = "brcm,bcm2837-thermal",
-		.data = &(struct bcm2835_thermal_info) {
-			/* the bcm2837 needs adjustment of +5C */
-			.offset = 407000 + 5000,
-			.slope = -538,
-			.trip_temp = 80000
-		}
 	},
 	{},
 };

 ------------------------8------------------------
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
