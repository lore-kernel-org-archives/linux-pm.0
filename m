From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v6 2/2] Documentation: devicetree: Add boost-frequency
 binding to list boost mode frequency
Date: Fri, 30 May 2014 16:01:17 -0500
Message-ID: <5388F19D.8070303@ti.com>
References: <1401440477-4328-1-git-send-email-thomas.ab@samsung.com> <1401440477-4328-3-git-send-email-thomas.ab@samsung.com> <20140530130827.GK24233@leverpostej> <CAJuA9ajs6K1PVtXC4_U0vQsA0oPnpaF_PdMfiQJxBFStF3Z2aw@mail.gmail.com> <20140530185549.GN24233@leverpostej> <5388E105.3070609@ti.com> <5388E3D2.2060602@gmail.com> <5388E666.2090203@ti.com> <5388E7DC.40606@gmail.com> <5388EB21.5020300@ti.com> <5388ED87.1090209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:38522 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbaE3VCB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 30 May 2014 17:02:01 -0400
In-Reply-To: <5388ED87.1090209@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomasz Figa <tomasz.figa@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Abraham <ta.omasab@gmail.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "kgene.kim@samsung.com" <kgene.kim@samsung.com>, "t.figa@samsung.com" <t.figa@samsung.com>, "l.majewski@samsung.com" <l.majewski@samsung.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>

On 05/30/2014 03:43 PM, Tomasz Figa wrote:
[...]
> OK, so you add overclocked frequencies to operating-points property,
> boost-frequency property, build a dtb, use it with a kernel that doesn't
> support boost-frequency and nicely overheat (and likely destroy) your
> board. I don't think this makes too much sense, sorry.
Yes, that is unfortunately true as well :( Sigh.

-- 
Regards,
Nishanth Menon
