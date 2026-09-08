Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5755A987A;
	Tue,  8 Sep 2026 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788898052; cv=none; b=ok5GYNy44kCuPcmTDZlH1M9cM4Elk9LD+VabmJgZoJevsMIgPUN4e1gjQW2Z7zinqgmZFRHKmstktTRrel/wuIWAbGJeIAxLeGVoc5kRlloEc+COvKltFelDr3EHSHSixyMJnNIKKwT7GgUJrMJOA4XQgsnqNv8uOlI8cy5PYUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788898052; c=relaxed/simple;
	bh=+58J6D3CE4XJKlOjtrnHo4Q/C2s+g1wtC9m2MXhx4vs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TbjNH00AxIpZ4OE2wrUlvIJQPAhSeYHKZNwFIoo4KwnX7rKm8979gsh6upAZmg97xTkHzXDRXg3ELZzd4d/gEQMXpcwilVEauxn1MssysD01ZmDkx39dF1O7m7XQVPWoGfOzT/0cKe1Mfj/jGQ2H0jbh2z9TgfWXck2RSy6fbTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGTJ7QR7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGTJ7QR7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340F11F00A3D;
	Tue,  8 Sep 2026 20:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788898049;
	bh=iJOWJWZvof6Aiu8tr3s25l3nk9WBufyE2g4zQc4CtfM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EGTJ7QR7Lt3NiLz+E6t3GFiwCY6WeF0N11n7PdlGiOiLrHZX4r4GptoeRIddmZ5ba
	 a6blWerESKctCBmyVJ5tMc6GzZdW1+FEk+3SCFjPruF8n1+bicbrOdbdOVNSf8wxOH
	 z160qZ1Ep/t9PsutCIQxDQMrY19tWAkzMVJH1hbXzDArdjSG/Xn8kkunk0sEIDy/+j
	 bikHWmyYmGvzzlub4kNyvR7T/3xdLbvCgWSUfWDAFqLnUlQhFGGDGiCgv/duU+doRn
	 bAoYE1++RXmodzQxuvH2Pq3+Vf2xVA1nuyWb9ucleVLCeCt2Fd5pOPfEuedQwP8MgW
	 d9f/kiDOTZnnQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Zhu Ling <zhuling0805@qq.com>
Cc: Zhu Ling <zhuling0805@qq.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Radu Rendec <radu@rendec.net>, Pavel Machek <pavel@kernel.org>, Len Brown
 <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo
 Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH] genirq/PM: Re-enable chained interrupts after hibernation
In-Reply-To: <tencent_EB4BC71944911E53F173CF6B5D92EB1AA908@qq.com>
References: <tencent_EB4BC71944911E53F173CF6B5D92EB1AA908@qq.com>
Date: Tue, 08 Sep 2026 22:07:25 +0200
Message-ID: <87mrtr1p8i.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 05 2026 at 23:27, Zhu Ling wrote:
> Chained interrupts remain enabled across suspend because they can be part
> of a wakeup path. Consequently, suspend_device_irq() does not set
> IRQS_SUSPENDED for them, and they do not have IRQF_FORCE_RESUME accounting.
>
> After restoring a hibernation image, the interrupt controller can have a
> chained parent interrupt masked while the restored descriptor still marks
> it started and enabled. For example, the restore kernel may initialize the
> controller without probing the driver that installs the chained handler.
> resume_irq() skips the parent in this state, leaving interrupts from the
> devices below it blocked.
>
> Pass the hibernation restore context from dpm_resume_noirq() to the IRQ PM
> code and force active chained interrupts through the existing force-resume
> path. Set the disabled and masked state before enabling the interrupt so
> that cached descriptor state cannot suppress the irqchip callback. Calling
> irq_startup() alone on an already started and enabled interrupt can skip
> the hardware access when the descriptor also records it as unmasked.
>
> Leave disabled and unstarted chained interrupts alone. Keep the existing
> behavior for ordinary resume, hibernation thaw and recovery, and the early
> syscore resume pass.
>
> Fixes: 0a0c5168df27 ("PM: Introduce functions for suspending and resuming device interrupts")

This fixes nothing than a theoretical problem hallucinated by a LLM and
we don't fix hallucinations.

If that would be a real world problem then this change would cure the
symptom and not the root cause.

Thanks,

        tglx

