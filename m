Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AC3A5E67
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 07:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790063123; cv=none; b=FhxSrjU7YAj+jGI9We50t+vSr0FA8laaRLGhbYmenPBQtIl1wEKKVDlrvyYUvN42wf9lGc2QEMqGNGqQUaYzvIUNEjX+rUp2Vil4FCA+2BESV61VEvQeM0HrzQGEwtWeK/LRvRg/VfyYTCNnjiXh57Q/q0HrZogHF0kFo4NxfRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790063123; c=relaxed/simple;
	bh=TpdKMFLGjPzefo61cvunv7j2BylXh6l1j/OMO4CLiOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbuBPO+7mfiGiJv1RihyILLU2d+uGOpTN89UqHS/hx8Xr7w7PPniyA/0fc/GmXRG7cpdUd1NhHRbo9w76RUQMxtcwpmzF6zAAO7QDJLFvFgkM8UZQ7L9A/+BD6b6xzKS8mxJ4iLyA9VXoA7S/36HkKN5ZHRF+xI3Aafm3N9sl+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htHEjaBj; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htHEjaBj"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5eso33320581fa.0
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 00:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790063115; x=1790667915; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v311mTme30yUrQjluYgG3Q413l6dAIYyGwWk0CumHTE=;
        b=htHEjaBjFWrhqdasdkHqLZfR4b2wWCswmJi5yWOGumvb7JKBXc8tUxKmjUTE9FPJtO
         sVEuclxZx73AbB1PVVyFrxPIV+ImjgLH5RMi+Vpw8Ln7RO1RtAwhX+vribbJmKjOE8D3
         SmWd0J+20GqO4lG1MD8AWi+6Ur88Y2/ThUGP5dIt7qDY45AYcLSJw+L1IxUcQlGZRvNH
         GcxUNexeieT4mm51TXaDGCGfWeazot5GUODtCzWqtkuT/16qbc7b4jWDl1cdakSMgTSN
         HaITTWssOhh1K3cN2fHdznLY1sKoCXJnE+XW83Ky6Tv35obACFdQe48MVReF/Pes9sSV
         h1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790063115; x=1790667915;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v311mTme30yUrQjluYgG3Q413l6dAIYyGwWk0CumHTE=;
        b=dHZmF00QUaXWeO7SONgb0MqFT9Zi3+iofHJTMoJNvYphu3W4Qk9p0p16TvCe3ERBW+
         KKswz5EHERYa1MxoGsNobCwQB4lHOefUmLtv96aXzR3Lb0yVG//Sd+cWnmTUrDsOUFqh
         s/xVec7MDCvW9HkZoL3I2tkwN7ehwUk7TEiggGBWKWG+fubIN+qZa+bKKjWa7wVtZils
         QJ/sIiU1+uJP71eOaIvbQxaaaoSsVjWgzURZDhBA0Zr/QXorhF9lB703Eudfu8T1aJSE
         50Y2OeUXT54dJCbYKmCONCfqzaQr7nA8RVf2e8kp939Hvk2pimm1Ql/BVB3PbWE8zMc3
         MPPw==
X-Forwarded-Encrypted: i=1; AKwUvBzx9Aph93aityvaLz+d+nFYDxOWhk0QtXeR1am3VWk/WevBN8WJIgq5CU0gB29R7Rja3FNjILN+Rw==@vger.kernel.org
X-Gm-Message-State: AFuF++m+fPVlw7hBcbBNLWxhBMbdFu9y9hqH29N/Th0aA2tgWMsU/ZRN
	2cw7gcjstMBn30M02Gy0OKX7d0L4ZdnYTt2pvfTM2Z9dD3YWNabgoAe6
X-Gm-Gg: AYBFou3914y04zKl33kvMN7SoIHOiDdwrKTjXNcB5gGd2vXnkc0QgiqohHzLTbrgpcB
	AfEnhJ+X8JKVPgDGBGSyya9i2y9MJojIUNXF6CKKVhvwe0ootXMiggWgC9RZ4dP/gjkyFP6BWFu
	E+DFvxZDpDIZqviIgmoK01/PmI/Tv+46lwHJu7x5nIa3Ct705n9Rqinw3zZl5hnfQ6+cLveUF+M
	0dQanG2dwqP8Y+hG8mRJT6n48csUdOU1HXx1OPL+BCZLtPZ6Wmefqdbb7no44EHiW5HToxsFRB5
	hMi8xP58ifH4WmmJkkgU0H46yuuROfFFzMsALI1Gy3jGl5gC4zM7UPTzdYJAoalwxumW7FcsS67
	DXkz/EKAVvLdlc0XTS2DKJtR4YRXxr5/Qix+af6S4riG+lO4olltuFtpXo6PdvT+3+/uZFHAINf
	Zt453ohZXSdV7FaO3KDtfMkfhP+ZRhaoxOgXVjBc+JKVfTfN/AcqmtJxRYuj0fnvI/XfooI6oAu
	dV0dLRTwocqNJx3O+mYwrF+IzPB7IUh+YBfv+RmdrVChStNWdWDU6A=
X-Received: by 2002:a05:651c:b23:b0:3a5:f044:fcbb with SMTP id 38308e7fff4ca-3a5fc09bb75mr30555911fa.21.1790063115207;
        Tue, 22 Sep 2026 00:45:15 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46ad0e9sm276409e87.2.2026.09.22.00.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 00:45:14 -0700 (PDT)
Message-ID: <9ba75a42-a3cb-4ee2-bd29-84f23bbaa70c@gmail.com>
Date: Tue, 22 Sep 2026 10:45:13 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 4/6] reboot: extend psc_reason with power-on and reset
 causes
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
 <20260921-pscrr-framework-v14-4-a16290003b7c@oss.qualcomm.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260921-pscrr-framework-v14-4-a16290003b7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 20:44, Faruque Ansari wrote:
> psc_reason covered only the protection reasons. Extend it to mirror the
> full POWER_ON_REASON_* vocabulary - power-on, watchdog, software,
> external, RTC, reset button, CPU clock and crystal failures - so a
> provider can report why the system last powered on, not only why it was
> shut down. New values are appended to keep the existing numeric ABI.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> 
> changes v12:
> - new patch
> ---
>   include/linux/reboot.h | 28 ++++++++++++++++++++++++++++
>   kernel/reboot.c        |  8 ++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/include/linux/reboot.h b/include/linux/reboot.h
> index 4c5327dd7645..13f004ad1066 100644
> --- a/include/linux/reboot.h
> +++ b/include/linux/reboot.h
> @@ -225,9 +225,28 @@ extern void orderly_reboot(void);
>    *	management errors, or an unrecoverable hardware fault requiring
>    *	immediate response.
>    *
> + * @PSCR_POWER_ON: Regular cold power-on (e.g. via a PMIC power-on request).
> + *
> + * @PSCR_WATCHDOG: Reset caused by a watchdog timeout.
> + *
> + * @PSCR_SOFTWARE: Software-initiated reset or reboot.
> + *
> + * @PSCR_EXTERNAL: Reset asserted through an external pin or reset input.
> + *
> + * @PSCR_RTC: Wake-up or power-on triggered by the RTC.
> + *
> + * @PSCR_RESET_BUTTON: Reset triggered by a user reset button.
> + *
> + * @PSCR_CPU_CLK_FAIL: Reset caused by a CPU clock failure.
> + *
> + * @PSCR_XTAL_FAIL: Reset caused by a crystal oscillator failure.
> + *
>    * @PSCR_REASON_COUNT: Number of defined power state change reasons. This
>    *	value is useful for range checking and potential future extensions
>    *	while maintaining compatibility.
> + *
> + * The reasons mirror the POWER_ON_REASON_* strings in
> + * <linux/power/power_on_reason.h>; keep the two in sync when extending.

(still a nit)
We should now also ensure the psc_reason_desc[] in reboot.c stays in 
sync... (See my nits for 3/6). I have a nagging feeling this is not 
optimal :)

Is there a reason for having this as a separate patch and not merged 
with 3/6? If yes:

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

>    */
>   enum psc_reason {
>   	PSCR_UNKNOWN,
> @@ -236,6 +255,15 @@ enum psc_reason {
>   	PSCR_REGULATOR_FAILURE,
>   	PSCR_OVER_TEMPERATURE,
>   	PSCR_EC_PANIC,
> +	/* Append new reasons here; the numeric order is ABI. */
> +	PSCR_POWER_ON,
> +	PSCR_WATCHDOG,
> +	PSCR_SOFTWARE,
> +	PSCR_EXTERNAL,
> +	PSCR_RTC,
> +	PSCR_RESET_BUTTON,
> +	PSCR_CPU_CLK_FAIL,
> +	PSCR_XTAL_FAIL,
>   
>   	/* Number of reasons */
>   	PSCR_REASON_COUNT,
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index e53fb31bad06..5d4ecc82b35e 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -1102,6 +1102,14 @@ static const struct psc_reason_desc psc_reason_descs[] = {
>   	[PSCR_REGULATOR_FAILURE] = { "regulator-failure", POWER_ON_REASON_REGULATOR_FAILURE },
>   	[PSCR_OVER_TEMPERATURE]	 = { "over-temperature",  POWER_ON_REASON_OVER_TEMPERATURE },
>   	[PSCR_EC_PANIC]		 = { "ec-panic",	  POWER_ON_REASON_EC_PANIC },
> +	[PSCR_POWER_ON]		 = { "power-on",	  POWER_ON_REASON_REGULAR },
> +	[PSCR_WATCHDOG]		 = { "watchdog",	  POWER_ON_REASON_WATCHDOG },
> +	[PSCR_SOFTWARE]		 = { "software",	  POWER_ON_REASON_SOFTWARE },
> +	[PSCR_EXTERNAL]		 = { "external",	  POWER_ON_REASON_EXTERNAL },
> +	[PSCR_RTC]		 = { "rtc",		  POWER_ON_REASON_RTC },
> +	[PSCR_RESET_BUTTON]	 = { "reset-button",	  POWER_ON_REASON_RST_BTN },
> +	[PSCR_CPU_CLK_FAIL]	 = { "cpu-clock-failure", POWER_ON_REASON_CPU_CLK_FAIL },
> +	[PSCR_XTAL_FAIL]	 = { "crystal-failure",	  POWER_ON_REASON_XTAL_FAIL },
>   };
>   
>   /**
> 


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
