Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B0267B05
	for <linux-pm@vger.kernel.org>; Wed,  4 Feb 2026 13:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212278; cv=pass; b=ssCEbWYC/Uk0HfAO8lSdHEePMjskmgu0aPZ0tvnQRJg1jKNfU0UPkPEmtVu0ZwhacrPHfgK7kCbIS4LXQbS3kFptStGaHnuwIxzFSJpdfi6BrNIbEW9B0ewHIZLTnPWkACF0bXBqobOZZJooWB7sbljbUv3fZ7EBw7g7iJm/9hE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212278; c=relaxed/simple;
	bh=TNbAp3YIMzhCgXk3KkdV7t1ztaV7hijgyNhwmhHPzRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Guh6hEC9snuIFu664d47UeY6Ryb9HGWOXCESklNaDcJ22vbUva3bpca3+cRHvrZimYlba0JfP2QlS/Yc8DIlXUiFHuKNO/f06DOLvk61xBTL0gSLI8mgNhZ/cSu2Stk2vhR6Iph0pB8ERIOHNfeOUvXCY9DYrtcnsZ2zsBOfLks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yBXyLRPn; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBXyLRPn"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b7c2614f7so6335352e87.3
        for <linux-pm@vger.kernel.org>; Wed, 04 Feb 2026 05:37:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770212276; cv=none;
        d=google.com; s=arc-20240605;
        b=GvFPqLr/7wnyVCCadBPXE3aSIOebRM/YdS4cVeR5Tj4K9X+x0SkqYRM5OQ8Eh/hIjt
         l95fSGtyd4g/NvCh1M3l6TmnWrsD60EtGBDfuclWlo/Q0S/+Ri6nDNoLn42wpkUSAcBJ
         hrc0l3r0RsGOiDkUPYt2zp+bupWUQVx6J0wIE6zrmOEHviBAHT6t7xkmpYlOoC20nCUE
         ZAvHyA1oHMpgl+N1ySIEGNlr75IF1mh0eKqlGbJGa0jM8nTFHTA7bjKRMwKcsujFnQCx
         XSlk23G3Y4QM5naF9ADTaA9g8rSyANxu0For5rHmslwySEy7HvzvnemBspPd5T/UPu1V
         FRaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MeqldFa/mhl2711exrQHrvvPzPeGGLfZb92y2I+VBt0=;
        fh=k9xtos4at5mve3sk7eUDUylugA9bYESB+5cDsnGQZNY=;
        b=gM65X1qR3AZFLgVuOD0phEnKE21kM7YpSlNI7o2Uy8Q4q8TYSe28k7mu+B9g9b8NL3
         WhFIiXu76FhgGSLDljy1hjQ0+4dK0/biP/0D0Q0awgapvmK0Zz9XhAHM1FH7Si4nYPcE
         a+XKEiI7vFk9DAFC8/rufZ5T0FfsQShzOjY0HKEA9nR4Ih3Yv+0/Q8KEAJKEzXSOrqKo
         XTyyPZgGfXgiyaAMoQr6VHx2r9+kA3bmXZCttB82m4Gx1ZJ+vpwbpCfAUTd7PCyZu1Tr
         1PcnPCPXHoKjMXO4CivGqxmgg2zLjjLmdKsy6am3htv5YAfWq/MHxCorG3bgDLmzjDWh
         Cuaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1770212276; x=1770817076; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MeqldFa/mhl2711exrQHrvvPzPeGGLfZb92y2I+VBt0=;
        b=yBXyLRPngRi3tUIZ2zlV3lrEuE+9lbJnRv0DFaw2ka5uiC28awT5LOLZY58p3rs+BK
         CyBYldpvb+QZ3FseY3KQemc9dD/girDpEYmkbco49JNdJKesCqZlEqTEIr7U8L9jhUdI
         B2MpB6tqQa8QDTlZKTpx/UZO3ntmT+dKAJoc8nPbBuGRiOfXuWaegY98iEBTNH3recw2
         MwMuJQHlbZpe1hwVyIwvDIR5lZtSS0neJ5+Zvfop2qhpMEE3p2Wh9OLn1T4CsYlCLmkV
         R6k77eCJVQH+8xIXyriXcz7mVokOzXc20GqSyVDgM2DxZf0Dp9zylBQlAoEJNqouPIG5
         WX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212276; x=1770817076;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeqldFa/mhl2711exrQHrvvPzPeGGLfZb92y2I+VBt0=;
        b=C6RqW+dEG0GFOyX8DIyou2rJtNZGnaRJPsqYb5OmhzGqnmOEo/5V3OymTNwaoK0LV+
         4bLC5VyPQRU8A2NhY19fO71ZTdA9bZ0X6dNVSdPF6CbTEqr3cuWe20in/PdE6FwV4uw8
         fNhDwTqQDCpLx9GO4M6RuzkI3TNsHGJF9Sv66khh7ZtYwKJ6G/pJrD8Uf3yuiY1t/Mhh
         sp1phUoQgycOaO9WQQdeV/NwuSg4LmKFrSRqLiv2xPoZH1MCQcd6/6lV6F5RMsHhvu4O
         423WQiFoRYY+RQNJ8rcv494OIyNviv8X51cZQlI55BoTCHKGAq00RCpcXcMEkvcptaiU
         j2Pg==
X-Gm-Message-State: AOJu0YzDCEJMzaSn+loGEFAcKKaZL/WBjqBiqm1aSslJIx7juB3Zg9Qo
	sGNWI9rYzSPp88dUyqDgvr0nnDU/aOjnWpkicZDbEHeU2X7vt64rJ7c8zTMRjE/QhYfL6lZretU
	UI30Czmzghgmie2tOKWVdumsmLCm1HUFNZKvjEM2lIA==
X-Gm-Gg: AZuq6aJt941DWnxmkhJ16/kB9Z+fJ0MYctO8pyh22+yT34uaEMOxEaKfSXJ6eq0fhif
	37OdUA30aIvXbMBqukdsq2Sfk7Hsq8/aMgZdV52usIELeS8FiVW3z5Bo1a8Tut5BC6kxvOdIFTd
	k31nX9r25OV5woZg7/6oqP4V98OsYT9RKw2RWEFQeJ2ohH9exFIv0lT+cdy6YqD29oRNOD4eooJ
	5Qj1pPz6jJyBAcsxNq3LP3TJ9qvM0euYakbFud4V5yhppjWu7cFdrKJbrPY4n2QHRgGXORA
X-Received: by 2002:a05:6512:1242:b0:59d:e5dd:2bf8 with SMTP id
 2adb3069b0e04-59e38c03ca9mr1135772e87.4.1770212276135; Wed, 04 Feb 2026
 05:37:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12852589.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12852589.O9o76ZdvQC@rafael.j.wysocki>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Feb 2026 14:37:20 +0100
X-Gm-Features: AZwV_QhIJOUBI_t7Vswk5m_318_a62MbDbeZo-UGzTW41iXYCxuOimc_Z46DJyI
Message-ID: <CAPDyKFrDRRU_WxKFZ-ni9Wc8JboYB3uUHpoOM_ppzghyJ3V1ow@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: core: Clear device async state upfront
 during suspend
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Xuewen Yan <xuewen.yan@unisoc.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 3 Feb 2026 at 21:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> In all of the system suspend transition phases, async state of all
> devices needs to be cleared before starting async processing for any of
> them because the latter may race with power.work_in_progress updates for
> the device's parent or suppliers and if it touches bit fields from the
> same group (for example, power.must_resume or power.wakeup_path), bit
> field corruption is possible.
>
> Rearrange the code accordingly.
>
> Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
> Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
> Reported-by: Xuewen Yan <xuewen.yan@unisoc.com>
> Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.yan@unisoc.com/
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me!

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/main.c |   33 ++++++++++++++++++++++++++++++---
>  1 file changed, 30 insertions(+), 3 deletions(-)
>
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1527,11 +1527,20 @@ static int dpm_noirq_suspend_devices(pm_
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> +        * Clear the async state for all devices upfront to prevent the
> +        * power.work_in_progress updates from racing with power.must_resume
> +        * updates carried out by dpm_superior_set_must_resume(), since these
> +        * flags belong to the same group of bit fields and they should not be
> +        * updated at the same time without synchronization.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entry)
> +               dpm_clear_async_state(dev);
> +
> +       /*
>          * Start processing "async" leaf devices upfront so they don't need to
>          * wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry_reverse(dev, &dpm_late_early_list, power.entry) {
> -               dpm_clear_async_state(dev);
>                 if (dpm_leaf_device(dev))
>                         dpm_async_with_cleanup(dev, async_suspend_noirq);
>         }
> @@ -1732,11 +1741,20 @@ int dpm_suspend_late(pm_message_t state)
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> +        * Clear the async state for all devices upfront to prevent the
> +        * power.work_in_progress updates from racing with power.wakeup_path
> +        * updates carried out by dpm_propagate_wakeup_to_parent(), since these
> +        * flags belong to the same group of bit fields and they should not be
> +        * updated at the same time without synchronization.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry)
> +               dpm_clear_async_state(dev);
> +
> +       /*
>          * Start processing "async" leaf devices upfront so they don't need to
>          * wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry_reverse(dev, &dpm_suspended_list, power.entry) {
> -               dpm_clear_async_state(dev);
>                 if (dpm_leaf_device(dev))
>                         dpm_async_with_cleanup(dev, async_suspend_late);
>         }
> @@ -2023,11 +2041,20 @@ int dpm_suspend(pm_message_t state)
>         mutex_lock(&dpm_list_mtx);
>
>         /*
> +        * Clear the async state for all devices upfront to prevent the
> +        * power.work_in_progress updates from racing with power.wakeup_path
> +        * updates carried out by dpm_propagate_wakeup_to_parent(), since these
> +        * flags belong to the same group of bit fields and they should not be
> +        * updated at the same time without synchronization.
> +        */
> +       list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry)
> +               dpm_clear_async_state(dev);
> +
> +       /*
>          * Start processing "async" leaf devices upfront so they don't need to
>          * wait for the "sync" devices they don't depend on.
>          */
>         list_for_each_entry_reverse(dev, &dpm_prepared_list, power.entry) {
> -               dpm_clear_async_state(dev);
>                 if (dpm_leaf_device(dev))
>                         dpm_async_with_cleanup(dev, async_suspend);
>         }
>
>
>
