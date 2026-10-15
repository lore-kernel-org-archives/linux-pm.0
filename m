Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFA52759E
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072074; cv=none; b=Y2Cjo6crNZKLer7uo6Y5IptShEZ5eOzkiVsIjyMEqxX9l0Hic/dA6PJIZ0kl8V8lNBHlfmxQ17/HjenujH2qL8Idph8+waOk0w8Ak7KWT++K2Jwegfr09+2eAgio16FtcKyZF8mtzisf+2oCT9rASBNSWebyuZ3tgy/+IWCRw+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072074; c=relaxed/simple;
	bh=j55zw5viGxZp1pXxSJj+AkBUOD4ghpetwBiAyan2hnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dZGjx9P4XSuWFzzAERPoX5YiaeVSPXStsZ0TYS4Q4AeD5aGRUH398ZcxadKy0Lr8jUv3I/ZLQi6QYmC/uhFyTp9L/sXdq0iODgFmYJAtGlB1gT1ne45hLbYYCuBwiX/VXPapKZLB4uVXGirVZo77jeyIUSha4wvc9JSXI+lvRfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUbuH08q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUbuH08q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72351F000C5
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792072073;
	bh=g0/qpdrfy/Oj2jhQu3d7Pibrb4+olgpm2ZjNSrruXrQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eUbuH08qiYvnc9cxPyONkuoJAtkQS6uILm2e4x6d1oj49SsGu154MK4GTGWhxXSHJ
	 3cxsQhdmtYEzaLwr/2EmYruyEXlyTgZ0zDjxOWWxlJSLVHXT/GlnUCNuk7m49W8Lxs
	 AQnh9JvmJwpWPyVbrcv6QGiYI7ql3Sno+MMdVpzP+Rqe1NEtr3YzkVKTvj5ZFtjalK
	 wTNHZqZd+ZZzxk/skEATbuTZ1+msLxAjcqYFEoX6lLgQxvleU3yfhvrvC1FYO/dqUO
	 s/veGeEciRoH1VpmVJ2t7OFXHh+5GWlL56g20mxsyHGgGgOpz5JtekQ/P4K2FxgVR2
	 3X+2O5tBagVpw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be47159f2bso96105e87.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 06:47:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwOXBLkxOwz7u1pj81SOoUAX319JfwVgv/sVGISzVuGURYxKJFhB6aZc1ji9NkfVl1KGhk9H09kiQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLL5QRupz9keDyTEPBwlEiKj3CDGJqE3HlmKBr1uRQAxMORUTFQ
	/yWCx2K5dXfGjgxLWpqLITwqxoGxCym9Aya/hPZzrt6eWbxFyljdgGxBx8R+qR8vvoaSKZleVfR
	Wf5qxKSkurf4Pl84Rfj2FL+HNze3FzGc=
X-Received: by 2002:a05:6512:3091:b0:5bc:cb78:b884 with SMTP id
 2adb3069b0e04-5bcde8c1270mr5845776e87.41.1792072072088; Thu, 15 Oct 2026
 06:47:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014132703.93355-1-aliamemis@disroot.org> <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
 <20261014150537.121547-1-aliamemis@disroot.org> <08b6196a955faef9968224d7946ea5b1150f2ae3.camel@rong.moe>
 <20261015120902.15337-1-aliamemis@disroot.org>
In-Reply-To: <20261015120902.15337-1-aliamemis@disroot.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 15 Oct 2026 15:45:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hEA_Pna=So-jd77OhaUEO1-Y6bEVFVMJ-bGNeziNj1kw@mail.gmail.com>
X-Gm-Features: AclHuK-LWYktE4aThDeFgwzeVaOyAWCAYG2t8e1kKUTnt2HN-pzsBDgg_CDv3q4
Message-ID: <CAJZ5v0hEA_Pna=So-jd77OhaUEO1-Y6bEVFVMJ-bGNeziNj1kw@mail.gmail.com>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: Rong Zhang <i@rong.moe>, Hans de Goede <johannes.goede@oss.qualcomm.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Charis Stratakis <c.stratakis@proton.me>, linux-acpi@vger.kernel.org, 
	linux-pm@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 2:09=E2=80=AFPM Ali Ahmet Memi=C5=9F <aliamemis@dis=
root.org> wrote:
>
> On Thu, Oct 15, 2026 at 07:51:22PM +0800, Rong Zhang wrote:
> > Thus, any call to ECCC or RDER consumes at least 200ms in emulation, bu=
t
> > in reality it doesn't.
>
> Thanks for finding the actual deadlock!  The 680 ms came from assuming
> "slow" EC commands.
>
> I'll wait a few days for Hans, Rafael or anyone else to comment on
> dropping the EC query and UCSI patches, then send a v2 that merges
> both series.

I would prefer to drop the EC query and UCSI patches for the time
being until it is confirmed that they actually help.
