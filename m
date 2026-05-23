Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF47C1E5B88;
	Sat, 23 May 2026 01:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779501129; cv=none; b=XN38NWzSGaHFwZJ+EFDwZh3eOAmGwZ3I5moo43fS80uEtq7hTkJE82SznSHlP4GVL+891ZAgoNLxX4Q04jU0dS+8HZzK6Lq0ZBkh2prsZr3RK/+Tg6WKydkYoCQXiew7q5gv0TFhtbsIlDsHDwVdtzDY84F+pume25w/YyGKHBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779501129; c=relaxed/simple;
	bh=3hyI92Pq2/82Z+X1uonWcCEaU7tZBpUhCaDx3Zyp31M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/FxDYztCfAPGOu7onV3xhX1jugXxNBi5+NOVs0UElbQo11VpNz8+M6PqjzJ/XVKQA5I4BGz4VbAzsqgPONLh+dheOGP8jZogduI8Xy3ZqTRUAkaIzQYVgQCPTomatjxsTFniMO5FdOi/SRa7qUXvMVligi4va2p08xGqqBM1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn; spf=pass smtp.mailfrom=mails.ucas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mails.ucas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.ucas.ac.cn
Received: from fric.. (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowADX38Y+CBFqR08AEg--.16056S2;
	Sat, 23 May 2026 09:51:59 +0800 (CST)
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
Subject: Re: [PATCH v2] PM: sleep: Use complete() in device_pm_sleep_init() and skip no_pm devices in dpm_wait()
Date: Sat, 23 May 2026 01:51:58 +0000
Message-Id: <20260523015158.2466001-1-xujiakai24@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJZ5v0j9fFR7Et-p76jm8C-PGjQ3b+CZFqi_Ch2ixZDB0dEFtQ@mail.gmail.com>
References: <CAJZ5v0j9fFR7Et-p76jm8C-PGjQ3b+CZFqi_Ch2ixZDB0dEFtQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowADX38Y+CBFqR08AEg--.16056S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87
	Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwAC
	jI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IYc2Ij64
	vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x
	0JUQZ23UUUUU=
X-CM-SenderInfo: 50xmxthndljko6pdxz3voxutnvoduhdfq/

> Please see the sashiko.dev feedback on this:
> 
> https://sashiko.dev/#/patchset/20260513021509.483108-1-xujiakai24%40mails.ucas.ac.cn
> 
> AFAICS, it has a point in the first comment (not so much in the second one).

Thank you for the review and for pointing out the sashiko.dev feedback.

I will send a v3 with the corrected commit message shortly.

Best regards,
Jiakai

