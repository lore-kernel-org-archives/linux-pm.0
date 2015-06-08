From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [lockdep] cpufreq/ppc: possible circular locking dependency
 detected
Date: Mon, 8 Jun 2015 22:10:47 +0530
Message-ID: <20150608164047.GF4198@linux>
References: <CAOJe8K3Mtj9UMOYwjAuh7DYQxHR-ZLbEBAQJ+t3oSDphwu5+Hg@mail.gmail.com>
 <20150608163228.GD4198@linux>
 <CAOJe8K0rnDiYE3NHTcwgkxBYb5kxQZVAJreeXFL9yPpXVhNGqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35237 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753343AbbFHQkv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Jun 2015 12:40:51 -0400
Received: by pacyx8 with SMTP id yx8so63858325pac.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2015 09:40:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAOJe8K0rnDiYE3NHTcwgkxBYb5kxQZVAJreeXFL9yPpXVhNGqw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 08-06-15, 19:37, Denis Kirjanov wrote:
> [    6.091149] 4.1.0-rc6-01265-g908e80d-dirty #15 Not tainted

Sorry, this points to a dirty tree. Can you please explain what's more
than rc6 is here ? Are you using any other patches from somewhere? 

-- 
viresh
