From: "R, Durgadoss" <durgadoss.r@intel.com>
Subject: RE: [PATCH] thermal: shorten too long mcast group name
Date: Thu, 21 Mar 2013 10:19:00 +0000
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59C5573E@BGSMSX101.gar.corp.intel.com>
References: <20130321.190819.892238877314124764.yamato@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130321.190819.892238877314124764.yamato@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Masatake YAMATO <yamato@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc: "Linux PM list (linux-pm@vger.kernel.org)" <linux-pm@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-pm@vger.kernel.org

> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Masatake YAMATO
> Sent: Thursday, March 21, 2013 3:38 PM
> To: linux-acpi@vger.kernel.org
> Cc: yamato@redhat.com
> Subject: [PATCH] thermal: shorten too long mcast group name
> 
> You will see garbage at the end of line in the output of following command
> line:
> 
>         $ genl ctrl show | grep thermal_mc_group
>         #1:  ID-0x2  name: thermal_mc_group^B

Agreed.

> 
> The type of structure field for "name" is char[16] in the kernel:
> 
>     #define GENL_NAMSIZ 16      /* length of family name */
>     ...
>     struct genl_multicast_group {
>             ...
>             char                name[GENL_NAMSIZ];
>             ...
>     };
> 
> strlen("thermal_mc_group") == 16 is too long for the array size.
> 
> "thermal_mc_grp" is more readable than "thermal_mc_grou". However,
> I choose latter; the patch for genl command side may truncate the
> last char in the name:

I prefer we use thermal_mc_grp.

+ Adding Rui & the Linux-pm list.

Thanks,
Durga
> 
>      http://marc.info/?l=linux-netdev&m=136371412625262&w=2
> 
> Signed-off-by: Masatake YAMATO <yamato@redhat.com>
> ---
>  include/linux/thermal.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index f0bd7f9..a65dff3 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -44,7 +44,7 @@
>  /* Adding event notification support elements */
>  #define THERMAL_GENL_FAMILY_NAME                "thermal_event"
>  #define THERMAL_GENL_VERSION                    0x01
> -#define THERMAL_GENL_MCAST_GROUP_NAME
> "thermal_mc_group"
> +#define THERMAL_GENL_MCAST_GROUP_NAME           "thermal_mc_grou"
> 
>  /* Default Thermal Governor */
>  #if defined(CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE)
> --
> 1.7.11.7
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
