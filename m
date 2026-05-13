Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCE73DC87F
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665208; cv=none; b=fDpF4yJyGQaWzXAVwcmNllU/MBJY5ndCJ7kjOE5GyJrhqN5Vbp+lz1KrptX8blfIfnWPNilMfALjSImluoCranY/FFRvhi3mwW5s2QiHzxVgGym/sBNorvtnpzodZgpdfOz29Gge/u6CRjEyF5bs3yvvi6W/AmD24xE/G6MepCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665208; c=relaxed/simple;
	bh=R0E17z7r+LYNRSdvyWdyqZP/kUEcYvbbo/0Srhey10I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HKDGkrr4XXqizqfwiEBUzGjsltbKdI17ekyt3JBuNBjKV11J54605nx3fYjTKacd0bpP82OL4/d79CryxEEC1QmJS1KyZH92C5wnqTdXwrwPLbjCIQHlO9UYQdGMTJ6R0BeiydG/ynAefkXYGZN+qGh+EJig4XNX7IJTR7QR5fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jzfLSY7c; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jzfLSY7c"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so63267185e9.2
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 02:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665205; x=1779270005; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R0E17z7r+LYNRSdvyWdyqZP/kUEcYvbbo/0Srhey10I=;
        b=jzfLSY7cavs/yDze9MwRISa4ZVPK0xcg57MsYPaKKvuUfUGPFvgOL3vfG4i9SK0pW+
         dnpgDl50cbs8UeSa9HbLysiymQJxV3uX27T0DUlr4ipnTI/fDJFBPFn0CdEJe9464sKN
         MSDuwj2/jo9IpenDpG7Um0i/EVQaih42OzMEQYo9ayIFask/liz7ia9BY4AIxmHG/9ZM
         EO1u92uTKIR3pUGClzhfsUr19Sjec2mU3/MSgz+eTv5iExRED4X/gqy07BI5GbEzgKlq
         6qQe1QhGHKjWZ32UoeJ56xHnwVJd37S7GFK7kZHAzeXT4SaG0NPrDDG0gQpTNcgFE8vd
         giLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665205; x=1779270005;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0E17z7r+LYNRSdvyWdyqZP/kUEcYvbbo/0Srhey10I=;
        b=MJaOZrYhJXekFz/DTTdo3CHhkL1iAM483JvfBIRObq1sPnrCPyEh60lS2tTiKQ0NHa
         EWiyXyf1Gv6eEJdZiQB1ssUxT+y0GiBv/AX2iudSyOyiqhTXXX/tT144O6jyUE+5Bwbx
         Edu5S1xuaCR/EhJbxtPX+iq9A5u9uH5z+klEZYfmnMZI9G0gVfMXd2fM3ytop8F9b6kN
         q+fCjfyMUt6Z5bEja1HfUBfImwAAAgV1w+Q/injnbF1oVYvTzxA/OpDXlcSdklVosDXM
         3Hnagp9OxHYCxjukDVKSmch/FaPFVyr888YKFo10UEntl5tz2Se46iWmDUpgnaRLp4Hn
         6bSw==
X-Forwarded-Encrypted: i=1; AFNElJ+EhSitPgWFi1Hk6BoFt+QrHPp88uBslQ7NLqZdJZM3fzPJghLYTtmgmXXx0uIPZ5RdlYKJfwZpQw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzebUQUeVCnrFiyEKwRqSm02Vj7iH6FE2pboSzXPjMj/PjRnz3t
	HWRntoNfBob4kWq+DgEXgz3sQA4vmdtxozai9/Ye2AY7NzgN9dvlsoiU
X-Gm-Gg: Acq92OF3jD6g/kabKm01MLzZ3WMbvWxWVBEhClMcPYYmx5E5sJYNZAx1mGo1Gx5oVzi
	LfNT161MdfrNcTZ5tuAZ1KF2IWL/UVmLpJdCLfe/mYZjy75YUzqpXQkr44uLZ2XM9ttlACG+rKY
	lMFCKJtnKsoS3dV/J6SDkdVhd5SFHLZ1LuYadE9PPI5FLoti3bi66xIkLZrN5xHo9xLfGo3arx/
	z6QNeRKgRUMAcrDkPpCIUpKWTwX/3AOFr6fYUoX3JPlFBBiPO2888+BytFCqwcAed+abRMPjYNH
	MqBY7s5aAKu5hFxtF5cJml5odD2b8KXwV3IB4afF/Q1So/edDXbNqieiT77Y6oa0uVLatCYYAJB
	EAotye9Hmk8QnL2I+JLs+wHrRvwwRHysbWsFhtVP5lctRs9vbry8i6fabyfrOQTfaVjVX2LaYhB
	3C3xpHoQXbX+UtmBYFZqAuqx7/OZx2EhqJzhS8vMduRp4Vc5m1
X-Received: by 2002:a05:600c:8b12:b0:48e:978f:c45a with SMTP id 5b1f17b1804b1-48fc9a3ba11mr39073755e9.19.1778665205077;
        Wed, 13 May 2026 02:40:05 -0700 (PDT)
Received: from vitor-nb.Home (dsl-113-208.bl27.telepac.pt. [176.79.113.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fce37b308sm65629665e9.10.2026.05.13.02.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:40:03 -0700 (PDT)
Message-ID: <17e3511e4bf46f83c91088bd4e081d4323e1bd93.camel@gmail.com>
Subject: Re: [PATCH] pmdomain: ti_sci: add wakeup constraint to parent
 devices of wakeup source
From: Vitor Soares <ivitro@gmail.com>
To: Kendall Willis <k-willis@ti.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Kevin
 Hilman <khilman@baylibre.com>,  Dhruva Gole <d-gole@ti.com>,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 tomi.valkeinen@ideasonboard.com, sebin.francis@ti.com, devarsht@ti.com, 
 vigneshr@ti.com, vishalm@ti.com, vitor.soares@toradex.com
Date: Wed, 13 May 2026 10:40:02 +0100
In-Reply-To: <20260512161737.pflweaz2r3q3nrfl@uda0506412>
References: <20260506-wkup-constraint-v1-1-0a4bce791b29@ti.com>
	 <becb54adc0bea88578c8fe4c7c1b7b68bf5cc6d4.camel@gmail.com>
	 <20260512161737.pflweaz2r3q3nrfl@uda0506412>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 11:17 -0500, Kendall Willis wrote:
> On 17:51-20260511, Vitor Soares wrote:
> > Hi Kendall,
> >=20
> > On Wed, 2026-05-06 at 22:16 -0500, Kendall Willis wrote:
> > > Set wakeup constraint for any device in a wakeup path. All parent dev=
ices
> > > of a wakeup device should not be turned off during suspend. This ensu=
res
> > > the wakeup device is kept on while the system is suspended.
> > >=20
> >=20
> > Thanks for the patch.
> >=20
> > I tested it on our Verdin AM62P. As expected, suspend now fails cleanly=
 with
> > "-
> > 19" when an SDIO WiFi module is registered as a wakeup source, instead =
of
> > crashing on resume:
> >=20
> > ti-sci 44043000.system-controller: PM: failed to suspend: error -19
> >=20
> > I did not test the IO daisy chain wakeup path, since that is out of sco=
pe
> > for
> > this patch.
> >=20
> > Best regards,
> > Vitor Soares
> >=20
>=20
> Hi Vitor,
>=20
> Thanks for testing the patch! Could you add your Tested-by tag?
>=20
> Best,
> Kendall

Hi Kendall,

Sure:
Tested-by: Vitor Soares vitor.soares@toradex.com

Best regards,
Vitor
