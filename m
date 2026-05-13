Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9663334A3BC;
	Wed, 13 May 2026 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778638624; cv=none; b=m3NlkQptrDmIw1flwmuxPWFeQ4FwUaKZgMSkHgRcSUJ2A4oyKvqyjuohvuaV/4XhIIQDPQXw6PKrRlzc3TGx5qgXq2XJRB/IhT/7CA5GaeD1osffvwOG9pMnQZ2w+1hPir2FDW3LGyXOtqGFWJ+pWCXKkqblPFhK7IOLU/N+vEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778638624; c=relaxed/simple;
	bh=dkCUu38rWb7JolA3RArVchG6hM4JZsSM3EG+OE1Nw4U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YhptN7hUzm4k4WbI9inBnPL0d3pdUwMSPy1DXfq25Y6theukna2zUozmptq1QEm+BQbdpNel4hU3vHkGZTg+bS6P/AHUbOl9Ht2KsI/ooFiCtL5Cum2JxMgzGHBK5N6X1MOn9YiG/3Xtn/eIT+Csn5XADmkzOGc/WyG097Z228M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABX6QwP3wNqRiodEA--.19635S2;
	Wed, 13 May 2026 10:16:47 +0800 (CST)
From: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>
To: rafael@kernel.org
Cc: ccross@android.com,
	dakr@kernel.org,
	driver-core@lists.linux.dev,
	gregkh@linuxfoundation.org,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	xujiakai24@mails.ucas.ac.cn
Subject: Re: [PATCH] PM: sleep: Use complete() instead of complete_all() in device_pm_sleep_init()
Date: Wed, 13 May 2026 02:16:47 +0000
Message-Id: <20260513021647.487957-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0i0MdJCS-0xeP3gZi30gYV4DMJxPceodRexksMcL=b5PA@mail.gmail.com>
References: <CAJZ5v0i0MdJCS-0xeP3gZi30gYV4DMJxPceodRexksMcL=b5PA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABX6QwP3wNqRiodEA--.19635S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYE7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z2
	80aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	F7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7V
	AKI48JMxAqzxv26xkF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I
	3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxV
	WUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
	AFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZE
	Xa7VU1c4S5UUUUU==
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

> sashiko.dev complains about this one:
> 
> https://sashiko.dev/#/patchset/20260509092707.3426533-1-xujiakai24%40mails.ucas.ac.cn
> 
> and I think that it has a point.
> 
> Before this change, dpm_wait() needs to be updated to skip devices
> with no PM support.

Thanks for your review! I will send a v2 patch later.

Best regards,
Jiakai

