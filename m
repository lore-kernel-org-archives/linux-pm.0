Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2602A38B150;
	Tue, 21 Jul 2026 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784642723; cv=none; b=uzHnLER3PMA24qCqF0rhOhKIdj+Kckb6Xb2Z9CCkNiNvvFolfjv+WbxGS9P5U/y+3JS9nmVva8WEyBXiY76bNlGdDLZ8ZGG/k1Q062+0D0vCZup3hILfnFI/hz9xzxW98xDlhgtZiCBRKuixJwTxR+rE8j61dty+l3IVMo8uFGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784642723; c=relaxed/simple;
	bh=q4K5gcXU5klye82gxHcjUi2gsyTVSgkJ2NW3fIBt/Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q9pq51lMGFk6fXfURC+OB7NTR/dOpcEcnyoYoDBxZh62J6vh2J+env1pAcLqmA+xQN2PvdiDjCCSuFpEaAfQFaB3kPNSsU8NBCyMEyiyEpLVu0DFtuXNeu59HNpa4nhWcAT7ci1MczwZsxaCmPL7t0A/N4V4gra6P4Ig7DjEfb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uy8XuX7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uy8XuX7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6419C1F00A3E;
	Tue, 21 Jul 2026 14:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784642720;
	bh=PehfNGx1mNxRgN9BHnDwgkSZMR8L+TVhpX7WdRj9MNU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uy8XuX7yCRMYpQkrkEnTlTFFoP05gHXxaeW26pKb9iOdD8MHSVa8D5G4ByzfZsfM6
	 9AJbqCjygcqJgnZWZUNBbq+ruf5IVeYvApX3lidZePsL6Kk/xvju2mNehb6S6sIvWt
	 qV1d5x2+uhtW/FNtzmK6ta855Emy1iqIpzdz4pwANMPK5VvI73kjGg9XR+Q7byMuw2
	 DchREMsKibVBYYNuh9lFI2d4XpyDayyuifEBmWwaY3dyyQs3LlH3v1XPo0KYVU8vRa
	 uUdhoi2eqinCrWXrBEcmfT6K7hRFWdyVqckoCDncK1hXVDzqmEqmyesIVaZAdyIr+D
	 lXwKKWGrPnzgA==
Date: Tue, 21 Jul 2026 15:05:16 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Disallow disabling boot CPU based on config
Message-ID: <20260721-towering-orchid-foxhound-d804bc@sudeepholla>
References: <20260703-disable_boot_cpu_offline-v2-1-782d16ff58c3@oss.qualcomm.com>
 <20260703-competent-adaptable-coot-f8daaf@sudeepholla>
 <4b7fe7e6-2531-4d26-9085-43f40a2ce2e0@oss.qualcomm.com>
 <20260706-practical-inchworm-of-experience-d4e0ed@sudeepholla>
 <05081037-9ed8-4e0d-8480-cfa45e950727@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <05081037-9ed8-4e0d-8480-cfa45e950727@oss.qualcomm.com>

On Tue, Jul 21, 2026 at 02:58:49PM +0530, Sneh Mankad wrote:
> 
> 
> On 06-Jul-26 2:46 PM, Sudeep Holla wrote:
> > On Sat, Jul 04, 2026 at 08:43:39AM +0200, Daniel Lezcano wrote:
> >>
> >> Hi Sudeep,
> >>
> >> Le 03/07/2026 à 17:51, Sudeep Holla a écrit :
> >>> (It is always good to cc all PSCI maintainer for any ARM64 CPU
> >>> hotpug/suspend related changes)
> >>>
> >>> On Fri, Jul 03, 2026 at 04:50:02PM +0530, Sneh Mankad wrote:
> >>>> The Qualcomm SoCs like LeMans, Monaco support suspend to ram which leads
> >>>> the SoC to ACPI S3 similar state where SoC is turned off and DDR is
> >>>> retained. The hardware design on these SoCs forces a constraint to suspend
> >>>> and resume the system on boot CPU / CPU0.
> >>>>
> >>> And you fail to explain why they have that constraint.
> >>>
> > 
> > I still need the above to understand the issue/constraint better.
> 
> Above mentioned SoCs have boot CPU fixed to CPU0 in HW, whenever SoC boots
> up/cold boots it starts with CPU0.
> 
> These SoCs support suspend to ram which leads to ACPI S3 similar state
> (where SoC is turned off and DDR is retained).
> PSCI SYSTEM_SUSPEND typically will be executed on boot core itself unless it
> is already offlined and non boot CPUs gets offlined using PSCI CPU_OFF.
> 
> As HW constraint always makes the SoC to boot with boot CPU, consider a
> scenario, where
> 
> Boot CPU is already disabled / offline => suspend to ram is triggered => SoC
> enters ACPI S3 similar state (only DDR is retained and rest of the SoC is
> off).
> <So far good>

Not really, see below ...

> 
> External wake up arrives (say power key press) => SoC starts booting with
> CPU0 => CPU0 becomes first one to "land" in kernel now.
> 

Ideally the firmware could have handled it by booting/waking the suspended
CPU and turning itself off even if it is some h/w limitation to ensure
the firmware is PSCI spec compliant.

> Kernel may later bring up other non-boot CPUs via PSCI CPU_ON calls.
> However Kernel had already marked CPU0 as disabled/ offline but same ended
> up in kernel without PSCI CPU_ON call.
> 

... You resumed back on a wrong CPU.


> To prevent this inconsistent state, before starting suspend to ram, need to
> make sure CPU0 is always online from kernel/ disable offlining of the boot CPU.
> 

At least not in the way this patch does. Kconfig is not an option. Why is
the firmware not handling it properly ? Just resuming random CPU into the
kernel is firmware bug which either needs to be handled as f/w errata
or good if the firmware can be fixed.

> Although the HW constraint needs boot CPU to be online only when suspend to
> ram is triggered, current patch disallows disabling it for simplicity.
> 

That's very strange, so it sounds like not a real h/w constrain to make CPU0
as non-hotpluggable. PSCI CPU_SUSPEND resume path must handle wake up on
wrong CPU correctly and land/resume on the correct CPU in the kernel.

> > 
> >>> Is it because some secure context is not allowed to migrate ?
> >>>
> >>> We already have a mechanism for that in place and this hack is not at all
> >>> required.
> >> Do you mean a mechanism for the secure context or for preventing CPU0 ?
> >>
> > 
> > I meant constraint based on secure context.
> > 
> 
> This is not because secure context not allowed to migrate but above
> mentioned HW constraints.
> 

Sure not secure context related but a HW constraint that secure/PSCI
firmware ignored to handle correctly.

Fix the firmware or explore ways to handle it as FW errata.

-- 
Regards,
Sudeep
