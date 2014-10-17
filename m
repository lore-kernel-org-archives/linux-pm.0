From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Locking issues with cpufreq and sysfs
Date: Fri, 17 Oct 2014 18:55:30 +0530
Message-ID: <CAKohpo=NH-eY__krHPgAUmrbxm-dd+rP9yGj3mGdXDxUQyPJVg@mail.gmail.com>
References: <543BCF9A.1060603@redhat.com>
	<CAKohpo=KVJRdX1h=Pp2mo63QXh+5ygS9RQ=EUXaq8z+JBDFykQ@mail.gmail.com>
	<54410862.6020508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f179.google.com ([209.85.214.179]:43743 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbaJQNZb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 17 Oct 2014 09:25:31 -0400
Received: by mail-ob0-f179.google.com with SMTP id wp4so587220obc.38
        for <linux-pm@vger.kernel.org>; Fri, 17 Oct 2014 06:25:30 -0700 (PDT)
In-Reply-To: <54410862.6020508@redhat.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>, Stephen Boyd <sboyd@codeaurora.org>

On 17 October 2014 17:45, Prarit Bhargava <prarit@redhat.com> wrote:
> Hmmm
>
> This is what I'm doing:
>
> echo ondemand > scaling_governor
> cat ondemand/*
> echo conservative > scaling_governor
>
> OOC what are you doing to test?

Exactly same and even tried Roberts script too :)
