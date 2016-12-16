From: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: Add missing CPU frequencies for Exynos5422/5800
Date: Fri, 16 Dec 2016 13:22:20 -0300
Message-ID: <f4f0dd96-abf1-d1ba-86a6-99f216b5175b@osg.samsung.com>
References: <5220084.l31t5oJbsy@amdc3058>
 <CGME20161213191823epcas5p346582b73ad9b401d9e773a1b076f1f61@epcas5p3.samsung.com>
 <26ffeee4-ff43-b3d3-3267-5fcbc50e2974@osg.samsung.com>
 <2340115.HEG9AYUCMD@amdc3058>
 <CAD=FV=W6R8cNuR+gTnNRF6d-TNgzUeYTwuCp27efoMsd0YOH3g@mail.gmail.com>
 <20161216073720.GA3489@kozik-lap>
 <1b6e8d3a-ec7a-db5d-dd0e-ef9d1480f80a@fivetechno.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1b6e8d3a-ec7a-db5d-dd0e-ef9d1480f80a-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Reichl <m.reichl-SRyzfwRm/0rPTwkrwQOX7A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Arjun K V <arjun.kv-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Andreas Faerber <afaerber-l3A5Bk7waGM@public.gmane.org>, Thomas Abraham <thomas.ab-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Ben Gamari <ben-OfdNVJEh3GKkIYD+M5K+dQ@public.gmane.org>, linux-samsung-soc <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alim <alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hello Markus,

On 12/16/2016 06:08 AM, Markus Reichl wrote:
> Am 16.12.2016 um 08:37 schrieb Krzysztof Kozlowski:
>> On Thu, Dec 15, 2016 at 04:52:58PM -0800, Doug Anderson wrote:
>>>> [ I added Arjun to Cc:, maybe he can help in explaining this issue
>>>>   (unfortunately Inderpal's email is no longer working). ]
>>>>
>>>> Please also note that on Exynos5422/5800 SoCs the same ARM rail
>>>> voltage is used for 1.9 GHz & 2.0 GHz OPPs as for the 1.8 GHz one.
>>>> IOW if the problem exists it is already present in the mainline
>>>> kernel.
>>>
>>> Interesting.  In the ChromeOS tree I see significantly higher voltages
>>> needed...  Note that one might naively look at
>>> <https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/drivers/cpufreq/exynos5420-cpufreq.c#178>.
>>>
>>> 1362500, /* L0  2100 */
>>> 1312500, /* L1  2000 */
>>>
>>> ..but, amazingly enough those voltages aren't used at all.  Surprise!
>>>
>>> I believe that the above numbers are actually not used and the ASV
>>> numbers are used instead.  See
>>> <https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chromeos-3.8/arch/arm/mach-exynos/include/mach/asv-exynos542x.h#452>
>>>
>>> { 2100000,
>>> 1350000, 1350000, 1350000, 1350000, 1350000,
>>> 1337500, 1325000, 1312500, 1300000, 1287500,
>>> 1275000, 1262500, 1250000, 1237500 },
>>>
>>> I believe that interpretation there is: some bins of the CPU can run
>>> at 2.1 GHz just fine at 1.25 V but others need up to 1.35V.
>>
>> That is definitely the case. One could just look at vendors ASV table
>> (for 1.9 GHz):
>> { 1900000, 1300000, 1287500, 1262500, 1237500, 1225000, 1212500,
>>                     1200000, 1187500, 1175000, 1162500, 1150000,
>> 		             1137500, 1125000, 1112500, 1112500},
>>
>> The theoretical difference is up to 1.875V! From my experiments I saw
>> BIN1 chips which should be the same... but some working on 1.2V, some on
>> 1.225V (@1.9 GHz). I didn't see any requiring higher voltages but that
>> does not mean that there aren't such...
>>
>>> ...so if you're running at 2.1 GHz at 1.25V then perhaps you're just
>>> running on a CPU from a nice bin?
> 
> I've been running the proposed frequency/voltage combinations without any
> stability problems on my XU4, XU3 and even XU3-lite ( I did not delete the
> nodes on XU3-lite dts) with make -j8 kernel and ssvb-cpuburn.
> The chips are poorly cooled, especially the XU4 and quickly step down.
> 
>>
>> Would be nice to see a dump of PKG_ID and AUX_INFO chipid registers
>> along with name of tested board. Because the "Tested on XU3" is not
>> sufficient.
> 
> If you point me to how to read these values out, I will publish them.
>

You can use the exynos-chipid driver posted by Pankaj. Apply patches 1 and
2 from this series (http://www.spinics.net/lists/arm-kernel/msg548384.html)
and then this diff to get the values of the registers that Krzysztof asked:

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index cf0128b18ee2..49fa76ec6d49 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -22,6 +22,9 @@
 #define EXYNOS_MAINREV_MASK	(0xF << 0)
 #define EXYNOS_REV_MASK		(EXYNOS_SUBREV_MASK | EXYNOS_MAINREV_MASK)
 
+#define EXYNOS_PKG_ID		0x04
+#define EXYNOS_AUX_INFO		0x1C
+
 static const struct exynos_soc_id {
 	const char *name;
 	unsigned int id;
@@ -71,6 +74,8 @@ int __init exynos_chipid_early_init(void)
 	const struct of_device_id *match;
 	u32 product_id;
 	u32 revision;
+	u32 pkg_id;
+	u32 aux_info;
 
 	np = of_find_matching_node_and_match(NULL,
 			of_exynos_chipid_ids, &match);
@@ -84,6 +89,8 @@ int __init exynos_chipid_early_init(void)
 
 	product_id  = readl_relaxed(exynos_chipid_base);
 	revision = product_id & EXYNOS_REV_MASK;
+	pkg_id = readl_relaxed(exynos_chipid_base + EXYNOS_PKG_ID);
+	aux_info = readl_relaxed(exynos_chipid_base + EXYNOS_AUX_INFO);
 	iounmap(exynos_chipid_base);
 
 	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
@@ -100,8 +107,8 @@ int __init exynos_chipid_early_init(void)
 	soc_dev_attr->soc_id = product_id_to_soc_id(product_id);
 
 
-	pr_info("Exynos: CPU[%s] CPU_REV[0x%x] Detected\n",
-			product_id_to_soc_id(product_id), revision);
+	pr_info("Exynos: CPU[%s] CPU_REV[0x%x] PKG_ID[0x%x] AUX_INFO[0x%x] \n",
+		product_id_to_soc_id(product_id), revision, pkg_id, aux_info);
 
 	soc_dev = soc_device_register(soc_dev_attr);
 	if (IS_ERR(soc_dev)) {

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
