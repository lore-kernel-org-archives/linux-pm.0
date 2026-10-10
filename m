Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA727AC57;
	Sat, 10 Oct 2026 13:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791639619; cv=none; b=PxsBguyh7mXdAD6251gLeJziesoN249yy4DIWblYDlxEs/mX7Ti/Qdugp0iB1iSO+xt7p5f56bQZIxus4gXl0+Lch8UmzXYlkggc8YPnkKog/+Jm8rXknI/RKsXjwnBxl2rjUBWIjOHWpQv+H5xUcxj0pFO7FlL1TKThan1phyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791639619; c=relaxed/simple;
	bh=lsJp2MvV8H1OhJPMQuMPbt3GdpR+wKAf5nyiZ6ILN34=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=KC8nilO4x4RVISmhcrSB8DECotOW9XmvATjQlcDK6n5rPfGFgJnhcuGVI4P+6IilKBClndj6iYVTCavj17dGtesKFe0psHfkV59lelVk/nmhi5OGUUV51I+OVehAGlk1RDn7CXTd64wu3izX0fn3xKsJw6Bo/vkzL6gZ9bAJ3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW+o7Ge2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW+o7Ge2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DA71F000FF;
	Sat, 10 Oct 2026 13:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791639618;
	bh=Io44OKtN8L9s20sxzd0rilXBdNQoIbjjjTAYFAepx/w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MW+o7Ge29PerOGxb14B0X9AefCQ/ejSI8q/f+0jfu/GxHBzlOOkubHRyHnjlYwkQE
	 +Y/3QogWD4tmDUYPi65jf9A86vvCK06LhPX/YH4LP32st9wqjokWuYeFsYCtTCWKIx
	 fPL5LXXPrVIZyq1e4RjOtJZTYhuDGxoB8zLq6PuCfHPYsg8gg+GA24b2yqVVso3D8R
	 6xpPoKtG0P8cPcag1pU/OuzsdRM+14x0FQNUt6CJiHVSnTuSN6WKwdqi2OA/wvY6im
	 oQ4rLgn4OGZNsWng7UvakLZmijI3nSOUjywMOvpFX8dnF2qC5fyk/V7jhi/Ls/sHMp
	 LpwYcWkO7UOJg==
Message-ID: <sashiko-outbox-166588@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PM: QoS: Add a sysfs CPU latency request with a
 boot-time value
Reply-To: sashiko-reviews@lists.linux.dev
To: "Roman Kagan" <rkagan@amazon.de>, "Pavel Machek" <pavel@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, "Len Brown" <lenb@kernel.org>, "Christian Loehle" <christian.loehle@arm.com>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Rafael
 J. Wysocki" <rafael@kernel.org>, "Shuah Khan" <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, nh-open-source@amazon.com, "Mike
 Rapoport" <rppt@kernel.org>, kexec@lists.infradead.org, "Pasha Tatashin" <pasha.tatashin@soleen.com>, "Pratyush
 Yadav" <pratyush@kernel.org>, linux-doc@vger.kernel.org
In-Reply-To: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
References: <20261010-b4-cpuidle-shallow-v2-1-adede7dd9077@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 10 Oct 2026 13:40:16 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] locking: data race on req->node.prio in cpu_latency_qos_update_requ=
est
--

commit d19f16780c138f4d33dfa7e439454d2244724233
Author: Roman Kagan <rkagan@amazon.de>

PM: QoS: Add a sysfs CPU latency request with a boot-time value

This commit adds a CPU latency limit requested by user space for all CPUs,
exposed via a sysfs attribute. It operates similarly to the per-CPU resume
latency request but acts as a single PM QoS request shared by the entire
user space.

Link: https://patch.msgid.link/20261008-b4-cpuidle-shallow-v1-1-c19e71127b1=
4@amazon.de

> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 1944dbeb0d4c9..f381361939079 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c

[ ... ]

> +static ssize_t pm_qos_cpu_latency_us_show(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	s32 value =3D READ_ONCE(cpu_latency_qos_sysfs_req.node.prio);
> +
> +	if (value =3D=3D 0)
> +		return sysfs_emit(buf, "n/a\n");
> +	if (value =3D=3D PM_QOS_CPU_LATENCY_DEFAULT_VALUE)
> +		value =3D 0;
> +
> +	return sysfs_emit(buf, "%d\n", value);
> +}
> +
> +static ssize_t pm_qos_cpu_latency_us_store(struct device *dev,
> +					   struct device_attribute *attr,
> +					   const char *buf, size_t n)
> +{
> +	s32 value;
> +	int ret;
> +
> +	ret =3D cpu_latency_qos_parse(buf, &value);
> +	if (ret)
> +		return ret;
> +
> +	cpu_latency_qos_update_request(&cpu_latency_qos_sysfs_req, value);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Low]
Can concurrent writes to this sysfs attribute trigger a data race?

This calls cpu_latency_qos_update_request() on the globally shared
cpu_latency_qos_sysfs_req object without external locking. Inside
cpu_latency_qos_update_request(), there is a fast-path check:

    if (new_value =3D=3D req->node.prio)
        return;

This performs a plain lockless read of req->node.prio, which concurrently
races with modifications under pm_qos_lock via plist_node_init() in
pm_qos_update_target().

The pm_qos_cpu_latency_us_show() function correctly uses READ_ONCE() for
this field, but the plain read on the update fast-path could cause KCSAN
warnings or undefined behavior if multiple threads write to the sysfs
attribute simultaneously.

> +
> +	return n;
> +}
> +
> +static DEVICE_ATTR_RW(pm_qos_cpu_latency_us);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261010-b4-cpuidle=
-shallow-v2-1-adede7dd9077@amazon.de?part=3D1
