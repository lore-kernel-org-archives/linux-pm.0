Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E0B16F288
	for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 07:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777102083; cv=none; b=tMI/Oy4UW1MH9VyrCjGq3aLJwoXjzEjJh4wM6sKCXPzCUYirBdng9Gbdqv1oUL4ZYZhwLNDlPf+fOse4RCPBo33f+ak1fE/ji3iUzQqKtr77ZJ3PhguI7FPHVSqsfl566CazbtTW5nJv3eWCa275bUAFL7zgBcJErq5NJ+ETLls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777102083; c=relaxed/simple;
	bh=17/CBFDL6IWPDeROXcR7moTxmvGzz9TuFleJpCtcQbs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/ePDL1X+MJGeS607hbEALi18Yn6mpcvZPF7M6HgdEBXmC6jvZro706hSRAoGgl5ET0VLrPoTex69UMUvGVwuMSm02JPqQJUv6Twutu34Xd1EUVw4n3TM8tKCqNJUHsgx6GxkV5HZD3sSb2mvijAJC7VQV7B2ILA9Kkta+Om4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H6SL5pws; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H6SL5pws"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a62a049c1fso5854562e87.3
        for <linux-pm@vger.kernel.org>; Sat, 25 Apr 2026 00:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777102080; x=1777706880; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xW5ZnIUGYBZiAKEkp+Ndmt4R6ae7mjibvf/cMHpatok=;
        b=H6SL5pwsRywSvLRGfBPof2x4mLMM0HRAgnouUXTXg6W9ZHBFlwsOGAVfVTV+J6BVd+
         N7cospIXFmJXNn970lyiSN+pnkLt4CAxypmBl1gmPq0pYbXVAQwokZttqUaUhexpHkBL
         I7BJFDoMOFkvpSWDntaTgnqIsPJ9JnBnh+Z71j6ZJlQFW45ODtMF2m3vr8FF39flQug7
         oGiwFDRvu1Ej5ICbMal+2C5kqcoXik49tzXmAf9LF6zY3ZzTyWalg5edhJGl+izqRxEf
         wyTG0x0Yax9SrvZHJqGZcEoZRDD2TOdBLD/YK1DZYHPHHoEsmVrI0rpiqI337dRWSRNS
         Q7bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777102080; x=1777706880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xW5ZnIUGYBZiAKEkp+Ndmt4R6ae7mjibvf/cMHpatok=;
        b=IEOOmM8IZ8YqhtxXUa8hTI+1NrldnoG0NPfjmcsWrzWT9/adkjQ5QmhDJ6dUvFA++d
         V9S+q2Soyp0R/shG/BTRlJl0NjP3Qvulur0Jkg9aOBX2hdAJQDKjzBLqHikYpo9bejHa
         bNT1ptioqGIkGxBzxgAzpYS5ZybEWmNADOlj3luRzhMmZTXrLiquxaWdmPvZ10QsCbIb
         ifolNdrd4e1B34/6XFCSR5E0YutQVbkwm467f95/rFS+0X369BM1WbTz7drDFwm4KoaZ
         BCGpiICa2bN+AvouQbhsXPVPOB77hPdDVeSP7ZYKEUc5FP5VpPY7+AMgKj2xGrt9tAkL
         FpGw==
X-Gm-Message-State: AOJu0YyJzfEkaiRstOpdbj4TYit2nZEXvUFLG0fr4yO8CGIziPeGbM85
	gBihPBK1p/Vrqt7cjKKAkmIlq29dC5NSQ8ZhlJc57MDvUniM5T3N4oz5zNKe3ihE
X-Gm-Gg: AeBDiev/BOnFQrOmR9SL4UeffXFZcFzpNaeEpnMnddYbQPbvI0vJvhPI9LXCUE9Q/w3
	eAG/z1i57j5q7ZdE7mJ6lJQz5k2xRsoUi5xIuu6kzm6MW3fbeMmfO1/qN5eUdVsP8MNHrf+xaia
	JfIzGeoIp33ynA8dd5XScvQD0lqFbOs8iTUYbCaCA1pgyzB3Hcm6ucs9vuadXokUKcxJtSPsiur
	vRvrnOSOXVBJXKVhuZijeVdc5rN23DlZzInLnre1Qp7IgVVh1nSJoqAdX3syOWPDOf4FdnLcfAt
	wfNlr3wVLiIsdRp/jATpN8KvDqVDLoP2K6f5paT94tAQOsKCWSN3HZAFECgAguLWlfktwkEmYKs
	t2hsGRrQ2ylNQe+vHj/oOmk25JZ3ofunDN9FrEWHVUrhVZ/2IQg/xPBaIE5YRsUocGm0j31q+mK
	LGldKr9HeQV+CJTa7oLAGUVBCoufkEcA1Zpdu77ZzHDF3MoHQgwoNuHuu+voIqkh4XIqDTZTo=
X-Received: by 2002:a05:6512:39d4:b0:5a4:496:5b9d with SMTP id 2adb3069b0e04-5a4172fc8f7mr10793133e87.33.1777102080016;
        Sat, 25 Apr 2026 00:28:00 -0700 (PDT)
Received: from [192.168.1.146] (176-93-242-43.bb.dnainternet.fi. [176.93.242.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc30csm6593821e87.33.2026.04.25.00.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 00:27:59 -0700 (PDT)
Message-ID: <87f43bb16b2c9bbd0ad5c78a3c0bbddff51875af.camel@gmail.com>
Subject: Re: [PATCH] intel_idle: Add Panther Lake C-states table
From: Artem Bityutskiy <dedekind1@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Date: Sat, 25 Apr 2026 10:27:58 +0300
In-Reply-To: <20260425072532.358365-3-dedekind1@gmail.com>
References: <20260425072532.358365-1-dedekind1@gmail.com>
	 <20260425072532.358365-3-dedekind1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-04-25 at 10:25 +0300, Artem Bityutskiy wrote:
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>=20
> Panther Lake supports the following requestable C-states: C1, C1E, C6S, C=
10.
> Add a custom table for them.
>=20
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  drivers/idle/intel_idle.c | 42 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Oh I apologize for sending this one, it does not belong to the series,
I did not noticed that I copied to the same directory. Please, ignore
this patch.

Artem.
