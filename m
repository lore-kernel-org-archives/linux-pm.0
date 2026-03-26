Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8F73B634E
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513261; cv=pass; b=tmwWrymBYB7A2ynrFAzdUJoewMj9UIonWSFMf9D4r3ZMqwhAJtRPeZkjpvos1mLtZmRJ6CD6TCe2psgDvW044e9bczi7S2fikHGbWUGwQiCqiEP5Yfj410ySM9Uc0mydayJutB8EZa/maLNOnjzGP6fOzj695vO8wk5f9I/MVuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513261; c=relaxed/simple;
	bh=h4YjjJIfRpCRbGq3Jz8rzDKxe41BHzLGaI4jB8ndqkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K29QLKr2dTvgGAnHe/uApUSN07+yMK7QYWH5J3NPDP9+vvqfSGHKrqZwnwgsaVKGREuTnS7/f4wRqK/eZSXZ7eQLIU5OPufYCBUyyYpyDxT73VTsmbgIcSzlacGqTopDYgO+SvbydOqO4fNum/IAOYGfeaSQgMDChedGmHecmSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zEqN6i+d; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zEqN6i+d"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-66a33f61d80so1205459a12.0
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 01:20:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774513258; cv=none;
        d=google.com; s=arc-20240605;
        b=Zog19fArZtv0R+R6iYFvPU2/fIL8pbEVW44B0vxKBgtkKHIZB1xsBFlnE9GmGb/2cs
         jp6pqNmp+2cqIsUVyKPLKlKL1jVQboRP3y+ry5PC8G71D2ATfV7m7KA++PsF6Rhpyz5L
         mxN3TQG2KEaDTmYE2yIC8XEWQ45DQsRvZbWgWywemsZm6h6kOMoq7I+K4oXRl18ikeQo
         2M3iSpeudYYomYSCEZHt4SaGiOyanbQ81hc72QljOrRVci52FcL69pKg2DAFXm+wuFQ0
         AQW4ULDZ3RVei4BsSZaX9rDq+m3ho3hG+Tey1V0CyE99xRQ6PojZSya6uMFOL1K2FJNg
         bu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h4YjjJIfRpCRbGq3Jz8rzDKxe41BHzLGaI4jB8ndqkI=;
        fh=fKUB+DRnaIzMUeGgQG7+5Iiy/fbHww7YtPj8qP/9o8A=;
        b=LeDPnJQIyuzg4OAyxitYs3N/Qwsi5nv3Le/C7YM4opYq6/aqvz2YmL6sSIQwQkqjZ8
         4XP0OcBViyNqX4mBcD8KvLiUpFZqGhoKRMsyOElNgBWhP4x6EhHZbHcYJsfKXq0fdbOI
         zaqJK0uvNQBYcYRpB3OFwnJf0xJAJGk/0+nu8O54HQxUsY8JNvBFx0WCIVMAwHAAhTsR
         FYHLuikuKHZuAZ6TxoJyKXrTqgFEAOVFZcn/miSrUQucwCUKmsH8Q0jj8BPhokkYO+aL
         4v2BgOt8VKqyuUjq3lwR7628xd2bTEz3TL9cQtVtKIKGer1IkgtzfU5FJf5iiJ+G5KLN
         Bffw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774513258; x=1775118058; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=h4YjjJIfRpCRbGq3Jz8rzDKxe41BHzLGaI4jB8ndqkI=;
        b=zEqN6i+dM9XfZBY6odQaYkaAJMPFRKuR6FMEQHhv+/R4nnEvZzDVWzfwjePPze7UUi
         czAYB4XSLzVhsMKjiHkIlUEDjoOpk9Z9nBmr5km60LRslemWC1nLYHoMbw9iN6XlMxRW
         bfaw7/9HlNKs4mhKIP5YYWT21uEHZUtfvYG0Z/6rhMlvDtqpOTpAM5Q5pBYealrriwXD
         qwggRTQC2VcnEDcoqCfZ5zgaiuaTlBwxtVrQj/LNiRUGy1DmcXhcuwWNcM77GckAIXP+
         DXNz41J9PfJ42uACbOtKYKDJJBZ4AJxCICmzsGwEoFTxRt6zZq5LHYob0sT15GebLNg0
         14QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513258; x=1775118058;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4YjjJIfRpCRbGq3Jz8rzDKxe41BHzLGaI4jB8ndqkI=;
        b=HRnpBw80w3Op4N6+i8uW+npMaC+Ivu3cxpxXzpRYVvewZg4argZ4GYkYxrzyEPcvUk
         lOrW1D3XATGa9kdraCE5UjlXJxADqBu6dwNDanLlfbiQnf0GEJ+0tyLzIt2FYeotXGmt
         E555XZPSsN/6udM4lve62kXTo7clOMnW37ormlNCs3By/ZCjokFKpMrXNq/TIR0mi0sU
         AIVQ+p0y7R2s7kUQ0Q+DbqmOKShhK13FFtOJTSoFgzxrAhIRuUG0ScDnc/oN0liC7/w9
         zPNG3Ua8ZizJznHBmYzpbF85AWoiTDgwpjN2mB1VrmY1/R0NxkVKp9I6/TvrsaDlM/Ik
         sqyg==
X-Forwarded-Encrypted: i=1; AJvYcCV7kk+Roj3hATfD5VH97NPiW9AgKH2MqS3AbKm6tGmrp1u1iAnZ6l3Rw4GIxMJUuDYfM4Hnkz4NpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdyMs8w2kMKqw8Lq8MjkIJsurz/i90VRHPPJeBqG+/OFC/1gXb
	It3hOTTMlcRNyDvSXhkoTrhjPVc7W7uoO3dvL0Y2RJr9H4ojmDbRWt+v1I7FF+TJ3rD1tukVBaz
	k9TiR1II8Stuu406C4wKaGTEbh7fJ/DlcjVTIA4ZHXw==
X-Gm-Gg: ATEYQzzoaBw+s3DXk6DXjL7ZF6BIE56Lwb+VkNJ4XmEEAcIhw5u/vMBJrru7QQuu/NE
	VgBYb8b4QZKrNd2lgJIPh4XgNOUE8gzZRT/6IQJsoxh7s69Zyn4IrfIcvsXUPaGDCjIAvmhsDPY
	TivkTM9nT2K8MivEQ6jQySi9qqb1jluzYSbYFuDQo1T/S3nSrDnvc0dKQw/kdJ5BlJE0BolyDr6
	5YiWjh8Z8MItVbq6l/fH4dyn7AMeVVGTyqIr8jwWBLDGexLOixkEU0mSnJIX2iDs6WLC5PaUEA7
	GD1fwSSeORteNC96NFgg0qg9EaeWALgrh0GL
X-Received: by 2002:a17:907:1b05:b0:b96:eb7e:bc55 with SMTP id
 a640c23a62f3a-b9a3f166391mr484776166b.10.1774513257612; Thu, 26 Mar 2026
 01:20:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325181314.3875909-1-christian.loehle@arm.com> <acTqSVd-FhywPQ6t@gpd4>
In-Reply-To: <acTqSVd-FhywPQ6t@gpd4>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 26 Mar 2026 09:20:45 +0100
X-Gm-Features: AQROBzAH46vdHWifsJCVvcXfSlCSS6CXqPEq-wpcopYabSOb3o4T-SK8-t_2J4s
Message-ID: <CAKfTPtDmnnGONJhrQPNh2rhe3-KvMkX1nW8-JYN+otNLQYSU-w@mail.gmail.com>
Subject: Re: [RFC][RFT][PATCH 0/3] arm64: Enable asympacking for minor CPPC asymmetry
To: Andrea Righi <arighi@nvidia.com>
Cc: Christian Loehle <christian.loehle@arm.com>, peterz@infradead.org, 
	dietmar.eggemann@arm.com, valentin.schneider@arm.com, mingo@redhat.com, 
	rostedt@goodmis.org, segall@google.com, mgorman@suse.de, 
	catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	juri.lelli@redhat.com, kobak@nvidia.com, fabecassis@nvidia.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 26 Mar 2026 at 09:12, Andrea Righi <arighi@nvidia.com> wrote:
>
> Hi Christian,
>
> On Wed, Mar 25, 2026 at 06:13:11PM +0000, Christian Loehle wrote:
> ...
> > RFT:
> > Andrea, please give this a try. This should perform better in particular
> > for single-threaded workloads and workloads that do not utilize all
> > cores (all the time anyway).
> > Capacity-aware scheduling wakeup works very different to the SMP path
> > used now, some workloads will benefit, some regress, it would be nice
> > to get some test results for these.
> > We already discussed DCPerf MediaWiki seems to benefit from
> > capacity-aware scheduling wakeup behavior, but others (most?) should
> > benefit from this series.
> >
> > I don't know if we can also be clever about ordering amongst SMT siblings.
> > That would be dependent on the uarch and I don't have a platform to
> > experiment with this though, so consider this series orthogonal to the
> > idle-core SMT considerations.
> > On platforms with SMT though asympacking makes a lot more sense than
> > capacity-aware scheduling, because arguing about capacity without
> > considering utilization of the sibling(s) (and the resulting potential
> > 'stolen' capacity we perceive) isn't theoretically sound.
>
> I did some early testing with this patch set. On Vera I'm getting much
> better performance that SD_ASYM_CPUCAPACITY of course (~1.5x avg speedup),
> mostly because we avoid using both SMT siblings. It's still not the same
> improvement that I get equalizing the capacity using the 5% threshold
> (~1.8x speedup).

IIRC the tests that you shared in your patch, you get an additonal
improvement when adding some SMT awarness to SD_ASYM_CPUCAPACITY
compared to equalizing the capacity

>
> Of course I need to test with more workloads and I haven't tested it on
> Grace yet, to check if we're regressing something, but in general it seems
> functional.
>
> Now it depends if SD_ASYM_PACKING is the route we want to take or if we
> should start addressing SMT in SD_ASYM_CPUCAPACITY, as pointed by Vincent.
> In general I think I agree with Vincent, independently on this particular
> case, it'd be nice to start improving SD_ASYM_CPUCAPACITY to support SMT.
>
> Thanks,
> -Andrea
