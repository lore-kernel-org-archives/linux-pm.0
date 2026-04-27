Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55063385BE;
	Mon, 27 Apr 2026 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777304759; cv=none; b=Z5OGT15qcgY8T/7O9TFdmCZuQtS8VDktR3DnEFvUYPgV7yrTGvK9p8Wr9K2rYCdinuGav0jAtLWSzu5bHwf/wPwU3xxcmdeeTLWYohAiusttG53vx9oH1l7X2+bBlhVmhzQicnujCgP7PMgdxFVRJHJLhwoz8UTze5RE1rwwMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777304759; c=relaxed/simple;
	bh=JD/A6OYaONolnqweLO4io8yQ2GLqYURqGGUObKkTw+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QpWQAiO7Kwy4PHR+pivpMCS+yr2cpSOtt+bTN0xttZgwuRqIluC97T3tK47oULuJKF0Nz5Z0N6qorsT0pkFrWhSL2RB9UogwVwgzCKDIZib0uG1eCtUmEpYVaeJQI9G9YsKfL+7b85MJffrHFWNlX5KnDlMEKFZ+msL33gjGqss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byea2TcV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byea2TcV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17CA2C19425;
	Mon, 27 Apr 2026 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777304759;
	bh=JD/A6OYaONolnqweLO4io8yQ2GLqYURqGGUObKkTw+8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=byea2TcVPd4FuIMiwxfJhydHbmEeM0ALBoXWVya48501cuSo9WBXUZ6ZGmd+hxB05
	 S6hDqZk0Tt4EYcyJAVieFcSYJXMmZDVe24gvF8bgA43mhQjCgczgHBGXkvd9aYBbGr
	 NQeM8UD60fpOy1GNOcDznPo4opSi2rzGpq6nd4o3AfYZmYs9LRA58iXtz9QWmvFZ9W
	 p3EsUxs1CFG0PFxUf+As6aLJyggqqVG8mgiCAVzFMDQ537xP+G2ldDG/CKijMY4FiX
	 HgtLrgN8ec4Ia9IPN71aGZkjr7Ql2jESYS67GSRpp5b6RSB6k52bPFvaHKbqLN8Hnl
	 N42bo9SXSG4cg==
Message-ID: <abfc9469-5d47-4e83-8c3c-03138f1b2ade@kernel.org>
Date: Mon, 27 Apr 2026 17:45:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] HP laptop charge mode control via
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
To: Navon John Lukose <navonjohnlukose@gmail.com>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Sebastian Reichel <sre@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jorge Lopez <jorge.lopez2@hp.com>
References: <20260427140857.397971-1-navonjohnlukose@gmail.com>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260427140857.397971-1-navonjohnlukose@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 27-Apr-26 16:08, Navon John Lukose wrote:
> Hi,
> 
> I have been looking at battery charge control on an HP laptop, and I would like
> to check the right upstream direction before preparing a patch.
> 
> This is not a new userspace ABI. The kernel already has
> POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR, and some existing drivers expose charge
> modes without exposing charge thresholds. I am trying to confirm whether that is
> the right interface for this HP firmware interface, and where the implementation
> should live.
> 
> On this machine, Linux currently exposes no native battery charge thresholds:
> 
>   - no charge_control_start_threshold
>   - no charge_control_end_threshold
> 
> The existing HP kernel drivers also do not expose this feature here:
> 
>   - hp-wmi does not expose battery charge mode control
>   - hp-bioscfg is present, but does not expose Battery Health Manager or related
>     battery threshold attributes on this machine
> 
> However, the firmware exposes working ACPI methods for charge mode control:
> 
>   - \SBCC 0x0000 -> normal charging / auto
>   - \SBCO 0x0500 -> inhibit charge
>   - \SBCO 0x0200 -> force discharge while on AC
> 
> These mappings have been tested from Linux by observing battery and adapter
> state transitions:
> 
>   - auto allows normal charging
>   - inhibit-charge leaves AC online and reports Not charging / zero current
>   - force-discharge makes the battery path discharge while AC is connected
> 
> My current thinking is:
> 
>   - expose only POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
>   - support AUTO, INHIBIT_CHARGE, and FORCE_DISCHARGE
>   - do not synthesize charge_control_*_threshold properties in the kernel
>   - leave policies such as "resume below 75%, stop above 80%" to userspace
> 
> For driver placement, this seems HP-specific rather than generic power-supply
> logic, so I think it should probably live under drivers/platform/x86/hp/ and
> register a power_supply extension on the battery, similar to other platform
> drivers that use power_supply_register_extension() from a battery hook.
> 
> Does that sound like the right direction?
> 
> In particular:
> 
>   1. Is POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR the right ABI for an HP platform that
>      appears to expose only mode-based charging control?

Yes, POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR was initially added for basically
the same settings on Lenovo ThinkPad laptops. Note these options are typically
used to implement battery "fuel-gauge" calibration functionality.

I guess inhibit charge could be used together with a userspace daemon
monitoring charge to implement a charge to 80% threshold. But that would be
a new way to use this API. Note I'm not saying it would be a wrong use,
just a new use.

>   2. Should this be implemented as part of an existing HP driver such as hp-wmi,
>      or as a small new HP-specific driver under drivers/platform/x86/hp/?

Is there a WMI object which will call 

>   - \SBCC 0x0000 -> normal charging / auto
>   - \SBCO 0x0500 -> inhibit charge
>   - \SBCO 0x0200 -> force discharge while on AC

when its control method is called with certain arguments ?  Typically
the answer to this will be yes, in which case you really should go
through that WMI object, so as to support more models where the
method names / args may be different.

>   3. What should the driver gate support on? For example, should this be gated
>      by DMI quirks, HP WMI/BIOS GUID presence, ACPI method presence, or some
>      combination of those?

That is a good question, if you can figure out how to access these methods
through some WMI object then doing so should be safe on any model with
that WMI object.  But firmware bugs do happen, so we may need some
heuristics on top of relying on the WMI object GUID.

Regards,

Hans


