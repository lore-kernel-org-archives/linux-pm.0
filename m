Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409BFC19
	for <linux-pm@vger.kernel.org>; Tue, 16 Jul 2024 04:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721104197; cv=none; b=IMUj8Hn73kX9AcG6GsCntoxXab9ktx4QgJJWDQEVwAowGGi6kBXIyiEX5cQg8CC/erfPBjKEEJ0Cxn0dX67vFO6t0IutrCz7sSDBStaklsrhixMLZWEKXhd97AgY1VzdyrsAvI82Pz8kREep/y9kU/Yfnw764x6BRXoohcSro6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721104197; c=relaxed/simple;
	bh=Fxaw7Ng7X6+7vJdzrKhj430hol4ifALArDkQpc2cjpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M/ism2NTYhT/9sfqtWZ0ZkoqeGn6M9brOGJp4nB+/SOZcMCFcgYfXY5ALgKatrm/v4p6C9nZ/lgdyCTc9oWsaXY2GsSgC8qwr8DWvKDuF574pReDDw8RZWbC1UG5mYPbwXUk3+ebTZ2VuPEu/P+T06+KJuw473hiPxjFa9DRYiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DQv1XXnl; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DQv1XXnl"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so5849301a12.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 21:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721104193; x=1721708993; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iubjZBekOpPoOdvguIEUCzz0zvPcWVts706zRXNeNzw=;
        b=DQv1XXnlfp5iHcf83CSoCPTgHbQa5eomip02DQCGgXMn15FoHbDAUnkU0c+8zRuCba
         ZMPlYvR5ka2rXpWD8cWz1GYxI5C8/7UwKM6TcIfvNYHpC5g2HOdg5V66Moy4c6bzZMaa
         gTsNenYA+pBqf/nCdHO3cjnnD/7+jB6BWXVfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721104193; x=1721708993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iubjZBekOpPoOdvguIEUCzz0zvPcWVts706zRXNeNzw=;
        b=D/pB7Y1QUdXErJknDCZlZQOOSbsxuP65bF0u+EM9NeuREPN8zTgGjcoXX3ZQtMkNZi
         SPXNovjI/HbJrzT3bkZ0UcPEf+CPsaZEd+yS18d85lKS626WezPxE7ZCpgeBKy+xxQmb
         7FbcctUkBW921og0HDR5Uwfp5eftfn+ti0L5qG3iZPAspNj2tvBoYKC/sioi1vVcrQ/9
         l6xChyInSaP58cNHvvyQhWAAuhthszbabQ2KPCQTLOfYByDDxpgGJ/im+nwDyZAiH6Qq
         q7q2jPIMit54ugm1/LJMGEUkvKva2UxVB9dbX7hi9/nHWOWkkhk1gDJAUXstX9C8F+RM
         D1wg==
X-Forwarded-Encrypted: i=1; AJvYcCW9Vi3OYBn+7qGN3cBzbtGnmBxlrmybgWyerhykVHHjA4Vlv2dPQv2OK4+Sv4sBVVzkHcmgWkqm13t9VInAq5yKdwSlVrp9HJI=
X-Gm-Message-State: AOJu0YzrOFGdWn0JZEmSh9JOoxCNtq3by1UaQTo2sriOMzxrVYEMB6jF
	joOqB7J3ta6wifAum4GYoX2QqwsWmds94NR8wmxmQ5sSSJT20rUgg+6i41jJTXoqDe26rnJw1u+
	PBg1u8Q==
X-Google-Smtp-Source: AGHT+IENIyKfILtoULoP8gw3DgPvfSCDsQ8zORCyVmeMEauYe3vge44qW6kcJ6WYurtAjldKMx6m4Q==
X-Received: by 2002:a05:6402:3592:b0:58b:1737:1143 with SMTP id 4fb4d7f45d1cf-59eee644f96mr541341a12.9.1721104193590;
        Mon, 15 Jul 2024 21:29:53 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b2504b711sm4222142a12.35.2024.07.15.21.29.52
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 21:29:52 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-58bac81f3f9so5849279a12.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2024 21:29:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZiaZrVxHFAmbsuAfjtPATdmJkD+bw4mzd6RZ66uB97BI2YSVPGhpmwmyY91JaAf2ZAUghx9aBBdpe9F35eVBdrOtGu7JGtKc=
X-Received: by 2002:a05:6402:234d:b0:57a:1e0a:379f with SMTP id
 4fb4d7f45d1cf-59eee832048mr631175a12.16.1721104191819; Mon, 15 Jul 2024
 21:29:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240712091008.14815-1-brgl@bgdev.pl> <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
In-Reply-To: <CAHk-=wjWc5dzcj2O1tEgNHY1rnQW63JwtuZi_vAZPqy6wqpoUQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 15 Jul 2024 21:29:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjcO_9dkNf-bNda6bzykb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com>
Message-ID: <CAHk-=wjcO_9dkNf-bNda6bzykb5ZXWtAYA97p7oDsXPHmMRi6g@mail.gmail.com>
Subject: Re: [GIT PULL] power sequencing updates for v6.11-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 19:17, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. Let's see how this all works out, but I already found an annoyance.

.. and another one.

On my Altra box, commit 8fb18619d910 ("PCI/pwrctl: Create platform
devices for child OF nodes of the port node") causes annoying messages
at bootup:

  pci 000c:00:01.0: failed to populate child OF nodes (-22)
  pci 000c:00:02.0: failed to populate child OF nodes (-22)
  .. repeat for every PCI bridge ..

for no obvious reason.

FWIW, -22 is -EINVAL.

            Linus
