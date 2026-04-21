Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D1A3876C7
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 07:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756489; cv=pass; b=Kv1XndT5elQbWgbVNtTiIqkmNUfA1xBec9TlQpoPJnQ+f3q6AIQdKDydf6q4UKac5NVoZhgDatDUwOumMDod7iuGgEcXl8Yec28xEHDqcDTppwBoxMQJ8ZTfSzOYq+8suGz/6YI5OZWF3mu/OWdqJD4s9PHb1PdODgb7nSghH4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756489; c=relaxed/simple;
	bh=SrM7B4xlCRXqko7TjsJdvgDkD2L8BaoWfnbPWdalSd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=PGfWeB3y1BMTjXVfi1Bq7BHswF8r6/73PlsikJIFJWSX773xDBsoZLR7HdgiuYbofz16mZSN+tpU276cD9xHpKastt3iDHIV3UYhH9XGQrz3V9aFOYGdIVdEq/LpapWvZtlqyuk7SQbaF4dm/JeSCUPD1ncwjvC4cK0pLxTODFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpJ6nPoa; arc=pass smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpJ6nPoa"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b8d7f22d405so678352066b.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 00:28:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776756486; cv=none;
        d=google.com; s=arc-20240605;
        b=QZFkAUkilRs3WPIvXJoyoHrNoAtGnotMIuTIP+M+xMpKgpONqm6ReuNISccH77uXlm
         CS/B3KGXZjxuRuJdbhwFstfZkj/pX/3FgT7IckYB4YMWPVBxgg6ewhwRoqwGbTb5LtL+
         y6PmQxfCLD02M4DbxvtLo4TtnzPpqTpskxZH1cBvOruMBWXxNZmVXaav3upbKH7V5SOY
         0NHk/cmNBSCXf4vQnbmmAdI1AZ40xs0FHp3ylJby9vX8cwcLHOjOK1qc+0gQCP1sEZOM
         aai1Mu2B5G04mxqtxQNyLLBPViZFHAyIyy5kPj+NIyMxR/BTEDno6qTLpxniPBLnV42m
         cV+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Ql38lC9ZYoXrn3/+8/I12f47H5/KcGWLQDIbsninAQ=;
        fh=M1JD1BTJk6rGuUIz5EoJzKy+kA20F732hf8kdU+ZmJ8=;
        b=kFiugdTU7l7RlongYBIztQQyd2dfPpOsnDzTluGZpCP/QVs4lSrX6M9mM3XIeiPim+
         mWe53zM6vpZMpQ+XuzOssMHvvYolUT9tJKIO9nkCZksHgXl39gLoQLnWF20wxtFXpRo3
         1T9A3EpJAx2cCNcQ8uT7mFjMv9zGsPK8SW6fj7hz9t4kmTfmhZ5JvI1O6e6ivWYwCKAN
         jsLhPRQhcWT6kI+0+C3WLX/OFzl1TQ3NTqfxDPuGjAlzQxLem3YA4Vokz0/UlIBnplee
         ESmssh4ONOU31u7WnfDVnwknGAcM3vyNOhd/ipzEO4p3D2dYxVF2T+a+3vc3m/kK9zXC
         cyGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776756486; x=1777361286; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Ql38lC9ZYoXrn3/+8/I12f47H5/KcGWLQDIbsninAQ=;
        b=gpJ6nPoaYfL9wLD+frghMli3YDk2v1bHqUuJ38puhEoAZA31Onn957mCjhFHzhaGgM
         q5TDa7wql1a+42GUijkFBUa7DIlJ62czATuYDPEbU73ZQ+r3Ye4Ug6qd53nRZ5FqhG4A
         OVeOm6KzCQdqgBc/26ZNzZXw4L7EZ0BFV/t4rvOCegZzLHrLnJHqJEC3bob/V2HVVVLe
         oGOdLk1LMjHJAzTLfntSbKjV3d3JLtKkJwtAYOF7J2JurvRHg+VScXcHxAowEaAWsJfD
         PsCFbdgHQFUQTglwI2ecQqbFldzIMxA6jE0FGLUfCsJWItR8i5Y1Q6JYJOC4Yd5FxZUr
         fR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776756486; x=1777361286;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Ql38lC9ZYoXrn3/+8/I12f47H5/KcGWLQDIbsninAQ=;
        b=ZyP74Qk0N6aD6kObq2F5T5Mu28x9SR6s24DI9TdxOPYh6rBHOaaYmZdj0bq4pJEuHk
         PLLqMqyRpYtwsAlRl6Oz6knqcyct/3sapk8OjrabcvYLHWzU9PnYUtQsbpvKKrfUoWbc
         Aq13pIOHVJXzo8mcCSIJQqKPSoCQW4H6NDnPG+VOclCuEqC8Nav29kCese+qmySy+SV6
         cVe52imsPVy9jkdjHcQ/93Q8B8gRxLeg528Rjthj+zkaYefTpqTs5dtP3gVJzobVaDVa
         Cw6/KdS3NBOc46KimIbDdcc2dqgfGXMTAuotU0fo81e0nlxl9iz3wgwKWUDO3J5fk992
         u0IA==
X-Forwarded-Encrypted: i=1; AFNElJ/WAgj0BcqzmKAl5FYqtINUVjjqWR0oKn9Zz821DQa/8q70+YJ8Y/uo/vq2H0ydS4pa8fbE+A+Kdg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzEOcDrPU/cHEuRk96uqqQ9bXqgXTnLRKNlOldCXIZmgE6gidIN
	ScIRT74q7qiyC7GofPA/G/G7Kk0AwTFdiOqvtg17wKGU/5P81+TGcBkRnQXu/SpKm1/bdeRbOR3
	aIAqyklvMFKQvNWibrq4VrZLopQ/lcy8=
X-Gm-Gg: AeBDiesj4fwipIf8XbRbASlMKjX0zYRABT8R0TXVmAdgj7wpsjGWkBC6pi328O4SldK
	pSF4R6d6ssGzEojmp0/S6If/zIRL4nV43Jc43QD0QgYAEm37sM+kMpaSZF/2Nit+FCWYNLMxdEr
	hYo7kQGSfPnMTIc6H7GXVf07dOONERW8triiEbiiSFji86AaLuX6t2gDVkNbwpAriRISDZZO0e6
	9Iso6VIMEuQ+XnpNm0GZWIRU2dsYtRB4HYPRggCDgpgAQdfFNvRB0F63delczRbu66Brg08z9sL
	zVTWxYvq3MAGVDM=
X-Received: by 2002:a17:907:3e10:b0:ba8:61fb:a927 with SMTP id
 a640c23a62f3a-ba861fc2f3emr295974966b.39.1776756485914; Tue, 21 Apr 2026
 00:28:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org> <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
 <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org> <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
 <aeaXszeaE62rM6BJ@aurel32.net>
In-Reply-To: <aeaXszeaE62rM6BJ@aurel32.net>
From: Anand Moon <linux.amoon@gmail.com>
Date: Tue, 21 Apr 2026 12:57:50 +0530
X-Gm-Features: AQROBzC3b4LUDC2_89z11CxE5Y66IyoxVuaubMCzdKHl_KwSO1e5I3jSF-QRINc
Message-ID: <CANAwSgTXwhkV=QEJqzY3WYV9+uy=6zEN9aEktinswFARs+m4sg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
To: Anand Moon <linux.amoon@gmail.com>, Shuwei Wu <shuwei.wu@mailbox.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Aurelien,

Thanks for looking into this.

On Tue, 21 Apr 2026 at 02:46, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi Anand,
>
> On 2026-04-16 17:07, Anand Moon wrote:
> > After reviewing the Banana Pi F3 schematics, I confirmed that Buck1 and=
 Buck2
> > Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the restric=
tion errors,
> > I expanded the voltage range in the DTS to 500,000=E2=80=93950,000 =C2=
=B5V.
> >
> > Additionally, I updated the DTS to map the second CPU cluster (cores 4=
=E2=80=937)
> > to Buck2 to better align with the hardware's power distribution.
>
> Actually the output of Buck1 and Buck2 are connected together, so they
> should always be configured with the same output voltage. And both
> clusters should be mapped to both outputs.
>
You should review the regulator_summary below, as it may indicate
it could be Big.Little architecture cluster.

$ cat /sys/kernel/debug/regulator/regulator_summary
 regulator                      use open bypass  opmode voltage
current     min     max
---------------------------------------------------------------------------=
------------
 regulator-dummy                  1    0      0 unknown     0mV
0mA     0mV     0mV
 dc_in_12v                        2    1      0 unknown 12000mV
0mA 12000mV 12000mV
    vcc_4v                        8   10      0 unknown  4000mV
0mA  4000mV  4000mV
       buck1                      2    1      0 unknown   950mV
0mA   500mV   950mV
          cpu0-cpu                1
0mA   950mV   950mV
       buck2                      2    1      0 unknown   950mV
0mA   500mV   950mV
          cpu4-cpu                1
0mA   950mV   950mV

> I also wonder why in the original patch the buck1 regulator is named
> buck1_3v45, from the schematics, it should rather be called buck1_0v9.
>
Yep, you are correct., It should be called buck1_0v9.

> Regards
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net

Thanks
-Anand
