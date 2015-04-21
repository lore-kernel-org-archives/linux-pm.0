From: Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [RFC v3 0/7] genpd multiple states v3
Date: Tue, 21 Apr 2015 12:20:52 +0200
Message-ID: <55362484.7080601@baylibre.com>
References: <1429542128-21021-1-git-send-email-ahaslam@baylibre.com> <CAJKOXPcvaAR2ZF=y2b2RLRW0CNE3ToWtzt4wYf6KNL7i_3TwNA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36122 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751792AbbDUKU4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 21 Apr 2015 06:20:56 -0400
Received: by wizk4 with SMTP id k4so133292433wiz.1
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2015 03:20:54 -0700 (PDT)
In-Reply-To: <CAJKOXPcvaAR2ZF=y2b2RLRW0CNE3ToWtzt4wYf6KNL7i_3TwNA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?S3J6eXN6dG9mIEtvesWCb3dza2k=?= <k.kozlowski.k@gmail.com>
Cc: ulf.hansson@linaro.org, khilman@linaro.org, rjw@rjwysocki.net, bcousson@baylibre.com, linux-pm@vger.kernel.org

Hi Krzysztof

On 21/04/2015 12:01, Krzysztof Koz=C5=82owski wrote:

>>
>> * added init_state for platforms to pass the
>> initial state when the genpd is initially off.
>>
>> * convert current genpd users for the structure changes.
>>
>> * compile tested for shmobile_defconfig, exynos_defconfig,
>> s3c6400_defconfig u8500_defconfig.
>
> Still the patch does not seem to be bisectable. Have you compiled eac=
h
> config on each commit (not just beginning and end of patchset)?

Sorry, your right. i missed that! i will reorder the patch set so that
each patch compiles in its own.


> Best regards,
> Krzysztof
>
