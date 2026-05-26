Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949CC3E92B4
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779795778; cv=none; b=rPiPUzcW9xeIvVTM7yk7aF0rg4+LMdJ00CubiTmsPK33LNcq1kXWQmvtcRT8ASlEWUh4mOEDHvzXgcPq+YB5stPKw9vbmFiXWjCQkM1RZM1IXtCFit/UNd3eA4HBVunLFqhFgOc6DrKT861ejqQj5UUA6E1+Zn3mC/xbwCvKR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779795778; c=relaxed/simple;
	bh=509GEhmpSvNq2l4T67vY7rShPFybU6U8g9Jx5ffQ/PQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBKqO7eHItxomsiRCvQWbGWUMtxsdnnsPwHlBQ+f+9RrhOwYyNd6bOtWUsVY0zzgGjHN4ggJi06eW8912nUDQgpp6IOuGWipaXHciWShQfRAg/LlIBvPAwr22WWO4TPw4iyBNlhbKgk3lVHtFz95t7YNsxbVE6CBP0aInTTPm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JtSRxQP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JtSRxQP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B5D1F00A3E
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779795770;
	bh=GvjK1m9UkOIjtjXOAGixXX+0w0SjpjMTz0sBFt+Vtng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JtSRxQP6gRRzPow5t2sXlJrVqxCp7cAIJU4v0kKRclQXd+SkCO+ZOYEQZCzoojIDy
	 iTAyxqCYPgkUnIjgiC3VA/5ioVue9ra3hijGVRKotFstKY/YUg3JnMcFA80T8yTuzA
	 ICCfjUUpcTWwRvFmee0uYIgJQyPim3BFH+wCosixTDs+MYxlnjqNnKk1ZYXiaP8msl
	 ADZiDyj0WWaLZin8URj6RHLJ6bcc8w8ayRAv9qQWUg0odOo1xiNGYnPFrIZUtd1xfH
	 49bwVk/LeY1D3E8GCD43HmKHMohZsWOM/iFAF/bThu5+HsCFx1aEfdQ+YDx9aApcZw
	 2qwnT8MT0Fghw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa0cf8bca3so9532059e87.0
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:42:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/W7DbLww8Ic+dfGQk8jd1ndxP+Vid2cbtrHwphsMYJQoS1X0G53YXtbYray2zU0n3SdMKCG4lWEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd+QBUfNCvW9bC74LsfHVhbNuaXN5oklpi3Kt8JFwB5dkbp66n
	M7npnWpGfcMZLjcybdiP8XAPk4JjiaU5sVM79ZaHFCRMl2OW87pjBJOvyoNAtvTy2XET/t/yin3
	cAobP8+iNCKpyZ/46WjQ+rnF3xyYDsWY=
X-Received: by 2002:a05:6512:3b0c:b0:5a4:19df:db1 with SMTP id
 2adb3069b0e04-5aa323955bbmr5495732e87.15.1779795768792; Tue, 26 May 2026
 04:42:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520081254.13493-1-l1rox3.developer@gmail.com>
 <CAJZ5v0i6_c8ScWB02GW6ryrwbM0ZHYpgn-pmop+U3WCTBwdraA@mail.gmail.com> <CAL+gSJwF_mfwNVss0evwjBptX-FLwWQp1hTUC0z9WMRnJLGV-g@mail.gmail.com>
In-Reply-To: <CAL+gSJwF_mfwNVss0evwjBptX-FLwWQp1hTUC0z9WMRnJLGV-g@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:42:36 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gAfue1ZDtChYnc3m-5So820rLrGPQrjBLp5hiTBLmhYw@mail.gmail.com>
X-Gm-Features: AVHnY4L9aCl0oZdz-ROYFR1fnkS_aJ34bKavgkjkbdvR4U7H7L_4wDGjVKouAD0
Message-ID: <CAJZ5v0gAfue1ZDtChYnc3m-5So820rLrGPQrjBLp5hiTBLmhYw@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: make LZ4 available for hibernation compression
To: l1rox3 <l1rox3.developer@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:30=E2=80=AFPM l1rox3 <l1rox3.developer@gmail.com>=
 wrote:
>
> CRYPTO_LZO is already selected unconditionally from HIBERNATION in
> the same way, and has been working fine like that for a long time.
> This patch just brings CRYPTO_LZ4 in line with that existing behavior.

OK, I guess people will complain if that turns out to be a problem.

Patch applied as 7.2 material, thanks!

> On Tue, May 26, 2026, 13:12 Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Wed, May 20, 2026 at 10:16=E2=80=AFAM l1rox3 <l1rox3.developer@gmail.=
com> wrote:
>> >
>> > Without this, CRYPTO_LZ4 had to be manually enabled in the config
>> > to use LZ4 for hibernation compression. Add the select so it gets
>> > pulled in automatically when hibernation is enabled, just like
>> > CRYPTO_LZO already does.
>> >
>> > Tested-by: l1rox3 <l1rox3.developer@gmail.com>
>> > Signed-off-by: l1rox3 <l1rox3.developer@gmail.com>
>> > ---
>> >  kernel/power/Kconfig | 1 +
>> >  1 file changed, 1 insertion(+)
>> >
>> > diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>> > index 05337f437cca..530c897311d4 100644
>> > --- a/kernel/power/Kconfig
>> > +++ b/kernel/power/Kconfig
>> > @@ -42,6 +42,7 @@ config HIBERNATION
>> >         select CRC32
>> >         select CRYPTO
>> >         select CRYPTO_LZO
>> > +       select CRYPTO_LZ4
>> >         help
>> >           Enable the suspend to disk (STD) functionality, which is usu=
ally
>> >           called "hibernation" in user interfaces.  STD checkpoints th=
e
>> > --
>>
>> Please check the sashiko.dev feedback on this change:
>>
>> https://sashiko.dev/#/patchset/20260520081254.13493-1-l1rox3.developer%4=
0gmail.com
>>
>> and either address it, or let me know why you don't think that it
>> needs to be addressed.
>>
>> Thanks!
