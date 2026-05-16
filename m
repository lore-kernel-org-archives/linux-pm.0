Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728AD305691
	for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778963731; cv=pass; b=fJz9KU3VoM2TZ2z+QZYo2Dxk+OBCA3YJBOMSOuzyO4adaVs/TsNOMEMSPuoCSi5YMrtwKbQeEZiXwXL+sSSOOLLaS6Gea/E3TNgwtbTsBmvA0EhLD0m4pZAaZHdEPi0QUW6TCOFfLdPcbAJ5N38qDIqPZr1XV/AcpAu8rfvdEgM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778963731; c=relaxed/simple;
	bh=BPzaDMTJ4FMFviJYoFNi5cUlUPTXvCN6U7hIvDbkvpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nyoAOVn8UTtitlLTvIqjw/t9jMsEkt7UUtD7RtK0TkPtpefKJWAIXtvVUrE77CXtHPNiWRJiR+D6/GzQJCMqo3QFGIUdrXq/DUb5S3Y1tnMJ1QQ7YIcZa/XRzlYZaIkM/Qg0ITeF7Mbc5DQ/e1rB9+RBAbJAb7G9nRh4BlkP4Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6roq2Fd; arc=pass smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6roq2Fd"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2f6e6a0a215so47073eec.2
        for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 13:35:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778963730; cv=none;
        d=google.com; s=arc-20240605;
        b=ARxmd7UHbYlb+7vIn8zAmdy1BJp9/XL6QEjM6ATkio2JfKJ4zbaoVNjU6KUn32rOLz
         n/k+5q4k8AiC6C1CvJ1o7wH8qD2Kx2BEuZQTuW5+beQ/gJ1xxFrnLai3Vhg3QH7JL5xH
         hyDB9MF3ZQgA09KKwQrOU5DptLTbIPP1OMh23ZF3L0XHU5KwGOWb2SwEcGpyCPm5NAST
         ZfozTxohn9NJuycaHx5A/jwkDVKNgRkvjv4MftNxrL9zPrxZg/kiugVx11Mouv3SAXZh
         +BhAuE1pfhQIjrEWhzEgRI1WQeUGTJYynam+Gteg0yuG5RWdfHRlReG56dXw798VKRGD
         vzSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BPzaDMTJ4FMFviJYoFNi5cUlUPTXvCN6U7hIvDbkvpU=;
        fh=4+MaFcJMifHROF6kf3Z//G0ru7LmsQ6Y1ziv6RgrE8Q=;
        b=OIZ0ZPReuSaTMS9T9XamOblsBgOpTCIliKWqyhzeDhBsn7oM5tc3N/rDqQWOSvX82/
         EC0EB0niGEjlFWCrd3jGPqeizevdqwc/MqSvyRRcJPz6mBNuxXmi+CLgFuWrhdqOvqpa
         S/dgiM6KwC/NBPWTJ1BGUhQCya/8Hwf6jPO2ZYwB0Xd00cK1OzkNMalPlBRv1lMYw+ik
         US23SOhXm/2HlkmEUpc+wcEmHAai+n0uZuHgIPLEwrhgp5m2jYxhHZppYasKH8jscRK3
         rL6ZHINx498p8LKURDB9D/Ptaw4nM4/bkk/w+ftIQMay8cQrHdgaT9F1+9wiLuJ4om6L
         0HrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778963730; x=1779568530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPzaDMTJ4FMFviJYoFNi5cUlUPTXvCN6U7hIvDbkvpU=;
        b=H6roq2FdZZgR6PL07+etqmp55hQjJxKEOIijy1gpRO9dMXuhsdMriSut25d5PxeQO8
         YBpF2fIIEUdnhFEGEf7r9W23aYldizUH2e8S46w+gKATsfuV8TS+nqJlp27Ho3ZQHgFG
         gd3zaTxZ1S0O5q1IZE/527ekp5o1DHj7vY2BSbhanZdRs2UyrPeuwnbAKBOrND/lFRSq
         jXzXw/BKR6i64Or9sYEjCv4C4oQtds7/HpR/7lVPu2bp4ZNZvpWVHjVjZT6qPa3T3is2
         qq0bYsDtMC5ZCQDWO5YpbO6PatCyqZRhTbbE/F3H96C31G165rZ3u2dUj/OJPGxV1+jL
         d36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778963730; x=1779568530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BPzaDMTJ4FMFviJYoFNi5cUlUPTXvCN6U7hIvDbkvpU=;
        b=gaFBzUYjym/FATkp4CvzbHGbl4hd9TxDK9Gs0ZwTijm6NBZ8cQ6H7rMbUebBy6v4wH
         eP+w9NOSjKImU0piRNHbU0xEQp/ann/z8ttXTNoo4rAdyvNP5EixLq4HmOodzHO3bKg4
         Qig3fLVAZirKL3/zRQVhAr3+3UVrU1yVB49vrb5JzBRS0Xr0op15l4H3udfYlx9acmUj
         8NG1CvXh8HeDSr5VJ8MHTSbV1tBnC8ao4Z23YOQHfcqCPxNEutgLqRZvR6vbmXOMcRze
         DanNCPhGnZQJ8WBAfo7SRBW97MaNrDob4Ynbp8moq6RB/dhSkXICHigdoG5m3d15vnLL
         AQqA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZDrDeaQcKmOM04Q4uJ91Vi3rYtZds8pph9LSmP971N6lhO6AL5caZo/n2LgRi6bf51svrLFdWzQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwDBV6VfHfzH+j90uZJd524upM4WRVMzmk1XfU8QGQsMIWvecbj
	m4naCnjApBfQDmVrWQu0BFf+ahrrz7p6JjrVAZbMwZu8WkOEJb1rJWBLceoSWVZDB+Zb4mXjiEx
	0UgTZnDjmO7CviUx/WyokFbBqLVjutkA=
X-Gm-Gg: Acq92OF6uU5VXd5xe//Uipx3XEYgyjk/eycCTbbQ/4MKmO3bTInYA1+3PWwOIuLG03H
	J694sCI5sA3DGKv5r29BbMobiyQkUdfTsAqEB13GdHvW12s97eKmihQCqgkxQPNh2bvWPX6qu0N
	GOdbzw4O3KZCe7vO7nbCBPCbq39ejbnN97BqAxOTolXC3zzA0E6MawqXRNKVvPmYwOrLgGh02rM
	YgpWyVCT4qYAMTmDN42ytbbcQakzUQF2xwlZv9WnocpQhm9s7nyYU+3IE90hWxb4hy9l7qsUkT8
	fXMPxN8iTFGffGcrFGMA8Wum7BRrUwp5B1lJZoB8Sz9HGve8VyzVMVRHNTpcPdI1200jPsK8CZJ
	1YZsp6512lE3TjLbX6oN14PQ=
X-Received: by 2002:a05:7301:644b:b0:2d1:9b35:4f03 with SMTP id
 5a478bee46e88-30398652434mr2017744eec.5.1778963729561; Sat, 16 May 2026
 13:35:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514150957.3501924-1-beata.michalska@arm.com>
In-Reply-To: <20260514150957.3501924-1-beata.michalska@arm.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 16 May 2026 22:35:16 +0200
X-Gm-Features: AVHnY4KpNKN-noX8erOoZUiIm6VUAJi1ESwJPjMqr1-JwtwRZb1wnwHRagz7hhA
Message-ID: <CANiq72kQ5=4-5whthbyTZ1VrdwHoZjUOKY8h3MCTRFUymBKD1A@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Rust: add runtime PM support
To: Beata Michalska <beata.michalska@arm.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, rust-for-linux@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 5:10=E2=80=AFPM Beata Michalska <beata.michalska@ar=
m.com> wrote:
>
> This series adds initial runtime PM support for Rust drivers.

Cc'ing the linux-pm list as well.

Cheers,
Miguel
