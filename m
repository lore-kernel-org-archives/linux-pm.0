Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52F7389DEC
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203674; cv=none; b=Waopy6VDld+ndxoE/34b7lgOlHO+l1W77qPeeZvyqRY/i6xNzC6amJSRj4iyBHHHWO6bQMKAsd+1eq9oXl0DEf9lKuLjk0EW73q8MjMWlM1MiCfGsFVbFWEw40cRmhSEvQPzBwx3Jt+QuTqdK0qdzHNgqEyJM4AAWBINwRAr8uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203674; c=relaxed/simple;
	bh=Y0a7WddgUQ/5f5obr2F/RzKsHSRjgorUSTkuUO5qnKs=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lhfZ81H5OS1Me2VEXyYax+VbuRvHoHq0MpRDw7fbk52RUr1Jo1cDKPpmPnIelVgVNAKvA0u51gYjfavX5ckT9A1wTNB80JiinUnFnBy8uK09XE2RGTIdMiXNLS9HZyXTKdkwGMep9tuE9+O5AkJ2c4BrlUAglpCbhn2TikyGqP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt2HkJH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt2HkJH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB6B1F01559
	for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 08:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782203673;
	bh=Y0a7WddgUQ/5f5obr2F/RzKsHSRjgorUSTkuUO5qnKs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Kt2HkJH49eUMpNp44hmnOsa/cj6zhemVuoKImAOY34KH6f9vjiJzR4lc64xOMI395
	 pROr+wwCuXnTUxcAUy96A3/+dC8P5yx/s1evQTV0qPDP47yl1XE+oTBdKF4+v6kJdD
	 x91TxytHaTJPncL654CBHV/3vxCbzT0KwOic99hwZ2ys+w++j9Zg+H2rwzYT8Torku
	 1dNDaZoDAMYqiCvp0U2xdynE0G4rqJnfeUBtJBBoFbQx5CTs2VhtWrK0hx/DUz6hDI
	 j6+KqqA7WF4tuITdQAiyAMzgZu2/0RAzFvojQakjwCzfGglcDjEqb+ULCi9n5SbeZg
	 5TdZbr0BUDOrQ==
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-139aff562e1so3084250c88.1
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2026 01:34:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8HW3eaVu7cuXwSdfW0jwy9lBzzEqfJABeS37YK/g16SFvGxgl3z9ib6u0EMBFwYut5O2lTd2lMSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyL6m5s6BiVUGdPDaPfMIoORUIRZl1fWoZCOXfK7RbhC6E5UDsf
	ZQwAIEi2dqLZM/PI40RgNJPeAQwtVHXsdCeaDe3l2LhdIR7xzLshzaie1U3bF2gUOBOQmP+bnEW
	eO2jRYnjt3IppvCfqgdapoEl6e8pLUjVqRNersYtOTw==
X-Received: by 2002:a05:7022:439d:b0:139:90ab:36c8 with SMTP id
 a92af1059eb24-139c6ebeb63mr1076352c88.1.1782203672876; Tue, 23 Jun 2026
 01:34:32 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 01:34:28 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 23 Jun 2026 01:34:28 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260623030736.1421537-4-sherry.sun@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623030736.1421537-1-sherry.sun@oss.nxp.com> <20260623030736.1421537-4-sherry.sun@oss.nxp.com>
Date: Tue, 23 Jun 2026 01:34:28 -0700
X-Gmail-Original-Message-ID: <CAMRc=McH-x5Td=60pMNUOmT-rZ3Xz4PvvKFK=8CMwESMOm4iag@mail.gmail.com>
X-Gm-Features: AVVi8CdbY5Iy4YQ3Oz-eyh9mfYSh4JWVxu6-pYJlwg1EFWjmAS3iyrKv35O8gr4
Message-ID: <CAMRc=McH-x5Td=60pMNUOmT-rZ3Xz4PvvKFK=8CMwESMOm4iag@mail.gmail.com>
Subject: Re: [PATCH V2 3/8] Bluetooth: btnxpuart: Add M.2 Bluetooth device
 support using pwrseq
To: "Sherry Sun (OSS)" <sherry.sun@oss.nxp.com>
Cc: imx@lists.linux.dev, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, sherry.sun@nxp.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	amitkumar.karwar@nxp.com, neeraj.sanjaykale@nxp.com, marcel@holtmann.org, 
	luiz.dentz@gmail.com, hongxing.zhu@nxp.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	bhelgaas@google.com, brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jun 2026 05:07:30 +0200, "Sherry Sun (OSS)"
<sherry.sun@oss.nxp.com> said:
> From: Sherry Sun <sherry.sun@nxp.com>
>
> Power supply to the M.2 Bluetooth device attached to the host using M.2
> connector is controlled using the 'uart' pwrseq device. So add support for
> getting the pwrseq device if the OF graph link is present. Once obtained,
> pwrseq_power_on() is called to power up the M.2 Bluetooth card. The power
> sequencer descriptor is obtained via devm_pwrseq_get(), so the power-off
> and cleanup are handled automatically when the device is unbound.
>
> Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
