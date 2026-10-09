Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3383A470E91
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554856; cv=pass; b=ZEMIGJnGbBdya6adgh/8GTIwWHosIfv+aXSg2lrSKm+xg1JUayGy4dTbUrHS5Us4H03vaWobMmxGnqdFNzHX+CmQC0q5O8aIsPZK7AOAeCVVwvhE9yudGZW8ZpNcZrbn29ZdReGnoranljADdrbf8d7vvdjjO5K49nFkJU60mqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554856; c=relaxed/simple;
	bh=b4rMtXSyvgzVOdG4ilTjHKgvnbsQsAYQrWnRRDEOIYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cKfLNJY4qH5xLYqpxkEzO87YAQhW5JXoUVJMZ68fZDmcvKmxoynmE09LatImJ8+KX0i1YR0qjZk42zxKUAvhtjQ+AP89pqDNhNvfDmrgG0uU892igGWA6Df+YTrzwylDqDzA+Os06marqx11/FvGGVwdAqBPs6axppWKwH7zDXw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tI28d+vc; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tI28d+vc"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e7496f947so657436166b.1
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 07:07:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554848; cv=none;
        d=google.com; s=arc-20260327;
        b=YZF1WuNEXS8cXtAVHaB46bxq9BZm4TIaw3iWanH58qFXr94UkyPlHv/1c/a+AlO/Xv
         QY8LD8gXQxNLb25nPstRpBGxlOcdDrKzLFG1HhbxOfc5yaUg3CL3q/FrvGeGMyZD0KQY
         rqo74+W/yyHkUl45r7wwdwmMZk0GssaPRC8WyY3e5U3QfctYrceCotXxR5GfwjpZRb3j
         DUoglDkTGMQCR+THRjrkaj13LvVSceyH6jjaz2xk+Ob82tER+jdzEUhkfRuvAoLZZUWa
         hvOcolS01NdGMf4YX37YysBd+BqKHiuEFBFhckBRiF4t1Pqvkd0WHXo2CopHEdG/MS+Y
         AgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aPA7l/cDhFmUwI+RbBKmxxOCeGT4OK8rl1qxZjkWe6o=;
        fh=NSPMMHNA6bYrIQhiPwvbse+o6bsdVwn7+3LOIcLDnG4=;
        b=c9FPMiU3hgS2tClpmDpdz/ZI5S1ugJ6kyMDKNcZPoqiJnVaHWyMqEtbpa51DpIzvjo
         3EGpP+uR1YpYi9etKGBHREtc/JlU8SNCx9xolPBe8YX1gF7m+h3QfmNPvUDi6dZpnecw
         VUZkq5k0BYQDNp2bG6jFzS32BkohSkDbHLYANBYLVwEmLbNmB/sJ2VFlJGDdQHSpCYE+
         2yTVA1soqFDMtzM/Q0Ymd/+glUffrhFf7tCVUncd8kZJWTobS3lT5GFAU8Zzw4N+CwDL
         ZIoxAT/yAVRNf1cFplVXev6/XuuE+onNtsmYGF1po4zl3I2pqilSeBT1ZRXjxjXCPx8M
         l9Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791554848; x=1792159648; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aPA7l/cDhFmUwI+RbBKmxxOCeGT4OK8rl1qxZjkWe6o=;
        b=tI28d+vcT32QNDXXxD57CMlYBpY0uzxmVlYA4pTnMZtsVPZu9Te/6iN6ABoKOseL6t
         lJfdMeJgOEg8ikoXEV7KBGOKonFLFV5PKbp1v9w5fn+zSldEysQJCAKe92B4tEme8vmL
         eFEphO3THRBHvZFXl1gwAKRftY8Mxc3SknwTVYRKx8wBKTvHLEOpxflZQS+P6ON/EyaR
         61vWsa04MyOGvpqByi5YR0GDJIkjE33aX+gvyMWeEZuXPiSOr/GbISpEC+72vwkb4n8X
         xnihV0WnCUmla7yRP+dRJOs2kBHgIdiEIs4o49RIt60R8breNsnApwnSBMXlo0W9W/6O
         TiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554848; x=1792159648;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aPA7l/cDhFmUwI+RbBKmxxOCeGT4OK8rl1qxZjkWe6o=;
        b=C/7zAOqUuNHMxU3GCDH29leswJ48KHV3khLEUYou+bSlDIdZnGVGZ4lwCpXcyquXhc
         ErYTIOOUQAWSssI04tAhvTHMuvgHPJCJkDmjX/+aZlh3k2YZGNLuuuKLgkFL5FYQJXwg
         PqZP8bcRzktBMSwTyXWCvG4iK9UfSf7TxAt7Mc3ZuFyp4aoivYKdVkLJmFgfsoZjDEt3
         wKZB2rGZsuczKeDiUIvSS/t8FkjI6Yx6AXPmCczP5OBByAPyTqi2cTjKy116ipJH8fMs
         yAnaGXuaw1MQHL/JC7GVj1U9FEc6SbGo5+gTLFIIuSCK1D5InNAKkSpTEcCDrXsjfLcQ
         k1aQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+r8MVAt45WtADJkeRv56oBhVJ9UDNOgmKKZ9YcBSF1hFoTNiX/Vgm0olxgUR+aIV2V6NljE1B4A==@vger.kernel.org
X-Gm-Message-State: AFq9FYLTJD6ApEXH7/ZJbAbeYdt0zkCu+Dy/AdIJT39nLtFHjBbtr8Yy
	PaK/oF6gQAB4WRX7yHGFugfzhadGuRkdfE3qJ1vRji0uBd0dG6i0L6ueElP4NUel54NSFoPvD3f
	ZqgCLLP9OZ9wq+YmOLn9lqyjZdHAt/9RgseaBVqrnRw==
X-Gm-Gg: AYBFou1xcChGWdLODhsilofxmJ382xUcSudD+EuPj9cpo9bIBUYMrlPyRVsxulvouiA
	AfSFiwYPRdeXbfHEmxgx0X0lLSRkDWCAbfmkywC1FpN5BBAV1TsU8OEynberEshGWxopWd/1067
	jWlwyuEvyt3+lLn+98YVin46ha3TPwCWaO7Vn93s/TEtT5xWwrhAHeBe8ZnVBghE4IFBi+W4btG
	5pIXvFOjS8OIumQeFxvDCSPf0cq80LcRftZuoZ3NMC3UY9eH7kW41gOLQezvTG6LeI9SXz6QqSq
	bzmTF6KoR6/84WetFMde016exRG25iFmMVxfbF+L90qnyrD0YBcTxDx5yYH1T8/K6Ui+Ns+TwcM
	J2xdFDxCOPudrNfLxxVUJ2A==
X-Received: by 2002:a17:907:9618:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c31a9d0a1efmr229344366b.11.1791554848238; Fri, 09 Oct 2026
 07:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002154415.2270586-15-vincent.guittot@linaro.org> <20261009111627.4861-1-kayracizmeci@gmail.com>
In-Reply-To: <20261009111627.4861-1-kayracizmeci@gmail.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Fri, 9 Oct 2026 16:07:16 +0200
X-Gm-Features: AclHuK93qwibmCeDReqU3VlqkUs03L7RaL6WzAc8RexM6-c3eryuJOq2Yp8j9Do
Message-ID: <CAKfTPtCwv5f1D0uDqa2vePcYzavgut1W1Mab7pz3o7a1vTYO9w@mail.gmail.com>
Subject: Re: [PATCH 14/18 v2] sched/fair: Enable push task for preempt short
To: Kayra Cizmeci <kayracizmeci@gmail.com>
Cc: arighi@nvidia.com, bsegall@google.com, changwoo@igalia.com, 
	christian.loehle@arm.com, dietmar.eggemann@arm.com, juri.lelli@redhat.com, 
	kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, lukasz.luba@arm.com, mgorman@suse.de, 
	mingo@redhat.com, peterz@infradead.org, pierre.gondois@arm.com, 
	qyousef@layalina.io, rafael@kernel.org, rostedt@goodmis.org, 
	sched-ext@lists.linux.dev, sshegde@linux.ibm.com, tj@kernel.org, 
	void@manifault.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Oct 2026 at 13:16, Kayra Cizmeci <kayracizmeci@gmail.com> wrote:
>
> > Enable push mecanism for the preempt short feature which is the
> > 1st feature using it.
>
> IDK typo count of 'mecanism'. It would be cool if I counted the typos I found in this thread.
> They're so important. But, I didn't counted them
>
> > @@ -3475,6 +3475,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
> >       sched_energy_set(has_eas);
> >  #endif
> >
> > +     if (sched_feat(PREEMPT_SHORT))
> > +             static_branch_inc_cpuslocked(&sched_push_task);
> > +
>
> Well, as I checked it seems like first user of the push 'mecanism' can't be disabled.
> This could be the correct behavior too tho? If we want to open it and do not let it
> close even when PREEMPT_SHORT is false...

I didn't want to make the push mechanism enabled by default but only
when something uses it. Short slice tasks are the 1st user.

I wanted to keep a simple way to disable it at boot when it isn't used.

>
> But I think you wanted to connect this to PREEMPT_SHORT, no?
> Well if no, then well I have no words. If yes, I have.
>
> I done a quick test, adding this line to here:
>
>         if (sched_feat(PREEMPT_SHORT))
>                 static_branch_inc_cpuslocked(&sched_push_task);
>        pr_info("push key count=%d\n", static_key_count(&sched_push_task.key)); <--- This
>
> And booting up the kernel. Playing with CPU1's online status and closing PREEMPT_SHORT.
> And...
>
> [    0.967146] push key count=1
> 0
> 1
> [    0.967146] push key count=1
> [   42.408439] push key count=2
> [   42.475103] push key count=3
> NO_PREEMPT_SHORT
> 0
> 1
> [    0.967146] push key count=1
> [   42.408439] push key count=2
> [   42.475103] push key count=3
> [   42.562426] push key count=3
> [   42.619255] push key count=3

This should not happen. I will fix it


>
> This is a bit messy since it's raw, but as you can see even when we
> close PREEMPT_SHORT this not decreases. It just stays on and grows over time.
>
> That's what I'll say, maybe I'm missing something.
>
> Thanks,
> Kayra
