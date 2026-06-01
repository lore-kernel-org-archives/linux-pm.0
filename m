Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EF8371D08;
	Mon,  1 Jun 2026 12:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318737; cv=none; b=dPvrUA6sbCfIDrn5A3F7Kci0PkSZNmYGyEIBapHZKIZT8c/5sx1EAAuV5C+JeoWyhpvACsYg43t2BpyZ3UjEtON+Fm1eqahLqZEnk8M8pGXqYsDs+U6s7iehEUees+gdeT+smHDbp3Ko2Z7FH+lBIUSZb8j5dz/D75zH1oI9zO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318737; c=relaxed/simple;
	bh=7tc4mECndYmDCk5y7K2VvuoTE9svoORXgKqE7WsKhfw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cs2GBmm6QTNaVMIga7Ud7xXXEHDPlgOLSBpiZwa15DRiGWqrXUCys1m90/iC/RCqEsURY1BJpsa5RujgunGbsJutocHGNZZVHG//uxgCEjwgf4uaRTp0A/b7J5nFyv/gkF9fLmepcA5YF3DyA6jpXdwBwRI9cGvta1J0yDPro2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IC5+y1mI; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IC5+y1mI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780318736; x=1811854736;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7tc4mECndYmDCk5y7K2VvuoTE9svoORXgKqE7WsKhfw=;
  b=IC5+y1mI2iS82uo9PCPBWYwp9le1PPPiMhXoLKwj6ZLMLZGfc+PF29hN
   Yuwy+CRIK8HfQW+BFaNxAgTaNHAb15zoKQHM7Z8ACUoKGwfi82pHtzr/s
   8/NV/j5KOKjr+6wkcNUDT3BdbOcN880votz4N2fhPqfE4qtel6ZjkK+2e
   ETnNvBZLGEK/pv1KJWD1CTBKw3jt2U5ueOKMCAzIJ41VK3rjqTu56BzHn
   migMljLtWa1FXQf+r5VPzg14q5s2eX0U+lI2JV9bvVj7zyig4LSDzccfl
   6CGuerXVDobTJQHngFEFFPAmby5lHpFYOPYKuKoye5s1cDdcSbbNsZp9y
   Q==;
X-CSE-ConnectionGUID: QHM5+Y+vTReTKmFJnsz9ZQ==
X-CSE-MsgGUID: 7JB9Xj2mQVSXwDuD484IdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="80806145"
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="80806145"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:58:53 -0700
X-CSE-ConnectionGUID: Ml1XyBh6RRuFrdzbEEvhpg==
X-CSE-MsgGUID: GnS2Io1OSIy9W1QY8nuhwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,181,1774335600"; 
   d="scan'208";a="242523604"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO [10.245.245.110]) ([10.245.245.110])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 05:58:50 -0700
Message-ID: <78ebe71f-85a8-4675-aa0e-6011353dee39@linux.intel.com>
Date: Mon, 1 Jun 2026 15:58:47 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: USB-audio isochronous Missed Service Errors on AMD Zen5 client
 (Fire Range) -- Data Fabric idle C-state? No OS-level knob found
To: Gordon Chen <chengordon326@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Mathias Nyman <mathias.nyman@intel.com>
Cc: linux-usb@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <18b4e4f7089aa4f1.da8dbe994ae3bb77.445e21b98b0b205b@GordonMsi>
Content-Language: en-US
From: Mathias Nyman <mathias.nyman@linux.intel.com>
In-Reply-To: <18b4e4f7089aa4f1.da8dbe994ae3bb77.445e21b98b0b205b@GordonMsi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/1/26 10:38, Gordon Chen wrote:
> Hi Mario, Shyam, Mathias,
> 
> I'm reporting what looks like an interaction between AMD client SoC idle
> power management (Data Fabric / SOCCLK) and low-latency isochronous USB
> DMA, on a Ryzen 9 9955HX3D (Fire Range, Zen5) laptop. It reproduces on any
> AMD Zen4/5 client I or others have tried, with any USB audio interface;
> there is an open community bug with several different-vendor devices [1].
> 
> I have a strong differential pointing below the OS, but no way to read DF
> C-state residency on this platform to confirm -- hence this mail. Questions
> are at the end.
> 
> Symptom
> -------
> USB audio playback has frequent audible clicks, and after ~10-30 min of
> continuous playback an occasional full stall. Each click maps 1:1 (time-
> aligned) to a short isochronous OUT URB; at the packet level these are
> iso_frame_desc[i].status = -EXDEV (COMP_MISSED_SERVICE_ERROR) -- the xHCI
> controller missed servicing a 125 us microframe. urb->error_count stays 0
> and nothing reaches dmesg; you have to look at per-packet status or count
> short OUT URBs. The stall is the same fault at its extreme: on an implicit-
> feedback device, a whole errored capture URB starves the OUT ring until
> re-plug.
> 
> What I tried (all ineffective except the last)
> ----------------------------------------------
>    cpu_dma_latency = 0 (PM QoS, verified locked)        no change
>    cpuidle: all C-states disabled                       no change
>    cpufreq governor = performance                       no change
>    amdgpu power_dpm_force_performance_level = high       no change
>    stress-ng --cpu 16 (pure compute, little mem traffic) no change
>    stress-ng --stream  (sustained memory bandwidth)     misses -> 0
> 
> So CPU residency/frequency is not the lever; sustained memory-controller
> traffic is. Reading SoC clock DPM (amdgpu pp_dpm_socclk / pp_dpm_mclk):
> idle and under --cpu it sits at socclk 400 MHz / mclk 1600 MHz; under
> --stream it jumps to socclk 1200 / mclk 2800.
> 
> This points away from clock frequency as the lever: a single --stream
> worker already pins socclk=1200 / mclk=2800, yet the misses persist; it
> takes several workers of continuous traffic before they drop to zero. So
> what tracks the fix is not the clock the SoC reaches, but the amount of
> sustained memory-controller traffic. My working hypothesis is that the
> Data Fabric idles into a low-power state between the sparse isochronous
> transactions, and that the wake/traversal latency on the next microframe
> can then exceed the 125 us deadline -- with only traffic dense enough to
> keep the fabric out of that state avoiding it. I cannot confirm that from
> the OS (I have no way to read DF C-state residency here), so I would
> welcome a sanity check on the mechanism; the measurements above are what
> I am confident of.
> 
> I could not reach this from the OS: profile_peak / force=high do not raise
> socclk (ignored for an otherwise-idle iGPU), and a manual pp_dpm_socclk /
> pp_dpm_mclk write is rejected with -EINVAL. The BIOS on this laptop exposes
> no "DF C-States" / "Power Supply Idle Control" option.
> 
> Reproducer
> ----------
> Any AMD Zen4/5 client + any USB audio interface, playing continuously:
> 
>    # count short OUT URBs (= missed-service events); nominal is the device's
>    # full OUT packet size (768 bytes for the Flow 8 at 48 kHz / 4 ch)
>    bpftrace -e 'kprobe:snd_complete_urb {
>      $u = (struct urb *)arg0;
>      if ((($u->pipe >> 7) & 1) == 0 && $u->actual_length < 768) { @miss++; }
>    }'
> 
>    # while watching: cat /sys/class/drm/cardN/device/pp_dpm_socclk
>    # baseline:           misses > 0,  socclk pinned at 400 MHz
>    # with stress-ng --stream 4 running:  misses 0,  socclk 1200 MHz
> 
> Questions
> ---------
>   1. Is this a known interaction between DF idle power state (DF C-states /
>      SOCCLK gating) and latency-sensitive isochronous DMA on client SoCs --
>      an erratum or documented behaviour?
> 
>   2. Is there a supported way to hold the Data Fabric out of its deep idle
>      state (or set a fabric-active floor) while a latency-sensitive iso USB
>      endpoint is streaming -- a kernel interface (amd_pmc / amd_node?), or a
>      firmware/PMFW setting -- short of burning memory bandwidth?

If xHCI supports Latency Tolerance Messaging Capability (LTC) bit in the
HCCPARAMS1 register then it should be capable of accepting latency tolerance
messages from USB3 devices, keep track of the shortest tolerated value, and
send it forward to the fabric (if PCIe then it should use PCIe LTR messages)
xHCI driver does not take part in this.
see xHCI specs 4.13.6

LTC capability in xHCI also supports driver adding custom Latency values that
the xHC hardware should take into account when calculating shortest tolerated
latency.
xhci driver does not (yet) support this, but could be worth hacking some PoC
code together to see if this works.
   
HCCPARAMS register can be read via debugs from:
debug/usb/xhci/<address>/reg-cap

Thanks
Mathias


