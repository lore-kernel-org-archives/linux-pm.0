Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC733FE12
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 16:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774714391; cv=none; b=BYAN/2h4fpVSdVvc7xB/Q5Jy2Xgv3szgT+BO++JzZ58SI3wBjhRxdTgDYKLDxJmNb/tb5d/i7aH/gb/2vI3Y56w0cJpjAP9jcVcCQPNI5RUVzjWiw4Y68kIuVnrIQZme/FTIWtYB51cDDF+H0GmXduA7hqJp1I28EQ+0uE6Xn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774714391; c=relaxed/simple;
	bh=4Z+mFQAbnt4C6pZCMBBWs9iSlcqzXB+lmQjLlU8/2bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7lLp9mEzkN/gGVexNqQ/5Q2xK59UvVcdZb5sWmJTfN0NnoAPcrSk0djD1KeXjeWFOdosf0j3bHbFEEZem5M3PS/ZOmq5FzIMDL/OH0G/QpPP7m2BPkG6IArf8uj1ViJwr4maEYp1pKnRg9CTf34Y4BsVoL3N3BgJQpkFL6B9kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIU8fSPm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIU8fSPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19C60C4AF0B
	for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774714391;
	bh=4Z+mFQAbnt4C6pZCMBBWs9iSlcqzXB+lmQjLlU8/2bs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XIU8fSPmvCa1mSgtuKlJsfoukx3RvSzIpkmGNQxSqxV8mHLL0DwZ/jWcguvZu1VtE
	 I9P5zEr+6vI1C1n7iGyWr01wl500T2TvqnhADDLstVkdpSECIARTThLDiJYvfMaR76
	 rQFy9yPWTzvqZSzhIk51xPEXztzNDNIW6P177n0m8Q6y1Wu6vCmnxW2IZHrNlf12H2
	 nISqs9736x+YG3VjDciyQ0Fg6EYx6CEqo840zhYwYOcyoNvwqsFy+0/48BWsurVSZn
	 eeovDDfkKSbQT0voT/EHpwM+iuu0C60YeI4g1xBQoMopM8lsIMoElW25WSGyEfTBrT
	 dc8vrRG1Y3g7A==
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-65013b72ae3so42933d50.0
        for <linux-pm@vger.kernel.org>; Sat, 28 Mar 2026 09:13:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU1IXz0k+q7oIYmE5lYo9xgyj+QlrGUQU/oIDKap9KQOByOMsZAId0Wy4rh35oTp383BRM8MC8ohg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyhdMA0olkur9biPh9xhFsnj2oihg8CpzWx36YgpLgmnEhl+lkg
	LK6FyTjsYyGZ3JxfWB3skvBiEcoYaDHPzPebIuRyggWcw54bH20oFLm6whMUMSfX6Ib/7ztXcnq
	JWbcttt2IDLc+3tPQ/vAZbG8EX1laz5o=
X-Received: by 2002:a05:690c:112:b0:79c:3750:4894 with SMTP id
 00721157ae682-79c37504d8dmr47928027b3.51.1774714390488; Sat, 28 Mar 2026
 09:13:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260328124707.141209-1-khushalchitturi@gmail.com>
In-Reply-To: <20260328124707.141209-1-khushalchitturi@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 28 Mar 2026 17:12:59 +0100
X-Gmail-Original-Message-ID: <CAD++jL=iVu1S8evU9=sV=k71u7n5jTMZ8YrMJk5icJY_+mnPOQ@mail.gmail.com>
X-Gm-Features: AQROBzDklq-GQh5NZyXhDrVjjCLpLGzhk6urwqG_znvsVqpJXZmDneHSYF7yTSQ
Message-ID: <CAD++jL=iVu1S8evU9=sV=k71u7n5jTMZ8YrMJk5icJY_+mnPOQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: power: reset: cortina,gemini-power-controller:
 convert to DT schema
To: Khushal Chitturi <khushalchitturi@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 28, 2026 at 1:47=E2=80=AFPM Khushal Chitturi
<khushalchitturi@gmail.com> wrote:

> Convert the Cortina Systems Gemini Poweroff Controller bindings to
> DT schema.
>
> Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>

Looks good to me, and thanks for looking into this!

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
