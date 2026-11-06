Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985208;
	b=noeLtBcsUAd/LHe4Sg+RVoaD7py1AruF5q3xOonZyBBVZ0L+hyt0HweeOfevFjv1wz9B
	 ZLDhk6O3cxpZoPXNyTIysO0vlX1c/tNHY1bj+xXatqppZozp3xFIYGRXkx13ohGd0puaF
	 6lJZo66Dt1+Ooy56pk+5R1SAiNlLbVQ8doZ27NXsqo3Qxfm9kWQmn5XAyp9lov1TWJWB6
	 s8tg8W2TwbPbqIQ8Z9OxlXipWUAIo/9zUun6ECXMhQuUKdQK+CCjJj3wF6tfPzq//L7Bc
	 nQle4YlidrivUCzM4/0X6BGHjGiulnaAkX9yCPladLMtdQWDPVzAwLk76vKf2rCDI/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985208;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=bPnDFLjtsMX7BueMtx9r8dp1yZvMpehBGipGAVCydqs=;
	b=XjpuAS7FD3iHWV10EgsIbswLe/cjWnL0P53uZ4nTf8LBN95M40ieIaI4vzZAFLaBThL5
	 zAqJl/9iHWwXr73GsgZ6BQHJAQf8JERGoiaK16DVFeult3SkyRtk4xgaBcHCmgLKCnnss
	 0vmlOBBnUHJUXE0oiWoKewZYi1zy7LzqLdth6ej/EKbRYYob0xCnduI67pCpqnPiKBZki
	 U66rAd5LYLzJ6lcSeuvj1gKYd/yefmIoWlyzXkZpW5uwyLRjOeun+YmKsy49RktkA/qU5
	 229UYIJ9IqOp35TOfjFke2RVCm3q9p3CMcQXu8+dCHTm9M1JRJCzvS0zkqN4yMlV6Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkPI8UND;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA39606A326;
	Fri,  6 Nov 2026 17:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TkPI8UND
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9038F1F0089F;
	Fri,  6 Nov 2026 17:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793985207;
	bh=bPnDFLjtsMX7BueMtx9r8dp1yZvMpehBGipGAVCydqs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TkPI8UNDklgLg24An0CwLzEX1nUXsMqpKIdUlZ239MrmVy4gbbxjw1PH5hwp9sw1E
	 aH0VxuxlrEDr4hWf2TQbx17n1vTj2OJEMRY6PR1+BkDwoCEZz5S5UZof9HYnAu2MNv
	 S0dDRX/8wnisoz3OjNlPaeZvVdq8GiepQUvEiBLk7bLZTw57XQT7cU8fvTiC8gs2/J
	 3vLeQsabyMMIY7PapuwdmTJekLnHjMoAraVZfWD79iOgYmdQGckzf+Tbmszf4bngg8
	 VwYakwG2MJpd7hgoJjPQdv7HzjdFJGtOY89OF7dZjE6riU1nsUGTe3Ud+CrZxHLyAn
	 WeKRm4PWN3yHw==
Message-ID: <82efa7f5-c5b4-4934-a72d-7399ce52496c@kernel.org>
Date: Fri, 6 Nov 2026 11:13:23 -0600
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use hibernate callbacks when shutting down the system
Content-Language: en-US
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Len Brown <lenb@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Denis Benato <benato.denis96@gmail.com>,
 AceLan Kao <acelan.kao@canonical.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 =?UTF-8?Q?Merthan_Karaka=C5=9F?= <m3rthn.k@gmail.com>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org, Eric Naim <dnaim@cachyos.org>,
 Bartu Alev <bartualev@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Driver Core Devel <driver-core@vger.kernel.org>,
 ACPI Devel Maling List <linux-acpi@vger.kernel.org>
References: <20261102-superm1-s4-at-s5-v1-0-313e0012dd39@kernel.org>
 <CAJZ5v0i07G06GDGX76f3-ppumfNUFD0nTB-Wz8k4PS=Ra13CsA@mail.gmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAJZ5v0i07G06GDGX76f3-ppumfNUFD0nTB-Wz8k4PS=Ra13CsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/6/26 10:57, Rafael J. Wysocki (Intel) wrote:
> On Mon, Nov 2, 2026 at 2:54 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> OEM systems that ship with Linux preloaded need to go through energy
>> certifications that match regulatory bodies in the regions that they
>> will ship.
>>
>> If any of those certifications don't pass then OEMs might not be able
>> to ship systems preloaded in applicable regions.
>>
>> Multiple models of systems are reported to fail in Linux but pass
>> for Windows on the exact same hardware.
>>
>> By looking at a breakdown of power consumption across devices the
>> issue is that some devices aren't turned off when user puts the
>> system into S5 (shutdown).
>>
>> A few years ago when I first root caused this I submitted patches
>> to PCI core to change the PCI policy at shutdown [1].
>>
>> But through various iterations I've come up with a better approach.
>> Instead of changing policy in each subsystem we can instead
>> change our shutdown command to run hibernate callbacks for all hardware.
>>
>> In order to accomplish that the last 17 kernel cycles I've been slowly
>> drippping changes into the hibernate code paths of all subsystems to make
>> sure they behave as intended.
>>
>> Those are all merged as of kernel 7.4-rc1, and thus I am now ready to
>> start using the hibernate codepath at shutdown. This series adds that
>> support.
>>
>> I'm not naïve; there is definitely risk involved with this change as it
>> will essentially affect anything running Linux that gets turned off.
>>
>> To that I will say that I have been running, rebasing and iterating this
>> series on my personal development tree ever since December 2023.
>> Various rolling distro community members have also been testing iterations
>> of these patches in their hardware and distros.
>>
>> I've also put a few guard rails in place:
>>
>> 1. Don't mandate hibernate support. If not compiled with it, just use
>>     previous shutdown paths.
>> 2. If hibernate callback fail, emit a `pr_emerg()` message but fallback
>>     to previous shutdown paths.
>> 3. Offer a kernel command line option `shutdown=legacy` that any affected
>>     user could use to roll back to previous behavior while we root cause
>>     any issues.
>>
>> I did split out the kernel command line option to a second commit.  If we
>> later decide that we want to keep this behavior but drop the rollback knob
>> we can revert that commit.
>>
>> Link: https://lore.kernel.org/linux-pci/20231213182656.6165-1-mario.limonciello@amd.com/#t
> 
> I have a couple of concerns regarding this, after looking at the patches.
> 
> First off, dpm_suspend_start() seems to be called during shutdown
> while user space is running.  That is risky because at least some
> things in the power-off code path assume that user space has been
> frozen.  I think that freezing tasks, along the lines of what system
> suspend does, before running dpm_suspend_start(), is requisite or you
> will get into trouble with people who run fuzzers across shutdown or
> similar.

Hmm.  I'll see about adding that to this path, thanks.

> 
> The other concern is that the "legacy" shutdown should be the default
> or people will get confused.  Arguably, it is not even necessary to
> try to change that in many cases.
> 
> Of course, this means that the new shutdown arrangement will not be
> used to start with, so there needs to be a plan to migrate users to
> this new order and I would start with the systems where it actually is
> an improvement.

It's improved every system I've tried and measured; but the level of 
improvement comes down to what hardware is contained.

The most demonstrable improvement comes from systems with dGPUs.

> 
> I would try to add the shutdown= option upfront in the first patch and
> make it take one of two options, "classic" (the regular shutdown
> callbacks) or "pm-aware" (hibernation callbacks etc) with the first
> one being the default at least to start with.
> 

OK.

> Then, you can add a DMI quirk table or similar with a list of systems
> where "pm-aware" works better than "classic" and expand its use going
> forward.  My expectation would be that, at one point in time, the
> majority of x86 platforms using ACPI would be better off with
> "pm-aware" than with "classic", but I'm not sure that this point in
> time is today.  Beyond that, it is really hard to say how cards will
> fall.

How would you feel about a heuristic to turn it on for anything with > 1 
GPU/accelerator for now?  I think that's the biggest bang for the buck 
right now.

But deciding when/how to turn it on for more systems than that I think 
is going to require a wider call for testing.

