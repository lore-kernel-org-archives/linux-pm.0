Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBC23A7F45
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321470; cv=none; b=AI4hcUQTXJbZIDaSgEo2F60ZEgdDKvsB9mD8O/wC9YFSQANacEFO7ANrEyy/85bLN+07SyGb4i1vlgPEPbJQt+KGFyCfdwrRa466BitHopbhttfqQQYGGx5T3t8esxgND0iFuwXHMAgIy2ihNS0S0wbAQsjO5BOG19LAk23IoYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321470; c=relaxed/simple;
	bh=G0GDCGBDBmBtWPYbM6yoLHhxE+ZZhx54r0Gt1ypGkpo=;
	h=MIME-Version:From:To:Cc:Subject:In-Reply-To:References:Message-ID:
	 Date:Content-Type; b=WAjwz0AkydDFrjaAczFz0qosUEOkUyuwpnqIRRsyPH70+1ewA++CD/s4SZ51CdoqmO9LJU+9a9M+4C7O+W4YDNqP56ZlxgKxYK5vyrLPZ3sZlzCOo4Eg5LxMHR4IHAIOmPsEM5wl7cr6rPtImxLAe6NFjwwRN7fskIhwBWlB8Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyW67PUj; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyW67PUj"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-137e3a3a4b0so1858830c88.0
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780321468; x=1780926268; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:references:in-reply-to
         :subject:cc:to:from:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bp5vSMppXoItqHAagwaAVQcBt6Js0Wroa25cfHyXfxo=;
        b=XyW67PUjtyqto6qCn3/7KpC+Xj8GtmSnUeZt5wQrV2t2acMzBglkdeBgYZ5UAUQFbS
         LLoIpBbA3IF65WEU3kZP5g6Lkwm5zVzcVVHGesFdlz4iMW38/9nujR61y0YXlGXuROed
         12Ill5JuV6C2XfCUGx24g/Rsf/fW7zQfg3GfQa6F3A4CIRyTXn1MqKksTtpXp8w5lcFH
         j+KLMltqY1U4cYQPOa3qXLY/oDmLugxuu12agzxBmATSo/2eK8954tGyWt5xAefw5sGI
         zrqaEUFWkQKiUAta7j+xdKJ2KdzdNVVqowuTVKjv9DmQFHLIYv7uzJvcs7SXEdvXwLo3
         5Skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780321468; x=1780926268;
        h=content-transfer-encoding:date:message-id:references:in-reply-to
         :subject:cc:to:from:mime-version:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bp5vSMppXoItqHAagwaAVQcBt6Js0Wroa25cfHyXfxo=;
        b=NGL0QhRP2xcDfVcrEI+nr9uEtuQHGoyxOytXoHeLDtewc1EIcGjJ4IOaTMPwiFZ/bU
         IT0Nq9EMQUQfBHcj63EOb/OrOYzZoaNroM8MziSKubWAsp5vj54b4Ds6UBT5MIo23dRT
         /llW9Q0lpOB+o9DLVQIPPjoHK/9qgA4Dbm3+1c84/xRKW9J+chNCLOWmKWEhrtL5Y5+n
         6YLAyDLLnDQtVNUhyJFPp02VDzp6m1PdOactew00se2X3m2tGjJ+u2qWkAVbyNxdRV4K
         /YB8+u4n1G5abivY2Y/mL4zIF8AXEUCTmBMwBfDAMQcsGZl1IfuApqpkDllDoV54EpTU
         z9Mw==
X-Forwarded-Encrypted: i=1; AFNElJ8h0WDujJ2pyWpRXwn1oRH/YskoGnkX7/jXK33NISym3R3gmXg7dv1U1vX4li12eKP6ogS6Invo4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyov2YDHxHx4VRgqt/X7iYzjx1w22i9lpTmSR2QeMsYp/KIoeW8
	gAZWlYo2cJD/dz/mNfTy0SK33ZbOG546jne1ic9meZHCY8CsTC+TAWjx
X-Gm-Gg: Acq92OFOt8tnrfi8KPDZXm/WncPcTbN1H1nwnGDHA9a1l6XGBCkuLWcjfBFCJ2XuyuO
	9Ch/Y5B+ZLnZJOo0rEvmTzd4c4pX49ncRPXTad7nbe0YLZ3291rXHJAYsYZpdPp2TkRhqyCfF8I
	dDrTx4New43igbrbO4my0YLL0DvTvPvzwaqE1rrGTbIzs2dRFg+U/hdhrJ4UmsT1F3ELajH+KFV
	bAehvq5A9OlrPjq7goh4jeMl/M1RB5cA/vV4kvvu0vVMFsh7J/kYues0tqMPPCKXx1slkhJ9d6E
	5JGN+ckhDS3RBJgJrwhNoj0FYxfcveHVUHK8Hip6NC+pTpgETq2FFWRiLN6E7vUPABVJYPn49vO
	ysCNQcKzq34oB3paldcoqnle75aM+4UXd/3OBroPlu6uPCTpkhurM7jPrQO6g4UTR6mj1X0ttn8
	SzkSGUoThUumH1VAfC2JRco3jFqAHEFC5PgdXR
X-Received: by 2002:a05:7022:6896:b0:133:1be4:a357 with SMTP id a92af1059eb24-137d3f18cb7mr4397728c88.1.1780321468166;
        Mon, 01 Jun 2026 06:44:28 -0700 (PDT)
Received: from GordonMsi ([24.249.245.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137b3c7fd47sm7323475c88.14.2026.06.01.06.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:44:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Gordon Chen" <chengordon326@gmail.com>
To: "Mathias Nyman" <mathias.nyman@linux.intel.com>, 
	"Mario Limonciello" <mario.limonciello@amd.com>, 
	"Shyam Sundar S K" <Shyam-sundar.S-k@amd.com>
Cc: <linux-usb@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>, 
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Mathias Nyman" <mathias.nyman@intel.com>
Subject: Re: USB-audio isochronous Missed Service Errors on AMD Zen5 client (Fire
	 Range) -- Data Fabric idle C-state? No OS-level knob found
In-Reply-To: <18b4f7b23ba6392f.e25301f473da0264.54f7bc72d1817dd4@GordonMsi>
References: 18b4e4f7089aa4f1.da8dbe994ae3bb77.445e21b98b0b205b@GordonMsi 78ebe71f-85a8-4675-aa0e-6011353dee39@linux.intel.com
	 18b4f7b23ba6392f.e25301f473da0264.54f7bc72d1817dd4@GordonMsi
Message-ID: <18b4f8f0c2ce37be.8d4c4c4ee804b95a.4c2042ec04b99872@GordonMsi>
Date: Mon, 1 Jun 2026 13:44:25 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Hi all,

A quick correction and a sharper question after probing the PCIe side.

I checked the controller's PCIe config (lspci -vvv): the xHC function
(0000:6b:00.3) has no Latency Tolerance Reporting extended capability at all
and reports DevCap2 LTR-. Its upstream root port (00:08.1) is LTR- as well.
So the PCIe-layer variant I floated in my last mail is a dead end -- there
is no LTR register to write, and neither the endpoint nor the root port
advertises the mechanism.

That leaves an apparent contradiction I'd appreciate help squaring:

  - USB/xHCI layer: HCCPARAMS1 LTC = 1 (the controller advertises Latency
    Tolerance Messaging Capability).
  - PCIe layer: the same function is LTR- (no LTR capability at all).

So if I issue a Set LTV command (the driver-injected path you mentioned),
where does the xHC actually forward that aggregated tolerance value to the
fabric, given it has no PCIe LTR egress? Is there an internal sideband path
to the DF on these integrated AMD controllers, or does LTC only affect USB
link power states on this silicon -- in which case Set LTV would never reach
the Data Fabric?

If it's an internal/sideband path (Mario / Shyam?), a Set LTV PoC is still
worth trying. If LTC is purely USB-link-scoped here, it won't touch the DF
idle problem and I should look elsewhere. That distinction decides whether I
write the PoC at all.

Thanks,
Gordon Chen
