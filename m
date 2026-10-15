Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47763F327D
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092554; cv=none; b=K+s0cinQJIdkZOGPY6oc1i3qEkyh743+qi81tD0CZCDfoJlEslP+uCsawelBnLaajUMMMUKqK4kYq4jj7WUOOq36Sk72P/KXi2eklNaRhtmYXsj3LIK7jxCB+Btx30Mb8hBc+lBP4YkOuksUYj+1X+hVIDLIT3kuZl/YjOZqR/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092554; c=relaxed/simple;
	bh=+YmjxjE65XqBm4GeivSGeqGBYYz3QfZNi6OJRNBe/eo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=UBE9pSsGNo0LJ647W2mUmGpS5RjQ4QjDsFo617RJc+mB5YVGU+UjVHzwMrKdCT+0XcTWmddwfKrdU8+jF1Hw8FIwTVkpuayHSe8wNvhnTKnwuXj4b+fWZfq1i1bwc1BnY/sMtDbJj1AnbFpvTw9FAanlRsWNLdP+cFZ2EIzLad8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=mb9/aJ/j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjoKjG6h; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="mb9/aJ/j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjoKjG6h"
Received: from stl-compute-04.internal (stl-compute-04.internal [10.204.2.64])
	by mailfout.stl.internal (Postfix) with ESMTP id 44AC71D00154
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 15:29:12 -0400 (EDT)
Received: from stl-imap-02 ([10.204.2.93])
  by stl-compute-04.internal (MEProxy); Thu, 15 Oct 2026 15:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1792092552;
	 x=1792178952; bh=MgEbppQQTowLMQPNZSlGtjUP8SmRXolTJc2W2H+p5Sc=; b=
	mb9/aJ/jtAbAbO/8ffWT78XXVL/gXcG6v5LmVJ169dFz20ME2Gt3bnP1XDkWMqc4
	5zAWrQaj6vZ8QKznXFgwQIXrtg8YBF0FTsxHy0L1qmJrOPVszT718VXVupgid09k
	7VJlXt+h9sGkN/RwJLnqkRz152ZBlSzOW6aiQ6WTI8LzjgRMBGGJvEx273WX2Mco
	KiWD26RtvDW0+NiSfjU3Hndj8Kem1ZjtMFs4KI7d+K/SDNzIGKOy82+jgRl4GHda
	luquPV3YDkCA9TbRswUtU+T4LNG53ivUkfJh7CCYSjSOl5unR0LNXWb1UvX+4HPK
	WRWZ/3KUkdThHfgfvCGKXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792092552; x=
	1792178952; bh=MgEbppQQTowLMQPNZSlGtjUP8SmRXolTJc2W2H+p5Sc=; b=X
	joKjG6h8zaxYfWQkcyEyfyQaSL+ZtXJ9lCBio0iiz4J3mo46FZ6f8dmsXCLGcq/u
	jsapybtnF5TlGVDp1V3L1/pNIJnusUYEr//FNiye7rto36yQysPe+l5TeSix3zC5
	BZ6DdBQMshx+xyRQv5slbMBrvu0/yZIvzijHG1MEuqrkggjgHJlzgvyl0dyJwmgG
	M5cwbL8H+0Wr0tF54xdiRBakKnKzqqHMqJ+LyVxvNq/7mIVP+RFUl/lL4iUYTS1z
	/EirggeCYTQZmLroJiC82seED3n58CuSRtY9Lj5PagVSQXNmsx/wAeRcUP/YdpEp
	yqPMDzu3uo3FTH0UPU40Q==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=squebb.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792092552; d=squebb.ca;
	mf=PG1wZWFyc29uLWxlbm92b0BzcXVlYmIuY2E+;
	rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
	s=fm3:rsa-sha256:OMHPapB6HrbZG5XUI7MtpdWzouResqbiVpuh8dMfJnj5r9y
	Dmo8W6CAIXaEQBTJarW/QwwpR6cxi+f4wLnXfJNhDUFiX0zukOmhsG1+WJCLQJV0
	z5Akd6TnCtSx6fUpJKUiZ3gQkmMIOdPUSBHc5SxM38b0q0mCMkTF2kzO98agXSzO
	swQJHR98Ywd2zZjIGKv8i7LktsU7bMjvnOtAdz1YEJs0Yhn4SVT8I2K+IGGbf36C
	OArglicdQa0yTw0gBYzDMHUqROIQqaqgOOyfCl+DIrnkDpvSg+BqqBQE6m0RM5ky
	l2IrqAKUrxIh8+ExwfaOpLrBXYoSU44jBnk9Aqg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wr2XeiXDelh7ew3+lM+lD+npUfytm0FExKe3nm258Sg=:+YmjxjE65XqBm4GeivSGeqGBYYz3QfZNi6OJRNBe/eo=;
X-ME-Sender: <xms:hynRalkcdBdiD3AaSwO22ZHEFio1yr_Iv2_1hygozOIpPigau_OEWA>
    <xme:hynRarrbgnk3pEbGYfWFpAJ0jR-2rezWAt66eba8qJGuqPq-8UQjDwlbpLZ6SjV5t
    SxZpCQDPSjJ6pbHIAFk2d_MIgcE5UxljH_NNy3v0L5UDireP4Roanzx>
X-ME-Proxy-Cause: dmFkZTEovlw/Vkrh3GNZ6L0mqtxXQUO8t5+ngky8WawprMbGOQlpF03iZGH4yUY4zz0Hqr
    oCgb9j4Qs3xljY7YREamUFp9luV34RlKD4IdiLJvzXzt5VV4CNe/RL9UuzIuJ8XgMnYXxR
    31fV/hqKJSuiuGCtuS9WJr266CnhXy0vc4GUXuEgle10PReaUZT3YlSQks0vKS/wu1mz0z
    EsUL6JJfbK+36P5Dt2aPSSxxZhSdBVsEt/wksnTOP7RRJ4yC7ro5KDbJuFWENJn7iiRKbS
    9hHW5tAWhbuD8xqaUb0Pujje/BpAOsVJz3eWsXxarkOKQjEokHLYX44vSwCuLrfOleycD4
    t7pb4ReyCsxn3VgUAIwEzYEIJwdh2EGY+R8djmi4wPC8zs6nbr5iFH78KquCYhkXSIlM36
    WW+y4mKwalyWpQl+EAwLDFIFdLKGIPpmT02bCOMR8yLoYxLMFmtrZN1R0NdaLdc4vwWfM9
    DApRm8Z6gru/Of11K0Wz/BwjhOT2VOBkw3XyV2ePwqdzSZEuVXMWQQJP3WD9TuYbU43AlY
    dPkidCPQ5ST33R+nrWCM7qq8nloTlcubDdS92lBeZuKkLaVqnFeQ2tLiahhTPwrdzG5518
    QWEEB/ro1tacNqcZwBH7YUOktvpRJWmq5TgxDq3Y5hkXy1HcPQ8DYbDKsL8g
X-ME-Proxy: <xmx:hynRagUz3bG10COEdiPSdVJi9FEa8-JrIvYavu-CqaWJqgkKO4aVFQ>
    <xmx:hynRamTS_WgCvUlWv0ghLgaZNU1tik7oGv5KysJSlVvMAPFUAQ21aQ>
    <xmx:hynRan0dR2iJTzzu5psHaM4hNdFWftuKVEMBl0tyQqiqQiRZyx3PnQ>
    <xmx:hynRavLRcDn_TlcmfEVU4lhQv5Yj1ktjBPdf4M1MnGvLEeJP90qMvw>
    <xmx:iCnRaiB-KvBoY8K7dFl6ce5P8CNW1N9AAhMYwcbKoH351SBe52XFxGUz>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.stl.internal (Postfix, from userid 501)
	id E84A52C0007E; Thu, 15 Oct 2026 15:29:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ao5-L1TSHHD-
Date: Thu, 15 Oct 2026 15:28:50 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Mario Limonciello" <superm1@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Armin Wolf" <W_Armin@gmx.de>,
 "Daniel Lezcano" <daniel.lezcano@oss.qualcomm.com>,
 "Hans de Goede" <hansg@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Viresh Kumar" <viresh.kumar@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Maximilian Luz" <luzmaximilian@gmail.com>,
 "Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Zhang Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>,
 "Jai Luthra" <jai.luthra@ideasonboard.com>,
 "Greg KH" <gregkh@linuxfoundation.org>, "Jack Wu" <jackbb_wu@compal.com>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-pm@vger.kernel.org,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 "Kurt Borja" <kuurtb@gmail.com>
Message-Id: <720760de-c150-4227-b78a-90d483d6cb7f@app.fastmail.com>
In-Reply-To: <f482b724-7217-412c-a0d9-7d8e322fcc84@kernel.org>
References: <20261014132500.3817549-1-daniel.lezcano@oss.qualcomm.com>
 <20261014132500.3817549-4-daniel.lezcano@oss.qualcomm.com>
 <c751e18d-57e9-4ce6-95dc-1bf53a7a4808@gmx.de>
 <CAJZ5v0jQQsXP4v7dymuHZhy2oVjPwV9eXhqV4bGPUgMyGyUsUQ@mail.gmail.com>
 <1cba0f2a-38cd-42b2-a773-9dca5d7519e5@app.fastmail.com>
 <68128016-661b-4b78-bac1-b7e23029d8de@kernel.org>
 <CAJZ5v0gHHoJVm9o-ZzD38jWpGbAZML4AMEpSmy9C9n5TSVYppg@mail.gmail.com>
 <f482b724-7217-412c-a0d9-7d8e322fcc84@kernel.org>
Subject: Re: [PATCH v1 3/4] platform profile: Add firmware-neutral aggregate sysfs
 interface
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thu, Oct 15, 2026, at 2:42 PM, Mario Limonciello wrote:
> On 10/15/26 13:33, Rafael J. Wysocki (Intel) wrote:
>> On Thu, Oct 15, 2026 at 8:28=E2=80=AFPM Mario Limonciello <superm1@ke=
rnel.org> wrote:
>>>
>>> On 10/15/26 13:04, Mark Pearson wrote:
>>>>
>>>> On Thu, Oct 15, 2026, at 7:30 AM, Rafael J. Wysocki (Intel) wrote:
>>>>> On Wed, Oct 14, 2026 at 11:31=E2=80=AFPM Armin Wolf <W_Armin@gmx.d=
e> wrote:
>>>>>>
>>>>>> Am 14.10.26 um 15:24 schrieb Daniel Lezcano:
>>>>>>
>>>>>>> The per-provider class interface is firmware-independent, but sy=
stem-
>>>>>>> wide profile selection is only exposed under /sys/firmware/acpi.
>>>>>>>
>>>>>>> Add /sys/kernel/platform_profile/{choices,profile}, sharing the =
existing
>>>>>>> aggregate callbacks and semantics with the legacy interface. Keep
>>>>>>> attributes hidden until a provider is registered and remove them=
 after
>>>>>>> the last provider.
>>>>>>>
>>>>>>> Notify both aggregate frontends on profile changes. Also notify =
the
>>>>>>> provider class device on a direct profile write, matching its do=
cumented
>>>>>>> POLLPRI ABI. Restore aggregate visibility after a failed registr=
ation.
>>>>>>
>>>>>> IMHO the aggregate sysfs interface only exists for backwards-comp=
atibility,
>>>>>> so i would be very happy if you could just make the associated co=
de optional
>>>>>> and instead teach platform-profiles-daemon to use the individual =
class devices
>>>>>> instead.
>>>>>
>>>>> It is not just a matter of opinion AFAICS, the aggregate interface=
 has
>>>>> been regarded as legacy for quite a while (see commit 778b94d7ac17
>>>>> "ACPI: platform_profile: Add support for hidden choices" for examp=
le)
>>>>> and it was retained exactly for backwards compatibility reasons II=
RC.
>>>>>
>>>>> I'm with Armin on this.
>>>>>
>>>>> Thanks!
>>>>
>>>> I don't think we can get rid of the legacy aggregate interface - wh=
ich I think is what you and Armin are asking for? What does making it op=
tional mean?
>>>>
>>>> Reading through the patch series it seemed quite reasonable to me t=
o move it out from under ACPI but still have the old interface working. =
What are the alternatives?
>>>>
>>>> User space (and users) are still using the aggregate interface in m=
y experience
>>>>
>>>> Mark
>>>
>>> If we want to get rid of the legacy interface eventually I think thi=
s is
>>> how you can do it:
>>>
>>> 1) Wrap it with a boolean Kconfig.  Default to enabled.
>>> 2) Add some messaging in this Kconfig that it's being removed after =
the
>>> LTS kernel from 2028.
>>> 3) Emit a pr_notice_once() or similar that it's deprecated and will =
be
>>> removed in the future.
>>> 4) Modify all (known) userspace software to stop using it.
>>> 5) Wait for userspace software to tag new releases.
>>> 6) Change default to disabled.
>>> 7) Wait some time.
>>> 7) Next LTS is declared.
>>> 7) Drop kconfig and legacy code.
>>=20
>> That should work, but my point is rather to avoid adding another
>> aggregate interface to replace the old one and instead switch over the
>> ecosystem to the existing (and documented) class device platform
>> profile interface.
>>=20
>> The legacy aggregate one may simply be removed when everybody stops
>> using it (which may take a while and it may be moved to staging at one
>> point).
>
> Right totally agreed.  I was meaning userspace software should switch =
to=20
> class interfaces not add a new aggregate one.

OK - I'm in a minority. I will gracefully retreat back under my rock :)

I guess if PPD and tuneD are migrated that will cover 99% of the use cas=
es anyway.

Mark
