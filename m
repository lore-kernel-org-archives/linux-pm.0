Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794538509;
	b=mqpIdAPxUBK1eq3MDpJgNoRGp5Po89wcT+NK9bohE50ZnkDpcvofaXAErSK6JMgGdeKb
	 tCvvnhCpsjjJgXWuM3Psg1AjEvsEAykzcpbj0uU+pAmreoP3YbPnJfoTz2IUspSFfSB6J
	 DrOfOTNvOfOIbcXrRWkNOwdio946G4deA6N7HHzn5AcYBkWvWyzpxJPG2dDUOb0wlQP3O
	 /L5qVSTC5+t/St7nceevvSxvxA0shNtIrE10hQCXdxRfAtkGakYuoKLID2OntDmF6q4on
	 qSud+VOdAwJOB0WN62Z8dnl1rkD3czLcGq3ZOXInWc57gZgt4Ed36ag7+Of1DGYvbAw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794538509;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ww5MKM6poDK+IczcuuMJkcSdFtjq/phga8CrflKC7U4=;
	b=2D/+OdE8DPg98FOvzU1gyun9H7DnS8dm8tzvXo/qUd0uJPBPJJgHYtm7DNhlv/Uj3CIt
	 MSuWNeTC9+/Ac45M4gtzxedLwb6yreIwlCl+0Xm8zZPtfr4mA3L/0M3QnwF5XCXCIl6ZV
	 u+GanFJELrusXGLBScACEtpkRmUeVmOx94RtNK2ZPXehlRu1iiW8oYaSbA8kuA88CeRTk
	 hxLMNdeJQMuLCOi/h4tUZ1+Gy7EXwbjTL2M5/3CsFmVSUDKIyCE3OrLezP1oe6kxlhZ6k
	 uMkrzO9D0eNpAQrNzuJyAVUgLPHLOiYehIVBom7E4MMiS8XLlYLHpmg1PBnj+a2jSMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cfMDacLG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDBA606A32A
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 02:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EDBA606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=cfMDacLG
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67c05273c38so568801d50.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Nov 2026 18:55:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794538508; cv=none;
        d=google.com; s=arc-20260327;
        b=pzsRT3s0OpLG0GPGNcPAOyYz1J1CXKUIeVmjYoWUnIhDh2Jx7fouQmqnYrnNFUKriK
         vGD9cnLSaGub9OAQ/d1+dGIp2TXQnBGVfr322hTKzqT60hukVBWxvseF1RP1enJ/Ik+C
         z4iDEg233fG7NMegW2tlJJvQGVrEM7xjPAeh5KUDeh5YH3MYWHo0eqj0TpIBuffPlXMa
         3Ca0IhMsjVV28OKWREhVe7bKImKiKm0idrCpk3JBoprDbVHXQqH0QDpg/85vjLgcobay
         Qbn0N6sPELk23/PMw0/YC9h+2jFWzUucU+PFpI7/Z2ysOC3lb64CgKuIT+zCd1IUuBh/
         WQ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ww5MKM6poDK+IczcuuMJkcSdFtjq/phga8CrflKC7U4=;
        fh=IK+myBWKgQiOMql89nBRv2ZVSdBctaBATSWXfBcWu+Q=;
        b=knLMOC+l7uqF2g+jVqgytYI6i671YTI1+WCMnyRwMzeZHs+NmIIVinkTFQInterb7E
         npjxrnJKCIZ8iP1DVCNoUaS4XddQ4CAFpopkknUj83mQ/JZPYDusCaYwXEftWhQkmQH/
         E0Vq/RGeiLHkzFgMELK+efV+IuEa+TGRUe6OCZbh2g/zv1eI4pYKTheMVToWlgBPw3g8
         n6jClCCYk9IQCNn1w9rVAQ2zmVWdU2u4pwq3/M0iTjFCnDgiX+NpwVL+eV8eczBKVZ6l
         ZKHbi6q++6JjZiQF+nGkFvMa9cyqTBnjNzVkVZ8V1gy1aRX/dJMHejWAR0ZD+iZFdwjQ
         Q2Bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794538508; x=1795143308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ww5MKM6poDK+IczcuuMJkcSdFtjq/phga8CrflKC7U4=;
        b=cfMDacLG8z5L1KijJ6WpfqoVtMnSg7D8XZ5tsiDdz2CqKktuXLlbD7h94kpjdl1/7b
         C9aE2Mt+Vmjn0zOJ228wsa6m/1EYkj4AUAvK4/n1l2fZDAxmemJ4JmrlN72c7nlHGDua
         tkc/zZ81gRVblWv/lVLluemgBz6hCHNVaSc1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794538508; x=1795143308;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ww5MKM6poDK+IczcuuMJkcSdFtjq/phga8CrflKC7U4=;
        b=W/HG6ZeguhZCFWA49aerO2DJfoSFWXpI1hEdTzdbMb0AjfTZ64IZIGgVuFCGGFtJfF
         dyAge7CazhHjiBikXKGvlCKdVc6BrGBWuravhuoVkV2DX7k/ML1xHcym8ApvX7Gyvk/I
         X1VgwiBbfwBzGLHuUKIZvSxVqu8EY+TftgAc1pzFz2/UXdTiXBJZ5XJo2IlJUr4jqdJN
         B8jrcMyWar/vSPlmFtZJgju0mYYl8T4lpRYPit86Pgc2RMsjn0XLbgL8HcAMqH3szjM3
         x88UBYIlgbQ3hSleD4MzNZz2TUOgiYAtOs8rBD0wis38LJ1cPQco7cb3qq0jh4EQV8p9
         +UWA==
X-Forwarded-Encrypted: i=1; AL+hErEWClrYn9aVvpQOd+y8LdLahSo+V/51BrvyLh8EVj5CyAk8vFG9WZH/S9wDLWodk9TslWjRlhJYxw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+ay+NhUY8AcBjS/ja5ObtwTyvNKsag3eevMJoQAtFavDBQdc+N
	lj2arbBO1N39OK20F1UNv3s5O2DB+gImIZBj+bDIyvQYHBmo6UwZglfktCu70rYCwNXuIqRJd2z
	LPmeJRISnRcNVn3+dcL3H10iBxWkbs2w/F8eIL1DS
X-Gm-Gg: AYBFou2tIqku7P1H3nkXPl6YecrsRP90SO2jvU1ctszZ1XK7ifUpojA7CMVnVM6SgsJ
	hDmL6WxJMZAbamFnCvdTkuA23YpB4UZj3PjEHgCEu7HNeIdqMiIrKf3XJlT3y3dX7VegHnrUzET
	VyLqgDuXOEuwjE2tHw96x5S7GDGiPvFGWc7qVUG7osM5Gywr1qujqPB2IjESU0TFmZMb77srchG
	EzO/I9Ih27bHecPw+eJx1YVzwPUuojv365aOx79fqjJp66+6eyLUYWNMkE07jMJg7sVkAVwqgPH
	nx5NFp3+x5W+ekpayjPO8iTXtBjinlkHfKPN24xCLEm8iJVryfuen9tu3QscayNsFJW3Iw9J/Ie
	7PY9yGugckBR/ewbMUqqKjJxsszBKWqIX+/FPVg==
X-Received: by 2002:a53:d5c2:0:b0:67c:7317:de93 with SMTP id
 956f58d0204a3-67d8976bb2cmr676238d50.91.1794538508154; Thu, 12 Nov 2026
 18:55:08 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026214359.3122870-1-briannorris@chromium.org>
 <20261026144346.2.Ib692ddd35c1dbea1757d9b1db6c1c7e938fc4ea6@changeid>
 <20261028-rapid-daffodil-rat-0adc6a@quoll> <aulIoq2oVjJ3DVzL@google.com>
 <d4a430de-715a-4936-8adb-35ff57a52b5f@kernel.org> <avZkfg6WMlMzOxpn@google.com>
In-Reply-To: <avZkfg6WMlMzOxpn@google.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 13 Nov 2026 11:54:56 +0900
X-Gm-Features: AclHuK-84j9IBFkhrVUuvk8buFltZEjB8ro1aPwuBHaC_xvB0gZrSc9m2OIxmfE
Message-ID: <CAGXv+5G5z75HGP8nv_i_nwEeSd3qkvyL_h_MYzV_XPT9BpR4jg@mail.gmail.com>
Subject: Re: [PATCH 2/9] dt-bindings: soc: google: Add Google Tensor CPM binding
To: Brian Norris <briannorris@chromium.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
	Jerome Brunet <jbrunet+clk@baylibre.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ulf Hansson <ulfh@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Peter Griffin <peter.griffin@linaro.org>, devicetree@vger.kernel.org, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Radu Rendec <radu@rendec.net>, 
	linux-arm-kernel@lists.infradead.org, 
	Mariano Marciello <mmarciello@google.com>, Douglas Anderson <dianders@chromium.org>, linux-clk@vger.kernel.org, 
	=?UTF-8?Q?Jakub_G=C5=82owacki?= <jglow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 11:48=E2=80=AFAM Brian Norris <briannorris@chromium=
.org> wrote:

[...]

> If I do keep these as literal firmware IDs: does that mean you'd prefer
> these not be in dt-bindings/? Many of them (especially the IRQ IDs
> you're pointing at) are not needed at all in the kernel side; they serve
> more as naming documentation than anything else. I can just inline them
> into the DTS. But I'd prefer having macro names for LPCM IDs and
> similar, as it vastly helps DTS readability.

I think Krzysztof said as much when we added macros for MediaTek pinctrl
numbers. They are just symbolic names for easier reference. OTOH a binding
is a contract between the device tree and the software implementation.
And if it's not a binding, then it doesn't belong in the bindings directory=
.

What MediaTek did was put the header files together with the .dts files.

Hope that helps.


ChenYu
