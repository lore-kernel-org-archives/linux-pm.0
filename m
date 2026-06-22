Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9F30EF77
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 16:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782146314; cv=none; b=PmRC9ImPLoJIkOwi55bw7YdjvarJNM5mgPEe0LUMEZAQ2DYKTXLEl7hL6YUaSPxEBbvHViGXKet/5GxuAc7pWrn/83WC1PKdyGuqx+kkgKtIyfqy9a+3nyYTbHXR1/GcQ2cBDsa5LjITOHX6pmWvPukz2ZUusew2TI1hy4QvKpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782146314; c=relaxed/simple;
	bh=hPm49NPDVXvL3QRNTU8lBi/G1qwz1rxy8oWzaNETaTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZUHfMPj1W8kh/miPbJlNllBSNji2r1hTV/BFOMO1mKYW1LR1bEgyhLzvpD/jYu0LSx/YyDxHfbd7K9P1KVD01dIAwnYwvDv/J2/qSqQoNfjsiEhqRQrqu5IhqxAEzZkuH2VusZak1DWI4oGAe0oEsQqREnfj0iYgOQ+FnS+ltaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/QBFha/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/QBFha/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA2C1F00A3E
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 16:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782146312;
	bh=LR5tUmzjiXIPbPxcGpPXAFyp4Iwl1bWztTFJ5+nO420=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L/QBFha/NdMgmRKcAzZGy7zM35twTY5krc85+061bLVe5JU58/vUG6gQ2xAMMyVkl
	 rpBb1EUiYj0xcSO5+Firf0IptDKdevurPnBtUGl8nMEcgdAcnfzsXnpfs+TJb4PLX2
	 TusvNVxLnjSuXq9ZZv+cDbHasPHGfjsLFA/9rNTGoCyEPcysa2VL98Ybe32hxlULri
	 Rz9cKKwwYWwUxlgoPzGAcjR6/TwhWNlfHKYoKktn81ZRJyzdoMU0NXVZC474cBq8yQ
	 aH37H3/TFComg948Ek7NacfSpQkD3A9LMRAezfxhWfk8XcanpAjdwINK+cXj/gLIYs
	 OYp1+9arIn04g==
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59c627b53a0so1675134e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 09:38:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9YoQEcp5pSzI6HmqH9KfA98LohPOsC/9X3dkiytBekVBhlpIsc3H7kMu/elwnZXkzvreWQAPBT2Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyyFRmJ/ExjhwM/FbbTIC66Ymdua32Xz39eMg4iIZOtgz51NWUA
	8JZJRt8ACDJyd++QrmCbm1KDFrA/Jxd9gVrjHEOWLEbLoJ9y/X3klyfpLgj2WuNSQGdKaeXBHgW
	XdHyoz6mjk8WRS8P+Rp3HJDtjpT2RziI=
X-Received: by 2002:a05:6122:3a0b:b0:56b:8e1c:582d with SMTP id
 71dfb90a1353d-5bbebc16c78mr6783166e0c.14.1782146311993; Mon, 22 Jun 2026
 09:38:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12920597.O9o76ZdvQC@rafael.j.wysocki> <8ca52415dcb582b821475eb4bd428846b1861054.camel@linux.intel.com>
In-Reply-To: <8ca52415dcb582b821475eb4bd428846b1861054.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 22 Jun 2026 18:38:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hoAUocfF-_veJzOCEmSPHxCrperAJ1JWzUiwfyMvMNBw@mail.gmail.com>
X-Gm-Features: AVVi8Cfp4chAlH0ymh6FMW6frGLFI1UbpHDtj4Mg_kA5ZT79hdi32Z88RmUmL8M
Message-ID: <CAJZ5v0hoAUocfF-_veJzOCEmSPHxCrperAJ1JWzUiwfyMvMNBw@mail.gmail.com>
Subject: Re: [PATCH v1] cpufreq: intel_pstate: Skip HWP_CAP reads in Broadwell mode
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Chen Yu <yu.c.chen@intel.com>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 11:39=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2026-06-19 at 21:24 +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > When running in the Broadwell HWP mode, the turbo, max and min
> > P-state values are retrieved from MSR_PLATFORM_INFO, so reading
> > MSR_HWP_CAPABILITIES in that mode in order to update those values
> > is pointless.  Moreover, using the MSR_HWP_CAPABILITIES value for
> > updating them in the Broadwell mode may be harmful, so avoid doing
> > that altogether.
> >
> > Fixes: de5bcf404ace ("cpufreq: intel_pstate: Clean up frequency
> > computations")
>
>
> Can't apply this patch on the latest Linux master even after applying
> prior 6 patches.
> What is this based on?

It should apply to

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/=
?id=3D5504ce0317f777dcf102751c3e518284226fc2e1

but let me double check.

In any case, there will be a v2 due to the feedback from Yu.
