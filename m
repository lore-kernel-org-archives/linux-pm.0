From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH v2 2/8] PM / devfreq: exynos-ppmu: Use the regmap
 interface to handle the registers
Date: Fri, 30 Dec 2016 19:25:42 +0900
Message-ID: <CAJ0PZbSpub+=iY_s_rGEY6eympHer2+EVuM-VZkbEF0o0hVVQA@mail.gmail.com>
References: <CGME20161228115654epcas1p1752ca85fc1cb3757a9b460584abcb7cc@epcas1p1.samsung.com>
 <1482926212-19223-1-git-send-email-cw00.choi@samsung.com> <1482926212-19223-3-git-send-email-cw00.choi@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:36732 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbcL3KZ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Dec 2016 05:25:58 -0500
In-Reply-To: <1482926212-19223-3-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, chanwoo@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>

On Wed, Dec 28, 2016 at 8:56 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
> This patch uses the regmap interface to read and write the registers for exynos
> PPMU device instead of the legacy memory map functions.
>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>


> ---
>  drivers/devfreq/event/exynos-ppmu.c | 326 ++++++++++++++++++++++++++----------
>  1 file changed, 237 insertions(+), 89 deletions(-)
>
