Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977534;
	b=cRO9KXFe8SdjEEBi38IqDX/P8cvcIN47SlYQCxv2BHF0cbj96e/dC9EU4OOVpvUrrtE1
	 6+ANv7bp50m++1/r3Ds0NzG37SpFinSnDnQq+UYUyx+bB8+LUrX6asYOKx00NoEMQeD4C
	 CASzi1W5qA4kDOnd+hqJyH6fWtV9yTwUpzUDiXhm5GDN+MiGs+TfbODT2FFoJr0ymYLXR
	 93KBjSp3rNgGMXMAwu4mF3NGWfRt246OVzR3E2kIpYSv7LXKGDb2rSkGAadbR+kF4JKF7
	 JX3/ylxOYIucVQZFr6JLrQBpXnLn392MLHFGTPXkud/adFgaBNu5xTT02Q6wx9XVj3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 Organization:MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=NmWhp1+LyIQqdsl5sDsW2eMq0P/G68XWMqICbb4m5WM=;
	b=ZfWDhV5SmcndVelOikv34JT3Q1MQXs6R8IrRQkZMw7GqdIUzmy/+xKU8Q7Ttu+vYnBzS
	 MWIEecP3er6anLMl2t4MVpv+45sQ+99xnLINbzjRx7W7xhrmvdgUkOusCJgP9jTjXbrE+
	 pwy/qp5nu1wq3//uniYD76Ee/il+Yii+UVSB0mZbKpU5rIGrjgOU+F933+ElFswdxpWsG
	 DAgyCZxMSsJSQVjhtQs1cSNjvTONWgjF4Unh5Gw3WZttuLkp9/snQoz39cJkCBXxm6gUu
	 l3OHeidYh/pId9MOSsJVxtb2zOhQAttsbHsqHMKL2OzrRyF3AduFfRrtQtQ/2nCRZ9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6BxSV4m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BD2606A33A;
	Fri,  6 Nov 2026 15:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k6BxSV4m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5501F0089F;
	Fri,  6 Nov 2026 15:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977533;
	bh=NmWhp1+LyIQqdsl5sDsW2eMq0P/G68XWMqICbb4m5WM=;
	h=From:To:Cc:Subject:Date;
	b=k6BxSV4mTU00+wTVG9VpS61s8A/x6X3gD3WfaJ6UdZn0N2sXg/YiuU6I7dwf/JwSq
	 nRbTZnjsS7DASxT1pot4KuDt07GtSQPX41tlpvlvupxhix4PRO8j+pFKXFT/WlIopb
	 7BnQKpxXsHdv8gmcIYv03YBXUXnIXfa8vYOh9Sr21CsgJ1idEjg+fbPp5L0Cp39nwq
	 kvd67SiawLIZCfSNiY3GaIUWgbsp3tW2W9bTw9qCItOc+NCzW8JYqMB5TS/V3cV21V
	 K0EDk6rq5fFNPj2eLiN+UyV/TRPYVIKyVDb89YnYrz1PQ3u08FmIVWLrrWGReOPoy0
	 LO9BltnKpasEA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Vincent Donnefort <vincent.donnefort@arm.com>
Subject:
 [PATCH v1 0/2] cpufreq: Fix issues related to cached resolved frequency and
 index
Date: Fri, 06 Nov 2026 15:59:05 +0100
Message-ID: <5176274.31r3eYUQgx@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi All,

This series addresses two issues related to the caching of the
resolved frequency and index in __resolve_freq().

The first one is that the cached resolved frequency value should be
the post-resolution one, not the pre-resolution one (which is the
case now).  Patch [1/2] fixes this.

The other issue is that __resolve_freq() is now called in multiple
places, some of which may race with the cached frequency and index
updates in the schedutil governor path and that may cause the cached
values to become invalid.  This is fixed by patch [2/2].

Please see the individual patch changelogs for details.

Thanks!



