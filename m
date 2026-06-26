Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119133CE0B0
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782456137; cv=none; b=q8IRWCfwzG0FAY9SfxEhXOgHoP99gmw5kCby4FM9konPfhmEwRjJ0eiFOHhVj9iMVVyK0LoOA/p1RyudT/XUdFVdgaiHBhigx0oNJBu11U/ODpUYS24vD3v0hnBiIOI8I/M0Ex7YucMBC/H/4aEDrt65EYzzfk5YyKtCvE9g8lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782456137; c=relaxed/simple;
	bh=fje9UXyWv8yL9YNs3YAeiDc/M9FDtyBCWEc+3DeCnmc=;
	h=From:To:Cc:Subject:Date:Message-ID:References:MIME-Version:
	 Content-Type; b=bwkk6HPKA6CdPIoHAyD3v5aWPB62UmOJHvf1ATPImTpJgi/vQo4gwGpvOk5Z5IGH6V7UUH/eS11qaWo9m935Pkq2cCjTjxBesW4OgUT0ioaNYitLpJirit/bJLCu7CvlnfaDtfXn3bzRHASI+ELj+5t4BLwnFPvTTXHuvbm09jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISo2Ik0P; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISo2Ik0P"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso7823495e9.2
        for <linux-pm@vger.kernel.org>; Thu, 25 Jun 2026 23:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782456134; x=1783060934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56xRi217GtHBHYQHJbgA7YLUn0MAQQE1vLXLfDs7/8U=;
        b=ISo2Ik0PSI7NsnY8GaQtAqk6chmMk1HDC/GMrq0RI6GawERtsBdrxDQ+szzbV+layS
         73LWpPcLREOQEbyDilRwOHRDWY37V7Gyd2hL9ThFE0GaOPE+4kUGEjRRvPGf1U2xxd9B
         AjUFPp9F6oDqlZgS+oKn8hCmaPeD/HYm36U14bs2GaKBdZr97uioB7p1eYDbnLVtUkJw
         wDoMqlc4fb987E4NU6dg2xjkviiwPdP0WkSCbMxDmkFZ19I1vCjLSBWhwLrG9gqqcvAH
         dXavnd6NIsqDGRFf+rCTZJOx8Q96vU34p6F69iN8xJhq8pi2HFKW4kIEW38k43nDXDCI
         uRaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782456134; x=1783060934;
        h=content-transfer-encoding:mime-version:references:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56xRi217GtHBHYQHJbgA7YLUn0MAQQE1vLXLfDs7/8U=;
        b=BDwXNG2VXdNzDJBVWC95F2sXEGTmC9ycflq2CmiZXCq4IY+3UXbv5pQrRNyZLtcKKL
         a/gfq6OXTQJ0IgOe5MRFR8Dh/rZUcy6JgGQq/qzydzZ12fVvDmM3RDAQypyHMso8u2np
         BxMZnedZEeGi7swJJnjKh7Svgl4KKAoDuGFFED+L1TsnepCBtgPrx23cQMppF7vMUYZX
         h626AkUqiZil2n7rytXeoN8erP39GYJok8ByEL8CyYUjC27WKRVaoJVd5UjpLJ6v700b
         eIBW1qrfQS4q8m9KnBEPpnEyjfgvgF5O6ZYAnZ1wNz12Uyn6oFiKBHymTRPrFYnfGPux
         3tKA==
X-Gm-Message-State: AOJu0YyhQu3xFP2UNgSEMZ9mFwwHQKV0GAr3P2ZfmVWDgY6HMl0+LcpM
	WG2U7QmyptbYH7geKDAVSi9ECKUNoEnRPsG4kpl/ofVpGeqOJDbdMklE
X-Gm-Gg: AfdE7cklDlLEt4sjoswzJYxuAUgGAQVMQllcnBDwTrkPQnZ0aBxauzCbhEfTHaYIi3a
	mhh0LoWtg84XKiMADxDbudCqw09jPcHgAZ+Do5GaYPFhoX2HCFO88VlQzYdG8WMuJvm0GeypuxZ
	gTqExAvocT3Op4Kihcvas9sh7PCWw6HQe+KIBGqf91y2pqxM0EGfXmrzESB8rbjAGEDix/zsEIl
	czx3lWrqehP8RqnVmSNmOmpQuI4BxyvZhZvJXDvguLCLsWRmlZjvdVIk1JQZD/aLaKuJwIoL20+
	vd9QjyNhStZg/UpZ1wnY5veLkiSCwkaChmXmAnDrcdRl0BMSZebmK86zBS7DVLJ3BZdQVXjm8zG
	lVqxw6MuKu2e1vzJ3ZJGJK1DJEVIz2sIkulSRQsliIiHkH4UQCWWK8BR184yo+bw/3nxa3vJkHJ
	oYgLOnEY/RwvgLPOCM910=
X-Received: by 2002:a05:600c:a55:b0:492:59fe:4a15 with SMTP id 5b1f17b1804b1-4926687e800mr77770015e9.24.1782456134354;
        Thu, 25 Jun 2026 23:42:14 -0700 (PDT)
Received: from beast.localnet ([2a00:c281:1461:c400:bf16:e4f3:7fa:c2dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46d86960991sm15326122f8f.6.2026.06.25.23.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:42:13 -0700 (PDT)
From: borissh1983@gmail.com
To: Sebastian Reichel <sre@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH] selftests: helpers: handle multi line in
 test_sysfs_prop_optional_list
Date: Fri, 26 Jun 2026 09:40:37 +0300
Message-ID: <12928066.O9o76ZdvQC@beast>
References: <20260625125237.36605-1-borissh1983@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Thursday, 25 June 2026 15:52:37 Israel Daylight Time Boris Shtrasman wrote:
> Modify test_sysfs_prop_optional_list to allow multi line parameters, in
> order to comply with checkpatch output that limit line by 100 chars.
> 
> Allow use cases like:
> 
> test_sysfs_prop_optional_list \
>         property_name "value1","value2","val3","very_long_option"\
>         ,"extra_long_option" \
> 	,"even_more_data"
> 
> Signed-off-by: Boris Shtrasman <borissh1983@gmail.com>
> ---
>  tools/testing/selftests/power_supply/helpers.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/power_supply/helpers.sh b/tools/testing/selftests/power_supply/helpers.sh
> index 1ec90d7c9108..8535cb7ed094 100644
> --- a/tools/testing/selftests/power_supply/helpers.sh
> +++ b/tools/testing/selftests/power_supply/helpers.sh
> @@ -108,7 +108,7 @@ test_sysfs_prop_optional_range() {
>  
>  test_sysfs_prop_optional_list() {
>  	PROP=$1
> -	LIST=$2
> +	shift
>  
>  	TEST_NAME="$DEVNAME".sysfs."$PROP"
>  
> @@ -118,9 +118,9 @@ test_sysfs_prop_optional_list() {
>  	valid=0
>  
>  	OLDIFS=$IFS
> -	IFS=","
> -	for item in $LIST; do
> -		if [ "$DATA" = "$item" ]; then
> +	IFS=",IFS"
> +	for item in $*; do
> +		if [ "$item" ] && [ "$DATA" = "$item" ]; then
>  			valid=1
>  			break
>  		fi
> 

A new version of this patch now at 
https://lore.kernel.org/linux-pm/20260625160556.54830-1-borissh1983@gmail.com/



