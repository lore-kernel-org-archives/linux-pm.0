Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2739E3C1F22;
	Thu, 15 Oct 2026 18:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088920; cv=none; b=EGpYDZ99XtITvvciiZRIKiGXxHGHKJJrHi3TEv90kQq9Zuj/qVc/JrYJ+GfJvOQr20Y7gL5QMY8ztU0d7o5gct7rXgf4zoksIhtvqTZgaKooJSYkibDhrPdefPACki4BzpyvV9xh7ej8mjFL5rWjCfKOhKYUy6Gnt3NVNSwJcyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088920; c=relaxed/simple;
	bh=9/W98+UPcz7+z2gbQuRuoeZt7XD0ZsfntBJYAWvwY4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBTbL00GkCNZyZCvc9D7uL4lvlOfdkyU4ow+jHsZRlJIPv8XCSbjUOW7f/yq3whTBx/MFYmtg9kihceQLX6EQg9D5ZvBPTcWZXEpnYEcbI5NX2LoAL4+jQ71sa8hzgYVfzomzSo3DW9dwTjg4u6hCdy+9GTKKvmURbeCjV2jrpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwOmq2Fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwOmq2Fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC001F000C4;
	Thu, 15 Oct 2026 18:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088918;
	bh=i2iJnFn6v25FyyvDfOpMCGiZQScbECC6kU6MH9ZcSYU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kwOmq2Fs4H9Ev2Bu5YczV98sxuuHuk6MJsK9/9ukp5JMI0LAIcWdfB5Q8w60kaDIx
	 QLYirymjeH55T/GkOc6I1Ka/5TD+iAvyQTcZLPs+45Y1LC5PvXeC7nFYW8nduqQy4L
	 otdE1GSxy03GTpsM9WwRI9V//ErwjVSMYSLNE/Oj8Q/BwWajTsYA4RTxFcSgfU9AW9
	 JEWdJkKizJpeuT1DMi+RgLH2vzWHbcmzx4gitmqbe68yeeEMPBLLjqJU/Z0u8E1TVn
	 faIM4LBWoF4jBOkKrgS9szutg4MDKuLY2uDN8GotrNh9Yi6XRmo2Z7axlZrxDZDZFF
	 sFp2K1SQtMCIw==
Message-ID: <68128016-661b-4b78-bac1-b7e23029d8de@kernel.org>
Date: Thu, 15 Oct 2026 13:28:34 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate
 sysfs interface
Content-Language: en-US
To: Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Armin Wolf <W_Armin@gmx.de>,
 Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
 Hans de Goede <hansg@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Jai Luthra <jai.luthra@ideasonboard.com>,
 Greg KH <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 Kurt Borja <kuurtb@gmail.com>
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
 <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
 <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de>
 <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
 <1cba0f2a-38cd-42b2-a773-9dca5d7519e5@app.fastmail.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <1cba0f2a-38cd-42b2-a773-9dca5d7519e5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/26 13:04, Mark Pearson wrote:
> 
> On Thu, Oct 15, 2026, at 7:30 AM, Rafael J. Wysocki (Intel) wrote:
>> On Wed, Oct 14, 2026 at 11:31 PM Armin Wolf <W_Armin@gmx.de> wrote:
>>>
>>> Am 14.10.26 um 15:24 schrieb Daniel Lezcano:
>>>
>>>> The per-provider class interface is firmware-independent, but system-
>>>> wide profile selection is only exposed under /sys/firmware/acpi.
>>>>
>>>> Add /sys/kernel/platform_profile/{choices,profile}, sharing the existing
>>>> aggregate callbacks and semantics with the legacy interface. Keep
>>>> attributes hidden until a provider is registered and remove them after
>>>> the last provider.
>>>>
>>>> Notify both aggregate frontends on profile changes. Also notify the
>>>> provider class device on a direct profile write, matching its documented
>>>> POLLPRI ABI. Restore aggregate visibility after a failed registration.
>>>
>>> IMHO the aggregate sysfs interface only exists for backwards-compatibility,
>>> so i would be very happy if you could just make the associated code optional
>>> and instead teach platform-profiles-daemon to use the individual class devices
>>> instead.
>>
>> It is not just a matter of opinion AFAICS, the aggregate interface has
>> been regarded as legacy for quite a while (see commit 778b94d7ac17
>> "ACPI: platform_profile: Add support for hidden choices" for example)
>> and it was retained exactly for backwards compatibility reasons IIRC.
>>
>> I'm with Armin on this.
>>
>> Thanks!
> 
> I don't think we can get rid of the legacy aggregate interface - which I think is what you and Armin are asking for? What does making it optional mean?
> 
> Reading through the patch series it seemed quite reasonable to me to move it out from under ACPI but still have the old interface working. What are the alternatives?
> 
> User space (and users) are still using the aggregate interface in my experience
> 
> Mark

If we want to get rid of the legacy interface eventually I think this is 
how you can do it:

1) Wrap it with a boolean Kconfig.  Default to enabled.
2) Add some messaging in this Kconfig that it's being removed after the 
LTS kernel from 2028.
3) Emit a pr_notice_once() or similar that it's deprecated and will be 
removed in the future.
4) Modify all (known) userspace software to stop using it.
5) Wait for userspace software to tag new releases.
6) Change default to disabled.
7) Wait some time.
7) Next LTS is declared.
7) Drop kconfig and legacy code.

