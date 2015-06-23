From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 5/8] ARM: STi: STiH407: Move PWM nodes STiH407 =>
 STiH407-family
Date: Tue, 23 Jun 2015 08:08:22 +0100
Message-ID: <20150623070822.GB3245@x1>
References: <1434987837-24212-1-git-send-email-lee.jones@linaro.org>
 <1434987837-24212-6-git-send-email-lee.jones@linaro.org>
 <20150623021708.GB16776@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f51.google.com ([74.125.82.51]:36242 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751821AbbFWHI0 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2015 03:08:26 -0400
Received: by wguu7 with SMTP id u7so1022226wgu.3
        for <linux-pm@vger.kernel.org>; Tue, 23 Jun 2015 00:08:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150623021708.GB16776@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, rjw@rjwysocki.net, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, ajitpal.singh@st.com

On Tue, 23 Jun 2015, Viresh Kumar wrote:
> On 22-06-15, 16:43, Lee Jones wrote:
> > This also incorporates the STiH410.
>=20
> Any explanation to why this patch is part of this series ?

Because the CPUFreq regulator is controlled with PWM and CPUFreq will
fail on STiH410 (my main development platform) without it.

It's safe for you to ignore it though.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
