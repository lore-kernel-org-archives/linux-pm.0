From: Chanwoo Choi <cwchoi00@gmail.com>
Subject: Re: [PATCH 0/4] extcon: Clean-up the minor issue and fix the NULL
 pointer error
Date: Fri, 19 Jun 2015 15:40:52 +0900
Message-ID: <CAGTfZH1oUQhtBNQcLL_XgMsVxsYG4fdA1a1rdktWFYAhcJJATg@mail.gmail.com>
References: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Reply-To: cw00.choi@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35038 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbbFSGkx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Jun 2015 02:40:53 -0400
Received: by iefd2 with SMTP id d2so12779788ief.2
        for <linux-pm@vger.kernel.org>; Thu, 18 Jun 2015 23:40:52 -0700 (PDT)
In-Reply-To: <1434695751-25631-1-git-send-email-cw00.choi@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: Chanwoo Choi <cwchoi00@gmail.com>, "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>

Dear all,

My mistake. I sent wrong the linux kernel mailing list.
I should send this patch-set to the linux-kernel@vger.kernel.or
instead of linux-pm.

Please ignore this patch-set.

Best Regards,
Chanwoo Choi

On Fri, Jun 19, 2015 at 3:35 PM, Chanwoo Choi <cwchoi00@gmail.com> wrote:
> This patch-set clean-up the minor issue and fix the NULL pointer error of
> extcon-palmas driver. And extcon driver don't support the bit operation to
> identify the external connectors from Linux v4.2. So, patch4 removes the bit
> data of mutually_exclusvie array.
>
> Chanwoo Choi (4):
>   extcon: Remove duplicate header file in extcon.h
>   extcon: Remove optional print_state() function pointer of struct extcon_dev
>   extcon: palmas: Fix NULL pointer error
>   extcon: palmas: Remove the mutually_exclusive array
>
>  drivers/extcon/extcon-gpio.c   | 18 ------------------
>  drivers/extcon/extcon-palmas.c | 10 ----------
>  drivers/extcon/extcon.c        |  8 --------
>  include/linux/extcon.h         |  7 -------
>  4 files changed, 43 deletions(-)
>
> --
> 2.2.0.GIT
>
