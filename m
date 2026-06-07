Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F282F361E
	for <linux-pm@vger.kernel.org>; Sun,  7 Jun 2026 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780831405; cv=none; b=Q1B68jKQ0YBcGmh9R4C+jxmx1gk+TpPpLREsUYtP8ZhqiLEPIKuq7DTVFWmPmXRFiLo8BFUfObQof2yHM8VUZJWACMkv4x3/vJKU8DXcInRzdz1okzAtiW4Fv0WosO6k/ZV+sjV7F1R9DlcO4VJoRKz2UHh6q3Trgzz+k8pK8WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780831405; c=relaxed/simple;
	bh=IFjZiSwqKHxCIcwpE/RgjCov4hw4GFItjcNHY409v1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMpQHOrLB8NtfE8p9tSZmDL2UHVbhGOyN6D1WznQwQQS6EZ/IpPhDaCYCATWCfRjMRyZ5vYxTdAjMX2XCuqO3J0muWHdvwAeq/DeKukgJakQM6E201dbucAa5oGC2GYzZIH671g7OxuMbX50IFCeL/1ic+Bb4RoLSO4PcXZ/Pxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TgEtj1Hp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TgEtj1Hp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490bb83a3f6so27101335e9.0
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 04:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780831400; x=1781436200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xIV+A9YUsZpIvm/xKY9cVRmnS1ILlYLm9GmVIzHOzZM=;
        b=TgEtj1HphPLWMe9prgMOX2WVJe4L4CZeoxGAHwFprwfA5Sym7FWykojN3LW7cbKe31
         UwCEbFxdSXrCFUAP3XH9P5Q9+f8GtA3VyubivapCbFVNkn2zvCtiia3eJqQB5OYnBT7v
         OkF+Hz4+Efv+NlHw6vYpgaDswuYiPBRycsNwIskql5hWw1EWPv4G5j/asBkRcPBT9I/x
         lLPd6HITuJalkjzSNiJNvg/UaFTmfdD7c5nb4mp9H4wCaxmDg9nZqP7qhDg5QGeAFP/5
         jLWzelX8RfbYeXcDp4IlctDdCMiwIHQH1N2d41UL9cmTY2tWZJKyCqudeRLNGPZcJ89k
         v8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780831400; x=1781436200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xIV+A9YUsZpIvm/xKY9cVRmnS1ILlYLm9GmVIzHOzZM=;
        b=TraoRxDab1ELv860uP3W1urpgZUg37XjfQGl61io6LeZVf4I+qNg4+gmtPxVRHHoNp
         YjCnBzr8E9Kxg2xvzqp0ZStlJzTjDXkPbQ3rle5SzM2G1XpT1prYZDiyxVUErJQ9GcV9
         XAxlzRls8Yz6S7CF4K7QZWTpRK/TBu6Uf7xXGQAH8LEpAFX8DEA6yZzMm5jzaT7Pywhk
         2DrHP16023rqrg3AGHRZlU6V9Iuz4slIYvMFk746lG2rBwpdjtlP+B3/fbwUIq0Tmvce
         mGlQW7lRf5hcvhLsZHSc/Tgl0XR9iBlTLG6El++QYGpxIY+xx0t27p7EW2E9BXRkOotj
         HOWA==
X-Forwarded-Encrypted: i=1; AFNElJ/f7zGanCF7ipQkfy4d8S0duVDMIC/Y8eEm764t8nzhzwHJbuAot+GvekneQk86k0dP2PX0+PL5pQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyutIBRB+D43nuRDvIVExr6Sk4IlbkrsgKpvgosyvZR2KHAzM3e
	79DICVSDQwD6aMMcBm/SV/Tk7y8qIfjTZxWg0sc7ibWRTwb3CAkh7YAv
X-Gm-Gg: Acq92OEdP1t3vP41MGhCi9OFHeX57NMC2VLsH7A3zOPPgSeY6yGHAYTeE/h9WheTLo4
	0FsIryx3MEP6VFjwOFVVC6T4dXma3sGa4c59GIuC9HSB9VUSoEhr1YQXiDgVTaKpDZHmdZlVM84
	ZFyClAmVDooNY7tgalugyXfIcnWkJ/C9pdKOedMQaW65UG9caOlziwf43c/uYcVhwlKysTA/ry7
	uII4C7cTW3Tg0tzGMhqR4BY+7sHeWrVZXQLVMAlf05Gj76X+6ccrNiupVaje1n67Ms2M7VPmoli
	C9P45VJB1QG+c8dBWoap9hLsKmU429q27R3Rlt3qHXduWnq0xicstw8+JRSK2+oYz4zl4l6iNOi
	/fcMBkAET/iUNgz/eZ8bH+Znk9yKysXSf9pKJlGdC3MzMW0CdJp8cTk0+EXybwQfIC79XAxmDCP
	HB75CUFY46L8qd/mQk8b0873hriwurgOZE1OrZjvatVgBfiGiEfhX0+vj7VuGEI2SvxbtiTAaZ7
	LE7BG3bmQ==
X-Received: by 2002:a05:600c:5246:b0:490:b55c:cec3 with SMTP id 5b1f17b1804b1-490c25d4c13mr183188405e9.12.1780831400348;
        Sun, 07 Jun 2026 04:23:20 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bda4fd52sm286426225e9.0.2026.06.07.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:23:20 -0700 (PDT)
Date: Sun, 7 Jun 2026 12:23:18 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Guru Das Srinagesh <linux@gurudas.dev>
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>, rafael@kernel.org,
 daniel.lezcano@kernel.org, rui.zhang@intel.com, lukasz.luba@arm.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] thermal: testing: Avoid NULL pointer dereference on
 missing arg
Message-ID: <20260607122318.40696a11@pumpkin>
In-Reply-To: <aiTdAQ6uCuFenv7N@shakti>
References: <20260606210420.2311145-1-ovidiu.panait.oss@gmail.com>
	<aiTdAQ6uCuFenv7N@shakti>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jun 2026 19:52:49 -0700
Guru Das Srinagesh <linux@gurudas.dev> wrote:

> On Sun, Jun 07, 2026 at 12:04:18AM +0300, Ovidiu Panait wrote:
> [...]
> > To fix this, make arg an empty string instead of leaving it NULL when the
> > separator is missing. sscanf() then fails correctly with -EINVAL on it.  
> [...]
> > ---
> >  drivers/thermal/testing/command.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/thermal/testing/command.c b/drivers/thermal/testing/command.c
> > index 1159ecea57e7..5513a26feed7 100644
> > --- a/drivers/thermal/testing/command.c
> > +++ b/drivers/thermal/testing/command.c
> > @@ -150,6 +150,8 @@ static ssize_t tt_command_process(char *s)
> >  	if (arg) {
> >  		*arg = '\0';
> >  		arg++;
> > +	} else {
> > +		arg = s + strlen(s);
> >  	}  
> 
> Here, `arg` is made to point to the NUL terminator of s. Couldn't this be simplified to:
> 
> 	arg = "";
> 
> to make the intent clearer? Since `tt_command_exec()` takes in arg as `const char *`,
> pointing `arg` to a string literal is fine.
> 

Except that 'arg' itself must be 'char *' otherwise the '*arg = 0'
higher up will fail.

So you'd need to handle it differently.

-- David
