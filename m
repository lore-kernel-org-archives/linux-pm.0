Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BF19ABC6
	for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2026 00:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783988670; cv=none; b=uJ4Y3UF0vz4rV2PpxyRx4aKqnRE8DYRNIyssPbcmojSZt0LMWWgNUGmf5uF7uYMvOGQyYmpxjvgknArU5cKnat5wen9DnYOaDtpSqIHBf/Yo5hinl/DPzUML7KFj/doWr4q/CKnOo9S+p7MQPvQuEcuMVPOQ/642ZeXsjZlgs64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783988670; c=relaxed/simple;
	bh=DahsozGJhtrX2M1ALPwSJqOC4jAE0W3BpmRPgHqXack=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq4AK0ugRnPQznng6KQ5RGA6wlj57PRCtKkNiCbZcNSk8ZK0/2hjVYea87ycSrHw8DzmG5irlQzqCpeO6l5eWR5d7REXveP7IEevNVkxThxrhcGksGkAh0REpDjFJG+G+N1W77JeiyzAm5BFy57EGT82Lury3pUrPZ/KykxmcpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RfqhREEn; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfqhREEn"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5bf94664327so1426493e0c.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 17:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783988668; x=1784593468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWMXzoVTprF/il3pTv3YOw63QQxuiitP828mB0/xOY0=;
        b=RfqhREEn06bpm7ZLUzx2fkfRolhXjVGRgpjd6nhaMaYsHyZoQbvUka+ZBQH9cTfJko
         nfsaWRiMnbv/YPtnAs/34v7QmyDIA8X6FhbGYoGHigR2Tv7s9AZxJc/YLUnK5RI1ueFp
         Bgh2Qhy+PgZtX/dcTr5X93wwkTfgkJgu0Kh9Sc9DXRvCpHmIDjhVsh51CbMlfZE5B8bu
         nFJc4xdwhqPDzO9p7WTeKkiXjusoZtS3iBCJm5QZDa+GaTBK1wvl3JIZ8eRe/Jkou6D+
         01qpJb7UtwUOSknxHLRgVvC1u/iz+B36EGRWG3OOF2NwN1jObwesnfWVMSZCjdWdUfkw
         AI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783988668; x=1784593468;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWMXzoVTprF/il3pTv3YOw63QQxuiitP828mB0/xOY0=;
        b=d+glv5Ko/uU5+Ns+/nb0uhnMnzH/9mPgfPfWP8Fr9A911wfkocRLI+AYfc69TtXtrz
         IQmYlDUJKiQV8e5pNFWVEhHhLstglHIILogw64a3C134Eq3ZwWvY1VU749stZtyUJxlk
         5LX2VPJjF4exX+wjsUVo+nlX6iL+JF2U4gQS3Dhacj3SzsTUdODxLri8+csW230FlyNz
         nBDeDBAnrcUs1xi22CUmySeGPCw7vjYyusbSNyb/ssEsvGVshssLqQ8XhkofCWKw1CV8
         W+4aYg+ItaxMzMbpXgSSJ3Cc9YbSrJeQkVKoLJ1NaoakVU2Iy+xkdXtSyivHWejcyALs
         NPdw==
X-Forwarded-Encrypted: i=1; AHgh+Ro1GdB0Z+kkgbU62YxiC4hN/ywNtb1P3ELj04JGmilo49hFqnVaQ79GT6ALfrdCSMMdSqz5wORi4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YyZGDfd503IWn9jx+e8GYCQecwOwVX+7R+5H+IZX/7I83OeRseW
	IQl5eLV48pwVitB8N1nbARpyENoIS8kkhVYbwhsc3iCSZS1AvQSIYxKj
X-Gm-Gg: AfdE7clrE/M6JBuUZpZsXyLjgpH7d1Ah1FpVRss43G1SAdLRtIVXIPxlYxZQUiJcWYw
	rTJehk7Bh3pQIIH1pvp3EziBgsLwVnfKhWpXQG7muDEny8d9gGvyny1WfToZlqfijZ6QBefqlCY
	uVGVAs4svmgnnZGkuzfumW2MUd2lP0+EoylglnE6IcEFeznxluEAUAe1L/vtDzwrQ29TN+1i7dH
	w+QT2yPpmuY6xql9ay1yjVq49YfW8rlwNPG7qOkcRJv9Kaa6SKcgJu++Rg8DOkiMbetJdWd0Qzd
	TYAVv1yu+m7QXc7ane5tgaqpQjN65GoXLYRdmx8/9Id6D1GODTyVbAnuu77upbzw1vm0ttrx9DU
	ztIJnyGMAMKXBD9Gws1wsLmHDob9Yh+ACNgVbALrEgaUoluEX8hgg3D6ig9yR0uR1VJltNmpRWW
	HchYoMaQjDY++0YEziBr02UaOa0WqrG0GfXcrsJf61PeTRHuD4sasnl5QBLiQoypMzzXbw2B0W
X-Received: by 2002:a05:6122:6d19:b0:5c0:fb8d:998b with SMTP id 71dfb90a1353d-5c0fb8d9f40mr2719123e0c.7.1783988668344;
        Mon, 13 Jul 2026 17:24:28 -0700 (PDT)
Received: from sam-fedora (bras-base-mtrlpq0776w-grc-33-70-24-179-211.dsl.bell.ca. [70.24.179.211])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bf6f66eb74sm9916940e0c.7.2026.07.13.17.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 17:24:27 -0700 (PDT)
Date: Mon, 13 Jul 2026 20:24:17 -0400
From: Samuel Kayode <samkay014@gmail.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	"open list:NXP PF1550 PMIC MFD DRIVER" <imx@lists.linux.dev>,
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 28/43] power: supply: pf1550-charger: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <alWBsRvgtGIbFSHb@sam-fedora>
References: <20260709033428.362970-1-panchuang@vivo.com>
 <20260709033428.362970-29-panchuang@vivo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709033428.362970-29-panchuang@vivo.com>

On Thu, Jul 09, 2026 at 11:34:07AM +0800, Pan Chuang wrote:
> The devm_request_threaded_irq() and devm_request_irq() now automatically
> log detailed error messages on failure. This eliminates the need for
> driver-specific dev_err() and dev_err_probe() calls that previously
> printed generic messages.
> 
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---
>  drivers/power/supply/pf1550-charger.c | 3 +--

Reviewed-by: Samuel Kayode <samkay014@gmail.com>

Thanks,
Sam
