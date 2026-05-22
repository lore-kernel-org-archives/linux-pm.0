Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A78239EB4F
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 05:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779428658; cv=none; b=Z15cH2VwDMsyz94jTS10fAee4fHHHnK15724z2WkKQyiqGMVdyvaWXG5VHUqy0klsjHdQ8TVcLol9tvvAdeLnJLApb4d58xxIro5FzKTvcO5a7K6dIIQu/oRt9sCYpMT9WwLeH4T6a4yb9UJZC0u7gTVtOb+gfq91D2mX7kqpyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779428658; c=relaxed/simple;
	bh=jxixpNCHvMRotUXT27hralS4lUCiap0pCNqAAun0jjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVUcoMA7TLpgIol4RnhCzy9TBkZptjs3rkba3RScJQZ9/+/YXznaGBxjLameDksall32Qsxtd0vtHaX7SPd4kNr2euNNHjSvdAgBZOo9I6jUT9SZGtyPK4U0FtoQZS18dNmZj9YeTjyI/+o0u+CL9p5Aqfl5VAK/hv8XUFJGe1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jdAoUcgT; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jdAoUcgT"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70c112cb61so5667304a12.0
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 22:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779428656; x=1780033456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MRtEIqVoX2FsvAfqkFJAXgU7NEYX8w7sjZGErxmCJVk=;
        b=jdAoUcgTqKFVFY/6aGzXjz1tqeK7H+jvYad74efhjGRmRgZ78laFPSGiBydRZjxdK3
         dyNpN539GhCQxsA1c6GrmwXSL1quO0yEMGdGYUny8c3eAJl2jvRw4xTBDlOvSE0IUPkp
         5z/+2GQGqhltAlNXeH73sEsK5iq6cOI0Hk90dFlaQad9HS5HV+35ktTRtn2QMbDZxeAM
         vl7VSUUg6PpcDJKV4plNd/7Zdx+xPMR+r4H3+p07RQh7LJkDcIx392bSCv70490Ax8o8
         cCYy0vO2Jqmc86gI1VIkiBweBiZtJmyAklr/5J1LZRDRptMNLB6GMJfPFHdNZrxmlIgX
         7Alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779428656; x=1780033456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRtEIqVoX2FsvAfqkFJAXgU7NEYX8w7sjZGErxmCJVk=;
        b=bskT8u+9YNG+pv3bjUsEWLXrvIzeUWe2WJY/zv2VuvrayoCVJHNUKx2UvDrCbQgzUs
         sjKfvLmrRCG3vlgPhpm85IMWZAbjHC8l/mUXueyIunRhKMT1tijAmcz83mvKhJ2vQZFs
         5HTMer9Aus17hFKH5lD3dVFH9j1scuW7tt5q3MtkSz5PyPqiRMpkXqVwQFa8TSeLRI7r
         ts2Z+rwH3LX1TVPY78dGTmLYjLdSXZmc3bjgyK9icZTBgTnN17g0XNz1l5UunUvwQ4Ud
         1akoKiRRaMO61izOAHgSyZ0o1GzfApRBayEV6ZDU6jjeuQkBFtBk769V93QRPspBVC28
         VOiA==
X-Forwarded-Encrypted: i=1; AFNElJ8ZhIN4DqjX0wn1b4vPxq+0q9M1dQlcfMW86xj3yuOs+6rSPu+NbeVnE9EsfKCIMDzRqYfcc0bPnA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXM4F7YTXLncmAMdhWIwcGqOvkJfAcAdTcFCk/hMEG5qM8rXpm
	6Jc5zASJok5w8km3oev1DfTOv4rA0LkiXk16UIm6r6gLc7rhjIinUSNQ05Lrws4fnRE=
X-Gm-Gg: Acq92OF41gmPzlJSgqzlF/GKqQcdu4KzfQT7+xgi30Qj5Rs1qAudsF8JC8sYC1F4bzn
	ZhOmu2iCbEjRO3AM9/uo36DtA+TBT7Lyy6VcvwB+Kth1Or+l9QUxl3IUr9L6dpfmFevhq0ImKMe
	Tifu/nPhY2z3R2syWnhAwGJtpsJUIFCz3Z85Vplsnmxdn6hx8YnwY5EKFIr+CByfT62+NYT9IQn
	78mAq1m59ud8xadsmTXor23dnWeWZ8b+P8bg6eiTzppN9/klAE9U54OP53VjawEkjq5lpCPnokj
	lh9MiQlL6AaBliKr1VpO0TY/DG14RwkeB+1rjFbincmy3PQwOXoV3TllFV/tPNw2UblMVRKa+vh
	G8CYiZC5gd/Wu8v7T2j6/yOqMECRxgtNBkIpNIT/0BgI200kOEerXha4xZ/6XRIBY3a5VWBXJH6
	9QfCcXMFCYSLSIh7wH6AuPna0=
X-Received: by 2002:a05:6a21:9212:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3b328cd7fdcmr2319563637.21.1779428656289;
        Thu, 21 May 2026 22:44:16 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85205855dasm480493a12.31.2026.05.21.22.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 22:44:14 -0700 (PDT)
Date: Fri, 22 May 2026 11:14:12 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, Jie Zhan <zhanjie9@hisilicon.com>, 
	Lifeng Zheng <zhenglifeng1@huawei.com>, Ionela Voinescu <ionela.voinescu@arm.com>, 
	Sumit Gupta <sumitg@nvidia.com>, Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Huang Rui <ray.huang@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@kernel.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 4/4] cpufreq: Use policy->min/max init as QoS request
Message-ID: <5vwdvlz7zqldgp2xffrymwpomder64y222g3hy25i3dvnquakm@vxzl7csmrnlw>
References: <20260511135538.522653-1-pierre.gondois@arm.com>
 <20260511135538.522653-5-pierre.gondois@arm.com>
 <bflxwyho5epheovbjnzlsvgvoitaqjbiv7kxcwbnoiz2nlmuvv@dtunrpupeyie>
 <99eb1963-dadc-44e6-9e67-814ed7089379@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99eb1963-dadc-44e6-9e67-814ed7089379@arm.com>

On 21-05-26, 13:58, Pierre Gondois wrote:
> Sorry if I misunderstand, but if we do:

> This would bring us to what the following patch tried to solve:
> 521223d8b3ec ("cpufreq: Fix initialization of min and max
> frequency QoS requests")

I missed this patch, that's all.

-- 
viresh
