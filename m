Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DED442373
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790363754; cv=none; b=MTUXR7n7UUvqHOqgiz38Q8isrJAgOcNrPu/aBChMFgs2k2wsMIRIbSfVNUDG8FRZ6pGJMpn4wAvv0lSyv7v7QyQRxlbhiPRUe4atcpo+ICHDJhtubxNDuVeQBEBFne9GYc9pBE7KuBlU3pwMtnqbSrGbOUvCecDq1HX/AjlxtFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790363754; c=relaxed/simple;
	bh=e+WinPAucV+GfWRrtt5ADkut+z9MM6GnVAZpizY/GBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxkTTqsWRWQ//JNV9u5khZhvJMGZhlR9q3BhnezvG9VMvZ7SZ8k2+koE0u8zvQhqi7zDcyhrSFqV8EvvqgfvqWEUs/FQFFMrNcf2reabQjjnQUOLhwMWl8dCMMwPOSOaja0jfC0NPsdyJPJyUJH5Za+sabkzaa3Pot2E3JpgP2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTVt/z+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTVt/z+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3652D1F000FF
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790363750;
	bh=/ZUwSQWAxvj4c4HOQ6Qvu23WkOSR7Y6AUF9uiTwPmfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YTVt/z+DTyKGKG7S3TT1tATMabgwxbhVFCGIAbb84Hnj1Yk+67lLQrUmTZIH8iEkp
	 zmBDvUDiP8UvS7LQ29T2qG6KP2Iih3ePXIt16ujOkYiln4snCrhz3OZNRnuoSMiRVm
	 sEA753iwrJq9On8eDGe0mgc1yjhsPmUSmrKVo0zMKfZFr3Ced9y4ahtvgLjCYbNgCs
	 c5o5TgHSQMZVVCqmmET5Nlt92pEIawSTDhLikrpbL1TVkvw6GnjxI7jdAsXWH1bdAG
	 h4ZFoCghNtKJ4TufZZgI88fkNF9xbf7vJ36CyeIiiqdegXilNtlrd9GNAtVRdOWzgm
	 0j7ovB/acHbXA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a658b1f7b7so3221931fa.1
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 12:15:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByXkYpA3IBgV6ebaotTQikL7Rx3FFW1JFV2RBOPn5kWh3/gf+D9Rg/S4EQNo6uN9+OnuOOP9A8wcg==@vger.kernel.org
X-Gm-Message-State: AFuF++m1wPpPgMYTxyp2jVMUZuy5XYbTDx/hgoJ5CHL1eUZaK+WI/vXN
	kme2LPN4TvLYTD8LaznY7HY9VRdXa27CpvuBo0YtmUnkWjsDT8LgEXMhg2ROdmANvUDAoKVLLjw
	OfI10eFvXEME56gJwFDn/cmV+UOEe5WM=
X-Received: by 2002:a05:651c:50e:b0:3a3:2a41:e329 with SMTP id
 38308e7fff4ca-3a63c072584mr19216131fa.9.1790363748651; Fri, 25 Sep 2026
 12:15:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915220105.14655-1-norsyazwina.fazrul@gmail.com> <fa9f518f-e10a-41e4-99ba-b281741c22db@infradead.org>
In-Reply-To: <fa9f518f-e10a-41e4-99ba-b281741c22db@infradead.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:14:09 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jepvJLOVFWypNPsRYcbQtqbQFSFjDLTU+CrHAGGZzfww@mail.gmail.com>
X-Gm-Features: AclHuK-WY6JXOOTMvZPD4eOzRiBaSkQw2wPlszcuyOKDprTunHaFFTxFxFcnkxc
Message-ID: <CAJZ5v0jepvJLOVFWypNPsRYcbQtqbQFSFjDLTU+CrHAGGZzfww@mail.gmail.com>
Subject: Re: [PATCH] Documentation: power/cpuidle: Fix repeating phrase
To: Randy Dunlap <rdunlap@infradead.org>, Syazwina Fazrul <norsyazwina.fazrul@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-pm@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:47=E2=80=AFAM Randy Dunlap <rdunlap@infradead.or=
g> wrote:
>
>
>
> On 9/15/26 3:00 PM, Syazwina Fazrul wrote:
> > remove repeating 'with the' phrase
> >
> > Signed-off-by: Syazwina Fazrul <norsyazwina.fazrul@gmail.com>
>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>

Applied as 7.4 material, thanks!

> > ---
> >  Documentation/admin-guide/pm/cpuidle.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/a=
dmin-guide/pm/cpuidle.rst
> > index be4c1120e3f0..e91ebd432f6f 100644
> > --- a/Documentation/admin-guide/pm/cpuidle.rst
> > +++ b/Documentation/admin-guide/pm/cpuidle.rst
> > @@ -316,7 +316,7 @@ interval" value.
> >
> >  Now, the governor is ready to walk the list of idle states and choose =
one of
> >  them.  For this purpose, it compares the target residency of each stat=
e with
> > -the predicted idle duration and the exit latency of it with the with t=
he latency
> > +the predicted idle duration and the exit latency of it with the latenc=
y
> >  limit coming from the power management quality of service, or `PM QoS =
<cpu-pm-qos_>`_,
> >  framework.  It selects the state with the target residency closest to =
the predicted
> >  idle duration, but still below it, and exit latency that does not exce=
ed the
>
> --
