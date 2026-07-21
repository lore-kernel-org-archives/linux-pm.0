Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1BC37647B;
	Tue, 21 Jul 2026 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665588; cv=pass; b=CVfXUJNyHxAF7k3uWP0Pt6tHCIvmCRf766c3gtHzKhU31kXknwcXQARRJW17lceaoTwBZexF8/5S678dKA7hBK0vaCmu26GmdXm8M/kqrKhgsd/qpRvAUyUHNnG4FihXOuHAxRHabMceQ5yZ74itLG8T+V7d57rkqXD5BVKTPLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665588; c=relaxed/simple;
	bh=51h3V2L5ALhUqhUJhVN774OSNZZ2BArP3ob1EWQtuTw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJsa8a9Mgq8yvpCSXDXX8f43JzABmLeeM1z4jFXZ8ZfRdCcf0RxNLUJXyRiaoz+k9QK7CodVnuLplmVlPwoHwfa355QhmB5GgZlmCz1Cg6Bv1Xs4v9FbKRXEVhIDlYJ7XydqzJgzVwTkEcZfpCeB4ui50lc9CaesxVPpl1ywz0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b=WQF4afaQ; arc=pass smtp.client-ip=136.143.188.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nfraprado@collabora.com header.b="WQF4afaQ"
ARC-Seal: i=1; a=rsa-sha256; t=1784665560; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LXDUf5JD8EIMSCkWNDgg8CjecGjgK4sYOeeRUvT+s2IDincOWmjjckpEDuL/Z/8rSCTbeUviaCj8uruki275r/IjmAEdV6uXEdDQHxNjXjWgbPfLyrCiO7mNyoF81iQacj3WijLjCgNrhKgIEqBsM4C4/3AYAKzBQlapCcraRrY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1784665560; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=51h3V2L5ALhUqhUJhVN774OSNZZ2BArP3ob1EWQtuTw=; 
	b=Gvq/4U4SfM4g8xHulsukmFFApv+7sxN+QnvDXEObD3vo9YGGYDiY9YoLMCO8+Cgo0JLPXirbCRLB/8NjvZ09fcZQl/uXKtvKXSdx0q/FW3AOyfemEFlC7xvifkIVnxNmS4wRl9gAEg21GjCcRiaWqTmcDDk9jIDkX3vdxBYiIWM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nfraprado@collabora.com;
	dmarc=pass header.from=<nfraprado@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784665560;
	s=zohomail; d=collabora.com; i=nfraprado@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=51h3V2L5ALhUqhUJhVN774OSNZZ2BArP3ob1EWQtuTw=;
	b=WQF4afaQMxNTp1lLBgd0nMXCr8RL7Nf6O2qiRghcT5AI/YTCbJW8GPgE8uA/Qgd6
	Jn24AazkS26ZPMpbzrCuVz3jmhmTotNAujuRBrq/tKprEW/icRRVkLh81Xg/lSCNW0M
	+3QM/++qW+xes+WMAYkec8Z1YZFUKlB1WoQd0ouo=
Received: by mx.zohomail.com with SMTPS id 1784665558162762.9808565657362;
	Tue, 21 Jul 2026 13:25:58 -0700 (PDT)
Message-ID: <73718a50f53f1ba8963a7ea40516a008d5c1a67c.camel@collabora.com>
Subject: Re: [PATCH RFC] PM: sleep: Return -ECANCELED if aborting due to
 pm_wakeup_pending()
From: =?ISO-8859-1?Q?N=EDcolas?= "F. R. A. Prado" <nfraprado@collabora.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Pavel Machek <pavel@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich	 <dakr@kernel.org>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra	 <peterz@infradead.org>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, 	linux-kernel@vger.kernel.org
Date: Tue, 21 Jul 2026 17:25:53 -0300
In-Reply-To: <20260609-wakeup-pending-ecanceled-v1-1-428d897c07cb@collabora.com>
References: 
	<20260609-wakeup-pending-ecanceled-v1-1-428d897c07cb@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Tue, 2026-06-09 at 08:48 -0400, N=C3=ADcolas F. R. A. Prado wrote:
> If system sleep (suspend or hibernate) has been aborted due to
> pm_wakeup_pending() returning true, return -ECANCELED so userspace
> can
> tell it apart from actual failures.
>=20
> ECANCELED is chosen both because it is a less common error code, so
> it is less likely to be used for purposes other than the sleep abort
> due
> to pending wakeups in this code path, and also because it more
> clearly
> represents that the sleep was intentionally canceled.
>=20
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
> To give more context on my specific use case:
>=20
> I want to address the situation where the system is running systemd's
> suspend-then-hibernate and while going into hibernation, the user
> triggers a wakeup (by pressing the power button). The expectation is
> that the system would abort suspend-then-hibernate and wakeup, but
> instead it considers that as a hibernation failure and falls back to
> suspend instead. The key thing here is that systemd isn't able to
> tell
> that this hibernation failure is not really a failure but an
> intentional
> abort, which is where the consistent error code for
> pm_wakeup_pending()
> can solve the problem.
>=20
> Sending as an RFC as this is changing an ABI and although I'm not
> aware
> of userspace that relies on the current error codes, it would be good
> to
> get more input on this.

Hi,

Any feedback on this RFC?

--=20
Thanks,

N=C3=ADcolas
