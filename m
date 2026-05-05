Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD923D0914;
	Tue,  5 May 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778012027; cv=none; b=rpHJzt2XtKDbMlo+eSLrIrSeLvpHpv8QG12GbK5a1bssgYmT+XjRCh9V2A8HdTdoninaj6+O136bO71gQJ9tFcODe/BnMQmp3XhF99LKBnQLJJChKhdaG13xoYryVXDpS82QZQH6hzXMX878XMEaYoEB0SAZBCqEmCdaV9Od4sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778012027; c=relaxed/simple;
	bh=ynAbCMg2qQJVXRYbA6ts9gqhSiOUCgGSYE0bBVHxnsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W1h7hujIIIi33fHe8yzsGR8BlRrUIDA2wL+nPgmLhoAzY+tYrSqI/fBgNag3f8brJnaBKOZB44i45qzlOjxioaJMp5j7prZeCU8On24y2Gt2oWzgLWbaM6OgVCkeetnLLP4gCqxn9BJ90ozhX3aZ8kHOwT/f7msPg6PRhtFICo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VBmwRDCc; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VBmwRDCc"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B7A4C1BB0;
	Tue,  5 May 2026 13:13:37 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C9383F763;
	Tue,  5 May 2026 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778012023; bh=ynAbCMg2qQJVXRYbA6ts9gqhSiOUCgGSYE0bBVHxnsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VBmwRDCc0L1cw4zLU+zTUNzgXz2NbrRwLCbgnkFP1rkdLhEqhpUNe7oxGqlaZeg2z
	 vua1SsfGoEsgdqpKayF1Mawrc2PdTs5A6wBFXd6hxLDGKoQyUds2S0hFeq9gH7EIOP
	 EZvyVz5Ggk2I1yb42cso9mRXhe/Qisi9iQ99JNco=
Date: Tue, 5 May 2026 21:13:32 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Philip Radford <philip.radford@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	sudeep.holla@arm.com, james.quinlan@broadcom.com,
	f.fainelli@gmail.com, vincent.guittot@linaro.org,
	etienne.carriere@st.com, peng.fan@oss.nxp.com, michal.simek@amd.com,
	quic_sibis@quicinc.com, dan.carpenter@linaro.org, d-gole@ti.com,
	souvik.chakravarty@arm.com, cristian.marussi@arm.com
Subject: Re: [PATCH v5 06/12] firmware: arm_scmi: Extend powercap report to
 include MAI
Message-ID: <afpPbHkvNE0ijM9n@pluto>
References: <20260428090922.346069-1-philip.radford@arm.com>
 <20260428090922.346069-7-philip.radford@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090922.346069-7-philip.radford@arm.com>

On Tue, Apr 28, 2026 at 10:09:15AM +0100, Philip Radford wrote:
> Extend scmi_powercap_meas_changed_report to include MAI change
> notifications.
> 

Hi

> Signed-off-by: Philip Radford <philip.radford@arm.com>
> ---
>  drivers/firmware/arm_scmi/powercap.c | 20 ++++++++++++--------
>  include/linux/scmi_protocol.h        |  1 +
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/powercap.c b/drivers/firmware/arm_scmi/powercap.c
> index 1d1188e98d49..b9d50f4e8ae5 100644
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
> @@ -164,6 +165,7 @@ struct scmi_powercap_meas_changed_notify_payld {
>  	__le32 agent_id;
>  	__le32 domain_id;
>  	__le32 power;
> +	__le32 mai;
>  };
>  
>  struct scmi_msg_powercap_cpc {
> @@ -1212,13 +1214,6 @@ static int scmi_powercap_notify(const struct scmi_protocol_handle *ph,
>  		if (ret)
>  			return ret;
>  
> -		if (enable && !low && !high) {
> -			dev_err(ph->dev,
> -				"Invalid Measurements Notify thresholds: %u/%u\n",
> -				low, high);
> -			return -EINVAL;
> -		}
> -

Ok so you removed this check because now that a notification can be
emitted even only to notify a MAI change, it is possible that the
thresholds are zero and the notification will be emitted anyway due to
a MAI change....BUT you have to review or completely remove the comment
block that precedes this that says:

   /*                                                               
    * Note that we have to pick the most recently configured        
    * thresholds to build a proper POWERCAP_MEASUREMENTS_NOTIFY     
    * enable request and we fail, complaining, if no thresholds     
    * were ever set, since this is an indication the API has been   
    * used wrongly.                                                 
    */                                                              

...becasue NOW is no more true and misleading, since you just removed the
fail and complain part...

It would be good to shortly explain in a comment the new possible
scenarios in which notification can be enabled...

>  		ret = ph->xops->xfer_get_init(ph, message_id,
>  					      sizeof(*notify), 0, &t);
>  		if (ret)
> @@ -1333,14 +1328,23 @@ scmi_powercap_fill_custom_report(const struct scmi_protocol_handle *ph,
>  	{
>  		const struct scmi_powercap_meas_changed_notify_payld *p = payld;
>  		struct scmi_powercap_meas_changed_report *r = report;
> +		const size_t sz_v2 = offsetofend(struct scmi_powercap_meas_changed_notify_payld,
> +						 power);
> +		const size_t sz_v3 = sizeof(*p);

While this is a valid and nice construct, I think is overkill here since
these offsets/sizes will never change at runtime....

...you can just define above a couples of DEFINE that hardcodes the
sizes of the v2 and v3 by using the

	#define SZ_V2 	(sizeof(struct scmi_powercap_meas_changed_notify_payld))

and
	#define SZ_V3   (SZ_V2 - sizeof(__le32))

>  
> -		if (sizeof(*p) != payld_sz)
> +		if (payld_sz != sz_v2 && payld_sz != sz_v3)
>  			break;
>  
>  		r->timestamp = timestamp;
>  		r->agent_id = le32_to_cpu(p->agent_id);
>  		r->domain_id = le32_to_cpu(p->domain_id);
>  		r->power = le32_to_cpu(p->power);

maybe more clear to simply:
		
		r->mai = 0;
		if (payld_sz == SZ_V3 && PROTOCOL_REV_MAJOR(ph->version) >= 0x3)
			r->mai = le32_to_cpu(p->mai);

		
> +
> +		if (payld_sz == sz_v3 && PROTOCOL_REV_MAJOR(ph->version) >= 0x3)
> +			r->mai = le32_to_cpu(p->mai);
> +		else
> +			r->mai = 0;
> +
>  		*src_id = r->domain_id;

Thanks,
Cristian
