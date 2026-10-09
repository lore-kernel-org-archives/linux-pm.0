Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC93D3D1B
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 04:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520395; cv=none; b=OYgh6wh1TNNY4fZ1L5OxTx/tpKYCgkJUuIxdFVJKiu90gGjUNR2XMXwAMjLGyWa22x0+deN2zTQiyRt//sLCSr9eT6jqRQk+JTXqqICfFPrYSD8/eH9kpDTYI1x3Y9AYqxkfJZjGcwNR7IK262B631em6UeqZk9A3SSxBd5SJjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520395; c=relaxed/simple;
	bh=BRksUHupWTwAHQEfDLT4q+pk1XcrAhHwf/e+BYIOG/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDO83YDoFA5XUzzfvP5Xa+cZ6BLYEac6bg9vilLZZ4CB52ciccCtGkzmwLWnMVmgsnYMg8C3ygx8Ywsj8XCRChNR+XaCxvNT9VBPA8qpvFz4E8+4SUDqaWMN+2t9/JT0kQZK6I6WaOusop2IzOmA11AR4I3gJQgROui42EN65SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F2jKTa+S; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F2jKTa+S"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-141395927feso6206820c88.0
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 21:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791520383; x=1792125183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Er36W4Z+TzVAMFUZ5NmRw1HzZaggY++xCA8t6qC7IVU=;
        b=F2jKTa+SJUd8YO98TL+atT0yyAHobpSEhu9xtydkXKGildcHWhT9U687Qm+ODaWfJR
         HByHA4lkRwyUi3DU6TH1BvlVQdoJchJJnJskUiT/xv/8oXhwFRHoLX+yBqsoYFvGUuyN
         RiSbdWCNxSWcKhhdW2X1OVpzQHfX4FP5F5cu5uaGSqhcDmijFDXdpkFMbdtAoAgMtORK
         /1RV0oxaQXeRz6bS0uL4FlpYEeJSV4L4MasMMV2HJMpWlBn1QzCluEY3yXAdE1H1R5WM
         F1q7jRjlAplV8PG4J0l7SIyqE+aEZiqreOETBTjSLwSPUBR+/lQ+lnuU2qc/gnii0/63
         zQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791520383; x=1792125183;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Er36W4Z+TzVAMFUZ5NmRw1HzZaggY++xCA8t6qC7IVU=;
        b=cvz6RrWMzRUkZqaKP5XO9RIo4a8EcTPZyYBBV48Mq43+lxycYJ7wsMC9Qa59ppvXb3
         FDmeum0ou3XIr9lhXdV6ucb0qFg/6BCWBgcB7Dx6Ls+NI0HUchIPAuiRVNaIkHIyuC0L
         Plb1wyyhDSdPVm0+6xeDvA997HoL0EItbdS1McIzwfHJv4jcEpYwEs+czFjEtucp2FFh
         aKykbjMWvyAWEDUnsgHlnccC3iXydxgAiWfEvx18VmYnzRYz8xJb85n8WIgMJJZFFXAy
         pAUfbmrR1tusmlIT5frXmkyyMNotP3/D+pZIyozwT53JtRg05BS7645Q/GFjUxzRt9ey
         DI2A==
X-Forwarded-Encrypted: i=1; AKwUvBzwiEZ1P4M5yrF9vQHopDqwieThwGoK4m2vm/FTDF9pCe41YAUknY/Xn/lE8abB+7Tm39O24nHErg==@vger.kernel.org
X-Gm-Message-State: AFuF++n4kJxvsVLZIsNklfEcYp4JzSUy6MvJ0ktZBtkuy8zEEBqRNwXR
	gorMO9JTk28srK2nQwhKiKk9ecyFk7QqL+klaK94O3tsckxWt7DqA1Z8DYEMJPrlS7Q=
X-Gm-Gg: AYBFou1km5nqwD7g1Ah8Ay1w953fGP5mRamZl6F3La2wB75Ph++aIgtLGf24BVJTJ0W
	ouhIFMYbkPJVmM7F4dc/9MGizx9FLNALeV9iRKlsImWkiJbGDksUO4CeNsyqCWKDEBNsSweGseb
	ITWPM63W5hRHjoRtgA9vXskj/rR/ks+7yN8rx56g5Px0pNhzAuJyG4GMddo+BAItKK68FE6veEh
	bVZrJYhDv/oct6WmYtYrlmWTfAGPYm/clMd3gQPPASMaTP1Sv7CUit5dexX+94HpwY6dcyxDC8e
	L0vOgouR0UIJQw+0ajv8IO9nvxn51KfQVcTDEADYnjfu02zo7HuP0z6gtHKrpcLLVOYGq2G602X
	oyFdGoj3+1Ko9eUPHVRzu9U+xLIvGf7+vh4zL2Bd57BLhK5LOLJKK7W/7OOG2pVAtveRMIR09Yh
	juaK/d3qDDjwGFq6/5I1h/U8VPsaTFyHsXjm8OpSR3Ijer31eqnFWUqgQjRmE7waL3clTct7Acb
	w==
X-Received: by 2002:a05:701b:205b:10b0:148:722b:7cbc with SMTP id a92af1059eb24-16a5dbfe430mr919153c88.14.1791520383310;
        Thu, 08 Oct 2026 21:33:03 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537ca0e64csm3128557eec.10.2026.10.08.21.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 21:33:02 -0700 (PDT)
Date: Fri, 9 Oct 2026 10:02:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Taniya Das <taniya.das@oss.qualcomm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-cpufreq-hw: fix device node refcount leak
 in phandle parsing
Message-ID: <ashueyfHcwGHziVG@vireshk-B250M-D3H>
References: <20261008172442.2725544-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008172442.2725544-1-vulab@iscas.ac.cn>

On 09-10-26, 01:24, Haotian Zhang wrote:
> of_parse_phandle_with_args() transfers a reference to the provider node
> in out_args->np, which the caller is responsible for releasing with
> of_node_put().  Neither qcom_get_related_cpus() nor
> qcom_cpufreq_hw_cpu_init() ever puts args.np: they only put cpu_np, which
> is a different node obtained from of_cpu_device_node_get().  The
> reference is therefore leaked on every successful call, and
> qcom_get_related_cpus() leaks one per present CPU.
> 
> Release args.np after the parsed index has been read in both call sites.
> 
> Fixes: 2849dd8bc72b ("cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver")
> Assisted-by: DeepSeek-V4.1-Flash
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/cpufreq/qcom-cpufreq-hw.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
> index 874ff3fb9d97..060a460716f7 100644
> --- a/drivers/cpufreq/qcom-cpufreq-hw.c
> +++ b/drivers/cpufreq/qcom-cpufreq-hw.c
> @@ -322,6 +322,8 @@ static void qcom_get_related_cpus(int index, struct cpumask *m)
>  
>  		if (index == args.args[0])
>  			cpumask_set_cpu(cpu, m);
> +
> +		of_node_put(args.np);
>  	}
>  }
>  
> @@ -554,6 +556,7 @@ static int qcom_cpufreq_hw_cpu_init(struct cpufreq_policy *policy)
>  		return ret;
>  
>  	index = args.args[0];
> +	of_node_put(args.np);
>  	data = &qcom_cpufreq.data[index];
>  
>  	/* HW should be in enabled state to proceed */

Applied. Thanks.

-- 
viresh
