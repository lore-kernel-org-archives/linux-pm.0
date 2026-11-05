Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874432;
	b=bNvzKVOInMJcktSByXzc3Q/fdsoTo5uswPOlfoxnPegUNXaAohUCErN+PzlJmthSN1E4
	 6epYJY75MfTMuZspOozMD6ChnBd2oioVh3w+Japivabs2pwc4WEq/lxAfYrc8JRK61JYB
	 8RllZ3bFIEhFamdOHnhTis6q+RxgVIhc3ciulD0RvPPl6ZiKP8lm/ibwNTnEi8WvEqKFN
	 8K9PGErXiuQMTXIcpnksf78MDRKlsl+oJXFKkVdqldbFSZOQ9ngORzrvZq/CQ0GAjHSmq
	 +T784StO9GLCzvzSVkEefOjXYG8Yvfp1oYnb4jcra3m7fvzeM28jta3eD+QdkSmTvGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874432;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2mA51xaXmuBciRFmWNiBqx1RgwG77VmJ4pTU7nzmmbw=;
	b=z129sMqr8X1W5RX6LAnm3RXtqTHX568tFrramXKIXeKWK62Oy9it19CQyCs9S3vkW6k0
	 gUlDUGOu8N3eC879Jc9Ec5OBNx3pJ7y3Yv5+kn2DTmeXVyitTdkPmjl9mzPTP/fAa2deT
	 6Q8tsHz4BPke8o7c+YaB89sD0oAlRrBDV4SFAdlN7uCSBDzQxyRRd9ZpS+Tk2M/1B/ChZ
	 YH8qmHJOAXI3/GwqrIlLTf398rvGnhBNY5CdCrRuDpdqgLgMi0BnFRgvuBTZuX1UNH/2d
	 QRRhqhc1Q6NvxTy/o3THrH3nWLTkwsU6VRV1n/XOJoIhegxyyBvmLFBEmMHKu/OJ34w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw3Dtt3A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ECE606A326
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 10:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iw3Dtt3A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85171F000C1;
	Thu,  5 Nov 2026 10:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874432;
	bh=2mA51xaXmuBciRFmWNiBqx1RgwG77VmJ4pTU7nzmmbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iw3Dtt3AziW/7H40j7kbxpqS5h4NJ4dfBrACF8jX3MAsmJOuiecu+B0t09NomHTgo
	 SE95bEqSTEbOLdpH63IHzcNTY4ZJxNzKYuwzF14QgvU7GT5s/47MELvofn4iL2XmNs
	 DMLltLzRsPcONFoE3QpN2w3WM3sdm7UVZFE6eqkU75Iq8HtJ4S/uzyt/aY4tANILGL
	 uuaWxvlu/rRakbVzXU2hCtbXcoAx3TffgEjG0lg7az4FxXd1btARDrQJp4m+PkgDdz
	 7g15IeIf1BbbV7Vd/AvqFVXTq3e+GURlacxqy428I59Rcz2RWLGzCX0e+tL6Hb+PxZ
	 7rsih9cCZY4BA==
Date: Thu, 5 Nov 2026 10:27:09 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Kaiqian Zhu <zhukaiqian@xiaomi.com>
Cc: Ulf Hansson <ulfh@kernel.org>, rafael@kernel.org,
	daniel.lezcano@kernel.org, christian.loehle@arm.com,
	linux-pm@vger.kernel.org
Subject: Re: [PING] Re: cpuidle: psci: Fix CPU PM domain state after failed
 runtime
Message-ID: <20261105-logical-ruby-scorpion-29ba7b@sudeepholla>
References: <20261021031709.42644-1-zhukaiqian@xiaomi.com>
 <20261105070658.18211-1-zhukaiqian@xiaomi.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105070658.18211-1-zhukaiqian@xiaomi.com>

On Thu, Nov 05, 2026 at 03:06:31PM +0800, Kaiqian Zhu wrote:

[...]

> Thanks,
> Kaiqian
> #/******?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????? This e-mail and its attachments contain confidential information from XIAOMI, which is intended only for the person or entity whose address is listed above. Any use of the information contained herein in any way (including, but not limited to, total or partial disclosure, reproduction, or dissemination) by persons other than the intended recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender by phone or email immediately and delete it!******/#
> 

Deleted, get rid of these disclaimers to get review/feedback please.

-- 
Regards,
Sudeep
