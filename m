Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794172016;
	b=0iPJndl+9k9eitgiwvZyGdAmYdfwm3xBpzPCtlcyhhIqeJHaOV1DKzPBkC3csU6NY8ol
	 DxRduCUEzYymXzKLv2KhquKgShLOlvWj/79tZD+qdMVH9C6KyotI4r6FVIPUF5wrxsL4j
	 PVvRltU3kk11XSPIre2czu8jhbA0AulUS5n4i6RbN5SAx3fm6dIVeln3RAuqJCbsqr/Z5
	 HBuDJq47YTtUzJO5WoNPJPZ5NNHg+mzVJ4z26O1CiMuOZBnn+5jX0FRUmywk642FcR4R7
	 j/2tKlRR05t5b3R9AEHYRIMikeOJTT6jaBDUPMsASfi+UxeJZAvSrA26SiGEzGpqRZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794172016;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Lri/WTSWkrPmnkfmb8OPckDNaNfPxlDZN6oZYmR6lYc=;
	b=fh9C/AMT2gX4rsGKV/rlIiz2fIF5U5HK60JjWq5q0B7MUOJXiIutqC5v3/gfWx5fD+gF
	 GNz9vqrrTiMxyb/4a8sreuzxTCOBSLhFBauM9poKi0iOuyDGXgkM+ZZHUXd7sfamH6gmn
	 RtpKLY72/isgdjZYtCkkN14cml9/wVnrckQnEGYjlk7XmBf60N+Fv1ABE/z6f0ZfqlDZC
	 fyz4N6lTTD8kyZ1LrYZ7i01t/gIQ0XaHPOBxLEeRGGzwxqEY8Hhj7jzL4JiWG5mdGksEK
	 UaPH++YPU95DqGcR3O6Utml7qvPbvxkjvNvgKYR8yObXHhlL9UyLyHUdz7AI5MOFxDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=googlemail.com;
	spf=pass smtp.mailfrom=googlemail.com;
	dkim=pass header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b="V85/hf9u";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2AE606A323
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 21:06:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E2AE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.a=rsa-sha256 header.s=20260707 header.b=V85/hf9u
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67990a45e02so227528d50.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 13:06:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794172015; cv=none;
        d=google.com; s=arc-20260327;
        b=inxJRjj942Ui8XzvS/XWO+Mar3xQSrpIF5rERdUCiyhRdwxaePw2D484Oe7sXn5u4C
         L8HFa3ajKqEWvp2zW/xD8gd36K2Gwuct19WkA3DjdAJeKBG30aA15lZcNmAehzNsoObg
         w4qQ7kMUwnVNTmlVqgaFWY7I7YtjsVqzTTeKkCowlcUCUFIXAw6MRuFajmDnYFZZWD6k
         TXiQvzyQUeie0fPLhk8PsnudPZH5URmAmuZ95FHJuAzI+uy3TdfV7UTl0ar64at8ut/L
         mnw+nETAO7/e7uRdT1vwiKwzQOUEk2HAeErZ5VdtEx2O/PE9H0MsNvCD5VdcPDArRDOZ
         GARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lri/WTSWkrPmnkfmb8OPckDNaNfPxlDZN6oZYmR6lYc=;
        fh=0+0axZxWfgyi/AbVqUrBfKORwwZ3eb6ZVidn4BEdf3I=;
        b=bvrfd82+YML3x5lFY8/INtQnsvdPoMNJrWVZvf4Wbr76tAwQHTVMgAXUIh4DemUoo9
         1SfSc+aQts4zulLH7sOkpcR9lNjUN647MUDVfRe0UtTScXMX5MluOvpHdBPKb/bAEpsB
         MyqWTBksPTbgpx+bWzXNuQchxHmphfVm8RYu37V+4s0sMNjKf0h/JgO3OBbucAbT7dHZ
         5qfKyW25M3lU6tUnqvftr4ZnXTpL5r9UWqwiU9R/v856Apgu7ojYIQ5EoqP2qT1fwIsv
         6WoF/9caKOw4n2O5x7OWbo6CCOppYHeoJ33SJyjfdGfYs4uYZTOpLQPzh6HlwYX9JGPG
         Tqqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20260707; t=1794172015; x=1794776815; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lri/WTSWkrPmnkfmb8OPckDNaNfPxlDZN6oZYmR6lYc=;
        b=V85/hf9u90ghx3A7sxECxUZhOaH7CbQg4qo/SSPFUlDdIJmrmpQt/ivx824AWCa2m7
         WefO5cXfAq7GVNpV/oYsMnkWobgtB1pH3jf8nJZECc5zkP2wsCB/shZ5JXAXF96tVDL8
         YPA26M3Y3aGoDk1DplbJb7fRi+wdme+tC1Zk+t0Og3Y6AAlS8NX4P5S+ktkwAv4Yx56F
         5yVmYZ3GAuFS/41zMprN9oP1IhPKAOgHhkbXpLVFKPf1XJGGLNFf9kf+q4TZea+xuzqj
         1fpihBNTIFn4MXblf82TptOvEugj8jT1q1hT4vxIV7Q8vvIrbmEFxotXc9tDIXOeP1Hx
         wnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794172015; x=1794776815;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lri/WTSWkrPmnkfmb8OPckDNaNfPxlDZN6oZYmR6lYc=;
        b=xpvTTviCEHBSuFITcibknk/fJv/auKZhcXZkXMyYtt7jFoIIymvChNd2gnvGKOBHS0
         IF8Qfn/92vHwq/0iTRhTJ/AtQBNHKJwwC8YOegZNdYW2jhCCniYQvdrq7WTyrJJr1U/A
         TWDogxq16vgx0SPtc/Ucm1kUFXG9qnCcamz7A2lL5qZzjBvcOHWiaDqX6PonoBlWl+YL
         aVQZPY2AKhSqaDJHXwfpf2CTgdHTuEfegGtgbHAiclWKWaUnPTZFoGjKkGc++likWBfl
         85CtgkDjYv14rBdsYgb5r+bAg9mKnu9Xa+rmWdqvIfVmrzEqwmJt6AUzvCgiI1AcLzpa
         81Xw==
X-Forwarded-Encrypted: i=1; AL+hErEUwLoTmS1MCxIVyMTNyxygeyUPxW8eqVhkznFUcTyMgatt/v4v5UMdCePg4blCtw79wALmQeqaUA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9h6nKHXyN2nmy/yHSzjhs4TgWWp3tkZ6TMrTPbwiB9upoCF++n
	GEs+wOUfe2u2N5X68/uJbQR5J4tBYORtY9nHmSeWVdGbD4+bo9cTFsopEDmg3BwX0TSBctgTVDE
	HFV41AO9WzfYCZ4XIXOyMubiCK4BQbc0=
X-Gm-Gg: AYBFou32+P4/E3EiEvE0108s42G4JgI6koxGsJzp22GAIvRUF2D77zkMMgui13sYwA5
	XR0j4EnnooNMlFoZLEChlMqy4+02S0i94JqrnFSZPfERiDdYM30LIcMl6Ah/6a77W5viHhPa2N+
	xFvvWFD1nuydkYxXjk5RzsrP4AvhYy7V7dv4PKMa0vU5aRLqt8fd3KySMO/TlBat7ZE9wWEQeLS
	7IVnRVhP/+dyZsXmXJ6LINplx0XwRNtYG7d4LJpW+wcFhUhozHd1kK4iBnyoyxkatQ/HI2GNBmx
	opeGmGLHuzELSNhSb1cj1igkKTU4f7hPHdJwHi7b7S9eXV8Y1oeY34RUrJu4roUUwJdQWIRY8o7
	JEu2GXdlEQmJE2QjbSEgyvLC0e9+6KtMyQeGwb8Q7sGIk0LDr70FiM/9gztc3ELK+YvYJcg==
X-Received: by 2002:a05:690e:4084:b0:67c:307:205f with SMTP id
 956f58d0204a3-67c3d9bdaffmr1517575d50.50.1794172015392; Sun, 08 Nov 2026
 13:06:55 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106101913.46664-1-christian.koever-draxl@student.uibk.ac.at> <20261106101913.46664-4-christian.koever-draxl@student.uibk.ac.at>
In-Reply-To: <20261106101913.46664-4-christian.koever-draxl@student.uibk.ac.at>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 8 Nov 2026 22:06:44 +0100
X-Gm-Features: AclHuK-74c2fIbgObwWVEcBBZUrlkOFXR6g67QOovSh9WdTOcreJmeRwgf3g9rg
Message-ID: <CAFBinCDKUmA8UPL86znCo1XwvDrwcvDsO9ZWgs1KkWSA9kZxcQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] thermal/drivers/amlogic: do not log the secure
 monitor deferral as an error
To: christian.koever-draxl@student.uibk.ac.at
Cc: glaroque@baylibre.com, rafael@kernel.org, daniel.lezcano@kernel.org, 
	rui.zhang@intel.com, lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, linux-pm@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	=?UTF-8?B?Q2hyaXN0aWFuIFN0ZWZhbiBLw7Z2w6lyLURyYXhs?= <ckoever@outlook.de>, 
	Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 11:19=E2=80=AFAM
<christian.koever-draxl@student.uibk.ac.at> wrote:
>
> From: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de>
>
> The thermal sensor usually probes before the secure monitor, so the
> first attempt always defers and logs "Failed to get secure monitor
> firmware" as an error on every boot, although the second attempt
> succeeds. Use dev_err_probe(), which records the reason for the
> deferral instead of logging it.
>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Christian Stefan K=C3=B6v=C3=A9r-Draxl <ckoever@outlook.de=
>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
