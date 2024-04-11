Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408A146A93
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 10:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831160; cv=none; b=JiL0kvflEqRq/4P6x77pjOx7ImSXxTE60BeZml6VmEtxK9M0DNvbYCfXXV7JLl9xOIHl9ljz6um+gfHu/n4EB0+BRftvCYi8G/j9tNT658o/UqTes8+RCmas1x+Cl+cSLUit0onB8oLV3KBvCf4YEzm/f3r60tvk+8FIj3OXDzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831160; c=relaxed/simple;
	bh=kXX0zc9WAsd6N2KIrTe65ihEabb5FGPtUOXi41NT/Is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAID+JVjqg5fhH96uK7T6/lNjieVfMBGLQQuU9zAQm0cz9gTSy/pRTczy1fEUQTMh/CjA2IDWlVflsHwJO/TUQ/5WNLRbV7IHXIVYcHkGCMTjPkaqFRnERMApbpYgvDlTfFsNv6GIAr3Rl20WxHTY9JK7+rTs/g05x9ZxVCP+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Os/QBFS6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Os/QBFS6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C584EC433F1
	for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712831159;
	bh=kXX0zc9WAsd6N2KIrTe65ihEabb5FGPtUOXi41NT/Is=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Os/QBFS6YjCpUCGx/zywj9ij8JE/FOb5cPPG46BJWYQwwef7w9r0xwcOnvAQwZGcZ
	 31dbn380E9+PMvr22z5uNH3YIBnhviUbiBvp0qbfokXu+6XmzoeoPrKMsfvVLsk98f
	 Nfjcwc/988PNgNs5LBGjuwNXVFGkbh5S5hFAgCKpCVlkMxiG9ieUqnPt+H9E0oloUy
	 ughyzLWNsmX9Wn8691RfvAC22A+42nsQTMaAdz5FsXxN+mNRoWFKtEa4mC4GXw5UnV
	 AHGla1jsK/t2uyYA8K6w895920zXKmNDHjJznkSCGeV4zCkxKANGX/5i7MEi5DFaTq
	 p4fh1TBvPQ1sw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a4930d9c48so2746175eaf.1
        for <linux-pm@vger.kernel.org>; Thu, 11 Apr 2024 03:25:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVcO2cmlC/C9NRO5NG9AblgP2p9P/fkZhk39Qe0wxjEqPOx83B2lk1/Sl1MzLQT9u3mi0Md7E0VUdsU20zjUe9Ts7t2/hoKMkU=
X-Gm-Message-State: AOJu0YxSLCNarU3t+vGer/YDKigmy7ZFNzeRykdPtsAl0rRznKWcT+/s
	nvtSGHDKwXhgxrNYGG2ZuCckUNIxYXPWgG+mZEzFLXods9KuSNg9NCKNqqH3fXR2ps60kXuW5h9
	Je4LLMa+nMlkLLI0rI4Ruu3DJ3wY=
X-Google-Smtp-Source: AGHT+IFLDynJ47uklCAAipkRDQH9Nt22a5SVs9OcGfsZ/ymrCMi9+ziiPeJ+qFkhvTMQlXoA5r7IL7kXIsY9vWhp83g=
X-Received: by 2002:a05:6870:b61e:b0:232:f9e0:e4ba with SMTP id
 cm30-20020a056870b61e00b00232f9e0e4bamr4844816oab.4.1712831159047; Thu, 11
 Apr 2024 03:25:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cb5d3388-3d2c-42f1-9e93-026d14c7e827@panix.com>
 <124e6b11-ca62-48dc-9401-7932845e19f7@intel.com> <56308bc8-0fd3-4693-9218-63348da8cf36@panix.com>
In-Reply-To: <56308bc8-0fd3-4693-9218-63348da8cf36@panix.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 11 Apr 2024 12:25:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gBEqL_9sVX9mWMD9Nt72WTNpkAz1q9r8=zytwGs2JdZg@mail.gmail.com>
Message-ID: <CAJZ5v0gBEqL_9sVX9mWMD9Nt72WTNpkAz1q9r8=zytwGs2JdZg@mail.gmail.com>
Subject: Re: Commit 0c4cae1bc ("PM: hibernate: Avoid missing wakeup events
 during hibernation") prevents my laptop from hibernating
To: Kenneth Crudup <kenny@panix.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, chris.feng@mediatek.com, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:26=E2=80=AFAM Kenneth Crudup <kenny@panix.com> wr=
ote:
>
>
> Well, the good news is the patch in the commit fixes the "bailing out of
> hibernate" issue.

Good, thanks for the confirmation!

This patch should be on its way to the mainline now.

> (The bad news is resume from a hibernate still fails, but that's an
> issue to be bisected later)

Well, sorry about that.
