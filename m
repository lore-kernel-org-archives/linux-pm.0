From: Stephen Boyd <stephen.boyd@linaro.org>
Subject: Re: [PATCH v5 0/2] qcom OTG regulator support
Date: Wed, 28 Dec 2016 14:06:18 -0800
Message-ID: <CAJOFmgySF7T1N6PDiw2rsQ+n68_k7n_M0TzXZe4S7PxTHmRapA@mail.gmail.com>
References: <20161018004251.28733-1-stephen.boyd@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f179.google.com ([209.85.223.179]:36079 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752032AbcL1WGu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 28 Dec 2016 17:06:50 -0500
Received: by mail-io0-f179.google.com with SMTP id h133so104784286ioe.3
        for <linux-pm@vger.kernel.org>; Wed, 28 Dec 2016 14:06:39 -0800 (PST)
In-Reply-To: <20161018004251.28733-1-stephen.boyd@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, linux-pm@vger.kernel.org, linux-arm-msm <linux-arm-msm@vger.kernel.org>, "Bird, Tim" <tim.bird@sonymobile.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Andy Gross <andy.gross@linaro.org>

Hi Sebastian,

On Mon, Oct 17, 2016 at 5:42 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> This is a resend/resurrection of Tim's patches to add support
> for the OTG regulator on some of qcom's PMICs[1]. I've made
> some minor modifications to the driver to make it work, but
> otherwise it works fine with my USB otg testing. Changes
> are noted in a maintainer tag.
>
> Tim, did you want to me to fix the name? I pulled these from patchwork
> and it seems you sent it as "Bird, Tim" which may have not been
> intentional.
>

Can this be picked up for v4.11? Tim hasn't responded so I assume it's
fine with the name.
