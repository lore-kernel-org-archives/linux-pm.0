From: ren zhen <darwin.xupt@gmail.com>
Subject: Re: [RFC]runtime pm:what does the runtime_usage really mean?
Date: Thu, 18 Apr 2013 16:24:19 +0800
Message-ID: <CACbbJyZbk_SEF2g5GrK5kWSPF9r-THc-TQgZg7c6tiHCE1geMQ@mail.gmail.com>
References: <CACbbJyZp2-s8tdKs3GYAs5HEHY7ZwaZOexugpBEKbFehaiSGGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f194.google.com ([209.85.220.194]:55502 "EHLO
	mail-vc0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3DRIYU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 04:24:20 -0400
Received: by mail-vc0-f194.google.com with SMTP id gf12so474143vcb.5
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 01:24:19 -0700 (PDT)
In-Reply-To: <CACbbJyZp2-s8tdKs3GYAs5HEHY7ZwaZOexugpBEKbFehaiSGGw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

'runtime_usage' is an attribution of device power, which appears in
/sys/devices/.../power/ directory.

On Thu, Apr 18, 2013 at 4:18 PM, ren zhen <darwin.xupt@gmail.com> wrote:
> Hi all:
>        The power management maillist says:
>                  " runtime_usage: the runtime PM usage count of a device".
>         What does 'runtime_usage' really mean? what situations should
> we use it? And when increase it or decrease it?
>          Anyone who know about that, please give me a detailed account
> of 'runtime_usage', a actual example cannot be more better!
>        I will appreciate any help.
>
> --
> Sincerely,
> Ren Zhen



-- 
Sincerely,
Ren Zhen
