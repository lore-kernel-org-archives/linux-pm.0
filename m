From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH v3 0/4] thermal: re-calculate k_po/k_pu when update
 sustainable power
Date: Wed, 6 Jan 2016 15:05:24 +0000
Message-ID: <20160106150524.GC2790@e104805>
References: <1452070428-2567-1-git-send-email-leo.yan@linaro.org>
 <20160106100712.GA2790@e104805>
 <568CF8D2.9040906@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <568CF8D2.9040906@linaro.org>
Sender: linux-doc-owner@vger.kernel.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>, Jonathan Corbet <corbet@lwn.net>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Punit Agrawal <punit.agrawal@arm.com>, Daniel Kurtz <djkurtz@chromium.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 06, 2016 at 11:21:54AM +0000, Daniel Thompson wrote:
> On 06/01/16 10:07, Javi Merino wrote:
> >On Wed, Jan 06, 2016 at 04:53:44PM +0800, Leo Yan wrote:
> >>k_po/k_pu are two proportional term constants and essentially they have
> >>fixed ratio compared with sustainable power. In current implementation,
> >>k_po and k_pu are absolute value after calculation and cannot represent
> >>the ratio relationship with sustainable power; as a result, when change
> >>sustainable power we cannot smoothly change proportional term constant.
> >
> >In v2 Daniel said that the use case was made up.  Can you elaborate on
> >why we need this?
> 
> To be clear, I didn't say Leo's use case was made up. In truth I've
> never asked Leo what his use case is.

Sorry, I didn't mean to say that Leo had made it up.  I was just
asking for a use case and it looked to me that the "fan inhibitor
mode" was something that you guys had talked about.

Cheers,
Javi

> It was simply the use case that I used to illustrate a bug in the v1
> implementation which was made up (and which you asked for more
> details of).
> 
> 
> 
> Daniel.
> 
