Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA623290A6
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 06:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295457; cv=pass; b=QjyABJtVRR7o2iH4GC95souCVa1ZTXPFfZnDcXQx7X7wXCRKd6Z3vI1wEaWLMKWY2mRB9rKK3txdJfcYvXDwQD0y4fTphHcIl6vaWZxRqh8smPyLPYDJnrNrGSDZhBGhP8pUkKW8XLzZJOqqzUCHA5nCT8AI1BY0ThD/DQoLN1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295457; c=relaxed/simple;
	bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JH5yZTCFDeeMU1VhdGP+0hz7gLYD/aW/vGk08Q5dNRNjduhYVoEpH5OWYCgTbrfFdpKPJKZo96UgMFWYWV4jopanToSPVSu3gK0g7lPY9dveyKU6GxJdGik5Nl2H2OIQga/F31VpoP2eR84Bg4YsSpIJBteBnEmBYcVr9ENeKtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TewebJpN; arc=pass smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TewebJpN"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304e5d3cdfeso168994eec.3
        for <linux-pm@vger.kernel.org>; Sun, 31 May 2026 23:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780295456; cv=none;
        d=google.com; s=arc-20240605;
        b=dgNQNW3Mf0HUBoN4DRGE7QTroenCtIzf8BSOEXF9Wf1HejdH/9PokD2zKCX+H3qrWP
         ni8xLBDyYxGMCoR3u++L3UX1ss0Y1Z3B3Yb82UM6fH5YQnSkxEG6PjM0q5IH9EC6O8b8
         HifI/lVji4sFpuFX97P+Tq4EkgL3WcqHKfNo2teQFKn+Zf/C231xRR4XyHCxWI3bkhzG
         QWPiynLRIaWcnkSk+9nKoDl6ltJmwtZha0EMM/nGpPtNbaCvN/NNwW3h2tcfsMDGldQp
         aq6ZXB9KS3cR8y4Qbc6vTakzOlgbD9w3ynCCa0rZAd35WaaecFTbJRzSiwF1wi+wCRHL
         njUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
        fh=647DIYHzO38eElUXz7/exE//TiIm6aS+GQ4Gq+WDFIk=;
        b=Vc1abzXSju6Jmfwq3YLR+geY2OqAfQ6IP7HeUGbLvV9k9DxY2VBDuXhox6VXBOGU5m
         o8/Kq0lEUiC8zKz01sBOcSmPwmPtSN0fYkNy6tyxmhTUQDMOgzWymg3zf4yLvhIxKzBG
         p1v7fp1l0DYjsJV2WcZCgAyAihMNa4YQDEurGX6bF8O1K2P4cWLZKlK1KNKj4L6Orwk6
         qJMCegqTPVRoTqXDwXaFML/Q12Pif9c+s3rYpwrFv+jZaC02so90bA42fH9ztq3L8Gfa
         10pGe0ttqKrr0x9c2X/qwk8lmU24Mk+UIaDP8VyN6n4hBKZaj+fKZHZKBjg0jMndlpPL
         7unQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780295456; x=1780900256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
        b=TewebJpNtT6qAjTZUa+Mh16aWsN8/d/7b3VddeBekOT6dBZYswciaPWb0aQ5iZJCyf
         4baxLX5lRuW6PXHqZZteTZ4MYFyYmFHYxQewdtTUz0v6WZe3N4Y+Za52bSSBYcc8atW9
         XqKFeoRGNJHG8Z4l78aOK92iCqV0zMYn/DaIbVIczgsCXnLa9EXoQqUE1K0KAayO697+
         fWAO2owf/6pFEgo7Fv+hfs2mlEcNf0eDEfJkButpuEu1KNF/HKxVaCbj6K9LEtkgD7ar
         O1mwUp/kcuahZ4f4CWbhwGwTuoIGoyMUlvE3tQcl7QlXFW+kk/wP4hWDB4lNux2EAOpj
         PRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780295456; x=1780900256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R1yhEG4MKoXjJ4bO08OeDXprdSO1fiP+peqcjquLtrs=;
        b=kw/oScaXvM3i948E5c1BqxBavKtA/cST2nf9QOagIdBI2hmM/KpbyW4FH6yusIAbtK
         T4sPCh90cVZML/ufUSc9bkX8tqHa1jCfsm7GrC2V87atRGhi9WFIsPYK8fAN/6AP5i03
         M3HScDHpZk41HEboAcznVzZLAu0PkkymH5re7snkxrW/ovttI0wj/d09FxrIf031rBfH
         lfJaXmMbQ0/UwqxXgbIMjhWVfZ2m2McL8nbblT3rmvgt9H3phrC/5NKvxceiOXoQxEKM
         ++6x+aujO0UPoh5AVuVu3DxIjcsa0Klpkn5xzkpKe6RpMt9wc0RQR34+CfnUnlu1fWMA
         suNQ==
X-Forwarded-Encrypted: i=1; AFNElJ8xdHpEiR8ki3wYgQPx2+RgCo0OMMuRArBwdgGYgn40F9gTETodhE9+ZHo2a83cat+5ZsUR+iAjXA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8x29UubAyLPmYQpZS34yg9+LdWganbja2+6xpsn0dt8nML7b
	3mH9I8g+xPksODKt5KPMOVqGOrOi1n9V1GWTz5OuPDo21QoCGyZYxXMDj/h64NQ21TQz01aNm1P
	lfx8W8NRQDCKJiRBTJgCqHYRngYly0BSFfUas
X-Gm-Gg: Acq92OHN8TevCKJON1yTl3zZcIB6wa0hk2xP/yvnxUWqmMhdRrL4bRHUoq4DYkWc4RH
	WpxmZb/4QBrS0NpTLgTwbrt01XiMVUhCgjGZ2egxYbythBfDE3FSFP59Jp6xrGKU+blMZ9/vwo1
	9nGBWHwX3IV9/KDZnNUodKCjhjxtNvWBPlGm+YQ2UwweRDWsqI+305G2/BgzvPE7k2/8Cc+4J1S
	dCaBE/DTy3b9T3BeE5nUOx6wpyPumX5SKAJdccyjwYiU8G6OMtvn4v8hkXdZhdqK7QorYyUcEnn
	IKbGAaz8hSVNRhjUbgyqq4kviJ2LPMAx517IwdzejVkB32WMc8tSOBnn7n3m3rYAOjifSZsFhmd
	MuTbnOQhslkNtCrZuyR1QRYeFNhzRRmpeeA==
X-Received: by 2002:a05:7300:ec08:b0:304:2af3:5fef with SMTP id
 5a478bee46e88-304fa70effbmr2039142eec.8.1780295455709; Sun, 31 May 2026
 23:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530095809.213611-1-ojeda@kernel.org>
In-Reply-To: <20260530095809.213611-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 1 Jun 2026 08:30:41 +0200
X-Gm-Features: AVHnY4L74PI_Op0lO-oFiwBsbA3m9WuT43J5CDI-t5H375DzSgGheCIUTH6PY5Y
Message-ID: <CANiq72miRU9Qz1+ehyNa26LaG4LbT1XcHgKoODRhoHBxxDdHXw@mail.gmail.com>
Subject: Re: [PATCH] rust: cpufreq: clean new `clippy::map_or_identity` lint
 for Rust 1.98.0
To: Miguel Ojeda <ojeda@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 11:58=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

Adjusted to "6.18.y and later", since `cpufreq` was not there in 6.12.y any=
way.

(I didn't use Fixes: because it isn't really a fix, although as usual
it depends on how one thinks about those...)

Cheers,
Miguel
