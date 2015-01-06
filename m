From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 02/14] cpufreq: stats: return -EEXIST when stats are
 already allocated
Date: Tue, 6 Jan 2015 09:12:57 +0530
Message-ID: <CAKohpok0sgaYG-uaWPxL1mXtTpv9YGMVPnqwaLo3ZnNS_7-zRA@mail.gmail.com>
References: <cover.1420177186.git.viresh.kumar@linaro.org>
	<1494840.aVYkdgdxZS@vostro.rjw.lan>
	<CAKohponEXJUbxUSJJJ_=2rwA28keSQ8L+NzhY7c_67ZCo+1aRg@mail.gmail.com>
	<1822529.41loKWJpmB@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:47283 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753277AbbAFDm6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Jan 2015 22:42:58 -0500
Received: by mail-ob0-f175.google.com with SMTP id wp4so64124144obc.6
        for <linux-pm@vger.kernel.org>; Mon, 05 Jan 2015 19:42:57 -0800 (PST)
In-Reply-To: <1822529.41loKWJpmB@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>

On 6 January 2015 at 05:22, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> Now note how much useful the above is than the stuff in your original changelog.

Yes, its all in logs now :)

> I'd say all depends on whether or not the callers deal with the error code
> appropriately.  If it is propagated all the way to user space, it really should
> *not* be -EBUSY, but otherwise this is a matter of how the callers handle the
> given error code.

It might not get propagated to user space for now, but not sure if that wouldn't
change in future. Even if it stays only within the kernel, we better return the
error codes that fit the best for a particular situation and so I
would still like
to get this through.
