From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [lockdep] cpufreq/ppc: possible circular locking dependency
 detected
Date: Mon, 8 Jun 2015 22:02:28 +0530
Message-ID: <20150608163228.GD4198@linux>
References: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36634 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752521AbbFHQcd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 12:32:33 -0400
Received: by pabqy3 with SMTP id qy3so100770059pab.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 09:32:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 08-06-15, 18:45, Denis Kirjanov wrote:
> Hi,
> 
> I see the following lockdep splat on my RackMac machine on boot:

What kernel version is it ?

-- 
viresh
