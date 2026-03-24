Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A3386C09
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 02:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774318851; cv=pass; b=FZz3ASxCZNUUI1OrgTOYu+H1RUKeQhHou5TSasarqDnesm/OZkSmQCpBI20pod1BDErY6wDhVwqILFK/XyWvs8exGLK60zTYr4ZRBowihtGURKe32Ia67bQgjgI7IfuDS9rpomzJjO0oEOp4PCtNKTxeeaeZK+/RbCyMKJ9gGOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774318851; c=relaxed/simple;
	bh=85X2O4LzjMd9F3MewKaUBRwXGQ7wlJ40lao7QqFFo/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4LKD7nyiJDQ8CNIQMmiaN8K830XsnOaiMA+MBlKYA9EBLMLSwV8X05pTtjuuk+HPBFT2Vkro7qp8SMSFRR3pdTQgl01zHpiejSApEN2c6GXKnNQn3oxsbCsjendGdtf1vxm+MqwQlhlmqe+H922W8w5m7kzNIFM/jgcc/JBkQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZsaRiZu; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZsaRiZu"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5062fc5d86aso39691681cf.1
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 19:20:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774318848; cv=none;
        d=google.com; s=arc-20240605;
        b=Hax2jLyWwQhGIz2GAf5anSPGg7o6VvQklwmXeqxZR60rbAVaQFg9fsRN3THtfKfhh3
         PSJ00uLWPMA57z2R8PvKPe+kyTnohEgZuj3sUhPTLZ6KAAWYQhHGfSkmogkztryJeaq/
         x3JsBihoLLSL3lv9MHXMYzMYEpAotLzi25fYswNXgpq4Vp52R/bIKurSCyxM8zL0tjsv
         0ufoxsodO1HAyxnJkvB5AfYYI4GCNW71+tFMy85b6njyssvDguGLM94CnpwtVGMudIYq
         F/XK6/FaL+/Ogkk2Ve8y+dBAkimikbkQmPWpCo7iU5RUeZqFIdiJxy3409Z9HhkYrsqK
         WXew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=85X2O4LzjMd9F3MewKaUBRwXGQ7wlJ40lao7QqFFo/0=;
        fh=W8yexwHEXvsugnbtE5keTWX/f4lsFdivDtzBfnPOXh4=;
        b=JZHwxnXyc6V6yhJuPsWenHfupVgsEUf+LeIJJGmWZltjFAO5KiatvAVmtE6v3IU7YK
         IAMUEQFeki/8us2/D1CD0LYUsJbC0SZmxYkz7U2MndaJrpSNdmhx9vpHbk5yogUYoXxc
         PFvGwjB7d6s2dMzcxIFVcsKEJNTcKqDhG5W/biOXMSVaFds+riHMO7qCN0p3qMidM8n5
         AV25Zt9oFEwHOAGjEerpzxdtnzPLFuy4Hy1RDJ3PAaHV4kprB5eYRRC3tlduQHZERVC5
         ldPQ4PNLK0lY38PUpFytMeVDtQNGjbyl6OuZd59yZv8mWXZirkIZ+Bd2EhbO7DoywF4D
         2QPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774318848; x=1774923648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85X2O4LzjMd9F3MewKaUBRwXGQ7wlJ40lao7QqFFo/0=;
        b=VZsaRiZudfFnxWD8ziIEFNYV1SIw0XIoxCEzGJbeOlMDlnNSsFQ+6iDM0pI75YnicL
         FzhfST+oNqMNITaXSJli32ub/+QNKLw8c5Yushm20JCv96/P1MpyftH+PvAmVxJsFwe1
         jqtg0+FhSfOkxCwRy5IrI+zvV5cMCh2cWR3zGCo0iCu4/2Vc3dvf+HllNYV/NYlMfshb
         i2pGflrEKtQvKkLJ0OpZP6TuFBSlX9DDcUvjOLI893azn7apsiMoaNO5Fr2Cr/SywTrL
         sjIqwqE4xJ+8sirVL0ObYI9ixr/5ZflHAuM4AngvkIYbW0bVuwFY3gb60wRqyN4yM7eb
         cD5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774318848; x=1774923648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=85X2O4LzjMd9F3MewKaUBRwXGQ7wlJ40lao7QqFFo/0=;
        b=nuc9ElaNG8ccIajyHSel9Kmniwp7C2TcJeXjKKQMgOiW658db49WNAr5Y9iW0ga/5o
         ySZ0L4aWgyDFwInOxtn9GTD110KoLucsKaJ16jaybt2SAthAYi9KRd1Difs7RQpoze0c
         ov3ND1mb1ZX03e3uxKNxlRarNt5RPAay8rz8DzdBe9ciO25m18sKzKQIR2ej4AvmK9eU
         G8YSNryueQFRfhxp3TFqGbnSD/RjXFniiItavhKIIT4ItmggOnvgtcBSJrx3F1Gw1IhQ
         BrkZ+BOgcDwIKpwkUh9rRgl4eRc6+FiQ//mUazc3l0iEJe0qfHX8El9rl6WgU99srJia
         C7rw==
X-Forwarded-Encrypted: i=1; AJvYcCW3b6koUZVPitBmKYCPXEvFPbIfKhsw07AdXWNmJI42TkdrQ1/qyFUfKlmojUDZbwB63KRrZf4nzA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpQ9bdHKSx7+5vL94v7AGcBetlz4ZBVbP02YUGJ8So/d69BIJG
	EpOI2HacbwWRA6V6uC0W01+0N8SLy2+942jfbEG1nCh/IyMImXDNP+66HtzBs4/D+2LkwXcMxO9
	RmA9bz5pf8t2t5K8PoaVDuRn6PZyAB/Geym7E
X-Gm-Gg: ATEYQzxuu4r7mc1Z3WAHuIv+GuZpU3JrYkbXPfnsGoWVvw/1R80aMooTdzK7Kg7EM+a
	r0ZfshhnLS6y+dqAqtGeymk+p3TRXi9zEI61zHRReh1Qy0N2pEY2pWQJ9SrTtjpcEd5Q2k2q9oT
	/swh3a3YQIxrbL1jQygvQlwZ26tYCxx87QiGLU4yYx77qdaEEirHtoJ7HIBlXfBjL+nruZ+H58C
	De+YvLWMT/RKB433cjGjHK+JbgfIrlQkqCYk7R97s138NT5wa4EhZpSWACy33LJlomKf8CH4YXp
	6d7aV7Oy
X-Received: by 2002:ac8:5f4c:0:b0:50b:567a:e915 with SMTP id
 d75a77b69052e-50b567aef06mr109828651cf.64.1774318848198; Mon, 23 Mar 2026
 19:20:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320113148.7308-1-xuewen.yan@unisoc.com> <031562ee-b88f-49b9-8b1e-dbbbe1a508c6@arm.com>
 <ajjgf7xg5fwo6uk5ualkzoupuyj3pmp3l5yb2i2zfhop3msfkg@ieoosfn35gth>
 <3daf28ca-48c2-477f-ad06-5704b17b880e@arm.com> <sbtbzkzrtgrmqhxnwcqrvxprgzytkzwcsanooyukhphymgt4t6@telvhz3yolx3>
 <c19fc390-ca3e-4ad9-92e8-e30dfd6fc95b@arm.com> <psrlnsgdg4afrbk7u3vq35bsqc5msncrfifrl6ee45usn27r7y@fwjklu6mcutw>
 <2a71d446-3277-4b8e-9b29-b77ebd3a4381@arm.com>
In-Reply-To: <2a71d446-3277-4b8e-9b29-b77ebd3a4381@arm.com>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Tue, 24 Mar 2026 10:20:37 +0800
X-Gm-Features: AaiRm53M1O0RJ3BWdQu4jnh_MovgTnsVo5TxknTiw_fQ2ycLM245YfVxVT5T4SA
Message-ID: <CAB8ipk_7MGUza9_izMypMxPFUjAoB34ZZp0-ts4w6eJ+tr+MDw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] thermal/cpufreq_cooling: remove unused cpu_idx in get_load()
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Xuewen Yan <xuewen.yan@unisoc.com>, rui.zhang@intel.com, 
	rafael@kernel.org, linux-pm@vger.kernel.org, amit.kachhap@gmail.com, 
	daniel.lezcano@kernel.org, linux-kernel@vger.kernel.org, ke.wang@unisoc.com, 
	di.shen@unisoc.com, jeson.gao@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 9:25=E2=80=AFPM Lukasz Luba <lukasz.luba@arm.com> w=
rote:
>
>
>
> On 3/23/26 11:06, Viresh Kumar wrote:
> > On 23-03-26, 10:52, Lukasz Luba wrote:
> >>> How is that okay ? What am I missing ?
> >
> > I was missing !SMP :)
> >
> >> Right, there is a mix of two things.
> >> The 'i' left but should be removed as well, since
> >> this is !SMP code with only 1 cpu and i=3D0.

That's also why we sent out patch 1/2; after all, it is always 0 on
!SMP systems.

> >>
> >> The whole split which has been made for getting
> >> the load or utilization from CPU(s) needs to be
> >> cleaned. The compiled code looks different since
> >> it knows there is non-SMP config used.
> >
> > Right, we are allocating that for num_cpus (which should be 1 CPU
> > anyway). The entire thing must be cleaned.
> >
> >> Do you want to clean that or I should do this?
> >
> > It would be helpful if you can do it :)
> >
>
> OK, I will. Thanks for your involvement Viresh!
>
> Xuewen please wait with your v2, I will send
> a redesign of this left code today.

Okay, and Qais's point is also worth considering: do we actually need
sched_cpu_util()?
The way I see it, generally speaking, the request_power derived from
idle_time might be higher than what we get from sched_cpu_util().
Take this scenario as an example:
Consider a CPU running at the lowest frequency with 50% idle time,
versus one running at the highest frequency with the same 50% idle
time.
In this case, using idle_time yields the same load value for both.
However, sched_cpu_util() would report a lower load when the CPU
frequency is low. This results in a smaller request_power...
