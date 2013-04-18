From: ren zhen <darwin.xupt@gmail.com>
Subject: Re: [RFC]runtime pm:what does the runtime_usage really mean?
Date: Thu, 18 Apr 2013 16:31:01 +0800
Message-ID: <CACbbJyYsDQgTufArES73wgx04x7ZYREgz0AXYdnoxjNTq4dWKw@mail.gmail.com>
References: <CACbbJyYot+VS4TeWPQPc1XezAtrtK_qs7ddZTB3zTVUizFs2JA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f195.google.com ([209.85.128.195]:45742 "EHLO
	mail-ve0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966077Ab3DRIbC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 04:31:02 -0400
Received: by mail-ve0-f195.google.com with SMTP id m1so1763ves.10
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 01:31:01 -0700 (PDT)
In-Reply-To: <CACbbJyYot+VS4TeWPQPc1XezAtrtK_qs7ddZTB3zTVUizFs2JA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Addtionally, I cannot find any explanation of 'runtime_usage' in
Documention/ABI/ directory.

On Thu, Apr 18, 2013 at 4:24 PM, ren zhen <darwin.xupt@gmail.com> wrote:
> 'runtime_usage' is an attribution of device power, which appears in
> /sys/devices/.../power/ directory.
>
> On Thu, Apr 18, 2013 at 4:18 PM, ren zhen <darwin.xupt@gmail.com> wrote:
>> Hi all:
>>        The power management maillist says:
>>                  " runtime_usage: the runtime PM usage count of a device".
>>         What does 'runtime_usage' really mean? what situations should
>> we use it? And when increase it or decrease it?
>>          Anyone who know about that, please give me a detailed account
>> of 'runtime_usage', a actual example cannot be more better!
>>        I will appreciate any help.
>>
>> --
>> Sincerely,
>> Ren Zhen
>
>
>
> --
> Sincerely,
> Ren Zhen



--
Sincerely,
Ren Zhen
