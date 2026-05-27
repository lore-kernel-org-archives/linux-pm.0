Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674E1379C3B
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779910230; cv=none; b=abhUlZnLnOy90Tp+TnDG04c/mhJfhXgZYCQEtm0DK8HV8eevZQQS8nVxnm6frcV5JxEQ6I2QZ3SWYBH1V4htk0JilF6ntR3G6Nmx67DJyDnYuqALViXMC8z1c0nqcnG88W4WmBRkdcS+dWpGMsOZhIXkw+JViBno9HqlR0cmVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779910230; c=relaxed/simple;
	bh=XnLXECd39en+z/aRQhZU/Pi3po/muwdDHatmweq+ty8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dU1x5vVt2fjQMaFHRZrMS6oPbEdR9FszC6GVT/laXnZpNd5EDsH0HeVYDrAf2iqR6OjH797nWNVtRIaEGx6F3sGxbUBJK5sO0dfj0U2DQ6RhZKuxMnJ8ckAfh1IPXZ7vdF/i/vMu0xtUZOIH2SSFdCfElBeEYCNBD4bZjFt/cOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rSAfWEyq; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rSAfWEyq"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-132830d8281so5405362c88.1
        for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 12:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779910227; x=1780515027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXtWEbDs3zgPkGw6xxXPOO82q1lDm2Cgn2gdWx+FiYo=;
        b=rSAfWEyqTah8N+oP2wRwHrcfdXAb+1Mc57obnMITI7WjdaI/SGLDsWUHGI/ci24SFS
         i/2XpGY/CLnQi8kdY86pyuto7AHujRCq1w02Vg0iAQxKiErbaS838IRql9X4q6FlEiDl
         1heyDaSVSQS0MK36T+GX6T4Peg7EA7sNlxR9vzVFXFidsZiM8U2jxsp1A0WTIPqQGlOr
         A5b67GVWFzUw9ygbO0ELwnwFZkfBW2AyQsYCZwgZtgZ8A1AdqxRw4q4dRRIwXjdA9Uv5
         V9NSaKUuZg6/BBBSkKUTak/wR2wfUJ/6smYr5xFFXov4Gl0vytmKzC3zfFJ8chqlMuIG
         HsFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779910227; x=1780515027;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PXtWEbDs3zgPkGw6xxXPOO82q1lDm2Cgn2gdWx+FiYo=;
        b=ZyIhkSvx8/MyOXuQraiOlWP8B0KRBjGnV4xxRPRlC96aBCxGHD5haKZHiFjwsvNl2v
         G+U9wSJYmLEGUfD1ikZT2NLCaKoDEovzb2YftM9Reapgkqh9jaf5OxcjdQIFrPnmvWHA
         UfakE3RqOHuM4b92VP8sup8B9qAKV/Q/7sktn0OWtEeAnMz6dIThpGgSSPssp2kmTdSE
         QQRERs31WHmawFxukH+PQ4adISIbAiSBjJZVu2IF3WNpI9GSORDJbMzM33NJI+y+AXXP
         N3tXE2VHxpX5Q8hPEwZ1o1MJ31vu5aV/gO6E8Vp2FojNzRz9jgGiSd62LbydVTiDs717
         7abA==
X-Gm-Message-State: AOJu0Yy4eGP73iX+6jFNO6FCcx0TytwB7dqoQoposhvPUTgLdNNmpRfk
	tUujKBn0Hbox1EELbUrtSaV3KF955/KCdHmprfNkg2AaTpiz0UIqCkr9+zRYM2eBJw==
X-Gm-Gg: Acq92OHLTKz9VmouRLAE/wZXBetoGxdBxbWz4ec4MWSDnp1kNhRBDMMePSN1w0tW0iq
	Mvr5w/u1nVFvb/oq2XJR9qYOBS9GqnRzZHUfRvVofAkjz9FKZGPoanYtnyTNI90h9zuVc8cPfMj
	n5C2wJFvE+t8uyjGwsBunkMpg72gTwoxq2zH6qgz5FBRMGYKayaOoNrHtSmByeCCGetIEs8er4C
	6TTqcOAjpwcJRViZu5VpbgdFMLwkLZrRrEQkAefRfAwNN0LZrYCs0+2RcDAtKEjY+BCbYRRJiYE
	mzGC0YUXh6QvqfsS59q/+5AJBdto95a2vLtUF36DQ3T8088ZaRSSwdR9k0U/qKB8brjMGg/FRVg
	S4JKFofxPwpKA34utiDte11fl5lwF0Cq4DeFpCbq197gR9u2Jc+XGG2WolfL+XMdOJSmbpmIELE
	OKlDUGD5pDU0sMbrdg9TbMqUHMhokzbAxjc9ONtMFKfd33bUQ5YYCG0WIzr7JOniHUxGJ+U2Wgl
	stK8Q5/JB65mzYBINHKbReeXJYD6cWIYxxMXgT4bHLPdbYdwBobdoDGZ/iE0OZWdw==
X-Received: by 2002:a05:7301:fa8b:b0:2ca:8099:ffc0 with SMTP id 5a478bee46e88-30448ffc59emr10801053eec.7.1779910225133;
        Wed, 27 May 2026 12:30:25 -0700 (PDT)
Received: from ?IPV6:2a00:79e0:2e7c:8:1f44:24e2:83c:2f06? ([2a00:79e0:2e7c:8:1f44:24e2:83c:2f06])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30481ad4cd3sm11102024eec.27.2026.05.27.12.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 May 2026 12:30:24 -0700 (PDT)
Message-ID: <638948f5-99e7-4a64-8f55-d9a895dd8e81@google.com>
Date: Wed, 27 May 2026 12:30:19 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] usb: typec: tcpm: Add support for Battery Status
 response message
To: Hans de Goede <hansg@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 Badhri Jagan Sridharan <badhri@google.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Tudor Ambarus <tudor.ambarus@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>, RD Babiera <rdbabiera@google.com>,
 Kyle Tso <kyletso@google.com>
References: <20260527-batt-status-v2-0-4282985165f3@google.com>
 <20260527-batt-status-v2-2-4282985165f3@google.com>
 <4e4a63a4-9d07-4b77-a8dc-ba19c9a803f7@kernel.org>
Content-Language: en-US
From: Amit Sunil Dhamne <amitsd@google.com>
In-Reply-To: <4e4a63a4-9d07-4b77-a8dc-ba19c9a803f7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hans,

Thanks for the review!

On 5/27/26 3:15 AM, Hans de Goede wrote:
> Hi,
>
> On 27-May-26 02:02, Amit Sunil Dhamne via B4 Relay wrote:
>> From: Amit Sunil Dhamne <amitsd@google.com>
>>
>> Add support for responding to a Get_Battery_Status request with a
>> Battery_Status message. The port partner shall request the status of a
>> port's battery by providing an index in the Get_Battery_Status AMS. In
>> case of failure to identify the battery, the port shall reply with an
>> appropriate message indicating so.
>>
>> Support for Battery_Status message is required for sinks that contain
>> battery as specified in USB PD Rev3.1 v1.8
>> ("Applicability of Data Messages" section).
>>
>> Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
>> Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
>> ---
>>   drivers/usb/typec/tcpm/tcpm.c | 151 +++++++++++++++++++++++++++++++++++++++++-
>>   include/linux/usb/pd.h        |  29 ++++++++
>>   2 files changed, 177 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
>> index dfbb94ddc98a..ee45d90dbf98 100644
>> --- a/drivers/usb/typec/tcpm/tcpm.c
>> +++ b/drivers/usb/typec/tcpm/tcpm.c
>> @@ -232,7 +232,8 @@ enum pd_msg_request {
>>   	PD_MSG_DATA_SINK_CAP,
>>   	PD_MSG_DATA_SOURCE_CAP,
>>   	PD_MSG_DATA_REV,
>> -	PD_MSG_EXT_SINK_CAP_EXT
>> +	PD_MSG_EXT_SINK_CAP_EXT,
>> +	PD_MSG_DATA_BATT_STATUS
>>   };
>>   
>>   enum adev_actions {
>> @@ -389,6 +390,14 @@ struct pd_timings {
>>   /* Convert microwatt to watt */
>>   #define UW_TO_W(pow)					((pow) / 1000000)
>>   
>> +/*
>> + * As per USB PD Spec Rev 3.18 (Sec. 6.5.13.11), the number of fixed batteries
>> + * that a port can be queried is restricted to 4.
>> + */
>> +#define MAX_NUM_FIXED_BATT				4
>> +
>> +#define BATTERY_PROPERTY_UNKNOWN			0xffff
>> +
>>   /*
>>    * struct pd_identifier - Contains info about PD identifiers
>>    * @vid: Vendor ID (assigned by USB-IF)
>> @@ -683,6 +692,9 @@ struct tcpm_port {
>>   
>>   	struct pd_identifier pd_ident;
>>   	struct sink_caps_ext_data sink_caps_ext;
>> +	struct power_supply *fixed_batt[MAX_NUM_FIXED_BATT];
>> +	u32 fixed_batt_cnt;
> Why not just have a struct power_supply **fixed_batt here
> and directly pass that to power_supply_get_battery_all() ?
>
> And then call power_supply_put_battery_all() at cleanup /
> driver-remove time ?

Comment addressed below.


>
>
>> +	u32 batt_request_id;
>>   #ifdef CONFIG_DEBUG_FS
>>   	struct dentry *dentry;
>>   	struct mutex logbuffer_lock;	/* log buffer access lock */
>> @@ -1391,6 +1403,37 @@ static int tcpm_pd_send_revision(struct tcpm_port *port)
>>   	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>>   }
>>   
>> +static void tcpm_init_fixed_batt(struct tcpm_port *port)
>> +{
>> +	struct power_supply **batteries;
>> +	int ret, i;
>> +
>> +	if (port->fixed_batt_cnt > 0)
>> +		return;
>> +
>> +	ret = power_supply_get_battery_all(port->dev, &batteries);
>> +	if (ret < 0) {
>> +		tcpm_log(port, "Failed to fetch batteries refs ret=%d", ret);
>> +		return;
>> +	}
>> +
>> +	for (i = 0; i < ret; i++) {
>> +		if (!batteries[i])
>> +			continue;
>> +
>> +		if (port->fixed_batt_cnt < MAX_NUM_FIXED_BATT)
>> +			port->fixed_batt[port->fixed_batt_cnt++] = batteries[i];
>> +		else
>> +			break;
>> +	}
>> +
>> +	if (i < ret)
>> +		power_supply_put_array(batteries + i, ret - i);
>> +
>> +	if (ret)
>> +		kfree(batteries);
>> +}
>> +
> If you do as I suggest above this entire function can go away.
The reason for implementing it this way was because the USB PD protocol 
only caters to a maximum of 4 batteries. I wanted to avoid unnecessarily 
holding references to any extra ones if a platform theoretically had 5 
or more.

However, I agree that this is overthinking it for a practical scenario, 
and your approach is much cleaner. I will drop the helper function and 
switch to dynamically holding the array pointer directly as you suggested.


>
>>   static int tcpm_pd_send_source_caps(struct tcpm_port *port)
>>   {
>>   	struct pd_message msg;
>> @@ -1476,6 +1519,8 @@ static int tcpm_pd_send_sink_cap_ext(struct tcpm_port *port)
>>   
>>   	if (!port->self_powered)
>>   		data->spr_op_pdp = operating_snk_watt;
>> +	else
>> +		tcpm_init_fixed_batt(port);
> And you can just call power_supply_get_battery_all() here and store
> count int fixed_batt_cnt (make fixed_batt_cnt an int so that negative
> errors don't turn into a big number.
>
>>   
>>   	/*
>>   	 * SPR Sink Minimum PDP indicates the minimum power required to operate
>> @@ -1502,6 +1547,7 @@ static int tcpm_pd_send_sink_cap_ext(struct tcpm_port *port)
>>   	skedb.load_step = data->load_step;
>>   	skedb.load_char = cpu_to_le16(data->load_char);
>>   	skedb.compliance = data->compliance;
>> +	skedb.batt_info = port->fixed_batt_cnt;
>>   	skedb.modes = data->modes;
>>   	skedb.spr_min_pdp = data->spr_min_pdp;
>>   	skedb.spr_op_pdp = data->spr_op_pdp;
>> @@ -1520,6 +1566,87 @@ static int tcpm_pd_send_sink_cap_ext(struct tcpm_port *port)
>>   					   port->message_id,
>>   					   data_obj_cnt,
>>   					   1 /* Denotes if ext header */));
>> +
>> +	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>> +}
>> +
>> +static int tcpm_pd_send_batt_status(struct tcpm_port *port)
>> +{
>> +	u16 present_charge = BATTERY_PROPERTY_UNKNOWN;
>> +	bool batt_present = false, invalid_ref = true;
>> +	u32 batt_id = port->batt_request_id;
>> +	union power_supply_propval val;
>> +	struct power_supply *batt;
>> +	u8 charging_status = 0;
>> +	struct pd_message msg;
>> +	int ret, charge_now;
>> +	u64 energy_now;
>> +	u32 bsdo;
>> +
>> +	memset(&msg, 0, sizeof(msg));
>> +
>> +	if (batt_id >= port->fixed_batt_cnt || !port->fixed_batt[batt_id])
>> +		goto send_status;
> And here you can then additionally check against MAX_NUM_FIXED_BATT .
>
> Also drop the NULL check here, power_supply_get_battery_all() never
> leaves holes / NULL entries in the array.

Ack.


BR,

Amit

>
>
>> +
>> +	invalid_ref = false;
>> +	batt = port->fixed_batt[batt_id];
>> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_PRESENT, &val);
>> +	if (ret)
>> +		tcpm_log(port,
>> +			 "Failed to fetch power_supply_prop_present ret %d",
>> +			 ret);
>> +	else
>> +		batt_present = val.intval > 0;
>> +
>> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_CHARGE_NOW,
>> +					&val);
>> +	if (!ret) {
>> +		charge_now = val.intval;
>> +
>> +		ret = power_supply_get_property(batt,
>> +						POWER_SUPPLY_PROP_VOLTAGE_AVG,
>> +						&val);
>> +		if (!ret) {
>> +			energy_now = ((u64)charge_now * val.intval) / 1000000;
>> +
>> +			/*
>> +			 * Battery Present Charge is reported in
>> +			 * increments of 0.1WH.
>> +			 */
>> +			present_charge = (u16)UW_TO_W(energy_now * 10);
>> +		}
>> +	}
>> +
>> +	ret = power_supply_get_property(batt, POWER_SUPPLY_PROP_STATUS, &val);
>> +	if (!ret) {
>> +		switch (val.intval) {
>> +		case POWER_SUPPLY_STATUS_CHARGING:
>> +			charging_status = BSDO_BATTERY_INFO_CHARGING;
>> +			break;
>> +		case POWER_SUPPLY_STATUS_DISCHARGING:
>> +			charging_status = BSDO_BATTERY_INFO_DISCHARGING;
>> +			break;
>> +		case POWER_SUPPLY_STATUS_NOT_CHARGING:
>> +		case POWER_SUPPLY_STATUS_FULL:
>> +			charging_status = BSDO_BATTERY_INFO_IDLE;
>> +			break;
>> +		default:
>> +			charging_status = BSDO_BATTERY_INFO_RSVD;
>> +			break;
>> +		}
>> +	}
>> +
>> +send_status:
>> +
>> +	bsdo = BSDO(present_charge, charging_status, batt_present, invalid_ref);
>> +	msg.payload[0] = cpu_to_le32(bsdo);
>> +	msg.header = PD_HEADER_LE(PD_DATA_BATT_STATUS,
>> +				  port->pwr_role,
>> +				  port->data_role,
>> +				  port->negotiated_rev,
>> +				  port->message_id,
>> +				  1);
>> +
>>   	return tcpm_pd_transmit(port, TCPC_TX_SOP, &msg);
>>   }
>>   
>> @@ -3854,6 +3981,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>>   {
>>   	enum pd_ext_msg_type type = pd_header_type_le(msg->header);
>>   	unsigned int data_size = pd_ext_header_data_size_le(msg->ext_msg.header);
>> +	const struct pd_chunked_ext_message_data *ext_msg = &msg->ext_msg;
>>   
>>   	/* stopping VDM state machine if interrupted by other Messages */
>>   	if (tcpm_vdm_ams(port)) {
>> @@ -3862,7 +3990,7 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>>   		mod_vdm_delayed_work(port, 0);
>>   	}
>>   
>> -	if (!(le16_to_cpu(msg->ext_msg.header) & PD_EXT_HDR_CHUNKED)) {
>> +	if (!(le16_to_cpu(ext_msg->header) & PD_EXT_HDR_CHUNKED)) {
>>   		tcpm_pd_handle_msg(port, PD_MSG_CTRL_NOT_SUPP, NONE_AMS);
>>   		tcpm_log(port, "Unchunked extended messages unsupported");
>>   		return;
>> @@ -3887,9 +4015,17 @@ static void tcpm_pd_ext_msg_request(struct tcpm_port *port,
>>   					     NONE_AMS, 0);
>>   		}
>>   		break;
>> +	case PD_EXT_GET_BATT_STATUS:
>> +		if (data_size >= 1) {
>> +			port->batt_request_id = ext_msg->data[0];
>> +			tcpm_pd_handle_msg(port, PD_MSG_DATA_BATT_STATUS,
>> +					   GETTING_BATTERY_STATUS);
>> +		} else {
>> +			tcpm_set_state(port, SOFT_RESET_SEND, 0);
>> +		}
>> +		break;
>>   	case PD_EXT_SOURCE_CAP_EXT:
>>   	case PD_EXT_GET_BATT_CAP:
>> -	case PD_EXT_GET_BATT_STATUS:
>>   	case PD_EXT_BATT_CAP:
>>   	case PD_EXT_GET_MANUFACTURER_INFO:
>>   	case PD_EXT_MANUFACTURER_INFO:
>> @@ -4100,6 +4236,14 @@ static bool tcpm_send_queued_message(struct tcpm_port *port)
>>   					 ret);
>>   			tcpm_ams_finish(port);
>>   			break;
>> +		case PD_MSG_DATA_BATT_STATUS:
>> +			ret = tcpm_pd_send_batt_status(port);
>> +			if (ret)
>> +				tcpm_log(port,
>> +					 "Failed to send battery status ret=%d",
>> +					 ret);
>> +			tcpm_ams_finish(port);
>> +			break;
>>   		default:
>>   			break;
>>   		}
>> @@ -8597,6 +8741,7 @@ void tcpm_unregister_port(struct tcpm_port *port)
>>   	hrtimer_cancel(&port->vdm_state_machine_timer);
>>   	hrtimer_cancel(&port->state_machine_timer);
>>   
>> +	power_supply_put_array(port->fixed_batt, port->fixed_batt_cnt);
>>   	tcpm_reset_port(port);
>>   
>>   	tcpm_port_unregister_pd(port);
>> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
>> index 337a5485af7c..afb9c2c65588 100644
>> --- a/include/linux/usb/pd.h
>> +++ b/include/linux/usb/pd.h
>> @@ -724,4 +724,33 @@ void usb_power_delivery_unlink_device(struct usb_power_delivery *pd, struct devi
>>   
>>   #endif /* CONFIG_TYPEC */
>>   
>> +/* Battery Status Data Object */
>> +#define BSDO_PRESENT_CAPACITY				GENMASK(31, 16)
>> +#define BSDO_CHG_STATUS					GENMASK(11, 10)
>> +#define BSDO_BATTERY_PRESENT				BIT(9)
>> +#define BSDO_INVALID_BATTERY_REFERENCE			BIT(8)
>> +
>> +/*
>> + * Battery Charge Status: Battery Charging Status Values as defined in
>> + * "USB PD Spec Rev3.1 Ver1.8", "Table 6-46 Battery Status Data Object (BSDO)".
>> + */
>> +#define BSDO_BATTERY_INFO_CHARGING			0x0
>> +#define BSDO_BATTERY_INFO_DISCHARGING			0x1
>> +#define BSDO_BATTERY_INFO_IDLE				0x2
>> +#define BSDO_BATTERY_INFO_RSVD				0x3
>> +
>> +/**
>> + * BSDO() - Pack data into Battery Status Data Object format.
>> + * @batt_charge: Battery's present state of charge in 0.1WH increment.
>> + * @chg_status: Battery charge status.
>> + * @batt_present: Indicates that battery is present/attached when set else absent when unset.
>> + * @invalid_ref: Indicates that an invalid battery reference was made in the Get_Battery_Status
>> + *		 request.
>> + */
>> +#define BSDO(batt_charge, chg_status, batt_present, invalid_ref)	\
>> +	((FIELD_PREP(BSDO_PRESENT_CAPACITY, batt_charge)) |		\
>> +	 (FIELD_PREP(BSDO_CHG_STATUS, chg_status)) |			\
>> +	 ((batt_present) ? BSDO_BATTERY_PRESENT : 0) |			\
>> +	 ((invalid_ref) ? BSDO_INVALID_BATTERY_REFERENCE : 0))
>> +
>>   #endif /* __LINUX_USB_PD_H */
>>
>
> Regards,
>
> Hans
>
>
