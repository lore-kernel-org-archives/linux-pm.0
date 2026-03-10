Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0D2FB632
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 20:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773174683; cv=pass; b=Sy3BEJMadcoCZCsIxUvwVOEYScpQZ8x/aZkm0H8WWajOcQBM66NNhM6ckk1NwN9cUpizCy3wRUOvpOKJ258OB/MbSVaE2WjLugB312JVPeMZCIJhq/eEgoxDV1zpuOWpJjZyiudbESKvXz4WQVCanFG7RZZqKiEEWyo4DmFe9XU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773174683; c=relaxed/simple;
	bh=rGwT+iwlPcz7fLrpp4wRsrxUUp+hs3Nud9RouFTF1L8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k4+de3E/2CJxOB0YFRKQvFcpLAgliV8jgj+IP8CC/p0lS0N5wt1p31P0GD3OKXCHhK5WfP5wQJklf1R/pxsTbAQ/Upa1kZinQ5TrZ3RYdJUi5jdt4bvGD9vumMUUxhFuk9sgPd0wPMTzOaXv7Z52bHRSWyX7ZRaBGcOxfrjhFdo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbQaL4EJ; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbQaL4EJ"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a133502accso6713992e87.3
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 13:31:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773174680; cv=none;
        d=google.com; s=arc-20240605;
        b=cDq8PlmXB3IsfXKUAfdtHElUl2Wwk/JBJtt5YJs8JZg7NAjS2QhANkxPSG2Nk6JRKp
         7C5c8r8r0YBZ9jayRWVJ8+29dgJmzuQLc93Vb/mmfkYc/p40kgvPjrM8AKFaAhX2HUDE
         1C5CNT974q5nQXxgtGvOsCMMiX/zAO3NANNS2WxtqUBXF+VlPTTj7Vy5R4IFAXQXGXuo
         P8Uy2zfxiFBEo9Tg4K2wU5gvPVfZftXugfFU4uEtq7wF4VKUhlTgMOjjPl6BFBbB6kxt
         iCV27IYwV1bf6QUNCFUxTsOJI1+deUylGM8wA6qGwQb7D/4LCu44JWj0udTSsiAAO0Lr
         u7bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q0TVLG9JTMKpn6Vqwj6rN9mE85YOz6NbxAoBKHU5OcU=;
        fh=296HC3+12gB63LDZNaeFYExZUSZpOxa/hDbykBcmIJs=;
        b=LZjcD7ID1uo9nMhGKgMS1i8dL63arJYE8McSuwdkIc/aYe2I0m9U9cAE8mXHTwGxYG
         5ymr/1zoPVuL7LcBeFCz7ysNX3bjHCvrtH0hk5sEem+2kXE8N7iRXvvvKyIoy8B00Vmo
         gS5jqxOcjJjfbrPGOMph8QwcjL/k9/kUEYwCWwkq60YEYoMqFECKi+0BjwWYupFizxL2
         dygY6K2tU4+uJdWlYqTq/Wub4tgvi7SGakAacc9k6/JXQ64hV8WWLelBxkZoT4OZxWF+
         o2qbAEdnboNs/qnAT10Y5X7g79h0Icv4R8CSVFcXkKe9PABxSsIDerVaUjJTCAR79Ykw
         8lzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773174680; x=1773779480; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0TVLG9JTMKpn6Vqwj6rN9mE85YOz6NbxAoBKHU5OcU=;
        b=hbQaL4EJmJEIzSOvXXfcgm8MHqHCmkDSTVzuIfxj9iLC9GpcGQfsC4Qj7GP4vpmq7K
         Sn3hVFvX/RpnEnbk651jb8+LFiNifA4TUvPWVO6neSdHkgKYrOXVIOdSQECu8eDor4FB
         0XlS5u9tJkMqSL/B//A5PncRJfO55EShb1z0JiPCM63Wup2JoRmkrgTrFJyN6vGnsbGw
         7vKMNqJTHc0K9HwOMlq6XsP9UjFITevfLpN8337lDIOGiJpp2PqxjsEXjWP4NxnWoTAN
         U+SHZAB6SGyRHk5/05sDbM+gkv5p91zktSn7UG8S4uVfdF2i3Nlt3Fw7gfIeOBZycHXz
         IN5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773174680; x=1773779480;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q0TVLG9JTMKpn6Vqwj6rN9mE85YOz6NbxAoBKHU5OcU=;
        b=tk8b7w2GmnsmjLDmroLQ9/Gr8ZBjEzfqBLUGN7aU6K6SgI7RZxN4G5svTQI2V5pC9H
         i51XAuiwBZ8OPUNhrrIz6US//EtPB/Kfci8M3AwofX5W8CogGgWPQ4Va/l6Rd9XvgWyR
         r4qjxiwG/DNBCGFkPm2JjuyDIPUW/nu49H+Yvtrjw6vSOE+R/i7UngzrRsCVJkCgh9Yy
         tQE1au13iGKJS4vLs/aLz8w0ySU17ExR3UTnwR+OE/Izrx5atamvWCxW8N+TPn1Y1HUa
         DlIvldpxBpkcIwxNcIdTO9o57aq3vnRGzdOZrpqVsiejZzsFSbD5hulUHYzCy6eqMZz3
         XEKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXjFPoV7bWydSswKHICma6+/yiuFvI4d/25OjDAtcFDoAbBq5Y8MP6xVXNj7gmGdfZ5cmEMk34fQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdP3lD6BVGt9MIv3/cqetVjFDf9Qfqvh8AdtIlvRzde9rknC0z
	ZcKGSnVPGDZ+5xXgEQ950A0QGi+Zthr9ixVlYuMI1lOPZ6Q5wkvbmawOcc7fWyy/HYuiFVz3njG
	jz/v9TR0Bxjq2yx6PZP8XljOcD5n86ew=
X-Gm-Gg: ATEYQzz2Ky47ou+PDf3mQS5yxegSvEtBft9528QJ9hUChzvTepYpelz5+jgRgAEOqbF
	J3g1V6A/P00sA4H1sEcP9ADiRXNWh9tvKSNXnzW404tFnwL4STGjBB59bglYjlpNN6Y0ndT6L+v
	m+7tmOrgK5Q/mNGjYFGWvW4XRjqSKyGvi76rytGY/gdV2QjCWu3CkSYYTT4T2X8sI1eJjI0CK3y
	BUq5bZNDMxk4ClGAIChjHaC8ZkGmLZ2ena2KCBLokzid/Ly0hPB21gwzzWgpxxf1FeF94rj85w3
	8vvbf9ZARc9+mZMGn/m85Lxwaez46uFtTIBToB12EVOXXqC2VxpfR6P6TVx3SM0jmDcH
X-Received: by 2002:a05:6512:2204:b0:5a1:1d47:76e1 with SMTP id
 2adb3069b0e04-5a13caae710mr5357598e87.3.1773174680103; Tue, 10 Mar 2026
 13:31:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
 <CALHNRZ9R1XaYWeTneZmyAvGY-s2-rbSC_=bSV-nC8_zU+bGLqA@mail.gmail.com> <97134126-f1a0-43f4-a4f6-0c1bd85e0c92@oss.qualcomm.com>
In-Reply-To: <97134126-f1a0-43f4-a4f6-0c1bd85e0c92@oss.qualcomm.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 10 Mar 2026 15:31:08 -0500
X-Gm-Features: AaiRm50Hf3iPK6NugLvQSXXwLyR31efJNTkfa9DQKJe8sbkpY8MxEetmFEFA02o
Message-ID: <CALHNRZ8vEcq75O_M2A4F6p_Y000SvVgu4pAW5OLtX0ucAGAqFg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: qcom: sm8550: add DDR, LLCC & L3 CPU
 bandwidth scaling
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 3:20=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> On 10/03/2026 21:05, Aaron Kling wrote:
> >> ---
> >> Aaron Kling (2):
> >>       dt-bindings: interconnect: OSM L3: Document sm8550 OSM L3 compat=
ible
> >>       arm64: dts: qcom: sm8550: add cpu OPP table with DDR, LLCC & L3 =
bandwidths
> >>
> >>  .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
> >>  arch/arm64/boot/dts/qcom/sm8550.dtsi               | 367 ++++++++++++=
+++++++++
> >>  2 files changed, 368 insertions(+)
> >> ---
> >> base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
> >> change-id: 20260207-sm8550-ddr-bw-scaling-b1524827f207
> >>
> >> Best regards,
> >> --
> >> Aaron Kling <webgeek1234@gmail.com>
> >
> > What is the normal merge sequence and window for linux-arm-msm? I see
> > several things that have been picked up for -next recently, but none
> > of my sm8550 patches that have been reviewed / approved have been
> > picked up yet.
>
>
> This one is probably waiting on interconnect, no? Not saying that
> merging here is easy, quite the opposite - it's frustrating, but you can
> help by responding with actual data, e.g. bindings were merged and DTS
> can go, instead of just content-less ping.

So patch 1, the bindings, has to go via a different tree; then patch 2
goes via linux-arm-msm? Or does the first patch need an ack from other
people? I was assuming both of these could be handled by the
linux-arm-msm maintainers.

Part of this was a reminder, yes, but the question is still honest. I
don't know what the expected merge window is here, knowing that is
good to know if something got lost in the mix. I've got a couple other
patches as well that are standalone dt changes with no other deps.
I've had patches to other subsystems that have sat for four or five
cycles just waiting on the subsystem maintainers.

Aaron
