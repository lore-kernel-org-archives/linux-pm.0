Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC342885A;
	Wed, 30 Sep 2026 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797281; cv=none; b=G5P7ycyzGTTsJvk6hH7uyP1nst5BE+/Fji/8DyN9zHkcVFCqXYBltdRPABAnuV+yuSRrdMqTNPfT6sZxeE6mCJySrbAL82eZ0WXkycpNsR+PbEUVk/D5pX5moHfCZk48fNT8yvVIQFsGuDgGUqPZJP31oLT8yb3G1WDAiTjO7iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797281; c=relaxed/simple;
	bh=XRBtD6UQ/g2XUJCDvgHluYVpYjV/2DqntngjUXFIch8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B8NbVH5mVZHPiSsRMV/7hGkidXGApmDs6B1SIrLtNN7+XcX1B2GppKsfhWdHjPbECtGm/zN78lJUWQ9hXEGjYvI35cyyXV7mziYAfzcRN2zkAjM36SGnF+6gQuKyOuk90gM7xgm7NmUEmoGrE1y2U+vrvNU/tevTG6IeudfPzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjUJPRb1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjUJPRb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291351F000FF;
	Wed, 30 Sep 2026 19:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797279;
	bh=wLglIRyfM6RiGXgcdG2eKC+9iI7ADOBxpEUpwTEGn3s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=cjUJPRb10ymTF7VYO5xr+OXS4gLHj8p4iK4/Ln/19APDaNolCBS5/++gWsEw+K94C
	 8n1tNLDGXK7fDYiQu4S3yA92uKJ5nE1pt/CNJ0/gYo4+rhSDaumTQ0N/CfM5M/h47e
	 X02lszvCnMAn61la0p61vFdTwVPIWFaUD15zl6gmEHRQgvyGPlQ4z61fTKeW4LyRzz
	 la2zpU2QfndKTyIUFegAOZKkk3Ny8iiDa5hOXyVXOO3Lp+PVadQi+xw2LvLGQwCn5u
	 0fWQHgQlm0UHk7iWm9538S/rnwYsMgoI+LHpJI6uvYIlZiAjAr+VHw2odtEEg3i6Fr
	 UCjPOdgC/rzQg==
Message-ID: <01667c52-284d-47ba-aa9b-2b0ff685610a@kernel.org>
Date: Wed, 30 Sep 2026 14:41:17 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] ACPI: CPPC: Refactor boost ratio handling
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20260924160052.2858456-1-superm1@kernel.org>
 <20260924160052.2858456-2-superm1@kernel.org>
 <213bc2ba-2ee4-4a89-9054-3bd953546789@arm.com>
 <c20aa0b6-30a7-4c88-80e0-21bd5e97c0c8@kernel.org>
 <CAJZ5v0iYf1dXVX4LFeWnnsatA8b0LahRfJUe8hH7-978z+nKxg@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0iYf1dXVX4LFeWnnsatA8b0LahRfJUe8hH7-978z+nKxg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/26 14:37, Rafael J. Wysocki (Intel) wrote:
> On Fri, Sep 25, 2026 at 4:54 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 9/25/26 04:40, Christian Loehle wrote:
>>> On 9/24/26 17:00, Mario Limonciello (AMD) wrote:
>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
>>>> to better reflect that it returns the effective highest performance value
>>>> for a CPU, accounting for preferred cores and heterogeneous topologies.
>>>>
>>>> Add a new helper amd_get_boost_ratio() for doing both for boost
>>>> ratio calculations and update callers to use it.
>>>>
>>>> This refactoring is needed because on some AMD systems (Zen6+),
>>>> the boost ratio should be calculated from frequency values rather than
>>>> performance values.
>>>
>>> I think I see why you chose to implement it this way (the x86 APERF / MPERF)
>>> issue, but I'd still prefer it to be spelled out here why this is necessary.
>>>
>>
>> Do you mean in the commit message, like spin the patch?  Or just in this
>> thread?
>>
>> Not all cores will operate at the same frequency and fixed scaling
>> values from CPPC perf don't apply anymore.
> 
> Well, CPPC is per-CPU at least in principle, so the above doesn't
> explain much TBH.
> 
> It kind of follows from the cover letter that there's something
> missing in CPPC, so this is a stop-gap thing, but it would be good to
> put the information from the cover letter to the changelog of this
> patch.

OK; I'll respin the series with the detail in this commit message.

And yeah; this is totally stop gap to allow other development that needs 
this.

Once next ACPI spec is out I'll tear out the stop gap and put in the 
right support.
