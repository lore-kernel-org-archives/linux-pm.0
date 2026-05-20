Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75963A254C;
	Wed, 20 May 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779267537; cv=none; b=hknK71bNraga0QZNF43YkCn0EfbnK6Ekf2CdnZWTe3ctMOzJkykX42ovzmmXIMw52vuOMcpoeyWoWN8O0cZ3ueQohx1N6l0qtofc6MV3g0NSokrF+t1b4vFgoBFVI/1zoTSVAo0GEKZ7SZnVrnpEKLK8NyezaKdruT3lQzXRtgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779267537; c=relaxed/simple;
	bh=YfJrh2tqW4oiFxVzvovNy67le8j1cP8HssBVwy88V+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bB6trVIsXs7Y3/+bMB5K39QV67gTaXPSQpG9i/Ns27tujJHsaZ+i9rBbXtoCIMSvQ/ufTxDbHgQRMWV6Ow3o3KRtF7pzIEBttQRhC+UQuX7vR+b++RRohUOXhJ0O/psxkodtpxd8De+sDoelqI3i3nEJy7b2DabX6Zd+7fE+prM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=LOWLPCEZ; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="LOWLPCEZ"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29B47488B;
	Wed, 20 May 2026 01:58:47 -0700 (PDT)
Received: from donnerap.manchester.arm.com (donnerap.manchester.arm.com [10.33.8.81])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59F183F85F;
	Wed, 20 May 2026 01:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1779267532; bh=YfJrh2tqW4oiFxVzvovNy67le8j1cP8HssBVwy88V+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LOWLPCEZYS0lhB6TdtBQvXnHSQMYLBzWXJB/asOAQgDGMrUEG9NUFlOq/W1iwtNDD
	 8+qwOoJlPvIH0xVw4Urg0nR5iBnZraNiPP7sscKh9EXCe1MSTbvr1FtPWehs7ESjYO
	 BEI6OQ2TU+7ZHUIPZfZbCSbfD7ibOEf9NL5JjN6A=
Date: Wed, 20 May 2026 09:58:47 +0100
From: Philip Radford <philip.radford@arm.com>
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org
Cc: sudeep.holla@arm.com, james.quinlan@broadcom.com, f.fainelli@gmail.com,
	vincent.guittot@linaro.org, etienne.carriere@st.com,
	peng.fan@oss.nxp.com, michal.simek@amd.com, quic_sibis@quicinc.com,
	dan.carpenter@linaro.org, d-gole@ti.com, souvik.chakravarty@arm.com
Subject: Re: [PATCH v6 06/12] firmware: arm_scmi: Extend powercap report to
 include MAI
Message-ID: <ag13x1Wp7PQ-wa4q@donnerap.manchester.arm.com>
References: <20260518135234.2953532-1-philip.radford@arm.com>
 <20260518135234.2953532-7-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518135234.2953532-7-philip.radford@arm.com>

On Mon, May 18, 2026 at 02:52:28PM +0100, Philip Radford wrote:
> Extend scmi_powercap_meas_changed_report to include MAI change
> notifications.
> 
> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
> V5->V6
> - Re-worded existing comment for POWERCAP_MEASUREMENTS_NOTIFY
> - Added define for V2/V3 sizes
> - Used new definitions
> ---
>  drivers/firmware/arm_scmi/powercap.c | 28 +++++++++++++++-------------
>  include/linux/scmi_protocol.h        |  1 +
>  2 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
> index 1d1188e98d49..fdfaf03277ab 100644
> --- a/drivers/firmware/arm_scmi/powercap.c
> +++ b/drivers/firmware/arm_scmi/powercap.c
> @@ -11,6 +11,7 @@
>  #include <linux/io.h>
>  #include <linux/module.h>
>  #include <linux/scmi_protocol.h>
> +#include <linux/stddef.h>
>  
>  #include <trace/events/scmi.h>
>  
> @@ -21,6 +22,8 @@
>  #define SCMI_PROTOCOL_SUPPORTED_VERSION		0x30000
>  
>  #define CPL0	0
> +#define SZ_V2 (sizeof(struct scmi_powercap_meas_changed_notify_payld))
> +#define SZ_V3 (SZ_V2 - sizeof(__le32))
>  

Apologies all,

After posting I have realised that I mislabelled these macros where SZ_V2
should be the smaller of the two.

This will be fixed in a new version along with any further comments.

Sorry again,
Phil
