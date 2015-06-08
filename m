From: Denis Kirjanov <kda@linux-powerpc.org>
Subject: Re: [lockdep] cpufreq/ppc: possible circular locking dependency detected
Date: Mon, 8 Jun 2015 19:37:43 +0300
Message-ID: <CAOJe8K0rnDiYE3NHTcwgkxBYb5kxQZVAJreeXFL9yPpXVhNGqw@mail.gmail.com>
References: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
	<20150608163228.GD4198@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:33791 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbbFHQho (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 12:37:44 -0400
Received: by yhpn97 with SMTP id n97so42344547yhp.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 09:37:43 -0700 (PDT)
In-Reply-To: <20150608163228.GD4198@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 6/8/15, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 08-06-15, 18:45, Denis Kirjanov wrote:
>> Hi,
>>
>> I see the following lockdep splat on my RackMac machine on boot:
>
> What kernel version is it ?
[    6.091149] 4.1.0-rc6-01265-g908e80d-dirty #15 Not tainted
> --
> viresh
>
