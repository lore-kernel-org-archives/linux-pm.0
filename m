Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795416480;
	b=qnsT2bzh8FG3W4vGwSPT+AKV5OHcFpvh7KLdDB8HQNgGI/3s8ux3jcEmggl+WsIKpDcN
	 OJVIksYjeboyay7iEDDig3RLC8baXOA+l7KxEBFJugCqfCkgGe3cUBkhOudvCVXS35nbk
	 wYUH4FkqZljga6dNrFDXMUpiQwSa7PSTwQ672LasQ3KcEQE435+Z+mvbt9V/WJYqSeftT
	 yP/lKOn4np2xTOEfUAvWJelsoa8/qfI9ZBWk+f5/nG5mTHDMo5qwyTOoY5uoOIGvN7yZ1
	 DxqAvpT+FCes3SzMsTr+tYg9tNOM1CBfpqUmnU4chaZ3+SfPIdWlOb/UTDswi/vm+kA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795416480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Content-Disposition;
	bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
	b=SP8EKC+ngJ7dzoDCAUBDcDE+9L7QYZvipoMa9abUjObvKCzcsyamuBUI/6zdkeNWVxQ9
	 gFidXGxtpl5kPXGK5D/kjGQ0TblDyb3dH4EVDUr7EMsfHJpEFyggGB8pRmwIGc9H5GatU
	 r18aRZxsHJskw3TTd2JA62OpqWld4mw7+lsflv3t2Vi7FLtLncQ9BiGMKtuOMSm9+qVFT
	 WnBspiTA7fDREc0vcptwFxp0VvknosczNGPYhZ5qcsQ0BCp8b4ClJL8pQeBOGDJd62aIt
	 lC6qoACJSfjBffGdCDskaB+thy1KrmiPZVoK4sqoU/Z/Zeh9/Ohady4gy4Rignu2Hsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 95BCA606A31A
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 06:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95BCA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QtcT5jHJ
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2f037bc348dso24316385ad.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 22:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795416480; x=1796021280; darn=vger.kernel.org;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=QtcT5jHJqWm1+yYAA4VFMUP9cS+spmeKwR5RDKEV3n+c3ftxMf2A+S0r6XtwhfzSkA
         i89BXqck7v1ltIBc4g+zcm6rPOPLJn/WoTGr6fWujJ5HHX37VCCqn+5hkt4UpvPDAyK/
         DzuOh0Appm/d4BWAtNs5xZba9MLv+lEZJLKeuv9+JAAyKr9eFkW+rOMsNjggp1sksr5X
         B2JKTwP7urRGyQVRlhafyhdA2ffZMnmFgkniU7mpAO/qkc49LYqaFAX5hYEglksH7mef
         k7TEeU43ML1MTVqG7C5tNuJ/CESrvVz2mPnzpvEBeefrauZymIXXWJIHNRH3mUgbvMWa
         6S3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795416480; x=1796021280;
        h=content-disposition:content-transfer-encoding:content-type
         :mime-version:references:in-reply-to:subject:cc:to:from:message-id
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9XAnfSrCk5TAgri3G5kirQJ+1QUBkthXAlw0j/mwUvk=;
        b=BfBffkUL5nmH9jJMbEpbe3HDGpdaiPk8uv4Esby0gf7cIBVurRaiFeeBpoj/8R/gTQ
         vQzwvLyn81Qm6tluGymHcwXhcG83e9JzH5uJrGQZfoGO3DHWUQmVrILKCk9MvIvQF+IP
         xkR0Hix4WUwdZPkhxWea7BFQUYlYJdZvCD5vjCukhx+vCPuP2aS73tMes+WoPf+wG/da
         B0MMFTXkv+zug/UnxqRIbjntYX/JM1u/SwqPFqPozBwLl8E1++Ws9DAkTRek3MArbyS/
         LkN6i1m6KJNSTRRrAvU+BCl4bElOfndcbjyPkDY7jkJ3OFfx5sYtO6dqbpRwIOh3aX8F
         JMFQ==
X-Forwarded-Encrypted: i=1; AL+hErHlKXmqooyfKEOHhoKicszOOTuN0fdtB4nbLfG6V1QjctmxRRNlBzA8rAiHnNtff2Ex/xGyqb8LeQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+DsGZU7tL4nTp47EfsuqeNWrGlvp/BN3YtcPqc6l+B8P5x/lLZ
	GDRtzZqGcT0eic6EefjvoHnBScz97bzE9c5sRM+hpJ5ga+EQZNgWbTdB
X-Gm-Gg: AZFdTZcFQQ1hlDUVmvH1ufRs+FH3VWWL/0V062vPK3kKw85rNR7LbGXp4bHUdnOdnEj
	aMvYPFzQQwBaMmjL2D65+xOeP9vFJ2yPeyPhWnO5As9uyYUq8hwZZgGUCSCSxjN2C2ZhHRHIKti
	I0Lx5G9qF/AI7g6HekinXlsisZALBHHqlZPEVGsQYorHW9Kd+EYQGLO0k7lXmXJrIvpWAD+RV8a
	G/CqyFtzghdLOY3TGPuvrioYZqJZIt+MYsLF7sLsOEshaBI8yJ6GT8YhyLZ8xDZJzk6QMVzlDDQ
	4RIFOGkvyxRpt0xp3IF6NEejR66Xcz9kdZ3hL0YdRh5QDZzjCgH2ljejrUh3rhiPp+pLIJ3B32P
	8aDe3JIZLchZvQOYpznZUwD++aNTdBqcS4QH7hCSxLucIl9KJW40vKEHUHTiJEaEOvMqZvYRxsD
	vJOPdYD319prmYzjWpPfOS7juripwgUeOJXMVbBDC8y35s7GAIzuSrTTVMOnrv3jXAREtcxQ3Ax
	HzrUccugY+2qSqzm6zCVciDoUBxrNAka7TQcRG8qaNj1ScP0RazaN5dTd7K+6LXnfNH7Q0ka6Pl
	IdmGivifqTwnXHWPE3103jJnJH6HEGtI1zkLpiiYQW+8ZGCsn09BSVKv0DQfktDSd81o2A==
X-Received: by 2002:a17:902:ce82:b0:2ef:e9df:2422 with SMTP id d9443c01a7336-2f03f1cf4e6mr103786255ad.16.1795416479999;
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Received: from localhost ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03ee84364sm48678155ad.5.2026.11.22.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:47:59 -0800 (PST)
Date: Sun, 22 Nov 2026 22:47:58 -0800
Message-ID: <8ee0713aa3e3cb1e54c0a60f1b32cb86@gmail.com>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Mika Westerberg <westeri@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Corey Minyard <corey@minyard.net>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 8/8] power: supply: sbs-battery: use 4-argument i2c_smbus_read_block_data()
In-Reply-To: <avELD9tlEfl9Uth7@venus>
References: <20261024-i2c-smbus-read-block-data-v1-0-19bb97467982@gmail.com> <20261024-i2c-smbus-read-block-data-v1-8-19bb97467982@gmail.com> <avELD9tlEfl9Uth7@venus>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Sebastian,

On Mon, Nov 09, 2026 at 12:52:18AM +0100, Sebastian Reichel wrote:
> On Sat, Oct 24, 2026 at 07:48:48PM -0700, Dmitry Torokhov wrote:
> > Pass the destination buffer size to sbs_read_string_data(), and pass
> > the buffer capacity reserving space for a trailing NUL terminator to
> > i2c_smbus_read_block_data().
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thank you for the ack. Will you be applying this patch to your tree, or
do you expect me to queue it through mine?

Thanks.

-- 
Dmitry
