Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5FF535FCE
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790074733; cv=none; b=u9r2dxXXnm+MnAGvDSBf2r7YXwgNJrTKFij0e3ZF7e/zT8fBnPS/Z65hq1YVGY98PgkhttUTrcFx5OaEi2wpdZAV/NXjguNDHPHCdi6a+Q3E+IkOpcN6WhbwHSRsCI6xepOnM6P0u9NxA2fVpVMaSj7og6n+4jMLiSfNBJkf37c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790074733; c=relaxed/simple;
	bh=503RZmhHuB49hcMMHyhvEKRa7joa1Czu0UxId6pYLn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cqll6jcMpjFXPXd4dbwyr75LnuRtRjCTFi9PaRV+13PDJFNkeq6csan5SNr1GFKmvusxh8bovaFWxLPpcXiHlUuri/ewzwyXZqMMdHteV8/CFzQ9gDXHWKyPYcJp/KgIw+59CCST690vk24m1FkirSrTGAjbM3h7MLSuf9g9Ee4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOkx3hGU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOkx3hGU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431971F008A2
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 10:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790074729;
	bh=503RZmhHuB49hcMMHyhvEKRa7joa1Czu0UxId6pYLn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nOkx3hGUl25hdOM6H8GEff1F9lmGyMGL5B+aHbi+jf4DPkg8awP2mR0qpwPAmwL81
	 D+Cz3GUV0J0YVZYZI2B30ZEnX+bdAAoLlYjcQtM0/fNqGVm06IqeRxJRXUjmo0MiZj
	 o9IHYE1larAI0VigviXS3nyqxG1fOZcK1xRNGx/uup24wVLw1XqcINqx4dtEhlycrf
	 SzRsYYRNSfresp/A0Y02ARFycbX8Ve2oy9n9To3mvK8LySlUyRX8qJx4kObf0y3RKi
	 ghQPT+lUK2kBFrjB52Vt8sCUj2I8iY0X4yHH/5c3Q4fjc2Z/8Dk6BIOHynglPqBQn/
	 X8bke+58rOC1w==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f1b845so3281081e87.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 03:58:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxZ08IfL05SIsJ40w4xhiDEHFdYkcdHLKgCy9t0szpI4Zb3GRSesArayDX9lTvDTl7gaEZ/dGibDw==@vger.kernel.org
X-Gm-Message-State: AFuF++lswMDWevFAi+4sWpdUNdiqRwv8GFqwpXHffbc8uy7KjO/qU/B2
	BGGKENobHPM69PB5YQtqvPWVaC6OdzSxUPzsFSBNZj4y8iph95bLdSFJ7J4ZNW2RD6x+oLTvU1B
	O5Oa+ZqkOVzvrlYZ9vVOM3zdeu9KwAeg=
X-Received: by 2002:a2e:b8ca:0:b0:3a1:5172:c287 with SMTP id
 38308e7fff4ca-3a5fbeb3c28mr28047001fa.5.1790074727534; Tue, 22 Sep 2026
 03:58:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807060848.832929-1-luoxueqin@kylinos.cn> <d02f335a-c97d-49ad-85c0-2eacd744eb0c@hisilicon.com>
 <651d6392-984e-4363-8ef6-94a23be615d7@arm.com>
In-Reply-To: <651d6392-984e-4363-8ef6-94a23be615d7@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 12:57:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gQfycqWaGpGQzYq6T_HOXiumFi0SD4sGJhn4eUS1FHCg@mail.gmail.com>
X-Gm-Features: AcwNN1Wby-rXjqfv0v1XIHNQU4vGq0TGDTF64LITUG1nSspF8SSKp1AzEAfWb4I
Message-ID: <CAJZ5v0gQfycqWaGpGQzYq6T_HOXiumFi0SD4sGJhn4eUS1FHCg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] cpufreq: cppc: Handle Highest Performance changes
 at runtime
To: Christian Loehle <christian.loehle@arm.com>
Cc: Jie Zhan <zhanjie9@hisilicon.com>, Xueqin Luo <luoxueqin@kylinos.cn>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Lifeng Zheng <zhenglifeng1@huawei.com>, 
	Pierre Gondois <pierre.gondois@arm.com>, Sumit Gupta <sumitg@nvidia.com>, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	Ionela Voinescu <Ionela.Voinescu@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 9:47=E2=80=AFPM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 9/7/26 09:49, Jie Zhan wrote:
> >
> >
> > On 8/7/2026 2:08 PM, Xueqin Luo wrote:
> >> Hi Rafael, Pierre,
> >>
> >> This series adds support for handling ACPI CPPC Highest Performance
> >> register changes at runtime, triggered by Notify(0x85) on a processor
> >> device.
> >>
> >> When the platform changes the Highest Performance value (e.g. due to
> >> thermal or power budget adjustments), the OSPM must re-evaluate the
> >> cached capability and propagate the change to the cpufreq policy,
> >> the scheduler's CPU capacity model, and the frequency invariance
> >> engine.
> > Any real use case of this on platforms that run cppc_cpufreq drivers?
> > Some addtional motivation may help.
> >
> > For example, a processor can age over time and its core frequency degra=
des.
> > It's good if platforms can make OSPM and userspace aware of this.
>
> +1

FWIW, this may be related to platform operating mode changes between
"performance" and "powersave" (longer battery life) if the top-most
OPP is a high-cost one.
