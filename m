Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483E7379C4B
	for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 08:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573173; cv=none; b=bkwEGNV/Nc4BZf9tNYyqjDLvBHPClPlko8cerwlGG8eTEZvmVc7MvkPhAswuvWn5TxGP0x05wefVMc260ZI24wA1iabAvCkdILS5zGjDtG/8UP2T3pU1ZahMch98vVM5nCW/zkchmH+zLBo6VQhksZ/qOTpkdHHyaieKAcFvoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573173; c=relaxed/simple;
	bh=Cw5y9vpzQ+HGAAqvHwdnbCKDka1FgZ8X0LZB56QGS94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuTPLQ2pC+QR9voBr4nKMuwi3R9MX654U64fuWIW3GqtFXROTB108WH1UWTot7PvFe267c+eyZW+mWUMxA89Hmz5knMya4KIrvMFYj5up32sQ+dECteyG/jPjUFXuDS11olSYdb/rb9g+f0hzTS5hqwjcQUnxVkJAKaW2uePZ5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gu/a4o4s; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gu/a4o4s"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d77f6092eso3198427f8f.2
        for <linux-pm@vger.kernel.org>; Tue, 12 May 2026 01:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778573171; x=1779177971; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ub9rCJB+xiyh5qMMvDQ8N4fa009xZ6N4W+3GYqzTDBs=;
        b=Gu/a4o4s2OwYS3JU03JpPaNeZZRabZtomXxQ1eM7TOCuqMsFsv36gr4xJdezROV5IA
         Ef6GhZPDMAWGYv1DhbOVvo0x0GMAQz3vek9ayZpChQARGZKWpvlfLNgPDmqwV0P2kY/g
         m4PB8tXEOP8ozDRbk9QCFpuUP6EbksDulwlwQ2/ZVZw2rP3tybPV3mUlSA2UKyZicVou
         69iJGyfFFkmSS8RagYoRY+kMPy9D+jlIA6JcfgX1SXaQFScsMcLx1OwPLqMe9cBsseBX
         gILd5IAXOCHKqiHPSLQGJ0qYXYAtdqEiy3kIx4IPKa8q70tJ0GSEm6q/WiJnGk6MKWDa
         FpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573171; x=1779177971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ub9rCJB+xiyh5qMMvDQ8N4fa009xZ6N4W+3GYqzTDBs=;
        b=i6wkPFrlsgUC0gK43USp8wdwJHGqwiAfoqqEG5s22oAwxK5XT2kyEbj6+M4sGUOG+r
         O/H0kegWPH6IiWAhsLnaZHYPy73FQeDcJbhlBssJCHDmZfDoBeLDHPhOfN1xVZosSe2z
         Wq5aj6Ljz84qWvbNjDCj/kO9/niJTmpncqf1nbFXrr7o8IUUH+hqJJZoc05Sktmup4yK
         s6y66i1m/oAvGWLn0Qf0pnc8M30rhQH2++Tst19QGXgj1psdl9ZjW9hba/rI6mXhYA+a
         exiaBgQp/b98U3pcbqarjemxnEzDq3p5wTSjInUUY4cCAdDDNEgZyfSiuoi62P1EMXTx
         e1FA==
X-Forwarded-Encrypted: i=1; AFNElJ9FtHiMNKEWXb9ggITRgGJfHuPEsA/phHE09ydYw/S+kVyK+nYYIl+a25BH4O2QUcjSATtGicMytQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf8lT7vyyi2kVyiZM51ip0WiNOIyHfq4I3dm4qvZpP0/kn67/R
	j3M/508Th1vmSOLlbRk+69WksBemQfiYxyvCv0nNd7a+3pWC0IEEq1NQ
X-Gm-Gg: Acq92OEv/bUIA8QIm7pBXlOLkbQ1Z5mIUIJhaZZhXpJsgGGI1wPPCIcgqbcYhCKY0Gx
	f3/Yry1ANy92RuJTXY6h6wPHQ1WTXSrQscHWluy/qUVNjSgCjxBbhNN6zrQmxfk4usHJ0vA1Pz4
	eKAG34acIqe9xtUHraUW+olqS09B/FDBFUYWkNu4L5aRyR5hL1zuATO0m04W8c7Sw+rIAe7FBlD
	bQrjQ5F4oZagZrPdYfM8UnQbtJsA2FZLGceRvbUaMyDRY5uJOVm0fYK3vN7vlsl7Etd9GQraxit
	3sKgtqIXDoC8hXF+ictI4sRdlQkzVLeQng9xZxDlvgWCn2K+JarY9BndBcHTTsIC3jWWw5w3qgc
	MP3R9OgbnjI43CB4OiQE7beMj6XHPOToZ/ql+ST951p3Tq3eOS6hZE1KsYPR1XFDa3LqQwVPPTw
	HxPh9bbdgOH6WRGMOE4ZY=
X-Received: by 2002:a05:600c:528e:b0:48e:7f1c:8778 with SMTP id 5b1f17b1804b1-48e8fe721bcmr30944315e9.17.1778573170670;
        Tue, 12 May 2026 01:06:10 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491e94c0fsm31909250f8f.32.2026.05.12.01.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 01:06:09 -0700 (PDT)
Date: Tue, 12 May 2026 11:06:06 +0300
From: Dan Carpenter <error27@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
	linux-pm@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [patch V2 01/11] hrtimer: Provide hrtimer_start_range_ns_user()
Message-ID: <agLfbp9yEiQlTYYl@stanley.mountain>
References: <20260408102356.783133335@kernel.org>
 <20260408114951.995031895@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408114951.995031895@kernel.org>

On Wed, Apr 08, 2026 at 01:53:46PM +0200, Thomas Gleixner wrote:
> +enum {
> +	HRTIMER_REPROGRAM_NONE,
> +	HRTIMER_REPROGRAM,
> +	HRTIMER_REPROGRAM_FORCE,
> +};
> +
>  static bool __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim, u64 delta_ns,
>  				     const enum hrtimer_mode mode, struct hrtimer_clock_base *base)

The return type for this function needs to changed from bool to
enum whatever...  Otherwise HRTIMER_REPROGRAM and HRTIMER_REPROGRAM_FORCE
are both just true.

>  {
> @@ -1410,7 +1416,7 @@ static bool __hrtimer_start_range_ns(str
>  	/* If a deferred rearm is pending skip reprogramming the device */
>  	if (cpu_base->deferred_rearm) {
>  		cpu_base->deferred_needs_update = true;
> -		return false;
> +		return HRTIMER_REPROGRAM_NONE;
>  	}
>  
>  	if (!was_first || cpu_base != this_cpu_base) {
> @@ -1423,7 +1429,7 @@ static bool __hrtimer_start_range_ns(str
>  		 * callbacks.
>  		 */
>  		if (likely(hrtimer_base_is_online(this_cpu_base)))
> -			return first;
> +			return first ? HRTIMER_REPROGRAM : HRTIMER_REPROGRAM_NONE;

regards,
dan carpenter

