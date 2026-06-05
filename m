Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499834DC549;
	Fri,  5 Jun 2026 12:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780664150; cv=none; b=K9E7MwpISakHc3BhhsjUrP5Y7fElf2YwrMuto/BOuhB6kHeYJ4VvSQk+5lxKKnqqZFnDugpZXv29HNRKbFTauCchD1WlLqbPNSvCl2yDglnMJzPlCfMBjtPYjGO7IV7AvRcvFtBLVO5RTyy7/apDFAuHgBmxIdqxH598acnbcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780664150; c=relaxed/simple;
	bh=Ae3EzWbz2x4wKInVAoclu1tHQGUFoRgqBgR2q+TkvCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KRKDyPu4IUxclzY2hCSUct0WiismXBYpcqXGmhCe8QrpSowz1IcOx0rGo5VanPLiFpIE5u+pJDx48MqzT9kqrIunkexIotevt+CWZDND6xkjx/Shy8Nm+FHZNshEana+i8siKMScxFotun66/oemV4c0JgTLYu0gI47+UCSb/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VAKkNA5e; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VAKkNA5e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780664149; x=1812200149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ae3EzWbz2x4wKInVAoclu1tHQGUFoRgqBgR2q+TkvCU=;
  b=VAKkNA5eyLFJq3H5YqgOZbS7iPxA/8O4ETIYVXXr3gNZXEOWM644L3mH
   oDVPy2HnrbpW4wU1yS5+CHrRoVowg5tFZNc2lYssHGpojHDLsWc3tlMyT
   wgmm/lQJYUuXt3bvp/7ZhG4UtYXgCZKKu0WeqrCuc6E90cwNz3Al0LkXB
   8dh8kqWcLHKSwgcgzcDG33ZStr9PFHUnlv3DMcxhLYGkhCfq+dtc7eo2s
   feAiq3tvpj/bhaHe6pPT+cXsL2vgLBYue6NWVYWRO5Hfdw/XOXND2EetO
   f4dnN2N8YDQgHsLXuUY8dsi7C/VM/LQStsN5BD1rDpHyGSCNN0lzrufK4
   w==;
X-CSE-ConnectionGUID: L6x7L05cQZmOSHBpWr2ThA==
X-CSE-MsgGUID: TudO+K+lSnirAefHxm+cmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85385717"
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="85385717"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 05:55:48 -0700
X-CSE-ConnectionGUID: pNDypNj5QOSEBsdX+loFJg==
X-CSE-MsgGUID: bgBH+cXUQOOAViSRpgmEWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,188,1774335600"; 
   d="scan'208";a="243999696"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 05 Jun 2026 05:55:43 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 6FB6595; Fri, 05 Jun 2026 14:55:42 +0200 (CEST)
Date: Fri, 5 Jun 2026 15:55:38 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: amitsd@google.com
Cc: Sebastian Reichel <sre@kernel.org>,
	Badhri Jagan Sridharan <badhri@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	RD Babiera <rdbabiera@google.com>, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 2/2] usb: typec: tcpm: Add support for Battery Status
 response message
Message-ID: <aiLHSlkdw_BAO6c_@kuha>
References: <20260602-batt-status-v3-0-a7c1c271f3b0@google.com>
 <20260602-batt-status-v3-2-a7c1c271f3b0@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-batt-status-v3-2-a7c1c271f3b0@google.com>

On Tue, Jun 02, 2026 at 10:47:07PM +0000, Amit Sunil Dhamne via B4 Relay wrote:
> From: Amit Sunil Dhamne <amitsd@google.com>
> 
> Add support for responding to a Get_Battery_Status request with a
> Battery_Status message. The port partner shall request the status of a
> port's battery by providing an index in the Get_Battery_Status AMS. In
> case of failure to identify the battery, the port shall reply with an
> appropriate message indicating so.
> 
> Support for Battery_Status message is required for sinks that contain
> battery as specified in USB PD Rev3.1 v1.8
> ("Applicability of Data Messages" section).
> 
> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 135 +++++++++++++++++++++++++++++++++++++++++-
>  include/linux/usb/pd.h        |  29 +++++++++
>  2 files changed, 161 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index dfbb94ddc98a..4ef3a82d046f 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -232,7 +232,8 @@ enum pd_msg_request {
>  	PD_MSG_DATA_SINK_CAP,
>  	PD_MSG_DATA_SOURCE_CAP,
>  	PD_MSG_DATA_REV,
> -	PD_MSG_EXT_SINK_CAP_EXT
> +	PD_MSG_EXT_SINK_CAP_EXT,
> +	PD_MSG_DATA_BATT_STATUS
>  };
>  
>  enum adev_actions {
> @@ -389,6 +390,14 @@ struct pd_timings {
>  /* Convert microwatt to watt */
>  #define UW_TO_W(pow)					((pow) / 1000000)
>  
> +/*
> + * As per USB PD Spec Rev 3.18 (Sec. 6.5.13.11), the number of fixed batteries
> + * that a port can be queried is restricted to 4.
> + */
> +#define MAX_NUM_FIXED_BATT				4
> +
> +#define BATTERY_PROPERTY_UNKNOWN			0xffff
> +
>  /*
>   * struct pd_identifier - Contains info about PD identifiers
>   * @vid: Vendor ID (assigned by USB-IF)
> @@ -683,6 +692,9 @@ struct tcpm_port {
>  
>  	struct pd_identifier pd_ident;
>  	struct sink_caps_ext_data sink_caps_ext;
> +	struct power_supply **fixed_batt;
> +	u32 fixed_batt_cnt;
> +	u32 batt_request_id;
>  #ifdef CONFIG_DEBUG_FS
>  	struct dentry *dentry;
>  	struct mutex logbuffer_lock;	/* log buffer access lock */
> @@ -1465,6 +1477,20 @@ static int tcpm_pd_send_sink_caps(struct tcpm_port *port)
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
>  
> +static void tcpm_get_fixed_batt(struct tcpm_port *port)
> +{
> +	int ret;
> +
> +	if (!port->self_powered || port->fixed_batt_cnt > 0)
> +		return;
> +
> +	ret = power_supply_get_battery_all(port->dev, &port->fixed_batt);
> +	if (ret < 0)
> +		tcpm_log(port, "Failed to get battery array, ret=%d", ret);
> +	else
> +		port->fixed_batt_cnt = ret;
> +}
> +
>  static int tcpm_pd_send_sink_cap_ext(struct tcpm_port *port)
>  {
>  	u16 operating_snk_watt = port->operating_snk_mw / 1000;
> @@ -1477,6 +1503,8 @@ static int tcpm_pd_send_sink_cap_ext(struct tcpm_port *port)
>  	if (!port->self_powered)
>  		data->spr_op_pdp = operating_snk_watt;
>  
> +	tcpm_get_fixed_batt(port);
> +
>  	/*
>  	 * SPR Sink Minimum PDP indicates the minimum power required to operate
>  	 * a sink device in its lowest level of functionality without requiring
> @@ -1502,6 +1530,7 @@ static int tcpm_pd_send_sink_cap_ext(struct tcpm_port *port)
>  	skedb.load_step = data->load_step;
>  	skedb.load_char = cpu_to_le16(data->load_char);
>  	skedb.compliance = data->compliance;
> +	skedb.batt_info = min(port->fixed_batt_cnt, MAX_NUM_FIXED_BATT);
>  	skedb.modes = data->modes;
>  	skedb.spr_min_pdp = data->spr_min_pdp;
>  	skedb.spr_op_pdp = data->spr_op_pdp;
> @@ -1520,6 +1549,88 @@ static int tcpm_pd_send_sink_cap_ext(struct tcpm_port *port)
>  					   port->message_id,
>  					   data_obj_cnt,
>  					   1 /* Denotes if ext header */));
> +
> +	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
> +}
> +
> +static int tcpm_pd_send_batt_status(struct tcpm_port *port)
> +{
> +	u16 present_charge = BATTERY_PROPERTY_UNKNOWN;
> +	bool batt_present = false, invalid_ref = true;
> +	u32 batt_id = port->batt_request_id;
> +	union power_supply_propval val;
> +	struct power_supply *batt;
> +	u8 charging_status = 0;
> +	struct pd_message msg;
> +	int ret, charge_now;
> +	u64 energy_now;
> +	u32 bsdo;
> +
> +	tcpm_get_fixed_batt(port);
> +	memset(&msg, 0, sizeof(msg));
> +
> +	if (batt_id >= port->fixed_batt_cnt || batt_id >= MAX_NUM_FIXED_BATT)
> +		goto send_status;
> +
> +	invalid_ref = false;
> +	batt = port->fixed_batt[batt_id];
> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_PRESENT, &val);
> +	if (ret)
> +		tcpm_log(port,
> +			 "Failed to fetch power_supply_prop_present ret %d",
> +			 ret);
> +	else
> +		batt_present = val.intval > 0;
> +
> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_CHARGE_NOW,
> +					&val);
> +	if (!ret) {
> +		charge_now = val.intval;
> +
> +		ret = power_supply_get_property(batt,
> +						POWER_SUPPLY_PROP_VOLTAGE_AVG,
> +						&val);
> +		if (!ret) {
> +			energy_now = ((u64)charge_now * val.intval) / 1000000;
> +
> +			/*
> +			 * Battery Present Charge is reported in
> +			 * increments of 0.1WH.
> +			 */
> +			present_charge = (u16)UW_TO_W(energy_now * 10);
> +		}
> +	}
> +
> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_STATUS, &val);
> +	if (!ret) {
> +		switch (val.intval) {
> +		case POWER_SUPPLY_STATUS_CHARGING:
> +			charging_status = BSDO_BATTERY_INFO_CHARGING;
> +			break;
> +		case POWER_SUPPLY_STATUS_DISCHARGING:
> +			charging_status = BSDO_BATTERY_INFO_DISCHARGING;
> +			break;
> +		case POWER_SUPPLY_STATUS_NOT_CHARGING:
> +		case POWER_SUPPLY_STATUS_FULL:
> +			charging_status = BSDO_BATTERY_INFO_IDLE;
> +			break;
> +		default:
> +			charging_status = BSDO_BATTERY_INFO_RSVD;
> +			break;
> +		}
> +	}
> +
> +send_status:
> +
> +	bsdo = BSDO(present_charge, charging_status, batt_present, invalid_ref);
> +	msg.payload[0] = cpu_to_le32(bsdo);
> +	msg.header = PD_HEADER_LE(PD_DATA_BATT_STATUS,
> +				  port->pwr_role,
> +				  port->data_role,
> +				  port->negotiated_rev,
> +				  port->message_id,
> +				  1);
> +
>  	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>  }
>  
> @@ -3854,6 +3965,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  {
>  	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
>  	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
> +	const struct pd_chunked_ext_message_data *ext_msg = &msg->ext_msg;
>  
>  	/* stopping VDM state machine if interrupted by other Messages */
>  	if (tcpm_vdm_ams(port)) {
> @@ -3862,7 +3974,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  		mod_vdm_delayed_work(port, 0);
>  	}
>  
> -	if (!(le16_to_cpu(msg->ext_msg.header) & PD_EXT_HDR_CHUNKED)) {
> +	if (!(le16_to_cpu(ext_msg->header) & PD_EXT_HDR_CHUNKED)) {
>  		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>  		tcpm_log(port, "Unchunked extended messages unsupported");
>  		return;
> @@ -3887,9 +3999,17 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>  					     NONE_AMS, 0);
>  		}
>  		break;
> +	case PD_EXT_GET_BATT_STATUS:
> +		if (data_size >= 1) {
> +			port->batt_request_id = ext_msg->data[0];
> +			tcpm_pd_handle_msg(port, PD_MSG_DATA_BATT_STATUS,
> +					   GETTING_BATTERY_STATUS);
> +		} else {
> +			tcpm_set_state(port, SOFT_RESET_SEND, 0);
> +		}
> +		break;
>  	case PD_EXT_SOURCE_CAP_EXT:
>  	case PD_EXT_GET_BATT_CAP:
> -	case PD_EXT_GET_BATT_STATUS:
>  	case PD_EXT_BATT_CAP:
>  	case PD_EXT_GET_MANUFACTURER_INFO:
>  	case PD_EXT_MANUFACTURER_INFO:
> @@ -4100,6 +4220,14 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
>  					 ret);
>  			tcpm_ams_finish(port);
>  			break;
> +		case PD_MSG_DATA_BATT_STATUS:
> +			ret = tcpm_pd_send_batt_status(port);
> +			if (ret)
> +				tcpm_log(port,
> +					 "Failed to send battery status ret=%d",
> +					 ret);
> +			tcpm_ams_finish(port);
> +			break;
>  		default:
>  			break;
>  		}
> @@ -8597,6 +8725,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>  	hrtimer_cancel(&port->vdm_state_machine_timer);
>  	hrtimer_cancel(&port->state_machine_timer);
>  
> +	power_supply_put_battery_all(port->fixed_batt, port->fixed_batt_cnt);
>  	tcpm_reset_port(port);
>  
>  	tcpm_port_unregister_pd(port);
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 337a5485af7c..afb9c2c65588 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -724,4 +724,33 @@ void usb_power_delivery_unlink_device(struct usb_power_delivery *pd, struct devi
>  
>  #endif /* CONFIG_TYPEC */
>  
> +/* Battery Status Data Object */
> +#define BSDO_PRESENT_CAPACITY				GENMASK(31, 16)
> +#define BSDO_CHG_STATUS					GENMASK(11, 10)
> +#define BSDO_BATTERY_PRESENT				BIT(9)
> +#define BSDO_INVALID_BATTERY_REFERENCE			BIT(8)
> +
> +/*
> + * Battery Charge Status: Battery Charging Status Values as defined in
> + * "USB PD Spec Rev3.1 Ver1.8", "Table 6-46 Battery Status Data Object (BSDO)".
> + */
> +#define BSDO_BATTERY_INFO_CHARGING			0x0
> +#define BSDO_BATTERY_INFO_DISCHARGING			0x1
> +#define BSDO_BATTERY_INFO_IDLE				0x2
> +#define BSDO_BATTERY_INFO_RSVD				0x3
> +
> +/**
> + * BSDO() - Pack data into Battery Status Data Object format.
> + * @batt_charge: Battery's present state of charge in 0.1WH increment.
> + * @chg_status: Battery charge status.
> + * @batt_present: Indicates that battery is present/attached when set else absent when unset.
> + * @invalid_ref: Indicates that an invalid battery reference was made in the Get_Battery_Status
> + *		 request.
> + */
> +#define BSDO(batt_charge, chg_status, batt_present, invalid_ref)	\
> +	((FIELD_PREP(BSDO_PRESENT_CAPACITY, batt_charge)) |		\
> +	 (FIELD_PREP(BSDO_CHG_STATUS, chg_status)) |			\
> +	 ((batt_present) ? BSDO_BATTERY_PRESENT : 0) |			\
> +	 ((invalid_ref) ? BSDO_INVALID_BATTERY_REFERENCE : 0))
> +
>  #endif /* __LINUX_USB_PD_H */
> 
> -- 
> 2.54.0.1013.g208068f2d8-goog
> 

-- 
heikki
