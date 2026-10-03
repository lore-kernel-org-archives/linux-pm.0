Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0DA27FB25
	for <linux-pm@vger.kernel.org>; Sat,  3 Oct 2026 00:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790987265; cv=none; b=rkWA0Yixz98eXrcwx+9n0eELB6hn0cYTLHVRHaJq0YKlqGfJhlyuU373iqGKUGX5gcdC2Uy8VkEcuB/70zr83JvWfKqJFll/U/Mwhia6pdK7/DzEmMNeLigF51GrBvpuv6DlqvTNhThEI17qv6rGipESN1vpomsz/qoMMV6GEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790987265; c=relaxed/simple;
	bh=/GXn4dQlSTFYkZKQfZ2Pd9kQ8BIokZtO0D7dCrKHVB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oHPESSHTNDEypiMt9qRIV4JzZ7P1k04a+9BHiZ1kUaLa48B0Eg/DVp9Y22AV44mxlw9KShdSRHCEjbvf6rp+kKir+d63sLp4bafLvZDphawH5l8hmffGOQktrYRhn9Gmy0q+95EXcuHnfIEVLhZXqMNLe9R8AF1bqG1++z3TCvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gA4GdXmr; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gA4GdXmr"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2e028ed54dso61480066b.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 17:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1790987259; x=1791592059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CyHDFt4DMiCfxal6/XACZnlAIAoB/klZYpEIKNjeAu0=;
        b=gA4GdXmrgbF53fNE+qH9oJckGswkc4/miFx9LleHVUSiminQnXD72vXFy7eI3rn5xf
         S190Wcze+i7XtBHJ6lwiKB3/VfJcCocoM/JAB0XFY/+2euL1CX409sSZCc3Q9drbfI0y
         NLrh44XnnwMlHqU8dHvGlh+ehXVKNO/7WKzb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790987259; x=1791592059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CyHDFt4DMiCfxal6/XACZnlAIAoB/klZYpEIKNjeAu0=;
        b=a+Cs4G8hxZ2is7AjmZdqOOjxrumhvy68C975uilAlI7Ztp9OEXZ1kkTjPRJYLVEZ/P
         r3ZdNU1h7WOK9qtn3Nl9B3hn2Ciq+hxf8SWr+odGaDc5Z780ePtecHl/Sfs0OIe+XKDp
         6dxiax6lHCScxqNABrU5ATGtteS88VyVeRZEEu92U6nD7veVYsenq/rBAzRWwcvPKrFy
         eY1fqq8+Nx2k9MpYzYpz09rlvPUC3PGyk/bLamwpXq6LCAJhbif2QBSHSrLxzCmftwDZ
         wtiVCWdsGs4GwrfMOArKpvFxDna9sqx3wYd192LRK8VOXc1PfppqKLsWJ+r0buF9cpWO
         X1jg==
X-Forwarded-Encrypted: i=1; AKwUvBzQHIscFxHyglBp94NJWNwfT5CCPppleHbxL7pY8Xd7HONQzW+Hi015eXVc43/0RMr3JKCsglwVKw==@vger.kernel.org
X-Gm-Message-State: AFq9FYLqRFUZ3XgfebTNwPMnMR2ehSnFEL48PpU7hJXLheQSDwnJYwf6
	m3hFWshM3GigHADpubd5OgJZV1cpwiW+OH5klti28h4LkjIjmFtPVkjut51uZTTqMa+PHnTfwrG
	rdps=
X-Gm-Gg: AYBFou07+DZuAVBxto7eb+DpwrZbXlEKJhGRq6JgophRr5NJ0EUCLz7DGxZuc/H0a8u
	lCLZGVWHZIfcv4STMqZNKwUlllYewmeJ2Slt/vTk+P8uOxL8W4CjQVOl53YNB/T0VNA7sB8soOZ
	Ksai7cjR4sgnWbENWSfdSD9RJPfw1iTsUUNg+O+qKgX59ue+7c0n0TP1JXkm/CNFGyIcB7ApI1q
	QvK7egCRnGnX2XWzSqkpZWTptpZ+qBDa8I59gRNwvgO5ozhZBZ1ZSFO1JxIaC9iPjOYfUDMHwGp
	XbENlVSBik0uZ2LyzDZJLMwOISURJA/RtDWfy8OMBEEGnQXWhwJfCQZOwOVQ879zjwQ1VRfie3T
	4+YJHZ5/eFIqxbgLlnHjL5YOJ8gJKayZZxx8aZ30iPcOCrCxFVy1eaBuVO8xdomXhzwdEmj1oG7
	qGZwGm4hrQAf4v+8hA8bbJucjBkY8UVpOND3sIWarfU6j243tHfugYZRSG0DMlgQp2EviHR7ret
	rWSR31do1WZNeoNR1viuqwZMjd2MHZhwT078w==
X-Received: by 2002:a17:906:6a05:b0:c29:f5d8:9c7b with SMTP id a640c23a62f3a-c2e4af87bf0mr359372066b.42.1790987259546;
        Fri, 02 Oct 2026 17:27:39 -0700 (PDT)
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com. [74.125.225.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e71d58d72sm11311466b.6.2026.10.02.17.27.36
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 17:27:36 -0700 (PDT)
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48b00a0ac65so4500f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 17:27:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByGfFYPXPA6qJ0z343iU7arS4+GlEgChJ9xCvKcQHUi6S7lr1BDz1WkTq7DR+ZLtnaay1DIojmLkQ==@vger.kernel.org
X-Received: by 2002:a05:6000:240e:b0:48c:455b:6625 with SMTP id
 ffacd0b85a97d-48c455b66e9mr3660895f8f.19.1790987255739; Fri, 02 Oct 2026
 17:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929184729.2346769-1-briannorris@chromium.org> <20260929114714.2.Id0a3276d23d30e0b5fd4d6dca730be0f9d8fe018@changeid>
In-Reply-To: <20260929114714.2.Id0a3276d23d30e0b5fd4d6dca730be0f9d8fe018@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Oct 2026 17:27:23 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WPohx1seYHdw0Mi=5xh8XCWvh23ie03+ePXQgTixGzOw@mail.gmail.com>
X-Gm-Features: AclHuK8j_7wUYw2uhi7CBehoDliA72XQiK-9p0LnmY5FpnefuRpK2XROhBPZAS0
Message-ID: <CAD=FV=WPohx1seYHdw0Mi=5xh8XCWvh23ie03+ePXQgTixGzOw@mail.gmail.com>
Subject: Re: [PATCH 2/5] PM: runtime: Avoid racy clock checks for autosuspend-retry
To: Brian Norris <briannorris@chromium.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-kernel@vger.kernel.org, Pavel Machek <pavel@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 29, 2026 at 11:47=E2=80=AFAM Brian Norris <briannorris@chromium=
.org> wrote:
>
> @@ -242,7 +242,12 @@ static inline bool pm_runtime_has_no_callbacks(struc=
t device *dev)
>   */
>  static inline void pm_runtime_mark_last_busy(struct device *dev)
>  {
> -       WRITE_ONCE(dev->power.last_busy, ktime_get_mono_fast_ns());
> +       u64 now =3D ktime_get_mono_fast_ns();
> +
> +       if (now =3D=3D READ_ONCE(dev->power.last_busy))
> +               now++;
> +
> +       WRITE_ONCE(dev->power.last_busy, now);

While we definitely want to fix the problem identified in this patch,
the proposed logic doesn't sit right with me. Let's say that
'power.last_busy" starts out as a given value, let's say "1020". Now,
while the clock hasn't ticked you call pm_runtime_mark_last_busy(). It
detects that 1020 =3D=3D 1020 so it sets the time to 1021 so it's
different. Now you call pm_runtime_mark_last_busy() again when the
clock hasn't ticked. Now 1020 !=3D 1021, so it goes back to 1020. This
could cause the whole heuristic to fail, can't it?

Maybe I'm just worrying about something that can't happen, but the
logic still seems odd.

It felt to me like we could just have a "bool". We set it to false
before we call runtime_suspend() and we check it after
runtime_suspend() returns. If the bool is set then we know they called
pm_runtime_mark_last_busy(). There shouldn't even be any weird
problems with weakly ordered memory since this boolean should always
be cleared, set, and checked in the same thread, right?

-Doug
