Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215863;
	b=TOJTTHyGa6JGtT2ckaMHJy4CNRxRZzX4RoxhgffkHUSIDkOIDyBcIlTb3BqwHKcaX7hV
	 XhOGcbnLMGqBtz9Dw/bbozO8HfKk58PzmjPRE6PbppJdcAZ2tlBaW7XnlXsZ2AyCmPgBT
	 dJhMc8xAI1iyLFtpplX+mGwqNwWVk+6yNp+7UnL7kc8VnhMN0pZkqW8WYzwTmJTMVnQ53
	 /UMwG1NwKlrcuLAPaoYZGUFJ5xFhvJaYM9heyRFiHUCYtE8hrZQuJsCvQdxzRDtUMPYrF
	 AN4mQMgohByUJYmPLtQO4iwjNSMYzcf1ry73n9Cv15WvHzkl+eYvDJ6m6sNxG9RYsDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215863;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=hpULEwBzMr2yjpqrT2e1UdgumWStkpKL7baBkCqpHVM=;
	b=DSHyhzRtRzOztWu5NX4zzzqv7PqWkmbWFkylkoqhRxM9C/qIp5WsLhXe0I6SzSHTwaoF
	 A39/jj7+EGd2loFkbO04iSN47U8PptjMpyxe4KfnP0S74TX2OuCuYKDpPSaPkZOX/lEol
	 ULnROm8Ck3F/DN9z6LwUBJ2PE9AxSiFyV9+umSxuwc7yCGqVWtnIm1Cs/WL3FHLSH1EVW
	 S/HX7fKX3ZBdYu34wwtivhqD3MpkAAfaPR7dWCK/O5kxi8wp0LNAJBb7vPD3owMwLID7L
	 RJtJ//B8zfwDRpAJuIO1D1e5gSdjDVDjJagLs6H/6jcTEwvEDf4Zmwnzmxl1PH3xXGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=minyard.net;
	spf=pass smtp.mailfrom=minyard.net;
	dkim=pass header.d=minyard.net header.i=@minyard.net header.a=rsa-sha256 header.s=google header.b=gC36719i;
	arc=none smtp.remote-ip=209.85.160.45
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FD1606A327
	for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 19:31:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61FD1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=minyard.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=minyard.net header.i=@minyard.net header.a=rsa-sha256 header.s=google header.b=gC36719i
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-4a75a5fa32dso402106fac.1
        for <linux-pm@vger.kernel.org>; Wed, 28 Oct 2026 12:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard.net; s=google; t=1793215861; x=1793820661; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hpULEwBzMr2yjpqrT2e1UdgumWStkpKL7baBkCqpHVM=;
        b=gC36719iCpac+J0uMgq776jeOZj6OFfT5UfXAAu8QRjqm8ZgwVM5w6YXhN3q9KyUXc
         UGImKfuKxj2xH2QGxCT0ozcu2XUDWhOrxBvqfGLLunODjP4c9GS11CQx8voF+sRxcalE
         7S4ObHLYVH4+CpL+UZyeET/2rX8tn/qqqm3VZC6LSFoa+343pmRwDGuEC1NWm2iWEhRe
         cHxwobq9jYGveOpMguxfPZVZkJIBsc0Xv6Z1asVJ6kZuWNYhYvqV7Ohyg09+WCESkW5O
         IY/QLHxaICp8xiYXFy2t3R0S49kIPN1px7zdW4RenyjdzgXzlWoklwmhmNFNvuL8z1rH
         x/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793215861; x=1793820661;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hpULEwBzMr2yjpqrT2e1UdgumWStkpKL7baBkCqpHVM=;
        b=R4VaQnvpcEYDFKdQE5kGEu11XFUiNT2Zv2lrv5jSSEUTsyzG1spjj8/fkOXugLPWQC
         /4gCl9GBGYZEnHWxYPHI13d3BXQ6Pf1cyhF76JPszpVuz4seURGPAowTqTE7FDs39Mox
         jftqJn///Fc9qWaWZgHW/QtnEd+0HRoaFQrwF2btJtmUZbWcZ+LRyQ63jBBdlC1AXBfa
         TsnvA6D9YPRHxDiAqjo4lF8Qtj16QCwBvSEMv+sF6d1aTPnNGQ0HC9lYe3eSn3qTvEUl
         Jm/p8wxue8p/Kgjm0D+5QoB5Rc6I3zrpNPoO4SjqP2QkQWV+7CJ6ysmp+M3yAjRwxjVQ
         r8TQ==
X-Forwarded-Encrypted: i=1; AKwUvByE0ImwyCYU73OKijvE+nhswPavJFR92u+bsG7dW7hi56eamhzjVRiRls7s/4KWyX0lCNGtoVLTOw==@vger.kernel.org
X-Gm-Message-State: AFq9FYKPYdk1e+FdBpuK2INcLbbgDmAvQO4ogLroAntvitiSEMiLj4LH
	6TrfjV3gG2S6DmZVvI5PfpFbD81uAA9kraVMOZ1fOF+tN8RYpAb235SoVOQP/SX3sYhfiuGDo7Z
	1NapYP5U=
X-Gm-Gg: AYBFou12N/NOSLPqvyhcSnuBbWlj8jMy5eMqGi0VDO/yOGe2Dt8H590SRPNWUVQ0dVe
	HhbZh9D5Bh90g1EZONWv/QdhyGNaiF9Qjn6QQpu25Mum2dYFBmfTkWhdkKQ7/t7Gn3NgnuEmwGs
	Ps4QSGpQZUKzgjJzjjBneFVxBga0KNtOjlGtNk4DurXaz9897H40ZTMMdzQcXhdhd1Yy6V0Z/PH
	qtz8Lcuc4XdEYw6+co0QVbgX/wSMLh/TtdI/OjA0nwb6jozlA0GSygIECWR7YHmk1LQfWKjOhDP
	5GeReGnTSti+ty4jAcJQpZkCu1peVz1cewX54XK90kNAtibWafjFfbdyVpJhig+2pfGlfg62UL0
	k+t6cxwn7drrjxr3/30O6lfXe0eOCscIBUnI7WkZD6e7+YtVsbf7o6VpYugwqez6I2FuJKZdHtJ
	a3ToOnjxeI48OQLOmkz3kXQX3IcIq5g9LsK44JaGHR5o2PhcNNyffVtAOVFApXIxoQb6OK4Tex6
	Q8c8bHZ/H/A/fCgPWphUtSyKB2mWfH4dd0JWFcueNnM5nvwRJ3xTzlIbAdoUi2rfS2H7m0jdi12
	riyuO9M/pWVeena20fDTUySUY93RGABNEymxUUFxfk3PnN1YDUWTjQQa2vqPsoxfPZItbIgdnGG
	oo39LrrdJ9HXrfJ73aCBupbfwB6oj3AaBAGZxq2j1FQK2DOaIKDWYNHPw0CjZUtUrR0T35z4=
X-Received: by 2002:a05:6870:9e08:b0:45e:54a3:b8ca with SMTP id 586e51a60fabf-4a8bb427d08mr2615315fac.19.1793215861021;
        Wed, 28 Oct 2026 12:31:01 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:2f32:e466:d3ef:5b82])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a8b78de44esm3375499fac.11.2026.10.28.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:31:00 -0700 (PDT)
Date: Wed, 28 Oct 2026 14:30:56 -0500
From: Corey Minyard <corey@minyard.net>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>, linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 6/8] ipmi: ssif: use 4-argument
 i2c_smbus_read_block_data()
Message-ID: <auJNcEiVgwCW5D1Y@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com>
 <20261024-i2c-smbus-read-block-data-v1-6-19bb97467982@gmail.com>
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
In-Reply-To: <20261024-i2c-smbus-read-block-data-v1-6-19bb97467982@gmail.com>

On Sat, Oct 24, 2026 at 07:48:46PM -0700, Dmitry Torokhov wrote:
> Pass the receive buffer capacity to i2c_smbus_read_block_data() in
> ipmi_ssif_thread() via the i2c_size field, and update ssif_i2c_send()
> callers to pass the receive buffer size.
> 
> Update read_response(), do_cmd(), and test_multipart_messages() to
> accept the response buffer length, clamping the transfer size to
> I2C_SMBUS_BLOCK_MAX when reading from the device.

This is in my for-next tree.  It passes all tests.

The reuse of the "size" parameter to ssif_i2c_send() is ok.  That's not
really what it was originally meant for, it was the transaction type,
but it wasn't used, so all is good.

-corey

> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/char/ipmi/ipmi_ssif.c | 39 +++++++++++++++++++++------------------
>  1 file changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
> index 2361103c5edc..9c0aebec2946 100644
> --- a/drivers/char/ipmi/ipmi_ssif.c
> +++ b/drivers/char/ipmi/ipmi_ssif.c
> @@ -503,7 +503,7 @@ static int ipmi_ssif_thread(void *data)
>  		} else {
>  			result = i2c_smbus_read_block_data(
>  				ssif_info->client, ssif_info->i2c_command,
> -				ssif_info->i2c_data);
> +				ssif_info->i2c_size, ssif_info->i2c_data);
>  			if (result < 0)
>  				ssif_info->done_handler(ssif_info, result,
>  							NULL, 0);
> @@ -541,7 +541,7 @@ static void start_get(struct ssif_info *ssif_info)
>  
>  	ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
>  		  SSIF_IPMI_RESPONSE,
> -		  ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
> +		  ssif_info->recv, sizeof(ssif_info->recv));
>  }
>  
>  static void start_resend(struct ssif_info *ssif_info);
> @@ -669,7 +669,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  
>  		ssif_i2c_send(ssif_info, msg_done_handler, I2C_SMBUS_READ,
>  			 SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
> -			 ssif_info->recv, I2C_SMBUS_BLOCK_DATA);
> +			 ssif_info->recv, sizeof(ssif_info->recv));
>  		return;
>  	} else if (ssif_info->multi_pos) {
>  		/* Middle of multi-part read.  Start the next transaction. */
> @@ -736,7 +736,7 @@ static void msg_done_handler(struct ssif_info *ssif_info, int result,
>  				  I2C_SMBUS_READ,
>  				  SSIF_IPMI_MULTI_PART_RESPONSE_MIDDLE,
>  				  ssif_info->recv,
> -				  I2C_SMBUS_BLOCK_DATA);
> +				  sizeof(ssif_info->recv));
>  			return;
>  		}
>  	}
> @@ -1314,12 +1314,15 @@ static void ssif_remove(struct i2c_client *client)
>  	kfree(ssif_info);
>  }
>  
> -static int read_response(struct i2c_client *client, unsigned char *resp)
> +static int read_response(struct i2c_client *client, unsigned char *resp,
> +			 size_t resp_length)
>  {
>  	int ret = -ENODEV, retry_cnt = SSIF_RECV_RETRIES;
>  
>  	while (retry_cnt > 0) {
>  		ret = i2c_smbus_read_block_data(client, SSIF_IPMI_RESPONSE,
> +						min_t(size_t, resp_length,
> +						      I2C_SMBUS_BLOCK_MAX),
>  						resp);
>  		if (ret > 0)
>  			break;
> @@ -1333,7 +1336,7 @@ static int read_response(struct i2c_client *client, unsigned char *resp)
>  }
>  
>  static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
> -		  int *resp_len, unsigned char *resp)
> +		  int *resp_len, unsigned char *resp, size_t resp_length)
>  {
>  	int retry_cnt;
>  	int ret;
> @@ -1350,14 +1353,14 @@ static int do_cmd(struct i2c_client *client, int len, unsigned char *msg,
>  		return -ENODEV;
>  	}
>  
> -	ret = read_response(client, resp);
> +	ret = read_response(client, resp, resp_length);
>  	if (ret > 0) {
>  		/* Validate that the response is correct. */
>  		if (ret < 3 ||
>  		    (resp[0] != (msg[0] | (1 << 2))) ||
>  		    (resp[1] != msg[1]))
>  			ret = -EINVAL;
> -		else if (ret > IPMI_MAX_MSG_LENGTH) {
> +		else if (ret > resp_length) {
>  			ret = -E2BIG;
>  		} else {
>  			*resp_len = ret;
> @@ -1382,7 +1385,7 @@ static int ssif_detect(struct i2c_client *client, struct i2c_board_info *info)
>  	/* Do a Get Device ID command, since it is required. */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_DEVICE_ID_CMD;
> -	rv = do_cmd(client, 2, msg, &len, resp);
> +	rv = do_cmd(client, 2, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv)
>  		rv = -ENODEV;
>  	else {
> @@ -1523,7 +1526,7 @@ static int start_multipart_test(struct i2c_client *client,
>  
>  static void test_multipart_messages(struct i2c_client *client,
>  				    struct ssif_info *ssif_info,
> -				    unsigned char *resp)
> +				    unsigned char *resp, size_t resp_length)
>  {
>  	unsigned char msg[65];
>  	int ret;
> @@ -1572,7 +1575,7 @@ static void test_multipart_messages(struct i2c_client *client,
>  					 1, msg + 64);
>  
>  	if (!ret)
> -		ret = read_response(client, resp);
> +		ret = read_response(client, resp, resp_length);
>  
>  	if (ret > 0) {
>  		/* End transactions work, we are good. */
> @@ -1590,7 +1593,7 @@ static void test_multipart_messages(struct i2c_client *client,
>  					 SSIF_IPMI_MULTI_PART_REQUEST_MIDDLE,
>  					 0, msg + 64);
>  	if (!ret)
> -		ret = read_response(client, resp);
> +		ret = read_response(client, resp, resp_length);
>  	if (ret > 0)
>  		/* Zero-size end parts work, use those. */
>  		return;
> @@ -1748,7 +1751,7 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_SYSTEM_INTERFACE_CAPABILITIES_CMD;
>  	msg[2] = 0; /* SSIF */
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (!rv && (len >= 3) && (resp[2] == 0)) {
>  		if (len < 7) {
>  			if (ssif_dbg_probe)
> @@ -1800,13 +1803,13 @@ static int ssif_probe(struct i2c_client *client)
>  		ssif_info->supports_pec = 0;
>  	}
>  
> -	test_multipart_messages(client, ssif_info, resp);
> +	test_multipart_messages(client, ssif_info, resp, IPMI_MAX_MSG_LENGTH);
>  
>  	/* Make sure the NMI timeout is cleared. */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_CLEAR_MSG_FLAGS_CMD;
>  	msg[2] = WDT_PRE_TIMEOUT_INT;
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 3) || (resp[2] != 0))
>  		dev_warn(&ssif_info->client->dev,
>  			 "Unable to clear message flags: %d %d %2.2x\n",
> @@ -1815,7 +1818,7 @@ static int ssif_probe(struct i2c_client *client)
>  	/* Attempt to enable the event buffer. */
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_GET_BMC_GLOBAL_ENABLES_CMD;
> -	rv = do_cmd(client, 2, msg, &len, resp);
> +	rv = do_cmd(client, 2, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 4) || (resp[2] != 0)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error getting global enables: %d %d %2.2x\n",
> @@ -1835,7 +1838,7 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
>  	msg[2] = ssif_info->global_enables | IPMI_BMC_EVT_MSG_BUFF;
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 2)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error setting global enables: %d %d %2.2x\n",
> @@ -1857,7 +1860,7 @@ static int ssif_probe(struct i2c_client *client)
>  	msg[0] = IPMI_NETFN_APP_REQUEST << 2;
>  	msg[1] = IPMI_SET_BMC_GLOBAL_ENABLES_CMD;
>  	msg[2] = ssif_info->global_enables | IPMI_BMC_RCV_MSG_INTR;
> -	rv = do_cmd(client, 3, msg, &len, resp);
> +	rv = do_cmd(client, 3, msg, &len, resp, IPMI_MAX_MSG_LENGTH);
>  	if (rv || (len < 2)) {
>  		dev_warn(&ssif_info->client->dev,
>  			 "Error setting global enables: %d %d %2.2x\n",
> 
> -- 
> 2.56.0.257.gf7497c7d27-goog
> 
