Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798587;
	b=uejSh4PczkwNvrrQKM23cA86yEY8hPgTOdnT/34CV5AYIjK25ueTZLPXbGuffFDL3Q/v
	 K+OJi022oa5aFBi+24v3mRCdbNQ13zfmCPs3CkLv8jrUGrmHCrcEd4JFRTmfFdlH5lB6x
	 LF+ZWlprsoOrJaQKaZ5/Q7h0wE6XwZhMY+7lei5fItlnGRpyjcDEsHo/eWDtqB7cuQldI
	 22ybthChAeaeBwsSprvKtbjuxTovYNqKBqDHrbmh340O5g+k7gKnGB0RuxSu67w+ETaFd
	 sdfLJNs0NuBGlBCcUp6dLXEOkPs9gv3D9iq66sbQVx2Evki+ZpmxLnvpZhKsBWDBTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798587;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Nm5GsoRVqPZjF7NiFim3iyXJW+IHzow3RlWZbSCsnE0=;
	b=EJEGolC7f87DqVtBiVvXt90iswSs1h8179uJX46JFXKKRL9PbCXD6zvFh6ywVEUVORJe
	 79PmOlTTs7cj2K9pfuduHtCcwxTAJF5EXI8v+aejCf9V6QOFQdYtUhbgqCLbNVBkT2zvL
	 42BnOvP9KE64LvvDu6khXC2nMwOBAZ/SfJoI0bSRx9WKD2NC+e+zvakmJzz8gRQ4RQigL
	 dgu2CTmM91ebphIJuUML2Tt4PvLW3wkLR0Nvf6gcgtb1y7ycsFYZ9+IrNLcDcAm4wcZmG
	 CE+B7KFE7V0o4annP2uBWoTBWHF1GBmbkHxiOlm7WgiQBp3t1zKCsHzOL2wnfz5dFSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjskCGsz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BBD606A31C
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjskCGsz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0631F0089B
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 16:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798587;
	bh=Nm5GsoRVqPZjF7NiFim3iyXJW+IHzow3RlWZbSCsnE0=;
	h=From:Date:Subject:To:Cc;
	b=mjskCGsz2pDTrTgeONRGn+PMQABd/uH6PeN26AYNzWZhyYa64nEaGLZzdHprB93bG
	 NnJoYAKbEpMpV8rVn5tOtyhrpqQ8yl3LKf1UVC26d1ZyOzlL1xkNw/4WA5fL4CIazj
	 V2rerAfFPSROYqP7t1y2wEnbMCBh9w9qJIFfbh156bu82NADA7VOSwrBfIbXbzoBWo
	 WP2QxC2phptBQxl80m+85MZ8tfAcbvO1MQA8ev9tqjtithDksiJLsxxYGtiB/LZchR
	 XvTsP+2k3fWZdcrJlAb8q2J6jpnqZnmP/ZWO7esQewRUInDG7nHDKq7zoVtWVbhJrD
	 1XFlgCaPTKpoQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5c1479a959aso6403095e87.2
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 08:56:27 -0800 (PST)
X-Gm-Message-State: APuU4Z/X5lQGTy7alIhSQr97l+5f9r6YcEN+x2soTBsE+zZiYCg2rDaH
	gbhXDa8jhxgPha3M/N6JlCpM5Wb+Vb5b/k+AL3NDp5J8HbqlgMVVZdXUGqb43OAeJBG5NN8ZJi3
	XorrG6XAtf9JVksTUMuy4Z/0MUijJDSg=
X-Received: by 2002:a05:6512:6695:10b0:5c0:bca:77cd with SMTP id
 2adb3069b0e04-5c1bc803ecamr5353701e87.42.1795798585547; Fri, 27 Nov 2026
 08:56:25 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 17:56:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jwg0cGJgPnP2SaXdcHWpW_5FPq25McuQmh9794L5QWpQ@mail.gmail.com>
X-Gm-Features: Aa3M54qnjPoJ8mF5BIzTgERRjtaFuU95ItH4SUcHBADTGze3jzpDHyS5YxxH9To
Message-ID: <CAJZ5v0jwg0cGJgPnP2SaXdcHWpW_5FPq25McuQmh9794L5QWpQ@mail.gmail.com>
Subject: [GIT PULL] Power management fixes for 7.4-rc5
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 pm-7.4-rc5

with top-most commit 569e1eb36b033f42a9c363ffe4bfbf50bdadae51

 cpufreq: intel_pstate: Use dedicated lock in set_power_ctl_ee_state()

on top of commit b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f

 Linux 7.4-rc4

to receive power management fixes for 7.4-rc5.

These fix two issues in the intel_pstate driver including one recent
regression:

 - Prevent intel_pstate from triggering lockdep splats during system
   resume due to suspicious ordering of locks that is a consequence
   of a recent cpufreq core update (Rafael Wysocki)

 - Make intel_pstate refresh cpuinfo.max_freq when a CPU goes online
   to avoid using a stale value of it (Hugo Sales)

Thanks!


---------------

Hugo Sales (1):
      cpufreq: intel_pstate: Refresh cpuinfo.max_freq when a CPU goes online

Rafael J. Wysocki (1):
      cpufreq: intel_pstate: Use dedicated lock in set_power_ctl_ee_state()

---------------

 drivers/cpufreq/intel_pstate.c | 52 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 10 deletions(-)
