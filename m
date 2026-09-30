Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222DD3BFAFA;
	Wed, 30 Sep 2026 19:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797547; cv=none; b=PCC8+h/qoE387ueAZT3BQk3ibl8h7o2XfokzUVOUuCvDf/flruL55Uo/RQ0QsbeugYFtejT07VeXUjSrNpiL/Q2Rh2x1m+1HvmcKuOZhPQAAHYs0v0jdRUYeuQ5OaCG/H2jjuTpUgVcpfHwAN5W1y+KF8j7xhd2sbxrxU1FeIRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797547; c=relaxed/simple;
	bh=xlPHLHRO9l6SNCL9EgtC878Ze/bscpyWa/omvYb4LeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPulHEIAI9GO19rnUR660w/S3PkiaBX/euIyUWPupQbnkQYfzndCg9FIBlRj/GYSwQ0maFl9WrvC0YCOsTagrbKoys1lP+pgcpk9YkDUVSHfw1eo4WVNRk1pbWPztAlJfnXLC4Md4Wp442bRkXSDFuItNHqwG45IpTb2qJZ4fu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQlEKJV3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQlEKJV3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8D61F00898;
	Wed, 30 Sep 2026 19:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790797546;
	bh=Nv6ZnGf02FGa0/XbP1BxuDpGXmlZsQYrEor5FTFbXgY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RQlEKJV3AEMuPs3Cr4Umu5g9anHi/j2ELE57xNGa+1Tzqw8q5W+Eg6jcaRJS5gOB1
	 b6BcuI180l38PC+ChlBVgoqrpV79ryGefY397wn4tiFlVTAhf7Fu7cesIgfQ8+VjxH
	 1lp9eaxAnsReMVbkRJ2bBYBSwB4bZxnOmlED1ymYubUzxGs5MQrbcCth2ed5+ybmc6
	 GeeTfwmaXtT8qHy/ohwXdr/rhddxbrrCE2G+e8UnCbqKAK1sRBxB0AAQqs+YUvyQDd
	 uHjbTk/G1ppEdjA+oDiZ5yK8Xlp4HuQd4H2OhfhEWBxaIgo4t0EWc+juLiElefmnhK
	 qkgHw+153sjfg==
Message-ID: <7104d7ca-9dbc-42ee-bc3d-f1bb95cdb830@kernel.org>
Date: Wed, 30 Sep 2026 14:45:44 -0500
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
 <01667c52-284d-47ba-aa9b-2b0ff685610a@kernel.org>
 <CAJZ5v0ig_sfHd6iG0n4ZA=957+YuvYE3y08xbj93n6ktaV9PVg@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0ig_sfHd6iG0n4ZA=957+YuvYE3y08xbj93n6ktaV9PVg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/30/26 14:43, Rafael J. Wysocki (Intel) wrote:
> On Wed, Sep 30, 2026 at 9:41 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 9/30/26 14:37, Rafael J. Wysocki (Intel) wrote:
>>> On Fri, Sep 25, 2026 at 4:54 PM Mario Limonciello <superm1@kernel.org> wrote:
>>>>
>>>> On 9/25/26 04:40, Christian Loehle wrote:
>>>>> On 9/24/26 17:00, Mario Limonciello (AMD) wrote:
>>>>>> From: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> Rename amd_get_boost_ratio_numerator() to amd_get_effective_highest_perf()
>>>>>> to better reflect that it returns the effective highest performance value
>>>>>> for a CPU, accounting for preferred cores and heterogeneous topologies.
>>>>>>
>>>>>> Add a new helper amd_get_boost_ratio() for doing both for boost
>>>>>> ratio calculations and update callers to use it.
>>>>>>
>>>>>> This refactoring is needed because on some AMD systems (Zen6+),
>>>>>> the boost ratio should be calculated from frequency values rather than
>>>>>> performance values.
>>>>>
>>>>> I think I see why you chose to implement it this way (the x86 APERF / MPERF)
>>>>> issue, but I'd still prefer it to be spelled out here why this is necessary.
>>>>>
>>>>
>>>> Do you mean in the commit message, like spin the patch?  Or just in this
>>>> thread?
>>>>
>>>> Not all cores will operate at the same frequency and fixed scaling
>>>> values from CPPC perf don't apply anymore.
>>>
>>> Well, CPPC is per-CPU at least in principle, so the above doesn't
>>> explain much TBH.
>>>
>>> It kind of follows from the cover letter that there's something
>>> missing in CPPC, so this is a stop-gap thing, but it would be good to
>>> put the information from the cover letter to the changelog of this
>>> patch.
>>
>> OK; I'll respin the series with the detail in this commit message.
> 
> Thanks!
> 
> With that, please feel free to add my ACKs to the first two patches in
> this series and route it as a whole through the amd-pstate tree.

Will do; thanks.

> 
>> And yeah; this is totally stop gap to allow other development that needs
>> this.
>>
>> Once next ACPI spec is out I'll tear out the stop gap and put in the
>> right support.
> 
> OK

