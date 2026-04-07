Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC082BE641
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 20:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593400; cv=pass; b=fP/4fKrFUswI3elKLpWn7CUw656v9X78rGBI/bHz3FqJYQuVpToiMM8qtVhilip66YCeP9qX08RVr0x4Obs/R5SzU5IhcoPxw1P9ZyJc5Tb/BkhUoFuhOANsArHxW7mDYVYAV5VEoKlUbrsZbnVSIpyP2ycNh3vg44QEM4+kKbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593400; c=relaxed/simple;
	bh=/vo8Ho9uK7QNdoBdsxzXkL/VUAV5uKB8HFsyFKhwoOw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fb8d0NhUVWl15A0yIuv+6Y2raKk4tOmocPkAZrK6+EaM075sQMm1nvO8SPsafOg9oVX7RW5w2cWCeBJKWYIgBHh0HjzZHzUbmjJyuqDYzce2GoPj2tp5WWaFNjIq6693be8Vc2SqkC3edQ9WVP7i4WOl7P9+oNJnnVY6GQr7DWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C9ShAHrh; arc=pass smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C9ShAHrh"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b9c01854477so909592266b.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 13:23:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775593397; cv=none;
        d=google.com; s=arc-20240605;
        b=b0nwq4YZuTfVhy6SHA/Bjbar4YaMtOEW512x7ikLZXgRjO+fnJCl/Zm5V1ssA0ysSW
         Vii+P6bipq2v/YITlDSngAqgYsMOZAdAUYHVou93dsPeobO5t7I8DN2xRFRPYJNs6Rbp
         6U1r3yG/zd4ZIsNuIZiZ3qzA02HM+x97/Pveqb/pvlLjdw2e85G/IiTcQRYGDPoCJbC6
         u8+EeTWEKWIYJhzshvuqqVUdOIQ6hLpABgYjeobYKLygOL2+fJJ6fCHzjakGaTvBBgGS
         fX5xz0WnIYB50ZB1SW7rSw/I3Bq1PjhBUxkk7zX+rPIaaKzhtOZRjrnUr+3QZNS/M7j5
         /o0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZCx8twqJvR9nn7bLFe0MWiBT1PMklf9crqW/etIEYlw=;
        fh=K/ZGz/ZC7IoYEsAF5dG7gAzUl+m0gx/YbJoOLz9OCMw=;
        b=N5pSXx+h3dYDfPmrDpPc7nWsUG1dfvGvFXEsWq1GlfvdqI28pFV4OQ9DxNOaVWrjSW
         gHFSgd7MPKgJp0tjq1qILF9JUV+jDCE3Hpb3Kr+dqCykNBzuAAxv9Ja4vUUx77i16h77
         9A+b36k3SvMPjt1F9pJn6qJgRwjElxH0K1PnfTbDLQHJI7/tRFK/1U//9VzQ19O6N2JS
         rSVsp59rH13vFuFeD7kU+B3YJenoGDxugodIJr+825GLvOocjyYRrlDuLBRdEG/zU56j
         w2rgUsuKD9e8q3Xl660Y5oRxX7oXpw1m2QWkV/MUH5Uhr5SyFek2UlwgiMtkdrkBHMp/
         vSdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775593397; x=1776198197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZCx8twqJvR9nn7bLFe0MWiBT1PMklf9crqW/etIEYlw=;
        b=C9ShAHrhqE76X97cIBZf5dHkbyR9lBkcPtM+Vqw/Bvk1yZN3HIKf1hCEQr3YmNY1N7
         Zx02UaezcXaHGuceYyemshxBMYz0Q/bbb1pB0Ex/qlRtQLLnRiNAUskOnqDjFEGTLDQ4
         okgc8+lIi1gAObQ0N7NcDC44RicH5dBkpoZNBfyWaKZ1eiVD6Fe9YLnXQyG3dbxfesl3
         T/tCW5VB3BF50RiBp3tqT7OqZgdo4+quvZPicECm0I7YroE9ExG/CcU5hrRb6xkuICaX
         S1g06lzf1PSG1V3vxwuibGeD0kj5OFskWhQHFaNph4P+Q0n7ZLmU1xvD8dIApmw5wMaQ
         TpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775593397; x=1776198197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZCx8twqJvR9nn7bLFe0MWiBT1PMklf9crqW/etIEYlw=;
        b=hpkRl/+fE/bpS3JngdKPxY50LjfFVAalChxh5dwEtwbRdz1E2zSaSvtZJ9qZsELlDD
         55uY1lNl4pPEXq7OVxngBrydNarpGHwnyDdjuOc4317TscKEF+rLSM8pJuc1uf472922
         wCxhsiZuJs6sj4T50OTvAfdmKB3pYY0YeaFVE5T+/onV0X4lwo/N/Sbd+Tn0zg3JowUD
         3QSWcGFBHFAcuUb414rKo+JaSVbWqmPTR1jOWdtcdSC4lL5cKvGRoPP++8ZRg3Atqv26
         NBPqujLduhXjqEeE2b0bTIrf2zKSU8xQFotsLIofgfWfMQ4sL0cCHfQw5RNZM/0QrNqz
         93Rg==
X-Forwarded-Encrypted: i=1; AJvYcCXwZ9bdth8XgI8PqCzOCsEWGgi9jkFjDvwMaJaL8oJFHKIFEW6VauuBoaaJJAKPWxI5KsjaKrC7+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsSMGnMZP9T8hm4pOX3M4UKOLZHKppc2OSMkSaJEcyxtEUDmY9
	Tg35nc0Gj+lO5ZMNhg4TyrJytpWvXYGTHAj+b4neVp8u/p/LF/POcoghHBqE+iSmzP+IZDB8x/I
	528z49npoMv9IizY2r4l7mhZ8MP1R9KpZar5oxpI=
X-Gm-Gg: AeBDieuysaRpoGYBRHhsYtSz9kaw8xKcERNmrxVe8P0xop5cNnOAoeYXsWSkuSDLakA
	IOVzgr1eRdWRuda/XB19SqbltFWSSrm4iaMoGbNMmsYxBGCY2LMkrITpYrAnsKp5sepMvmFLxSL
	4Tx6otA3KqGOBkj9YwNidINoD5dRKv9AMDYwRRGiQF/DhVJXEco+rVDEPMe2XkWUhJ6GNRJFHiB
	W/aQM+cq3Nb9PJHUrYzLuSItwxOk3zaAMkNe9Jiz8xFyvKqV31cXAb1/k42eO3Eqp181lLcyYHZ
	9dvisRKH1u0AK/ruMRnn62smsCSQKoEJWf7Y
X-Received: by 2002:a17:907:8703:b0:b98:4c58:f499 with SMTP id
 a640c23a62f3a-b9c67957ff5mr691793266b.28.1775593396835; Tue, 07 Apr 2026
 13:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407083219.478203185@kernel.org> <20260407083247.965539525@kernel.org>
In-Reply-To: <20260407083247.965539525@kernel.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 7 Apr 2026 13:23:04 -0700
X-Gm-Features: AQROBzB82cXuNdt0Ng1iSzJ-7D2GJGPn4Rejnm3RvPTfCJRZuUw3Y0MamQBLYuk
Message-ID: <CANDhNCo9QZKoEwX0r8JeP_8YTSvKg5ENTSw5Zjj9Po-FywBftQ@mail.gmail.com>
Subject: Re: [patch 07/12] alarmtimer: Provide alarmtimer_start()
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Calvin Owens <calvin@wbinvd.org>, Peter Zijlstra <peterz@infradead.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Ingo Molnar <mingo@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 7, 2026 at 1:54=E2=80=AFAM Thomas Gleixner <tglx@kernel.org> wr=
ote:
>
> Alarm timers utilize hrtimers for normal operation and only switch to the
> RTC on suspend. In order to catch already expired timers early and withou=
t
> going through a timer interrupt cycle, provide a new start function which
> internally uses hrtimer_start_range_ns_user().
>
> If hrtimer_start_range_ns_user() detects an already expired timer, it doe=
s
> not queue it. In that case remove the timer from the alarm base as well.
>
> Return the status queued or not back to the caller to handle the early
> expiry.
>
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Cc: Stephen Boyd <sboyd@kernel.org>

Acked-by: John Stultz <jstultz@google.com>   (also with Peter's
suggested name change)
