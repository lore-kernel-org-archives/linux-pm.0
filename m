Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900C43ADBA2
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 12:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792412511; cv=none; b=rCitgcoSXRejuNHrU4+sJXt1gIuo+leFyrnCRKiJWY1IqqKcnP2e2CyF4yhkeZyonDB5BNeKO6JjZ68jKHQ8L9d65QHCRPAZt38pdOJ/+q/5gZwQoXyGEpa08GqMQ+UWntFInINWyVmHgA9IxDGJXZ2uwg6dgRBkHD/9GRKUDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792412511; c=relaxed/simple;
	bh=EuezTHb/fLuDXt+dlX+AWXGQlXbedyyCyOKOUZxl9AU=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=NBicH2Kn1o13Px/wE6zEVA+T2EgyIaLrNXqOlm/AipWbv+qWUGpbiGV4BMqhRBdtsUjEg40O+HyHlD4nZW9sabrsrLJ2xz0DwwDaZ8wT7tLlGKTRLXUPYLYpsmnXpKuyV+XNINej9G5S7iSqxB/Z996wxOoLCsbXy1Efxt7wflc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=NJO62aLU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X27MOJKN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="NJO62aLU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X27MOJKN"
Received: from stl-compute-01.internal (stl-compute-01.internal [10.204.2.61])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E14677A00D7
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 08:21:48 -0400 (EDT)
Received: from stl-imap-13 ([10.204.2.104])
  by stl-compute-01.internal (MEProxy); Mon, 19 Oct 2026 08:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792412508;
	 x=1792498908; bh=EuezTHb/fLuDXt+dlX+AWXGQlXbedyyCyOKOUZxl9AU=; b=
	NJO62aLUv39aCKnPUwwUkMAwIZQkNReFmPkk3hS+zKjSvZOVRU7dKJgcEmvCQk5m
	1nq2JUKgaYiDYKEQMi0QgfkXmvrQ21mTZmhS6uFCH0+lmIz7AGfFxc6/OzSex8Iw
	9E1XXHzvpP88wmjOZd97YbimwOI8oMR6qE9ZekKkXsNG3G37nE63ywpsQIX4idtp
	dBvodzZOacaeYnwzPF2YNLyIOfEG68MYf1oVhfDbgNNxL6RB92icTbIjhA29ON+3
	bFiMGZet6oVaHdUXi7Nb1mp8L2eT8WyNAFEbTffnRkrdsh0RqTAqoHdnPDhEGYOX
	k88W2qMUZx3xwnJfpfn0og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792412508; x=
	1792498908; bh=EuezTHb/fLuDXt+dlX+AWXGQlXbedyyCyOKOUZxl9AU=; b=X
	27MOJKNA/rQq8wGPKIqyJR/QsGc3GiZQxra46TbbnBC8iKTqTLT3MvvfH+gVjpPl
	FDKP2bDavW6I+mEx7FRUJCHqxkJ6afvtoouZ4Y4C6Z3GQuMlxxxdjYU5jUkJsRaM
	cC81JxE/VKzsAhOs7mvGX4xWaGLb0vpQ5HfsCEko/+e89iBNAY0gJ7G8vM6xZucH
	M4GgfQl00EkrKevnPXePjHigoCXXcIEDaTErzdNjzsaCeiDbT2I6CGYxprwBT50u
	Y8MVtY1rmIahZd/d8FofqhzU2hNzkvFghd16MghQtAuqR+bA+fFXELCjwiKGy/3T
	ULg+wD4N1TwIbfPmPoJTA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=lyndeno.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792412508; d=lyndeno.ca;
	mf=PGxzYW5jaGVAbHluZGVuby5jYT4=;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm1:rsa-sha256:B1kUtlaD2S2FrZi+7II/VdK7wuYupiK3FiMYssdGEI3/Kiw
	ZrRaQ4dWR2xXudce3wK836jtTe5SO6we11OE71RNcC8NHKtgaSJCHK2o9ikL1/CB
	U1oBiZQyFlWaYPN2v20SKeNNzuWDnlG+tzuzImkzIzt827pRcMerlKA9bllCICAv
	DdnOdawWlKR+MxXK9OUzwupiKOROX/b+XNrwzq0HQjmbGO4e+/fyYSq/T2cxTMKo
	8datyLUMIVGvPqGIr1gzlHkGk2VbxGyRLKyE77hLxWY2Mu1v/XigcT6bbNHgkTHD
	YR0ftwUw6l2cqYnB41c7/hFWdeeZ9tQBGhAqqYw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:W7vikNgX5faAmV6jrWk9+BYj8bfrtgwq7qCewo0+QYE=:EuezTHb/fLuDXt+dlX+AWXGQlXbedyyCyOKOUZxl9AU=;
X-ME-Sender: <xms:XAvWaiQVudugeT5-p2I9NMLR9B7eJx5uFVe0rjEMflOIiJhiy07gfw>
    <xme:XAvWaiksi2d5Xzy6spFd0j9Y-TOLrI8QLwW5PmUEyWS3EJRVP_6RoWNOLq9Hlwssn
    VJZpH5WRxV1NTSjfFirnQWp78VA-SS14J_u4r6MJ-EH7g813-wfn8GH>
X-ME-Proxy-Cause: dmFkZTFrqgzUfBqSiwFG4oYJknaKDBF3ZDk1iCX9Scqi/RsIaAoSKGxnm6sbu8oXl5wNKi
    fxPXLXQvqQhng4qUxrrrf14+TXnYnlRkXdaVVV9rURwCRNHHvF7mYtvlcMJa0xV2MtLJcQ
    E16PRPYyRsReUlA/46/TXuQPCjwmRjHqLSoYNzxKX9kXcVjTczVK14zC8uKimpCLR46xJI
    k3o2T6+JNdtJbIcd5FHwcunqG6ppRD0tGr0DnXdIO+uBHSqKxmREnvJTUXUYIxlUdhyotO
    v/GT6VLd10nXvN3KZlN78tgEJWIT0Z5qm+RCsUNSMh6//WEik6xZGdCXHyXqwewuzEeBSS
    0kEvAqgpRH04E6j97fWMg2oed2/IsRIkgETY5eW2lDlj5hhHHBRy+zG84JdAilSTcA7VPY
    Ea3HAQR1EPQ952QZDig/t2x//+NFgxyBsXyQnD/pNlxxTFoCBD8swU6OeKmLZqsQW0WmNm
    stdPPny4i0t2BU2i2mas+0wosUNnA5j1C1LNRW0eAgarpjCbQSOe8UMgM86YIKLJ9LcKcB
    sAfgxyMwHsMbIZnrUf776F5f32plLKyUzr+Ju5l6gI6cqk/0sbWEBSCkCFHPVq4Y+PNaTk
    cZWPmrRxEHwDHMt8lVPOcAi1TjRn3k7kEIV9Fs8vC9QMNHNwMksBnDjVjldw
X-ME-Proxy: <xmx:XAvWatz8ggLndlU5qEmS6fXdyulr4SmV3ucZcyo52zVx6hl7Iei-Zw>
    <xmx:XAvWagVTONTiTIyiiCzvZJ2faqqUOB6R7DpXrtsxPDkph3LCras89Q>
    <xmx:XAvWah-vSzEzsP3WV9bNw2WmC5Mjf4aOhZ7dWzDQKt-fRjB1gciPMQ>
    <xmx:XAvWarvhJSj3ltskyZqKglD5HLfC4__ihhdQtr1iB20kztc20RqvnQ>
    <xmx:XAvWas5rrAy1aGF2ANLMRg_tNbPoN8D6sY4i-Ryk35SBIC7orunTpBjm>
Feedback-ID: i1769461a:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id 40F4BF6007F; Mon, 19 Oct 2026 08:21:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 08:21:47 -0400
Message-Id: <DM8T7ELISJJB.2MKMPBE1BELFC@lyndeno.ca>
From: "Lyndon Sanche" <lsanche@lyndeno.ca>
To: "verazimmerman1987" <verazimmerman1987@proton.me>,
 "srinivas.pandruvada@linux.intel.com"
 <srinivas.pandruvada@linux.intel.com>, "rafael@kernel.org"
 <rafael@kernel.org>
Cc: "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>,
 "rui.zhang@intel.com" <rui.zhang@intel.com>, "superm1@kernel.org"
 <superm1@kernel.org>, "linux-pm@vger.kernel.org"
 <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org"
 <linux-acpi@vger.kernel.org>, "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>
Subject: Re: platform_profile: power-saver lost on Panther Lake when SoC
 Power Slider and dell-pc are both bound (low-power vs quiet)
X-Mailer: aerc 0.21.0
References: <UPfoGdnS1R04q8uekSMTyes9PbDuvsGeBE42zHmsjD2xIdfPYx7ejdcpZhrxWFq6uwoMvClHTuHbrwaCh3yxD0Rw7OarNABC4dZsDra44mk=@proton.me>
In-Reply-To: <UPfoGdnS1R04q8uekSMTyes9PbDuvsGeBE42zHmsjD2xIdfPYx7ejdcpZhrxWFq6uwoMvClHTuHbrwaCh3yxD0Rw7OarNABC4dZsDra44mk=@proton.me>

Hello, thank you for reporting this.

To me there are a number of ways we could handle this.

On Fri Oct 16, 2026 at 1:10 PM EDT, verazimmerman1987 wrote:
> This looks like the same class of problem as amd-pmf + asus-wmi,
> which was solved by adding "quiet" as a hidden choice in amd-pmf
> (commit 44e94fece517, "platform/x86/amd: pmf: Add 'quiet' to hidden
> choices"). Would a similar hidden "quiet" (and perhaps "cool") choice
> for the Intel SoC Power Slider, mapped to its low-power setting, be
> acceptable? I'm happy to test patches.

This certainly would fix the immediate issue: platform_profile providing
consistent choices across handlers to allow selecting a range of
profiles exposed by the system. I feel like there is a better way to
handle this besides adding hidden profiles.

What if platform_profile itself was changed to separate the user/system
choice: the "desired" profile, from the "actual" profile(s)? In this
scenario, different drivers expose different possible profiles, the
system tries to apply the closest possible profile per-driver to the
user's choice. The possible profiles would have an index to indicate
where on a linear scale it lays. If I request quiet (2), but the Intel
SoC slider only implements power-saver (3), the system chooses 3 for
that driver.

I am only thinking out loud and would find comments on this to be
useful. I realize the behaviour of some profiles do not exactly fall on
a linear scale so this would need consideration as well.

Thanks,

Lyndon
