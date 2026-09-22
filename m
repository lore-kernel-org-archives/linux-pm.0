Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADFB543F095
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068982; cv=none; b=AHoLUvRWSJudvWgtjdoD4CPJvW2JLaRq+Bc9UQ06Sa4PO39eXLF/jlA71ofCITFtNd/PxIY/IJgyk3GX0k0urzapG63gXHW5U0Fu8qO7fJ17V4N5C7YBNmgfC12uJZ7iUYada/0suXjBlSYdhxxO5ermdL5c2d5SEnAjpzJ3dbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068982; c=relaxed/simple;
	bh=0MlNWyi4hCXVJVEWimjJfjTosZLJAjP+I7BsGPwrE50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gf5miZ2mLoZUwICQp9JbFZ0bZSVw69ncD6oWhLOMWEI1IEW/EzO4+2ZdsDjupu4HbBsLfVQ97RKrbZb6hf3b1znSeLTpCkMHTGPO9GKAjpFr2RhSqOnm7DicO9yNT1jmfcJswMmoRWoOJj2zZ4Glb0BL/+GMHG75upDQ+VVHNDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JojTQ7H2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAruvlcd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JojTQ7H2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAruvlcd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790068979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rpAVQ1UlV+yVL/E0QTVtJ9fL9FL/1XwCUiRQoK1VFSk=;
	b=JojTQ7H2pBNe5yFMbDwJ7+sE5gEhge6YPdwq9ej4Yt86p1x2QcWM6bD06XTsFoWf7tAVN2
	CaGMUgYRlf0EtK+aUlz2rhsUFsRLhea0eW7UobzvVEhJ9OiTZ+qukkLs8jNDdT6m1gu/4c
	g/M6nm/lWMVuDLLXyAfSAPjnGRN4NWs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-1h8lHXxLOf6wAA4NAEGtaQ-1; Tue, 22 Sep 2026 05:22:58 -0400
X-MC-Unique: 1h8lHXxLOf6wAA4NAEGtaQ-1
X-Mimecast-MFC-AGG-ID: 1h8lHXxLOf6wAA4NAEGtaQ_1790068977
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-486e90b59a6so1794812f8f.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 02:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790068977; x=1790673777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rpAVQ1UlV+yVL/E0QTVtJ9fL9FL/1XwCUiRQoK1VFSk=;
        b=YAruvlcdtaY8dQeuDq2W6zA9Z2lefnnlqGufgfEqcdR8Mb12IdlD8YwXXGyyvI6hGN
         pOktEV5gjZUSDiqKnV8n4doVLlUZ/nFm8T+rJoaxJ63oXKalf1o5NNfVLtRtth6Zsyj/
         VVpDTcOlIsZnNDhjyP2E3+ilyodO+y6yNVrACznxlX3la+7WApq59lnJT2KRVFPmt3KB
         OwUH4EQNG1qKGG9yCGBOZomtuHO1HjbyjWC5X8D/4UWORPRzFQTepamEPIdo0mzl9G3X
         6jHYc/kOXI/ZOXF2cB4CIC5TAc/WRi68c0FTNykJmgshZo3EJbRJBHzq6fqm234yUB9U
         qXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068977; x=1790673777;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rpAVQ1UlV+yVL/E0QTVtJ9fL9FL/1XwCUiRQoK1VFSk=;
        b=INpd9CaIHDaF8zfRS4kxW1H3mYrIGSfEPdwc0z0BI/5/lRthvJbVpRhaCZR8R57aBi
         aJUj0hJX/804jWAUvEiLJrGwntHs3pHofLWL0nBoug01x/8dne1WgIk4kfg6LBeuw02R
         0qk3g0ktqGRL7RqKH8CVpkmYD17oNWdQShcnzOEScbPALBOS2qKaoMMKRuqQ/Dx/zugS
         8uvkAjbi+Qp+OwEbHPajGsGsg1j/g5UoX65Mq1Dnx8DhgAyCpP1tGZDQCEDzlyM6vFGr
         iaVTFN8HHwEg2UK3G0JOqAvqIrmB4yAeSQwl60oSGduz2P39pUsdAACfE1Adl+kE+uAs
         aI/Q==
X-Gm-Message-State: AFuF++mmkzA1JHrMBNVmfuwYMWBHMcWb4+5fMFqCMsE5zlIuakTO5aVT
	rtOMOyx00YIxJB5QD02i0hymLfl2qF9tjx+PH+0Pdv7gENHVeQjrjjoh7ZVynDs3QqASmWra53H
	SOFidFlEEYaiW7wae0kPsq4RGM0nE9K433J2IzXScmZja+I6rNAFfb4AkWmhXFLHsFei3cfc=
X-Gm-Gg: AYBFou2VD5VOPJQg7fCJiOuHPclk5X/jcisU7wFeU3nJsaUi3mrK5njeX3uEOUHylRW
	fIm/wyHMHoQDV+alkCSRzcVEA4Ru/+EzPDvoaVVuymosdIGmtYKcH2iWtsY2ul7CepBWxdqdbIP
	o3m4rWD/f9zHzp1Pz3pyN7N8+yjcVmNbOX1PfNM/f3FlXkyMmUY3zyJTe2t6s8xlFAqssD5wL1A
	Y+2gqha11/tkFMBKQy9dQ3KhKVl2AMWGwpEjdqTMsrTok34jMYgGUICz+Gw2ziVXjPycuWMnWWq
	Htqaq3ID5vCVkEQZX5ciF94DHsmu7MqQXrn+SSXr35yqqevIJBNEfeNDX/qlUk2DVDMiGx6e9g2
	rUYBAba93YBf7whFoy1K65L0=
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id 5b1f17b1804b1-49fc574a9bcmr167312795e9.25.1790068976729;
        Tue, 22 Sep 2026 02:22:56 -0700 (PDT)
X-Received: by 2002:a05:600c:a013:b0:49e:6891:27a8 with SMTP id 5b1f17b1804b1-49fc574a9bcmr167312555e9.25.1790068976311;
        Tue, 22 Sep 2026 02:22:56 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ce2623sm79760035e9.13.2026.09.22.02.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:22:55 -0700 (PDT)
Date: Tue, 22 Sep 2026 05:22:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Baorui.Liu" <baorliu@amd.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
	saravanak@kernel.org, jasowangio@gmail.com, eperezma@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev
Subject: Re: [RFC PATCH v2 0/1] cpufreq: virtio frontend to report host CPU
 frequency
Message-ID: <20260922052231-mutt-send-email-mst@kernel.org>
References: <20260916073735.541-1-baorliu@amd.com>
 <20260922090224.430-1-baorliu@amd.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922090224.430-1-baorliu@amd.com>

On Tue, Sep 22, 2026 at 05:02:23PM +0800, Baorui.Liu wrote:
> This is RFC v2 of the guest virtio-cpufreq frontend.
> 
> Changes since RFC v1
> ====================
> - Fix 0-day kbuild error: cpufreq_generic_attr is gone on current
>   linux-pm; use cpufreq_freq_attr_scaling_available_freqs.
>   Reported-by: kernel test robot <lkp@intel.com>
>   Closes: https://lore.kernel.org/oe-kbuild-all/202609191437.OaXd0Blz-lkp@intel.com/
> 
> RFC notes unchanged: experimental virtio ID 42, hardcoded OPPs,
> sleeping .get(), QEMU backend is a separate series.
> 
> v1: https://lore.kernel.org/r/20260916073735.541-1-baorliu@amd.com

could you link to qemu and spec series, please?


> Baorui.Liu (1):
>   cpufreq: virtio: add driver to report host frequency to guests
> 
>  drivers/cpufreq/Kconfig          |  14 ++
>  drivers/cpufreq/Makefile         |   1 +
>  drivers/cpufreq/virtio-cpufreq.c | 240 +++++++++++++++++++++++++++++++
>  include/uapi/linux/virtio_ids.h  |   1 +
>  4 files changed, 256 insertions(+)
>  create mode 100644 drivers/cpufreq/virtio-cpufreq.c
> 
> -- 
> 2.34.1

