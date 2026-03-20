Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3335CB76
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 09:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774000092; cv=none; b=OA7oA+QjwRSTA1QNp3t+FGKWzUXwYQ2KDoTyYHyOF0xwzEK2nS+AM2wb5JLFDUQH50TU4HXREG/KypT4k2Eq5laoTRihmBAeQvPg+yAg96fi+lXSOLOrol0GOWjxQ9J+1W2jnQZZRRn7ku1fnM5so1vydDWgXdfSHrxTP+VcR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774000092; c=relaxed/simple;
	bh=7APFMvqa0gCQJ5T8+qHwOHyoZaMkXMNBK/5TVY+s4UI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g6AE1gkz3DVq5sn4Re7nggHk1YLbmK7grz377xCuoN2R4P5GLLITIDC5QVBZV4ah4Lp4izVsyle5Rkkz3RgjnQNWWWheE2iMBQ1+i5B1AJstnNzXZ2OTmVwrXXtBXTGdnuvytiVQn6pOiHpJCNw4DiLTKBrIsbrGR0p4fmQjSv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56ce54c8c82so32546e0c.2
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:48:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774000090; x=1774604890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2iGUIJ7TvYbGTB2SBBw+JWXRbj4mLmqq0A0KfQHtxXA=;
        b=GwdvtWvuwiBKMQg88oDI8D+pJjmY4DljBGmk1L24EmluvSAMEf6ieM20XArgTqP38z
         moXg/gUzdWMlDaucZBvHBrT/sYanDj3NsyhYSwXoNOQ4ZBOIx9Zk6ZUBzgRB7FJdIac/
         D9DrAwgRgoi1HsMsTk1JGrTF5qb67uoMfEwXG4ZtvK3i84a6zHGIyJDYIuzf6ueox+or
         C8vGnEo8qk7t7VAEK9GNa720pabLqjvcvbUNUAXeio75PnMNiotMfETOM6LZ3Vh5XHo1
         bQGuJA7Rs4XHK9oFWY6NwVjfGKWwEjnHCSueoqGwhDIFNsEXLSZnS6Ff/QBC4nAnv0mB
         dPUA==
X-Forwarded-Encrypted: i=1; AJvYcCUf6TVkclm869g7sv7gn8a/YLtZkIY6E/GFjPC724ALDuhEMkWb00sj5CdmB8bHJrRjFnrJ/Phmew==@vger.kernel.org
X-Gm-Message-State: AOJu0YxYzTgUjy4j1xpeX8FxHKNyaf+FOiYke0kHENWXpQmy22q6wuZG
	azo6WuuLWE2r9bquPwZBGwLxJySfd9v9HvDLz1sxVWGdBucF+65JY6YQZ5/JrCpvgjo=
X-Gm-Gg: ATEYQzzVjbg/FGtH3sq5X9lsZz6z8ZvKIVvzUcz1dV6rz2j5TH9S2mBwyUKd0YmcUjx
	o6ru5dCMqZmodawLk4752smMNDxWHYWvwZPztRGa5VmHYTpX8wBwJy2cUMUXsyj5+MniE7CRc/8
	wbOGF+aeFxNxOg0GjOnKxqBxWqRximB3+GRNRcOy1iJCmmoN5oDbz79YWXKpwRmnSlNvnwsCTU+
	3QCHODYXD8b4Tf8Jk091wsstiYUJC+o7cKaFFQcvkp7zop66ECq2rEBcHAVNGBdGOqJF3aI34S1
	EeggFLaJO3Mv5cNW7oZJ9UAGSdWorA9jUN0bZ5PYyC19DvALRlmmn5BpmpzkUEneVHLXXvG0vdt
	Y8Ut3STPIk4HK6fE5OIaV5cXaugQYDsKGaGrlZTTFVcY7j7xmOkvaMYudnAUkw1/EbCWctu8hUL
	+WPmZpAYdfkhZqBWeQNYPK+x/Celn7soi4wBkt8Wf0AvtNFlqim2WHebSUxzEx
X-Received: by 2002:a05:6122:65a0:b0:559:5dbe:fe29 with SMTP id 71dfb90a1353d-56cde323240mr1006086e0c.2.1774000090444;
        Fri, 20 Mar 2026 02:48:10 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcc34afsm1433791e0c.16.2026.03.20.02.48.09
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 02:48:09 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-602903ad849so542937137.3
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 02:48:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVgr+U5vaPaUAnRPjQbw2G5K0ulye0Mc2T6C2AS5Ky64xCuWWfURwAvLqBsegrtfG7UlH4TlGysOQ==@vger.kernel.org
X-Received: by 2002:a05:6102:4b85:b0:602:8ad9:1f6f with SMTP id
 ada2fe7eead31-602aeabedb1mr1161798137.5.1774000089201; Fri, 20 Mar 2026
 02:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <15510cee649959281d9554965cacd0c06531c1f3.1773308898.git.geert+renesas@glider.be>
 <CAPDyKFrMtsp5tRSAOx=ytfQ0xSONtRbC24gq2v4QdSh2wWSw1A@mail.gmail.com>
In-Reply-To: <CAPDyKFrMtsp5tRSAOx=ytfQ0xSONtRbC24gq2v4QdSh2wWSw1A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 20 Mar 2026 10:47:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXupFRDV7AQUwem7Jd2MJyepyONUtTXr8Xdow=zB_qcYg@mail.gmail.com>
X-Gm-Features: AaiRm53jo1Kzi6wdd9BDyM25xGy57mtBCx3HvMxUoZBMKfg4MkiWLGZ43AKoUH4
Message-ID: <CAMuHMdXupFRDV7AQUwem7Jd2MJyepyONUtTXr8Xdow=zB_qcYg@mail.gmail.com>
Subject: Re: [PATCH/RFC] PM: domains: Call pm_runtime_barrier() before dev_pm_domain_{attach*,detach}()
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ulf,

On Thu, 19 Mar 2026 at 11:59, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 12 Mar 2026 at 10:54, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > If a device has multiple PM Domains, dev_pm_domain_detach() is called
> > multiple times on unbind or probe failure.  If the PM Domain is also a
> > Clock Domain, and thus calls pm_clk_destroy() from its .detach()
> > callback, dev_pm_put_subsys_data() will set dev->power.subsys_data to
> > NULL when psd->refcount reaches zero.
> >
> > Later/in parallel, default_suspend_ok() calls dev_gpd_data():
> >
> >     static inline struct generic_pm_domain_data *dev_gpd_data(struct device *dev)
> >     {
> >             return to_gpd_data(dev->power.subsys_data->domain_data);
> >     }
> >
> > which may trigger a NULL pointer dereference.
> >
> > All dev_pm_domain_{at,de}tach*() functions document that callers must
> > ensure proper synchronization of these functions with power management
> > callbacks.  Unfortunately no callers seem to actually do so.  This
> > includes dev_pm_domain_attach_list() and dev_pm_domain_detach_list():
> > they call dev_pm_domain_{attach*,detach}() internally, which means they
> > should take care of this synchronization themselves.
> >
> > Add synchronization to dev_pm_domain_{at,de}tach_list() by calling
> > pm_runtime_barrier() before dev_pm_domain_{attach*,detach}(), and drop
> > the now obsolete comments.
>
> My apologies for not being able to respond earlier to your
> suggestions/questions. I have started looking into this now, and I
> will follow up with more replies and perhaps a patch shortly.
>
> Anyway, the principle is that callers of dev_pm_domain_detach() must
> manage the runtime PM enabling/disabling for its device. If runtime PM
> was enabled, it must typically be disabled before calling
> dev_pm_domain_detach().
>
> What makes this a bit more complicated is that we have two different
> scenarious to consider.
>
> 1) The legacy case, attachment via dev_pm_domain_attach() for the
> single PM domain case. Runtime PM should be enabled/disabled for the
> device, from its corresponding driver/bus. I assume this isn't the
> problem you are facing, right?

No, this is not the problem I am facing.

> 2) Attachment via dev_pm_domain_attach_by_id|name() (which is called
> for the *attach_list() case too), for the single/multi PM domain
> cases. In these cases, runtime PM is enabled in
> genpd_dev_pm_attach_by_id().
>
> For 2), I am inclined to think that the proper action is to call
> pm_runtime_disable() in genpd_dev_pm_detach() before it calls
> genpd_remove_device(). Although, I need to check more closely how
> suitable that would be.

Thanks, that sounds reasonable: genpd_dev_pm_attach_by_id() calls
pm_runtime_enable(), but there is no pm_runtime_disable() call to
balance that...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
