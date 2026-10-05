Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A683793B0
	for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2026 07:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791184597; cv=none; b=k8Ip7wxgplmZyrsR3man2cWf5728/BS+RcxHhRA5+/v/gal3bxrVrOgynfM3/bMZFqMbM1i1LhfiDjWldtNtCfBrXmGP9z5J0vUJ/5N4AvB1jfDocad5vICb5TQocJoCIWN7IZ2JIbget6zs0lpnU0mduVawgOPwP19YQ5F4yec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791184597; c=relaxed/simple;
	bh=n7h0h5dgydDrckQxnYSgZT643NfrxWR9J0Nqx+oJG2k=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=I/7LY1enRpajzAbgMTMbUjcWhSv/RZZoLGTM5pxbmMMEBuSF83x7FStvwI0WUsmhqJlNKnTObIJaKbvZ+F82VnX4nDk4t3xzsILJnfU0i+4MRB4l4AOwuFhUnRpS8Ey4N4qXu36xdNDeb4Xk+9k2X6ikp9JmSTWQ1QBLb1JNCRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nbv59oQA; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nbv59oQA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791184584; x=1791443784;
	bh=dYyoCQF9ZFCDAjguiwLOlgOAnH0U0ZP897fumGJYSU8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nbv59oQApB+pHL8C40LNWBcgzX5kbp/mH5TJIeytY7bar43ooE59snhSxpQ3rdbe3
	 jpV+VG3dLHP+JzEKRGeYg4DN7UBdID6k7t6kL8CFCZfmPzmyMb0LzLNBaFTXR/FBRh
	 1Ny+dhyzS6mvRJbbUEdIp/0lsnSgv+lqRm+xRd00KpjGOyBKJEC3ysE64QvaQj7t+n
	 1QlHcfgPSbaCYXtHQ0SJOT1y7a/frlSvyM92FDoHFyTDqYrENaa2tLfFEXz8W4RnJN
	 HkErZjCbBHFHb/29J/9k66o3E8SXeTf9/WLmleU10N2qAwsGM90qR0zByy+gHHV9R4
	 D5ThwKKyEirsg==
Date: Mon, 05 Oct 2026 07:16:16 +0000
To: Sandor Nagy <sannnagy@icloud.com>
From: Scrimas <isma.ph@proton.me>
Cc: Scrimas <isma.ph@proton.me>, linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org, rafael@kernel.org, srinivas.pandruvada@linux.intel.com, rui.zhang@intel.com
Subject: Re: [BUG] Lunar Lake: 400 MHz after s2idle; PL1 Tau affects reproduction and recovery
Message-ID: <20261005071610.885801-1-isma.ph@proton.me>
Feedback-ID: 150170229:user:proton
X-Pm-Message-ID: 68f8f8da99dd1eb7ec41204eccfd8713f24f2453
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, 7 Sep 2026 12:00:37 -0400, Sandor Nagy wrote:
> My ThinkPad X1 Carbon Gen 13 intermittently resumes from long s2idle
> suspends with all eight CPUs stuck around 400 MHz.

Same symptom here on a different OEM and a different SKU, so this does
not look Lenovo-specific:

  Samsung Galaxy Book5 Pro 360 (NP960QHA)
  Intel Core Ultra 7 256V (Lunar Lake), BIOS P17ALY.390.260616.03
  Kernel 7.2.9 (CachyOS), intel_pstate active, HWP, s2idle only
  platform_profile=3Dperformance, EPP=3Dperformance, on battery
  PL1 34 W (MSR and MMIO), Tau 27983872 us (same value as your X1C13)
  thermald not running

I log 60 s of turbostat and the xe GT throttle reasons after every
resume. Over 2026-10-02..05: 13 resumes after sleeps of 1.5 h or less
had no 400 MHz samples at all. The one resume after an 8.9 h s2idle
had all cores at 400 MHz for the first ~9 s of the log (the log
starts ~1 s after "PM: suspend exit"):

  Busy%  Bzy_MHz  PkgTmp  GFXMHz  PkgWatt
  16.37   400     25      400     2.38
  73.94   400     26      400     3.23
  49.75   400     27      400     2.87
  ...    (6 more samples at 400 MHz, 2.8-3.2 W)
  40.94   480     28      400     3.04
  37.83  3557     39      400    10.57

During exactly those seconds, gt0/freq0/throttle/reasons reported
"pl1", then "none". So the package was being power-limited while
drawing ~3 W against a 34 W PL1, at 25-28 C. That matches your
energy-averaging hypothesis.

Ruled out on this machine:
- ACPI _PPC: booted with processor.ignore_ppc=3D1, and scaling_max_freq
  stayed at 4.7 GHz during the episode.
- Thermal: package_throttle_count did not change during the window.

I have not captured MSR 0x19C bits 10-11 yet.

Thanks,
Scrimas

