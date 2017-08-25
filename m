From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/5] nvmem: core: Add nvmem_cell_read_u32
Date: Fri, 25 Aug 2017 10:07:48 +0100
Message-ID: <2744539a-d729-2568-47f0-42ba90036639@linaro.org>
References: <cover.1500041281.git.leonard.crestez@nxp.com>
 <eedf98ecb5d9d47f3c8b9ffbf58e03c7a2fb8db4.1500041281.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <eedf98ecb5d9d47f3c8b9ffbf58e03c7a2fb8db4.1500041281.git.leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: Dong Aisheng <aisheng.dong-3arQi8VN3Tc@public.gmane.org>, Bai Ping <ping.bai-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org



On 14/07/17 15:11, Leonard Crestez wrote:
> This function does a quick and easy read of an u32 value without any
> kind of resource management code on the consumer side.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
> ---
Sorry about the long delay, I was expecting this patch to go via Greg KH 
tree to an rc, which seems to be very late now, so here is my Ack so 
that you could pick this patch from other tree along with this series.

I will resend my fixes to Greg without this patch.



Acked-by: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

>   drivers/nvmem/core.c           | 37 +++++++++++++++++++++++++++++++++++++
>   include/linux/nvmem-consumer.h |  8 ++++++++
>   2 files changed, 45 insertions(+)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 4c49285..cf2d645 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -1111,6 +1111,43 @@ int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len)
>   EXPORT_SYMBOL_GPL(nvmem_cell_write);
>   
>   /**
> + * nvmem_cell_read_u32() - Read a cell value as an u32
> + *
> + * @dev: Device that requests the nvmem cell.
> + * @cell_id: Name of nvmem cell to read.
> + * @val: pointer to output value.
> + *
> + * Return: 0 on success or negative errno.
> + */
> +int nvmem_cell_read_u32(struct device* dev, const char *cell_id, u32 *val)
> +{
> +	struct nvmem_cell *cell;
> +	void *buf;
> +	size_t len;
> +
> +	cell = nvmem_cell_get(dev, cell_id);
> +	if (IS_ERR(cell))
> +		return PTR_ERR(cell);
> +
> +	buf = nvmem_cell_read(cell, &len);
> +	if (IS_ERR(buf)) {
> +		nvmem_cell_put(cell);
> +		return PTR_ERR(buf);
> +	}
> +	if (len != sizeof(*val)) {
> +		kfree(buf);
> +		nvmem_cell_put(cell);
> +		return -EINVAL;
> +	}
> +	memcpy(val, buf, sizeof(*val));
> +
> +	kfree(buf);
> +	nvmem_cell_put(cell);
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(nvmem_cell_read_u32);
> +
> +/**
>    * nvmem_device_cell_read() - Read a given nvmem device and cell
>    *
>    * @nvmem: nvmem device to read from.
> diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
> index c2256d7..a402522 100644
> --- a/include/linux/nvmem-consumer.h
> +++ b/include/linux/nvmem-consumer.h
> @@ -36,6 +36,8 @@ void devm_nvmem_cell_put(struct device *dev, struct nvmem_cell *cell);
>   void *nvmem_cell_read(struct nvmem_cell *cell, size_t *len);
>   int nvmem_cell_write(struct nvmem_cell *cell, void *buf, size_t len);
>   
> +int nvmem_cell_read_u32(struct device* dev, const char *cell_id, u32 *val);
> +
>   /* direct nvmem device read/write interface */
>   struct nvmem_device *nvmem_device_get(struct device *dev, const char *name);
>   struct nvmem_device *devm_nvmem_device_get(struct device *dev,
> @@ -85,6 +87,12 @@ static inline int nvmem_cell_write(struct nvmem_cell *cell,
>   	return -ENOSYS;
>   }
>   
> +static inline int nvmem_cell_read_u32(struct device* dev,
> +				      const char *cell_id, u32 *val)
> +{
> +	return -ENOSYS;
> +}
> +
>   static inline struct nvmem_device *nvmem_device_get(struct device *dev,
>   						    const char *name)
>   {
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
