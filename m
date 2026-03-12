Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE4331A7B
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 06:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773295396; cv=pass; b=utFZ7sa2RZB/QEY3OiQvzIu2AsDVKHFNNAG1VYcBrDLt4crlZ2EIw3HvVdj5Sz1uJ4GheccD432cCvUFDFZZM6H8qnZ9bH9QVqbz5FBOpLf1Z+4HeDpni/c3hsMTmE14ua2KEfxnsa/IcjLTph97chq00nCwGqDgufFfIzcBeRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773295396; c=relaxed/simple;
	bh=+oBB7oSL3gu76ZFznOdzZrgvR1lE4r0/R5vjiHzyszc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zd9zu7OTGrQe12DpO7hwys1EQt4ff8iir5c7nWN/yFSHfwoIMpHsmN7qjBPpo9KFLEblJ6P1DDCjx/kxaE6cvS/Sogij0i7chR4EuawJWcmJz4V+T7JQrDwMmd6KqYdlj1xYOBWqxKXvkGygS/nqO5p3QRWIrUBcAN74l9SGieE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA/WBfiw; arc=pass smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA/WBfiw"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be22d699c9so12173eec.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Mar 2026 23:03:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773295395; cv=none;
        d=google.com; s=arc-20240605;
        b=H1KUNSHqVtSS2KruSKbf6JtURo8AoXdFXv7zKlX4iGeAdrKYXmni/RjSbsRDZvx2OS
         Wd0EYrS9XgWUq+v+lH3JmnN0Kt/ic8ACRNNFxKl6vP4GFrmaSEwCYYYH7CLtS/wyp9u2
         KTwRnyQB4BI85Ko0u8xpc/tWnmIt4WvZRN8XyKWpO5YWvJyY21vIlZdMBJJnmc2tceYm
         2tKJwybipfIDZkUq3A6/XNE05ZlAYVJIU5fAIbBPnh1c+J9tkFI/+gfneV5HXM2R8TQA
         Re37iL9rQqzS+ehfrV55sz1Z62jxylADTAEWdsGWu14j95xVFtNRI7Z+jXmEhUQgViQx
         laNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+oBB7oSL3gu76ZFznOdzZrgvR1lE4r0/R5vjiHzyszc=;
        fh=HUZbAA2YDHgL74K6l1QqxgELtAVmPD2b7cguaNFxKVU=;
        b=NtzNR60LNr3yulbvv52dy8tL10HB8LHr8d9gSPMlG7exNMKWZltByT/7/crYoO4mXa
         5br3VzpTrHurA2fKUuFOlvbammk9YdWTzabZPWRbBNwtWEp/gI1QjqpuTnBOYZfEFRg5
         G/wsiOZZ2iPP/DVAHBx/iekRY/E7ioswJY6pnDvks///bqj7O+Sq0XE2JMdcqY2RZFwW
         Liyc+aPM+dZhO3vjxpCnlBJ6uoR0bG+JVxUNhx+7dJVg4JaO7e+PjfsulS41y2DhyVXS
         zWnaqifX2vkIiJl1rU284HomtG+nCjW9gmSNTEdqf5wNfA/8MdmBHPZFK3ZQWLAmrexM
         z+Mg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773295395; x=1773900195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+oBB7oSL3gu76ZFznOdzZrgvR1lE4r0/R5vjiHzyszc=;
        b=GA/WBfiw9Mlc/fVaefVKQ5oTphsypv22kwPp9XeUkOTlRJqB/qCRwQVJAmhsHS8Y3W
         Kzwo6HisCZRnqhfpwHiu1TE4lkt6IebV0Q0VmzIHSgRsIfOVk2PxThOIqCoDoco8wEHG
         XE5ezRxKGxiFJpvd/yS2gtyEZjpCif29p4/5k4rPP6vbrZQJDz4DsVkWvXvVTCPuwFIl
         VPEuhCRaHDgZjd5yMXTYi1jQ6WSJAU6OPZHZZdP97tL/f3R8/+irIqikwvD8OX3QSLen
         vEtc7RY4psSMRofCRbCV/IOBnpc0StlEnrRDjhSexlFSjy0Jvi7TxFNEW/ZeSJJRBrYY
         VrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773295395; x=1773900195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+oBB7oSL3gu76ZFznOdzZrgvR1lE4r0/R5vjiHzyszc=;
        b=ilbGbpF4Mdto3V/MdJ5t8Bf8fkUmOFptdz/iE6miThqkFst1gYrhqCcvEojaAE8bRl
         T4Ve52px/w/YalKJKnF4QHr70Ki05u2FENMn9TUjwQ9+VwLZMCjfp++mCa+NOolaS+bz
         eNubiJx4JRlH3fmVY2viGnVjXRtCOxUzqNsm9B+fv6uIUvyVgBedl8cQ9161EAEUPoyO
         DGSghxZW/hHPKMm2gfURrYfcHuOUfxT6357QDQgOzjm/4wsG2jg9ghhIMVxGHg7CjTVK
         /gOanuWt0n3avCvugp7btJZvxVvs5iQLaMe2yZaE64uFi0+rAE3R1q5IJtEmXjBlWpZV
         SUJA==
X-Forwarded-Encrypted: i=1; AJvYcCXdyYVpPH+WdBm+zuI1C9kFyoVP+d71FD+XjWxWA8sde6y7S+iX+nBF7gim79JyCBQexmPf5twTsA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq4N3/LykQaHDzMhhonjzdu9WqeIQ8jrg1bMtjYBdaUGEK94BT
	xESTPDz0TtagGSkAk22imn+zMVw1qkiR0suPrOVfvKDE2e5gdeNqpmMTmC6gv4DKElrFWrDFjiF
	RIAr39mO/5I6tqxmpLZN12MJ4Vn048gA=
X-Gm-Gg: ATEYQzxSHWrsgvhYVJBsPC/t+iFpBr1IvFrpAWpDd3217Le49nQiDGh11IHKL8FrwQC
	/fgpKmxdYxtDPYvbIPNtg7Ol/1NWgtUUp9lsRwPlY7ceu04A/CsMZf1H3rvu8P3U0rTQKrs2ILH
	/b+6dynshlmyaQIWR8iAjuohf4fHTbMdkjrVjUvdWK/RYqiZuQFy7kfRNM0ZDVB8jpt9iSNjjvj
	rEaI8hUxB+idJXO0M3twTvE776/9cE12w/mpWtVaAvc46xzkyUd29rXKYbcHsNWiLONYsrZwGHu
	YJVSzdHVxk0DyDhbiV7UnD7inu9O1fMRax7f1bs18nkxLuaqER+YH4LYTBLB4gFR0EXXWq29FPB
	ZSg91AMol0M+6cPrwSJsAupY=
X-Received: by 2002:a05:7300:cb0f:b0:2b9:ddef:2c13 with SMTP id
 5a478bee46e88-2be8a5690dfmr1190215eec.5.1773295394675; Wed, 11 Mar 2026
 23:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312041934.362840-1-jhubbard@nvidia.com>
In-Reply-To: <20260312041934.362840-1-jhubbard@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 07:03:02 +0100
X-Gm-Features: AaiRm525bmoStQ4ctXWsBGXCIjznlgr7HjlOAbhdTiG5pl2QJtyapP-xC8G6bPQ
Message-ID: <CANiq72kYpm5xZ+ppWuSg1O8zFQYgmbuJHBYh4dpgp2c7=zJJiQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] rust: cpufreq: suppress clippy::double_parens in
 Policy doctest
To: John Hubbard <jhubbard@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
	Alistair Popple <apopple@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
	Shashank Sharma <shashanks@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 5:19=E2=80=AFAM John Hubbard <jhubbard@nvidia.com> =
wrote:
>
> The kernel fmt! proc macro wraps each format argument as &(arg).
> Passing a tuple like (a, b) produces &((a, b)) after expansion,
> which Clippy flags as double_parens. This is a false positive,
> fixed in Clippy 1.92 (rust-lang/rust-clippy#15939), but the
> minimum toolchain (1.78) still triggers it.
>
> Add a local #[allow] with a reason attribute on the affected
> doctest function so it can be removed once the minimum toolchain
> moves past 1.92.

Cc'ing Rafael and Viresh -- do you want me to take this via rust-fixes
to clean the build log? I am planning to send a PR to Linus for this
-rc.

Thanks!

Cheers,
Miguel
