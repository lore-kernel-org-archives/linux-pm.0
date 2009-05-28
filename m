From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 01/04] Driver Core: Add platform device arch
	data
Date: Thu, 28 May 2009 23:26:56 +0200
Message-ID: <200905282326.57431.rjw__28468.4607213878$1243546186$gmane$org@sisk.pl>
References: <20090527100625.29671.43166.sendpatchset@rx1.opensource.se>
	<20090527100633.29671.83531.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090527100633.29671.83531.sendpatchset@rx1.opensource.se>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: paul@pwsan.com, linux-sh@vger.kernel.org, gregkh@suse.de, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 27 May 2009, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Allow architecture specific data in struct platform_device.
> Platform device data is needed by the runtime pm code. A similar
> struct already exists for struct device.
> 
> The architecture specific asm/device.h file needs to provide
> struct pdev_archdata if CONFIG_HAVE_PLATFORM_DEVICE_DATA is set.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Optionally we can make use of struct device archdata instead,
>  but since the runtime device pm is limited to platform devices
>  it makes sense to make this data platform device specific imo.
> 
>  arch/Kconfig                    |    3 +++
>  include/linux/platform_device.h |    5 +++++
>  2 files changed, 8 insertions(+)
> 
> --- 0001/arch/Kconfig
> +++ work/arch/Kconfig	2009-05-15 14:51:35.000000000 +0900
> @@ -112,3 +112,6 @@ config HAVE_DMA_API_DEBUG
>  
>  config HAVE_DEFAULT_NO_SPIN_MUTEXES
>  	bool
> +
> +config HAVE_PLATFORM_DEVICE_ARCHDATA

Hmm.  Do we really need yet another CONFIG_ option for that?

> +	bool
> --- 0001/include/linux/platform_device.h
> +++ work/include/linux/platform_device.h	2009-05-15 16:59:01.000000000 +0900
> @@ -23,6 +23,11 @@ struct platform_device {
>  	void		*platform_data;
>  
>  	struct platform_device_id	*id_entry;
> +
> +#ifdef CONFIG_HAVE_PLATFORM_DEVICE_ARCHDATA
> +	/* arch specific additions */
> +	struct pdev_archdata	archdata;
> +#endif
>  };
>  
>  #define platform_get_device_id(pdev)	((pdev)->id_entry)
