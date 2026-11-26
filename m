Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795724982;
	b=bzlpoyY2D1aytyYzLm7FwOFzrCoBSBS+HrTGOUSJehJlocxVZKCMC4+f5mQeaO/LrsFQ
	 GMRcZf0n1Ln1nybwosgl9ICq9ufffaUEvorZ1ytkGn3M1yX+5jhKzwJ2wO2mQhDGBDehs
	 VS5WsJKhNMMFDP9Wic5GGn0VIsaGI2BMez/WCw5UHNgLfeGzjL5CR+1eNkBhkzlzsuo/d
	 OIy8ITv2dsGk1ffvVDi3xtoP8+m8xBV+h346Zxsv/BKJM5p73MVnwkT3i0NyiK8xsRelj
	 fk4F2fds84WoENcqY+Jv6aURVlIKrrUXZrzja7P87dcwvLHVd9/QRKlZ4HemdKHgA5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724982;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ybSwYsBtFYROIp34qQ+zyeNf1481F+Ed1hRzeSMq/es=;
	b=j8Z2V0mAdJbSVSLIcnuonuDg+dhjHK8BsMTgBVEavzhYfg8cwDEWFG5druPIxagLIopt
	 Jx+dbKn7iDyPi99R6JuFLr+lCyjeHRk9a0FC2gt6wR7FgIPJIo8DYJ9yNCW/CeIcmp5U3
	 DXzagbhNphkLGijuN1vsLJBqVlnPms2opZ39sZ55TjCC2MorML3LjiV+zbPPhDI+Yo+Y8
	 qh+SyZqQxvVpOfZgyWPWqCxwVMeSGxGSyrYrbjPWpuVtG5fUgo807HzrqREgWo+fTYmnC
	 jdBP2m3AmDtymfn0Ol+w9AY1mH53yBfw6eqqelqc7qplzXq0ZjSc4V4blE8OVrA3BWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvnWuDTS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E40606A326;
	Thu, 26 Nov 2026 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CvnWuDTS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DB81F00896;
	Thu, 26 Nov 2026 20:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795724981;
	bh=ybSwYsBtFYROIp34qQ+zyeNf1481F+Ed1hRzeSMq/es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CvnWuDTS9B+z+krGjRcMZpTn9H7uWZK38RaC0srFABbGR3V2MoXMlYW8dY/quEjql
	 YoJh0rBLrLLKrDBx9XGXvkKNZEWbXD2El7BYruOLkCzCe0dChjk08mnbfUfO4Y/QaL
	 w4aeIm0aEaLt2VbDoRMGbbi2EK9cJZwJ+2Nd/wuuZk6k2Ozqd5iatKC3yTG/9SryOU
	 iMx3bB+AkKQ+0idMuHrQYoAPYyTFrozsvbM4ZJ0/k4AlC5TLMFXnLemPiL//kf/xVR
	 3LR0BYDbia3u40PJKD84oUdIjFekAxfTTH+Mhq/yjf+QUGpgKrzCG94FaveT0fNAgP
	 ddu9ERCk/IwTA==
Date: Thu, 26 Nov 2026 20:29:37 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Li Mingzhe <limingzhe1839@phytium.com.cn>
Cc: myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
	cw00.choi@samsung.com, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/1] PM / devfreq: add SCMI performance protocol bridge
Message-ID: <20261126-gleeful-lionfish-of-biology-6b3284@sudeepholla>
References: <20261118085715.27400-1-limingzhe1839@phytium.com.cn>
 <20261118085715.27400-2-limingzhe1839@phytium.com.cn>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118085715.27400-2-limingzhe1839@phytium.com.cn>

On Wed, Nov 18, 2026 at 04:57:15PM +0800, Li Mingzhe wrote:
> Add a bridge that binds the SCMI performance protocol scmi_device and
> exposes a devfreq-side API in include/linux/scmi-devfreq.h:
> 
>   scmi_devfreq_ready()         bound check for early probe deferral
>   scmi_devfreq_domain_id()     DT clocks phandle -> perf domain id
>   scmi_devfreq_opps_add()      import PERFORMANCE_DESCRIBE_LEVELS
>                                into the device OPP table
>   scmi_devfreq_freq_get/set()  PERFORMANCE_LEVEL_GET/SET wrappers
> 
> All functions return -EPROBE_DEFER until the bridge is bound, so
> consumers (DMU/NOC devfreq, GPU and other modules) are retried
> automatically. The API is generic and public so that out-of-tree
> devfreq consumers can use it.
> 
> Signed-off-by: Li Mingzhe <limingzhe1839@phytium.com.cn>
> ---
>  drivers/devfreq/Kconfig        |   9 ++
>  drivers/devfreq/Makefile       |   1 +
>  drivers/devfreq/scmi_devfreq.c | 205 +++++++++++++++++++++++++++++++++
>  include/linux/scmi-devfreq.h   |  30 +++++
>  4 files changed, 245 insertions(+)
>  create mode 100644 drivers/devfreq/scmi_devfreq.c
>  create mode 100644 include/linux/scmi-devfreq.h
> 

[...]

> diff --git a/drivers/devfreq/scmi_devfreq.c b/drivers/devfreq/scmi_devfreq.c
> new file mode 100644
> index 000000000000..147668850a7c
> --- /dev/null
> +++ b/drivers/devfreq/scmi_devfreq.c
> @@ -0,0 +1,205 @@
> +// SPDX-License-Identifier: GPL-1.0
> +/*
> + * Phytium SCMI devfreq bridge
> + *
> + * Single owner of the SCMI performance-device binding for the Phytium
> + * devfreq drivers (NOC/DMU), mirroring the drivers/cpufreq/scmi-cpufreq.c
> + * pattern: bind the perf-protocol scmi_device, import its ops/handle,
> + * register the dummy clock provider required by devices whose DT
> + * "clocks" phandle points at the perf protocol node, and expose a small
> + * devfreq-side API to the platform drivers.
> + *
> + * NOTE: the devfreq users must be built-in; unbinding/rebinding the
> + * scmi_device while a devfreq device is polling is not supported.
> + */
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/atomic.h>
> +#include <linux/clk-provider.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +#include <linux/pm_opp.h>
> +#include <linux/scmi_protocol.h>
> +
> +static const struct scmi_perf_proto_ops *perf_ops;
> +static struct scmi_protocol_handle *scmi_ph;
> +static atomic_t bridge_ready = ATOMIC_INIT(0);
> +
> +/*
> + * The devfreq nodes carry "clocks = <&scmi_perf id>" solely so that
> + * scmi_dev_domain_id() can parse the perf-domain id. The OPP core,
> + * however, treats any "clocks" phandle as a real clock reference and
> + * calls clk_get(dev, NULL) when creating the OPP table via
> + * dev_pm_opp_add() inside SCMI's device_opps_add(). Since protocol@13
> + * is never registered as a clock provider, that lookup would return
> + * -EPROBE_DEFER and brick the DT perf path.
> + *
> + * Mirror drivers/cpufreq/scmi-cpufreq.c:311-315: register a dummy
> + * clock provider on the sdev whose of_node IS the protocol@13 node so
> + * the clkspec lookup matches and clk_get() succeeds. clk_get()
> + * resolves to NULL (of_clk_hw_simple_get() just hands back the data
> + * pointer), which the OPP core treats as success. The perf path never
> + * uses clk_set_rate()/clk_get_rate(), so the placeholder clk is never
> + * touched afterwards.
> + */
> +static void scmi_devfreq_setup_dummy_clk_provider(struct scmi_device *sdev)
> +{
> +	struct device *dev = &sdev->dev;
> +	int ret;
> +
> +	if (!of_property_present(dev->of_node, "#clock-cells"))
> +		return;
> +
> +	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> +	if (ret) {
> +		dev_warn(dev, "devfreq bridge: failed to add dummy clk provider: %d\n",
> +			 ret);
> +		return;
> +	}
> +
> +	dev_info(dev, "devfreq bridge: dummy clk provider registered on perf protocol node\n");
> +}
> +
> +static int scmi_devfreq_scmi_probe(struct scmi_device *sdev)
> +{
> +	const void *ops;
> +	struct scmi_protocol_handle *ph;
> +
> +	ops = sdev->handle->devm_protocol_get(sdev, SCMI_PROTOCOL_PERF, &ph);
> +	if (IS_ERR(ops)) {
> +		dev_err(&sdev->dev, "devfreq bridge: devm_protocol_get failed: %ld\n",
> +			PTR_ERR(ops));
> +		return PTR_ERR(ops);
> +	}
> +
> +	perf_ops = ops;
> +	scmi_ph = ph;
> +
> +	scmi_devfreq_setup_dummy_clk_provider(sdev);
> +
> +	atomic_set(&bridge_ready, 1);
> +	dev_info(&sdev->dev, "devfreq bridge: SCMI perf protocol acquired, ready=%d\n",
> +		 atomic_read(&bridge_ready));
> +	return 0;
> +}
> +
> +static void scmi_devfreq_scmi_remove(struct scmi_device *sdev)
> +{
> +	atomic_set(&bridge_ready, 0);
> +	dev_warn(&sdev->dev, "devfreq bridge: SCMI perf protocol released, devfreq users will defer\n");
> +}
> +
> +static const struct scmi_device_id scmi_devfreq_id_table[] = {
> +	{ SCMI_PROTOCOL_PERF, "devfreq" },
> +	/*
> +	 * Claim remaining protocol@13 instances (e.g. the "cpufreq"
> +	 * scmi_device after a failed cpufreq registration): an unbound
> +	 * scmi_device on this of_node keeps fw_devlink holding the
> +	 * devfreq nodes in deferred probe with "supplier not ready".
> +	 */

For the above reason, you must build this devfreq driver using SCMI
performance domain genpd driver so that we don't need to create more
devices. With the latest fix merged, devfreq device won't be created
anymore.

-- 
Regards,
Sudeep
