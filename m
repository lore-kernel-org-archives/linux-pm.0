Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E923D3CE0A2
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 17:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950465; cv=pass; b=Ax8vRXFNZRLh7jjUe8eA4eQJktvj2Hra6mn8Z6tAqofk4/pArI5fWbRetVMdqro2+M8EP+peFnpr857sgc1WPglE64oh6lTYiBc67cgQhFlPDifwAkLqBbecOyh+RsVpTdEkUesF5h7mWWWYd87FFnYJwlmf1ypJliHlgRfGa9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950465; c=relaxed/simple;
	bh=f+1hgjoLe+9OAau5GDXmSyjb/F1lcu3rz3NObPtffwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPUIxs0ifErgOorFbPL6NJWwlqKvHG/5hTjVNLVl2XPtGs9tfKtoqJNUIr9/o/8vGkB0+BcNWKhvHaSExEExzwBbbYW1u/HoDI4DEGCCQjBwG9jN+DYLKm4W7vT3lsjcM1ZI2A3Gjht7UGoc8t7ekCSdNsuKAUcGDuZD3sdIPUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZT1xHc2x; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZT1xHc2x"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc8311c6ddso1672315ad.0
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 10:21:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785950460; cv=none;
        d=google.com; s=arc-20260327;
        b=BCiFkGZcQ8BJVSMuty3p7Dfa7o21Ac6KTy/hhfpRZJc9HipVhgJpcOrJ4h3E+FEEC1
         wbo45+u9RzL5FLAoSamWg5UV1WPq1hRGv+DCLnzxy/jaZh71pp3PPwL7qV+cybyAvUWG
         2DcKkgt41kmjDhV47pO13/VDwUeDedUhf6rkNbAz5tCMAQbjiO7wJI3aWBEovDRPIOYh
         z6sYAihev2xIT1O6Ho73FEwEecQLPiY5YVXy/r1AX3Krc7R8jd+I15tOio6P0qowQO6Q
         NcVe9tMZLYEhQc17gCiNKv7UepOWOw7cmMBssBvHACBTNW6PtthY/Z7GrWyIJ6Gi6wgk
         NkxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        fh=0VvrkDRtpm/042qCCeMTPj+rNnNceYgyZtfHKztjUkk=;
        b=RYdj8LCiHvH6uutqx2MW7Z1Qb4xUo3HqKSBVGXYGkdVuJpCDStfQ8DsjfixYs0tzjP
         AXw71SUbNscYOoUvzUyojY6JPeSLUVsri1cMm6Nrw95eN5Keq0aUM6vlNVsztXP10QmZ
         t2K8obWtYNhNI9F2F7FQS6imOTp2GeFKiokYgAQiwu0gdml0ApgNxAju1OVn3rkVkzHb
         EMQ9+f9HnCea93bnTyad9EkEo0HohdI78BcvG6iwRr2Ixs38NAV85J74loo+RU2No2n4
         IOxh31ChmU2mKl5JnaBFaR2XEibg4BJLqoy/r2cqJFIzn66C+4yQpPTOo46nk7Ljv0XE
         PYeA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785950460; x=1786555260; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=ZT1xHc2xyP9XYk8PUPnDAntsicElF5elLjXJHYxK/dTIRxhOXP4BYmKyaAm7D4myJe
         FXySCyN7nRIDJjvQu9UXCW9eDvMXBTKWNXVzmoLwbtoeTkM+2avemvUwcCdFVmdxcM5y
         HMcojfHT74MtjHUYX3FGuPiSQu6CG9RcMZN10Jij5DCneHFtm2g+5oKnouFZiqpXEehp
         s6g/qW8DnpBdkqN4RMvOha0mJmzKRXFYxdpGFxxrgKrHq8SOqH3+XjNo42K8aYfHQQpY
         ieaRXp6TarxQO7iZdwat5LWdNaE6ED/8Ui2j8nc1nYOEyzIfdGs6la8xuL4tQi7opQXq
         gWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785950460; x=1786555260;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cz1E8dA+nCFkDM0OHZhKzEI4Qib+t52DoabszOc2ICI=;
        b=muZH0W32MQccOEzFLbgnV5hi5f9YojfSQckpK9ZJAmtvRMhlr2tDe5QuF0mwbw9WeG
         ltwDYaYYIVAQ8RbzcBmCxEwmtg88ceME1rKywNFOdvRJYj6CbhrYrhXOIpWHLocCztps
         ZgEM8awQLDerxt5TBC+EjdcpaJ/pT5o8ICml+0V7sEbtSgi6Ycbc5frUiltQXfvB+Daw
         iV4Wb3L8gBPQPl6kJY6t+qnyVCS7MKfy4t+ZYJNmammNAIMeVnD4IcJEkE3y6RgkUrKC
         +AP8wKWAAClmWJr2+Rn3mDPHo3cKRaZ0QfSHDuY+/7W6nBfbcXdzRPdQW2rDubxfgCsR
         gLuw==
X-Forwarded-Encrypted: i=1; AHgh+RrEsUW+KKNSr4/CfhcrXhMvhx05VvqL92JVlVLPvjlZ9pc6PP3mlOOuP66JmaoBi0FINxJxbEFS9A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVxwjzPGp+0NeyLQ/lnyRRcAIXJFr8zAJ/1ln3iHaeYa9JqqLA
	LHoQTVE8+tTIEKPIWCmVcl7GL/1JlpCJm/q5By7TH9iJMMZ4FtsQlZKFInv/v+8fgMwVGO0rtcZ
	ykp/eNrGO3GkAAanG49RJaRxnXSj3RQg=
X-Gm-Gg: AR+sD11J/WjsxZ2EDXdPaIkNqj8e2awqAfKPVOjHpr1WdUbdYRJtyP5iAd7CNLFJukl
	XDzIqZW2rzvI0ZU2ITAKJj6Ky2ykoYIGoF9v2gyX7Jsep4EoB3GANnUE2YgVlXRS7zy4hvaIfxX
	c9kO8YzfmBLWISAM6A38boogMB7pqYIHBJ79kR1g93C4fRZFnv3rFnivsr+fS9Keppvdwemui3E
	yOekCVgH2ow6zF5NjOaiwzZs5Q9eGQQ2vwQWDyy6ttQwfE9JBiF8iihM1k3skve/ykmMq4V7lIG
	PGqs5Cjwxm4wN1BQZJOsAiIjN/wpYbG+++wS4ZrlScV5H5KJBSl9G/KyOUpwEDygL5KpqS+XFPU
	Ot7S1lli8gWwEsUjaxNFG02GEo2T4rLgyQ6TD8bWxQdLPkyCMaAXGgaCw72Pn
X-Received: by 2002:a17:902:ec8a:b0:2c9:ed4a:c3a4 with SMTP id
 d9443c01a7336-2d0ca1658f2mr73522915ad.0.1785950460122; Wed, 05 Aug 2026
 10:21:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0CoR7Z5B4-PH8GYYbWlZysVJpMnNLTFzTO0tBlOpJQNFiQ2CPrhdjyD4-4jQs4n0J_1QqovCd_EaYpclyigEKw==@protonmail.internalid>
 <20260628095132.47753-1-trev@trevrosa.dev> <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
In-Reply-To: <87pkzw9aut.fsf@t14s.mail-host-address-is-not-set>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Aug 2026 19:20:45 +0200
X-Gm-Features: AUfX_mwN2wRwvmcNPuq0EpEyS5qgayFtXbsdflDPhbgmFxUJf-YMOIqJTLTJEvs
Message-ID: <CANiq72=wo4LOfa3hrJhTFr8UzkchW4QQtUespCTq7qRJvrr6CA@mail.gmail.com>
Subject: Re: [PATCH v6] rust: aref: make `AlwaysRefCounted::inc_ref` an
 associated function
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Trevor Chan <trev@trevrosa.dev>, gregkh@linuxfoundation.org, rafael@kernel.org, 
	dakr@kernel.org, ojeda@kernel.org, paul@paul-moore.com, aliceryhl@google.com, 
	airlied@gmail.com, simona@ffwll.ch, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, igor.korotin@linux.dev, vireshk@kernel.org, nm@ti.com, 
	sboyd@kernel.org, m.wilczynski@samsung.com, boqun@kernel.org, 
	gary@garyguo.net, axboe@kernel.dk, daniel.almeida@collabora.com, 
	shankari.ak0208@gmail.com, lyude@redhat.com, j@jananu.net, lossin@kernel.org, 
	acourbot@nvidia.com, markus.probst@posteo.de, driver-core@lists.linux.dev, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-pwm@vger.kernel.org, david.m.ertman@intel.com, iweiny@kernel.org, 
	leon@kernel.org, bjorn3_gh@protonmail.com, tmgross@umich.edu, 
	tamird@kernel.org, work@onurozkan.dev, sergeh@kernel.org, 
	matthew.brost@intel.com, thomas.hellstrom@linux.intel.com, jack@suse.cz, 
	ljs@kernel.org, liam@infradead.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, ptikhomirov@virtuozzo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:26=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

In case it helps, there was a v7 of this one:

  https://lore.kernel.org/rust-for-linux/20260628100731.64885-1-trev@trevro=
sa.dev/#r

Cheers,
Miguel
