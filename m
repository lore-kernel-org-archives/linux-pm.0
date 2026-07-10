Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBB2773CA
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712393; cv=none; b=LveLCzBq2hMHY4wd0augfjpAaVGy5XTybDkEkRNTbODXWWAc98A4sYAysMw5TrLSldZAERZyqwIuuHoRJKnOPwobqDzv47De8SzWbDM5+muWbn4kmU+GaJ7D4nuaAVUvJTb6jFqLlBNqQm/DN532bQX671zeJuHQcAy09abR50k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712393; c=relaxed/simple;
	bh=htOp00x4FdqXR1iq4aGwDRJJXYEyQzl2O/yVzKc31B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2NBi67frge5K7KEhfXHfIfT4/hp0lmnesOe5Lb16qcCi6qq549fJLbe0w09aAZNvFL/b6fqm2Akt8Z45mvmkrExdT1sokX/PKRn74GfVJ8xJX3YCrjkAkHZU01jy9CLvynxk+LEqQUTQNSDCEfHZuzGMSIB0j42J1T/kevSPPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G3VhqjYz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3VhqjYz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03AD1F00A3D
	for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 19:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712392;
	bh=htOp00x4FdqXR1iq4aGwDRJJXYEyQzl2O/yVzKc31B8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=G3VhqjYzLyT6LqX0bDpphSwyxcY2jAHzlJwBUsdEgfz9X0+Pare0zY3WGWX0OkE+w
	 zn+dtVfLrvbo0GdEJuftm2HIXfcssfz5xjW+b+OVDgHNC5VtIporPEdls2DCAQKpp4
	 vATXv+fD04v8MvSjems4W/lcYxxDPpWPtv4HPAxpXfLltK3w2SUSSPS+aguA7sP2vr
	 Y278p9JEh/W419+kg9p93LrbkuVkBcQNmOOtfUQeFFONstPgBxQO589maqZeqUH+ik
	 UuHDsVR5/pIE/CZ9AzOfJ1H40yN838cDyPCBfczHw3H0KhvI93bTr60hMWdKyeTH+4
	 VBYG7cf43rFTA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b00d083818so2076311e87.1
        for <linux-pm@vger.kernel.org>; Fri, 10 Jul 2026 12:39:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrwuslCnzt5QJZ6BKwa6uVW/Gjd2Wu2ywHjLEK1b/7IsxlexZkE+U8IPDn1vvySy+5r1NVovQzqFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRJiUfa117V+W6E3+9W6RRB5DlGRuJj8br13h9wgdDLUtcZYi
	qrFsS7V0vXPdsY7fX+O3ABPuFxwsQH6ep3Io/W/Br0fkhBHcjaGUkYj69QgbuTKEQ1ca10ENGlp
	QmEhUeIiWokPRRL84dpCZJDkxa1bLhQo=
X-Received: by 2002:a05:6512:3f26:b0:5b0:15ed:e1a with SMTP id
 2adb3069b0e04-5b02ba2ecc6mr21855e87.26.1783712390796; Fri, 10 Jul 2026
 12:39:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709033428.362970-1-panchuang@vivo.com> <20260709033428.362970-7-panchuang@vivo.com>
In-Reply-To: <20260709033428.362970-7-panchuang@vivo.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 10 Jul 2026 21:39:38 +0200
X-Gmail-Original-Message-ID: <CAD++jL=vt7dwN3DdoW3F8jcnNTPSL6_2vfhgGnvRgsfYA39tOQ@mail.gmail.com>
X-Gm-Features: AUfX_mxNcuzyd-Isp_1kbRhwrjRvpZowkOuUZ7O2dCI3zqUwAayjCMPxX8a7R_w
Message-ID: <CAD++jL=vt7dwN3DdoW3F8jcnNTPSL6_2vfhgGnvRgsfYA39tOQ@mail.gmail.com>
Subject: Re: [PATCH 06/43] power: supply: ab8500_fg: Remove redundant dev_err()/dev_err_probe()
To: Pan Chuang <panchuang@vivo.com>
Cc: Sebastian Reichel <sre@kernel.org>, 
	"open list:POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS" <linux-pm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 5:35=E2=80=AFAM Pan Chuang <panchuang@vivo.com> wrot=
e:

> The devm_request_threaded_irq() and devm_request_irq() now automatically
> log detailed error messages on failure. This eliminates the need for
> driver-specific dev_err() and dev_err_probe() calls that previously
> printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
