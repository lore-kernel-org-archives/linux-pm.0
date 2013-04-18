From: ren zhen <darwin.xupt@gmail.com>
Subject: Re: [RFC]runtime pm:what does the runtime_usage really mean?
Date: Thu, 18 Apr 2013 16:24:38 +0800
Message-ID: <CACbbJyYot+VS4TeWPQPc1XezAtrtK_qs7ddZTB3zTVUizFs2JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vb0-f65.google.com ([209.85.212.65]:65328 "EHLO
	mail-vb0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755831Ab3DRIYj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 04:24:39 -0400
Received: by mail-vb0-f65.google.com with SMTP id 11so462916vbf.4
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 01:24:39 -0700 (PDT)
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
