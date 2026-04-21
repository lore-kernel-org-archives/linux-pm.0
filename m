Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA137AA9E
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776812755; cv=none; b=fPpm95Smm5dtBuz3mekaXic65JP/Iemx7EdE9cFqORWvuzBAvCvgk6DG8aOvHb76d/QFJgjGYhLdfcJI9PQ3I66TdZC3aHjQgQUt0k9DVovTmCjpLREV0i/NG6mnf1ZKwKjY2gLvQ+64Ez6l4nkUhVI1YwKbt7klTuJege8z4dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776812755; c=relaxed/simple;
	bh=o+mssblS9jTow+Pnxeo8d3Ca3SHh1bJByEwm09RiY5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gJ7UET53tPip8Gru+yU5K6+nwekJgM0OThQOAdOV0JXAHOcqBtD0s3udQvv5UE9w+gaKWspdz9vEyyXQ7BiCsPNtlfYhrQ81opZtwGco9CBLdNWNGLQ/PAZSkxpwa+svio41LTfh2kSnexI4P5fk0+2F0+o3xfCSXRJRCik9ICY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4GnHgBN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4GnHgBN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EDCC2BCB7
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776812755;
	bh=o+mssblS9jTow+Pnxeo8d3Ca3SHh1bJByEwm09RiY5g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M4GnHgBNg6ofb49dYeVLauGwyRToPKfo/8d+Bfi7U+/JSKvkG3vO5/ueHpil/af87
	 yKOibzaNOkDMKwgchUwdSNLJP9UBQXsDWhS436Y1bMKCnhEdrtPapJdFMctgJcRVkQ
	 QxCeDX05zfZyG5A3X4LQxKOB1wJL0j/DrsFBo9yUsPYDplh48j8f03RWabXD9eNtdA
	 G8c4r3w+Glyvil3eMuFkI1Vp8Bzpd7dkajGgxPatvhMKu7JKkX8eCdRtLJ+/yaD92P
	 ii3qYFP01iKDPAwz2cs9iDBBK6y3pH67Pd8jky9GE7uJKUAm4QW0UBGn54Pa/r5YkZ
	 qbyg8p5pDPpFg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-676f6c823c3so46125a12.3
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 16:05:55 -0700 (PDT)
X-Gm-Message-State: AOJu0YxzbllOxAn561JasHp129mwRzIn47BwLuEEyeDROssygz2sXtp1
	kBZQ58OCush255FnaP2gwqx3PZaV45rwpQAw7NE7LM9K7JrVKGNucCzKchCOhAXisHJ3fZmUcy/
	MPffp38g6iVbFz9NWKGMl/NB8SSpQV3Y=
X-Received: by 2002:a05:6402:ea0:b0:673:b696:8823 with SMTP id
 4fb4d7f45d1cf-673b6968961mr7346496a12.15.1776812754271; Tue, 21 Apr 2026
 16:05:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421143217.3717297-1-darcari@redhat.com>
In-Reply-To: <20260421143217.3717297-1-darcari@redhat.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 21 Apr 2026 19:05:41 -0400
X-Gmail-Original-Message-ID: <CAJvTdKkVA9DVEZmuBrh7pS=UN445tjixnrdnT34AuvcURRfc_A@mail.gmail.com>
X-Gm-Features: AQROBzAkwZ0Vfym8satm-9toJ8yQJrjwjK-machxKBozeFtKIiPUc5j83uwbolY
Message-ID: <CAJvTdKkVA9DVEZmuBrh7pS=UN445tjixnrdnT34AuvcURRfc_A@mail.gmail.com>
Subject: Re: [PATCH] tools/power/turbostat: fix unrecognized option '-P'
To: David Arcari <darcari@redhat.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Applied - thanks!

-Len Brown, Intel Open Source Technology Center
