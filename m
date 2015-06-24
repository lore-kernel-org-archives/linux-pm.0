From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 7/8] cpufreq: st: Provide runtime initialised driver for
 ST's platforms
Date: Wed, 24 Jun 2015 08:33:08 +0100
Message-ID: <20150624073308.GA15013@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-8-git-send-email-lee.jones@linaro.org>
 <1435046411.4528.6.camel@tiscali.nl>
 <20150623082857.GG3245@x1>
 <1435089796.4528.53.camel@tiscali.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:35216 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149AbbFXHdN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 03:33:13 -0400
Received: by wiga1 with SMTP id a1so126953027wig.0
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 00:33:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1435089796.4528.53.camel@tiscali.nl>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Paul Bolle <pebolle@tiscali.nl>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On Tue, 23 Jun 2015, Paul Bolle wrote:
> On Tue, 2015-06-23 at 09:28 +0100, Lee Jones wrote:
> > BTW, do you have a script that does this now, or are you still
> > hand-rolling these?
>=20
> There was a script detecting Kconfig problems that is basically
> retired. (The messages I sent were always manually written.) That
> script's function is now performed, much better, by the undertaker
> -checkpatch bot (courtesy of a group of people apparently all
> affiliated with the university of Erlangen, Germany). We're in virtua=
l
> contact but that group is doing fine so I'm basically not contributin=
g.
>=20
> Anyhow, my reply to your patch was the result of a manual scan for a
> small set of common (and mostly trivial) mistakes in patches that I t=
ry
> to do regularly. All pretty basic stuff, otherwise I wouldn't been ab=
le
> to spot these mistakes.
>=20
> Does this answer your question?

Certainly does, thanks.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
