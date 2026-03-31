Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7D83A3821
	for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001190; cv=none; b=ErfEXuGW7y5IDa43z8/KC4gjdP5CuKSImjlO6MxbeXFlj8fcGT31uiWNB2fiR3QyEm1sgkBoeZpP/BtIWTJakNQVC9GpDbCCmCkp/2kdkT17fJF5GORtrhZynakkln5OqdZzobUJ3JeeINSvsnCbv2OLgLVN7pkQ/0Sa8HA837g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001190; c=relaxed/simple;
	bh=QpA/50/qScWNaGo0ktyT/ol00BwYGqcFWkc/7d0Av9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AdRba9XFFTLPV7f/7+O93QppJ/T9mUHFHAx/9pzm100RdR/nvZ1C8Cn+AGDgS2VLLoQsZu8klWepDmAgP/NSMCDPXARfEUaTceVX2NcQTaaADka0I1iYl/RpI2iXelQn/qT/yF423hqQtlAvX8x2L5nmJBAm8IDPQqHuuvZpVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TjShkzsQ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TjShkzsQ"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-40f1ffba6a0so3321522fac.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Mar 2026 16:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1775001188; x=1775605988; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QTGoopl5+YCcmWM2yu0MNYoS83bG3qG8QrUzdQCFVFA=;
        b=TjShkzsQBVhwsceG6Uaxh/svZ0n7JNLGhed/m1ikmPkcN66F8qGhOiXy15gzgFmK46
         uGHxSpTwDE4s31Z2I+uYOcpz2kzXCs9FCRPmV1cmdQdghsVjUGPD0JdlUU0r24hufRrn
         JvFR8mhk/6msgokRGqB7XzRHn+MQpYiCuZaR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775001188; x=1775605988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QTGoopl5+YCcmWM2yu0MNYoS83bG3qG8QrUzdQCFVFA=;
        b=hNnvUl58iW6drMjUY8ECSM9jzNd/qbTAaYVQ3r94TSKi30Pu8YN+bOsBrWjSZJQ3Yt
         ZI5/TQsYWSLcZxSQUeQv8o1r7eyZT0PDfLKIZPce3pjZN+bGOo3qCzg150kxRjRz+WbE
         4ruQagyWbLTBIBG6tgmQFIVEtbcyNlxOewd9M0R8uqP0GQco4a/GadUy5sVr1BMxWoZ5
         T3DiJZvgtuzpeyv77ArlK6/be5P2YAuLI+uflcXfiLSPso/ZwKcwVoDAPVQzyb6mDYgI
         d9OK94gDIxbwhzKS3yHKjIsYXswG/m0QKNd/Jki2TKLaHaaBAIpbngpgvutSkHb2EMCo
         a+Ww==
X-Gm-Message-State: AOJu0YxZPjarAcU2zh7M2GTv0Zc5SCP2xxREQEVXwD71y3zF3crEaPtv
	KfPUtOGPg6WZi9KQnbV7Rmz0GyiU7NBe5Zq23biDqbQQntFAH2pG8A035M6iW4fkRFQ=
X-Gm-Gg: ATEYQzw32FbvtpvyAKY39GEJ/ZbMqafnYExsFhVEf+hs9YoDLTbQ6Q7XymweSzf5ZxW
	7avdFqGye1WbF9BYPUqmpznPmYx04BMnu32g45+pK8YCqmqWQ1dGb/1AJo0G2phlS3U+aqcQi1p
	hHlSupHQmc0k6i3xV3F7ysknVBuqlwh6WaWl785QaY/BSRYjboHAVKOQrz4ArQqZ+lwrKkVDFRM
	2GJjvt/V/cVd65NXgjf5PLhFUoMwcGqj448m8CthFFb+l4bWU0aoGf50KnHobX+oE7o88z0L1jI
	Wg+q5w7lSyFwBkFvzpTQOnC5KNa77T7YyIU0CT+q23EfxPhsPofSc4p0eaI0tt+m/FIf6IORECX
	MUMKuiEluvW2oC3uHFuaoPp9RuGAa0AonN576ZGOZQke9At/I2eEseATW5NBJ60B8oyuHj7kQh7
	K6omqMlgrOsSIl8k9pTE5CWZLOvhtdYgPnLig=
X-Received: by 2002:a05:6870:15c4:b0:3e8:44ec:3416 with SMTP id 586e51a60fabf-422d0000f16mr979450fac.46.1775001188061;
        Tue, 31 Mar 2026 16:53:08 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.187.108])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04958090sm8848548fac.7.2026.03.31.16.53.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 16:53:07 -0700 (PDT)
Message-ID: <42aaa8e5-509f-4d98-88da-9df10588e348@linuxfoundation.org>
Date: Tue, 31 Mar 2026 17:53:06 -0600
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpupower: replace atoi() with validated parse_int_range()
 helper
To: Kaushlendra Kumar <kaushlendra.kumar@intel.com>, shuah@kernel.org,
 jwyatt@redhat.com, jkacur@redhat.com
Cc: linux-pm@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20260331042859.1920369-1-kaushlendra.kumar@intel.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260331042859.1920369-1-kaushlendra.kumar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/30/26 22:28, Kaushlendra Kumar wrote:
> atoi() provides no error detection for invalid input or out-of-range
> values. Introduce parse_int_range(), which uses strtol() with full
> errno and end-pointer checking, returning -EINVAL on parse failure
> and -ERANGE when the value falls outside the caller-supplied [min,
> max] bounds.
> 
> Switch --perf-bias and --turbo-boost option parsing to use this
> helper. Also move error messages from printf() to fprintf(stderr)
> to follow standard CLI conventions for diagnostic output.

What errors are you seeing?
> 
> Signed-off-by: Kaushlendra Kumar <kaushlendra.kumar@intel.com>
> ---
>   tools/power/cpupower/utils/cpupower-set.c | 29 +++++++++++++++++------
>   1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/power/cpupower/utils/cpupower-set.c b/tools/power/cpupower/utils/cpupower-set.c
> index 550a942e72ce..dcbdff5c9ae5 100644
> --- a/tools/power/cpupower/utils/cpupower-set.c
> +++ b/tools/power/cpupower/utils/cpupower-set.c
> @@ -31,6 +31,24 @@ static void print_wrong_arg_exit(void)
>   	exit(EXIT_FAILURE);
>   }
>   
> +/* Safe integer parsing with range validation. Returns 0 on success,
> + * -EINVAL on parse error, -ERANGE if value is outside [min, max].
> + */
> +static int parse_int_range(const char *arg, int min, int max, int *out)
> +{
> +	char *end = NULL;
> +	long val;
> +
> +	errno = 0;
> +	val = strtol(arg, &end, 10);
> +	if (errno || end == arg || *end != '\0')
> +		return -EINVAL;
> +	if (val < min || val > max)
> +		return -ERANGE;
> +	*out = (int)val;
> +	return 0;
> +}

Adding a routine like this is not the right direction
because it adds code that needs to be maintained.

> +
>   int cmd_set(int argc, char **argv)
>   {
>   	extern char *optarg;
> @@ -69,10 +87,8 @@ int cmd_set(int argc, char **argv)
>   		case 'b':
>   			if (params.perf_bias)
>   				print_wrong_arg_exit();
> -			perf_bias = atoi(optarg);
> -			if (perf_bias < 0 || perf_bias > 15) {
> -				printf(_("--perf-bias param out "
> -					 "of range [0-%d]\n"), 15);

The above logic range checks on perf_bias - Is there a problem
in this logic?


> +			if (parse_int_range(optarg, 0, 15, &perf_bias)) {
> +				fprintf(stderr, _("--perf-bias param out of range [0-%d]\n"), 15);
>   				print_wrong_arg_exit();
>   			}
>   			params.perf_bias = 1;
> @@ -100,9 +116,8 @@ int cmd_set(int argc, char **argv)
>   		case 't':
>   			if (params.turbo_boost)
>   				print_wrong_arg_exit();
> -			turbo_boost = atoi(optarg);
> -			if (turbo_boost < 0 || turbo_boost > 1) {
> -				printf("--turbo-boost param out of range [0-1]\n");
> +			if (parse_int_range(optarg, 0, 1, &turbo_boost)) {
> +				fprintf(stderr, "--turbo-boost param out of range [0-1]\n");
>   				print_wrong_arg_exit();
>   			}
>   			params.turbo_boost = 1;

I am not convinced there is need for a new routine to do the checks.

thanks,
-- Shuah
