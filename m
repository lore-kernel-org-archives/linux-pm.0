Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F0625;
	Sat, 25 Jul 2026 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785015650; cv=none; b=gxkmGfcRM2kSQyc7nk/MehFMLC21JHpnptUrFqkoGg1WqOXTNUTn/adZY8mst3ARTKhAampsGyfXBjhJ+/glK1I+7amTKCGTGZ7BXaaGDr1xuTA2QuQygfs9J5JkbX43zbInEsI7F058gR11Pww/l1BBD8lnwbxluw8Bk/yHQ30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785015650; c=relaxed/simple;
	bh=qyCyhcPCK0MGIjwMUP1F4pB4FKfPc1liJrLOMavqTY0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOt/0wiLz1ie/Xw3cL8p3JuqXT1IMCSGvZSjn/Wlnf/G4CnbzG7yxZZ5VeShC2rvOMlpbExp0ZB3QeGoRjmjzd8EApNkEg4vrO3JgS/a4kBb0VqjQUA2KCCzakH4eJXcZhAgqjhMP2iyKoBy3TULTpZT8+MyhwCAd/bkkeBWX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f1BQpjQD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1BQpjQD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE591F000E9;
	Sat, 25 Jul 2026 21:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785015649;
	bh=DtlvVsw7NCv7y3/Q1wKXm9/39JV54+n13G3ySQjLkCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=f1BQpjQD69WssFkQsA2wArP+ybAChrPUic2AEqr9yHkAJaPVYRlJuxmnIcOmeKH7C
	 s3hY6ElYlXWLBvVYKlShHJY6ciRtm21mx97WRh379ORwWWczIgxtbxtD1merMxYsa1
	 xB7AeQ7/zBYij3ne6B0opeGTC43EHt/HQ6mZiTCzq5C/FDVPgcZX45n9eKkXSGGRns
	 LtwHGZQmPRCDU+knEn/4uCwlyjVQhkHYTHeknDOGYftbqg+eejpVfduBMgsgYNKfLB
	 /BBhvzHf359/1ffgj+vLfUOfCSNz8ocKQItpGTlT2HNyUHyzXMweboRV3Ee/dkIOlP
	 Ws9fH36IB2VfA==
Date: Sat, 25 Jul 2026 22:40:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Amit Kucheria <amitk@kernel.org>, Thara Gopinath
 <thara.gopinath@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Daniel
 Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, Kamal Wadhwa
 <kamal.wadhwa@oss.qualcomm.com>, Jishnu Prakash
 <jishnu.prakash@oss.qualcomm.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] thermal: qcom-spmi-adc-tm5: drop IIO_VAL_INT check in
 adc_tm5_get_temp
Message-ID: <20260725224043.62b15ea3@jic23-huawei>
In-Reply-To: <20260724-adc-tm5-drop-iio-val-int-check-v1-1-0b85a0895dd7@oss.qualcomm.com>
References: <20260724-adc-tm5-drop-iio-val-int-check-v1-1-0b85a0895dd7@oss.qualcomm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 16:30:24 +0530
Rakesh Kota <rakesh.kota@oss.qualcomm.com> wrote:

> Commit bb21ee31f575 ("iio: Fix iio_multiply_value use in
> iio_read_channel_processed_scale") fixed the
> iio_read_channel_processed_scale to return 0 on success instead
> of IIO_VAL_INT (1). The existing check in adc_tm5_get_temp()
> treated a successful return as an error because it expected
> IIO_VAL_INT. Drop the redundant `ret != IIO_VAL_INT` condition
> and rely solely on the negative error check.
> 
> Fixes: bb21ee31f575 ("iio: Fix iio_multiply_value use in iio_read_channel_processed_scale")
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Ah.  Sorry we missed that!

Change is fine but you might as well just 
return iio_read_channel_processed() as it only returns 0 or negative error.

Either way

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

+CC linux-iio for info.
> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index bb6222c8cc5f..af72db6299cd 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -369,9 +369,6 @@ static int adc_tm5_get_temp(struct thermal_zone_device *tz, int *temp)
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret != IIO_VAL_INT)
> -		return -EINVAL;
> -
>  	return 0;
>  }
>  
> 
> ---
> base-commit: 9eebf259d5352b87080d67758f483583d9e763d7
> change-id: 20260724-adc-tm5-drop-iio-val-int-check-38e27c4018c7
> 
> Best regards,
> --  
> Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> 

