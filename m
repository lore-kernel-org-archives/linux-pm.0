Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D3653B33D
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176472; cv=pass; b=NBcKn8NZdgp6kgAODlHveYKsQwqGuqJ+6eds2sgZwq/GlXlOklgLHPkmTFRhMn6xNSmlBxP6gFojzIxZzhNp1UnFco/a/PoQQOHX5ytSo8EwHWA9umQ9H/3yX4TspE8rk426jAI/8L3/EuCzuCci00IXKbzSY6k1UHf4tP7J4tw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176472; c=relaxed/simple;
	bh=GWWz5uyS/VWndEpl4fzi11VijBLfDed1qPxmM2bna+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bzhs2pqTPbCnvUuYGDKzduZdm1c40waKEgGZqUS5Do1tTDXTKJNa220LyScV0I/UsvIM64yo5HqI814gBReWv4YJZP/gw+XrWPxGTN7VrwKaPt+KMZEPYNtFQ5Xnnh8FLTIFBQ6stw27QcS/aq9H0hFzo393BO87ou1LALUqRXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpZuMppt; arc=pass smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpZuMppt"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43db0c16so14595517b3.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 08:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790176470; cv=none;
        d=google.com; s=arc-20260327;
        b=PkPlh11IckvXtV5OuE2h/KzxYlUplgaY6sSQiszWAF/BCZ+sxJglfvkN7VJ/m/y2Jw
         OGfuhNFurN/QXDMgVu0syPaAs6v8Nxp24DCVhPRraj/jvbnEHKt/LW36ThCEGShMOOti
         ie83wLCaO4zxtYgL3qjaRRA1zNqjEUuHd10aCssbxKF+rAxSuuZxzZt8yqhF39S/mAst
         q1bcttuvDruxz4kIfjDEkxrdBrvcxsAf5wZ0eLSYVYfnIPZ0YhWOkVSMxtltmaevY9uX
         7aFU+BudkMpkhnV9lju3kiLLXmzXupSo7NTqlk2lJOR+NuT0FRfLDeE8urLwpKTyQDdB
         orjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GWWz5uyS/VWndEpl4fzi11VijBLfDed1qPxmM2bna+k=;
        fh=5iOJiLYJip1MDoEBQu5EeYrpj6Y3y2Q/C4VRt1yuT9c=;
        b=b0CDeWLAJVCZZNu5S/AOGtdVlVMKvf2SACNC/Gmxs23UPbNTrU3pCTXnk0hdFK5ucY
         ai8guQs+MVeX+KYowIgkghpH/wHT2snDEsBcPWpZv5G2ogrxF/xfIiO5Rr9Nm5KYa5w6
         BIo8E6GtJL8zcI9nEQFbxAeDrSqx7WyyVc4Ql/uBjAS00W7mszmK9Ar1u0Rd69phik0g
         p67hpoMhLH7ZYTAkrhNlRZQYdJMduU+0g5Xg/glQhwH1urIbPkrW8Aywhrz8WvLpCvwa
         1UltS3K0OstttnRqkfzKRM1P4sRLoxd8m8dwETxIKzpgGPkFZlZNuJSD1LZt6C1f+E6a
         iL2Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790176470; x=1790781270; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GWWz5uyS/VWndEpl4fzi11VijBLfDed1qPxmM2bna+k=;
        b=FpZuMppth2BDHKsSuBpuKivrGL250vF10pq/2u5a1gBoHwXAFp1G2bfDuxUtHfk7RP
         24q/6uaq7+r3Hw7eR3NLhCW9Va/zHh2iZFnanlDIb425xTTLjUiTibOweaPEg/UL/DhT
         vZC/d9ywmjzRw1Yg92dIg2rqNOKWci0g4x/l8JE3b8dhyTbjF9ZHl68cKZBYyAw7iuDa
         W2e9jX7nGz0K/FNCu4y4yRaPecOd6rzb6IwuJPe/0E0C/11FZsXup7vVzxt5G40ATA9l
         E3A9TnI7YVVpWRHBvw8Zm47HaE/AqBkm5RqXjj83+Iv4YnKRTvkFavy34n/92lnoeo1j
         XOmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176470; x=1790781270;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GWWz5uyS/VWndEpl4fzi11VijBLfDed1qPxmM2bna+k=;
        b=Uep1XsiVHTH/zgTHxeJfKundtT1aXRzXJpdINU9gDrsaVACK49fpyVLjReFKj9eAnR
         gDdaWlHJo9GXhBp2XuVDaLdFFAFsHgdV3M1/qLdJMSlnJVF7rk/5GfYt9yFzeVOhP6pM
         OV2AIiPpTBivtsR7TpCAFQ+6b+/vb3Gi10hu7u9JGkjxtIwcKSZbE8R6o07ILJX3IMmW
         cYhD8CwEnDB+waJ5hIrOXLgqcMAI1AvLyH+qoQIJVfCxhqYGoWomYygN8JAtuqqt6GJj
         RPa0hsMNz+IrQ8VxT2Ls3YjdphgIwrhSRmOjq7UrlXQ/hdHKfN5V2VyFFk/7I1ANrUwf
         GSkA==
X-Forwarded-Encrypted: i=1; AKwUvByve/Hzl0IVw7zJijnYn8Tgc1lU/dlFYu/D2XiZaUkQillP1MbLWEElL+kHenibLZVO9UCNwFIMXQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kccu7FMD0cCE1+Zxu5bzYaWYW+Kqa5wAYaYgXoxzprfyyo4pyH
	2w7P4TPtcar+9NS+F7TRYqs10tmclujlmIHmTgPIqGzsrLJ2IC/nSF6EALT482v0rONlWl7idWt
	toGGduLzEZ6zbQ0Fy3D+W7ok2imf0VCs=
X-Gm-Gg: AYBFou1bDTq52eXiup6StiSv5CZOONzTesGCFe2vpMn0Nt2ENd7G2AP4iycoWGD6UFP
	wkKAKnfRrtOpU0IVQAJO++0mIh2ACqPq49j47LjN4CYYN/vf+sn36hyiTY1LSCNmvPMdmfrKzIK
	eUjCqi3nTfRS99ZuKjjQBTok9OgmqYMLyp2SmZVBlAmJ2DARucbb2wqHt8nKbnWPQDBvhLOnnI5
	6Lv6wX/QTM+S/UHxJXLtL9uvjLeiKy08PHCTeS9Ex9yeBr9nWhkbNlHdvGZvTKbhV7crGErAbdu
	KRDMDBnVC6Q4q9Ao608FRRCKrsb3WFliwj8rpyQo2rW9v4dvKbDXD5+y/tZy7e1XmA==
X-Received: by 2002:a05:690c:6b01:b0:873:5c6b:a310 with SMTP id
 00721157ae682-8a45c07ddd5mr16272367b3.62.1790176469619; Wed, 23 Sep 2026
 08:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825120929.13168-1-matt.devillier@gmail.com>
 <20260828142318.1881516-1-matt.devillier@gmail.com> <apToX3Paxb5sdClO@google.com>
In-Reply-To: <apToX3Paxb5sdClO@google.com>
From: Matt DeVillier <matt.devillier@gmail.com>
Date: Wed, 23 Sep 2026 10:14:17 -0500
X-Gm-Features: AcwNN1VrVHs8b4nTCmQU43U2FA0ufWHGKGX8hbBzHr1ThxK4dCVkXAGr6yBQgjU
Message-ID: <CAFTm+6D7OKYCqfw3yXnRX4jfmbD4ZBcf2TRL-2Tr+6LWSxWP=g@mail.gmail.com>
Subject: Re: [PATCH v3] power: supply: cros_charge-control: adopt EC charge
 state on probe
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
	"open list:CHROMEOS EC SUBDRIVERS" <chrome-platform@lists.linux.dev>, 
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi All,

Is anything else needed to move this patch forward?

Thanks,
Matt

On Sun, Aug 30, 2026 at 9:35=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org> =
wrote:
>
> On Fri, Aug 28, 2026 at 09:23:15AM -0500, Matt DeVillier wrote:
> > The driver previously always forced AUTO with no charge limits at
> > probe, which discarded sustainer thresholds and modes set by firmware
> > or firmware setup before the kernel loaded.
> >
> > For command versions that support GET (v2+), read the EC state into
> > the driver cache instead. Valid sustainer limits are adopted as AUTO
> > with those thresholds: while the sustainer is active the EC may report
> > IDLE or DISCHARGE as a transient hold/discharge step, which must not
> > be exposed as inhibit-charge or force-discharge. Sustainer off
> > (-1/-1) still maps to Linux "no limit" (0/100); other invalid limit
> > pairs are remapped the same way with a warning and pushed back to
> > the EC so the cache stays in sync.
> >
> > If GET fails, fall back to the previous defaults and SET them on the
> > EC. Command version 1 still cannot report state and keeps forcing a
> > well-known configuration.
> >
> > Signed-off-by: Matt DeVillier <matt.devillier@gmail.com>
> > Acked-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
>
> Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>
