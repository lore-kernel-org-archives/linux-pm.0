Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BF9345CB0
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774367204; cv=pass; b=jiufz6Nbn+jZzngD1mJ4ogI6Z8crMjU1m9pfpXxiMMhif+7zKkGf/xJTK+psv74sbobqLbFKsHPG1cPVwicxw44euzS9R94XFX+h1XU0WNmslg0WnjktOjw3I1sycxSGKGsF4CD8boF8OKx9etTbJY8nMtN36e9gSt2avND8Bm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774367204; c=relaxed/simple;
	bh=myealnjHRpNkrPuC+NI071bKS4zheQrDWTxXlU2rEuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y3yrDijzHlmBOoUXAKiwmWmFgfk4761fPqHPuqu5RGXa1+xYfr0gDv+VPL8WupkPq9AoCyOpLlBPe3inUOjzJPAYeylj3JiytADqeT2y5NC/0tW2sQd4Bj7G5b0nWzEv+SL2Ln+oPmkhzW5lUo15B2lksMSaw/XcBe8vM2nZrrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y1lXF4ad; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y1lXF4ad"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a12cd0bcd8so5042103e87.3
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 08:46:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774367199; cv=none;
        d=google.com; s=arc-20240605;
        b=O/wibnnwkfZQ2RaTfgRcX35hnPC8niaKMb3JQu6Itj4cCxFj0NEWkJysAjDxgpEqMR
         tOVkr6C6aONVlaAVbfCyuFqv+rVlAg7g32DtL4hnbwnnNJSO4BjlNEFIWr8gDE7RyInc
         UNJOFfWG2CKFpPxSeucUp5RDJd3SGUxThNiRfPKw3JkFyXTNmfx3SDlSdKJ1Dv964z7m
         HI38sG7KGbdpA6UL0A+bO/JuJ/KVUh+zmqxiM9+uIOm1xY0bs0H/g6ropE8MXbUdnifz
         rpVQaXiIG/lWzTGpQwJNYriCHBNS2Eg0lwUhe9R5uxUIgGxojdg3P6T5N5GkR5x/sfZh
         3pJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZM1xEwGx87iUs7rsSEz5+XXJ45+mZ7eY/kl/Zbvofbc=;
        fh=3M2eiVpgmISUgAdi4vmgFbcSFkXsNPXvqchGrP8IbqI=;
        b=cArrOQfr/jf1FigS7XYyy5rt/ncFYEBOC/5D8yGHdBXn8E928s1odEOzGoBDukGCeJ
         rUTy9nQRvZC0OGEUDg9GLLJMchuEtx3lQ+628QS9HLYmwueyy3UU9CABM7EBii9Mbkdl
         NJaI+VkCWsFouPoAxgZ6m92D9JLH7na8DKuWQTXBD8yCO/fAxuL8D7ruNwD2pVf+fxDe
         F/So3/Bs7yp6ObsgmFqAOC2qxA0fMIAfroxeM5urQTkSuI5GcaZiwFAABVXzORpfdCzX
         Z1yycm+ItjJOnlkcv3iEbFdTfctYlIyxkC0bQXBmVr5AUse1n8f00KK/psHRc/McBk6f
         k/VQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774367199; x=1774971999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZM1xEwGx87iUs7rsSEz5+XXJ45+mZ7eY/kl/Zbvofbc=;
        b=Y1lXF4ad/OTUIeHjeYU7ap56/TZnzdQQsrJDJDlQMjG8udHYjzKh81AIai+evDe0FN
         SwyX85unoW137PvEKo6UeGyHV7ImzN0WwFIqD4hwhaQxx9ybTVlW+2QLXoTEm85zK3cN
         trsDo1en0ob4NfAYsf51sbR2GtbL+gmh1fr0fWyuCiHj05Cz6AHQtDErHrcEx7PtQMz4
         CLDbb+Zigi/PbIxR6f7JQ/C3svSAs/zLtXCZc5ghJt0IMdi+ynFJoZOowPbVwqvNDF3H
         G8AZGsDa8zfAQy39gRTZcudHdIF/YWPQnQY3aNKk8QvxeI3RcAvttdoNwKYJ/d3KLlHU
         IJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774367199; x=1774971999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZM1xEwGx87iUs7rsSEz5+XXJ45+mZ7eY/kl/Zbvofbc=;
        b=AsRSMxIzSn9pIeLnqsT6znXVkIEq8f1LGGWdHdbIcRSIO/yb8NEmRmSbniH2Pu5qIu
         FwQ+73a1lNFe9pg5N3W35lcefnqT8kDe+gSlRXuwcZk71bEBxdFSYkHA3wv/Ajcd4iX4
         ZkA6G47u3I4hnvpJZPnQibuwPbFZOSLCmgNPvs4AoW4hZOhIiuNk8JJCy6UsoKA/j8ni
         j9NH4mqpXECnjKZHd7G1ptLnsnmsUf6MmkIZETmFeeKrjBAjHZsh7X1Fe4jF4hl2VIBd
         ax46zr+BheH0sxyaMabLSSGN0rOF1HnfDDgQlgH1cpmc0EEjDh7XXXA6ZIBMu7yuM0Q0
         DtKg==
X-Forwarded-Encrypted: i=1; AJvYcCVVM7bv3UqWqFklf/t9n6RQQ3vGmDzBylsTYROsejdWU0TJr38tmj9aAziVBwpmHcDEZUQsq7/EKg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo08++PtP8+/33iQPMRHJimx8n7nGxQnmrzda3sI5E9szf7V7K
	jzTwHVVMBzHj2qne/Q156ecTKCwP55OHj23CgUeq/PH8gmzHCez+Z9YEetMhAg0WQEAXXJoEqvp
	apmi7BTv1IebKkSfzn/rU3sw+qVRU++216PAX+1L6Ag==
X-Gm-Gg: ATEYQzyMZ7SoMizLEOVnmJvVelFAqY2/db4KfMeP7n5HLQbiHklmlskRscvRSAKJbcF
	fflVjepsUhHvl4lfmIkROZovra+RwpyK4sWQDQqKysvMg2EYhx+0+JJDqXTI5oPcBxNStxsx9ea
	Ni9GmSHxb0OsDhVfWrTJmPyETX6nrypREGiVJnxqnvRrIusDCLKD4XEfCJ95GUq5cY+D9ONlCKO
	sFgnH3YFjoQi16AxvQMdASVVSlMoNakjLY3dZz5E5u/b+U14UyZsY51Lmub/JreZzzrJqWs1Brz
	QkfBGyCD
X-Received: by 2002:a05:6512:3b13:b0:5a2:77d4:1043 with SMTP id
 2adb3069b0e04-5a285b54b7dmr5517789e87.22.1774367198561; Tue, 24 Mar 2026
 08:46:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
In-Reply-To: <20260316-cpuidle_ipi-v1-1-d0ff6350f4e2@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 24 Mar 2026 16:46:02 +0100
X-Gm-Features: AQROBzArOop2zxB1wGihvKREx53zwjJBE38Iy4OR1x3l_zaCLa4QZf1aF6IScrQ
Message-ID: <CAPDyKFqJX3rN0GY1j3-RDXGc0jCcMTG=OmWzi9+2y7CXJOvY3A@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: Deny idle entry when CPU already have IPI
 interrupt pending
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Christian Loehle <christian.loehle@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Mar 2026 at 08:38, Maulik Shah <maulik.shah@oss.qualcomm.com> wrote:
>
> CPU can get IPI interrupt from another CPU while it is executing
> cpuidle_select() or about to execute same. The selection do not account
> for pending interrupts and may continue to enter selected idle state only
> to exit immediately.
>
> Example trace collected when there is cross CPU IPI.
>
>  [000] 154.892148: sched_waking: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>  [000] 154.892148: ipi_raise: target_mask=00000000,00000080 (Function call interrupts)
>  [007] 154.892162: cpu_idle: state=2 cpu_id=7
>  [007] 154.892208: cpu_idle: state=4294967295 cpu_id=7
>  [007] 154.892211: irq_handler_entry: irq=2 name=IPI
>  [007] 154.892211: ipi_entry: (Function call interrupts)
>  [007] 154.892213: sched_wakeup: comm=sugov:4 pid=491 prio=-1 target_cpu=007
>  [007] 154.892214: ipi_exit: (Function call interrupts)
>
> This impacts performance and the above count increments.
>
> commit ccde6525183c ("smp: Introduce a helper function to check for pending
> IPIs") already introduced a helper function to check the pending IPIs and
> it is used in pmdomain governor to deny the cluster level idle state when
> there is a pending IPI on any of cluster CPUs.
>
> This however does not stop CPU to enter CPU level idle state. Make use of
> same at CPUidle to deny the idle entry when there is already IPI pending.
>
> With change observing glmark2 [1] off screen scores improving in the range
> of 25% to 30% on Qualcomm lemans-evk board which is arm64 based having two
> clusters each with 4 CPUs.
>
> [1] https://github.com/glmark2/glmark2
>
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>
> ---
>  drivers/cpuidle/cpuidle.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index c7876e9e024f9076663063ad21cfc69343fdbbe7..c88c0cbf910d6c2c09697e6a3ac78c081868c2ad 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -224,6 +224,9 @@ noinstr int cpuidle_enter_state(struct cpuidle_device *dev,
>         bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
>         ktime_t time_start, time_end;
>
> +       if (cpus_peek_for_pending_ipi(drv->cpumask))
> +               return -EBUSY;

As other reviews already pointed out, this must be called only for the
current CPU.

That said, did you play with bailing out just before the call to the
target_state->enter()? It would be interesting to know if that changes
the "stats" somehow.

> +
>         instrumentation_begin();
>
>         /*
>
> ---
> base-commit: b84a0ebe421ca56995ff78b66307667b62b3a900
> change-id: 20260316-cpuidle_ipi-4c64036f9a48
>
> Best regards,
> --
> Maulik Shah <maulik.shah@oss.qualcomm.com>
>

Kind regards
Uffe
