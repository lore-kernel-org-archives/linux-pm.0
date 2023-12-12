Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92650D3;
	Tue, 12 Dec 2023 07:01:34 -0800 (PST)
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-590b52645d3so50974eaf.0;
        Tue, 12 Dec 2023 07:01:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702393294; x=1702998094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EGu92SUJ9J01LWRjxiuDNZ6kwGOV4bXKbE++KcfIYPI=;
        b=lRThk79ee60x/Pw+aSoTOikWXJ9ey43Mt4YSCDloaYGiLssMADm49ad69KNy4+dIVz
         uBGZaAhQ/yLX8GxzUDUGKL9JNrAHEBPKx1xCSvXgQfeUaIcmnokOybi0fxMq+LSAbzkH
         kd53CmYgS1Dm4U+3i8hURgb2AgEE5kH68RJBj9ya09rqMIIj5+YRQN5WDqxMhrsL6/t6
         a6FIfHMO/xQZnMBa4Syef9hsKkv8g3Sj6LmnUdfYd/XdbyCkN8G1VnD3qJnNtQWY07PE
         mLXuX0/xdcsO0B6CCI/x/acUoq/O1Dg9uX8Gt7nirEMlLGbSo3QVDU/AujoBZRIUD3iZ
         2RRQ==
X-Gm-Message-State: AOJu0YxUbyS7xBNqeKJ9VYf/xnQlPBVI6Z6tDLnMQJ9NPGXRFX6vnrp4
	azN49kvIktlz60W68qXMzsFufmokf+IkBVHrv5A=
X-Google-Smtp-Source: AGHT+IEK9mFOYuIlQR0ZF+LZaAGnMACZ1Zxp6SUgMMbIxZ+hs8/dzveeTAGg6RvzfCXvs6aLuIivTmNxAuPSwBqrLDQ=
X-Received: by 2002:a05:6820:2a18:b0:590:9027:7ab0 with SMTP id
 dr24-20020a0568202a1800b0059090277ab0mr9351530oob.0.1702393293843; Tue, 12
 Dec 2023 07:01:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0jZAOmnccbEUsBNw3f-Uh6TmO-6JGgU+PJazmjFASczHQ@mail.gmail.com>
 <20231212143804.3887-1-chenguanxi11234@163.com>
In-Reply-To: <20231212143804.3887-1-chenguanxi11234@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 Dec 2023 16:01:22 +0100
Message-ID: <CAJZ5v0gLswRMBR1-b_TQTau7KMpuBbR5hYJyat6pMOD5zYSi7Q@mail.gmail.com>
Subject: Re: [PATCH linux-next] kernel/power: Use kmap_local_page() in snapshot.c
To: chenguanxi11234@163.com
Cc: rafael@kernel.org, chen.haonan2@zte.com.cn, len.brown@intel.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, pavel@ucw.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 3:38=E2=80=AFPM <chenguanxi11234@163.com> wrote:
>
> What I've learned is that kmap_atomic() disables page-faults and
> preemption (the latter only for !PREEMPT_RT kernels).In my opinion,
> the code between the mapping and un-mapping in this patch does not
> depend on the above-mentioned side effects.So I simply replaced
> kmap_atomic() with kmap_local_page(). If I'm wrong, please explain it to =
me.

You are right, but why don't you say the above in the patch changelog
instead of the irrelevant information that is there now?
