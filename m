From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 12/13] cpufreq: stats: Fix locking
Date: Tue, 23 Dec 2014 11:36:40 +0530
Message-ID: <CAKohpok+7b3t3-82EO+9tpmBHavMxBT1r2ORhPcQbT3hT=p9mA@mail.gmail.com>
References: <cover.1418902789.git.viresh.kumar@linaro.org>
	<6277a557b0102524ca317bf0aa94d7b479375d6e.1418902789.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:33129 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbaLWGGl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 23 Dec 2014 01:06:41 -0500
Received: by mail-ob0-f181.google.com with SMTP id gq1so24086618obb.12
        for <linux-pm@vger.kernel.org>; Mon, 22 Dec 2014 22:06:41 -0800 (PST)
In-Reply-To: <6277a557b0102524ca317bf0aa94d7b479375d6e.1418902789.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Prarit Bhargava <prarit@redhat.com>

On 18 December 2014 at 17:30, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Locking wasn't handled properly at places and this patch is an attempt to fix
> it. Specially while creating/removing stat tables.

Because we were required to allocated memory from within locks, we had to
use mutex here. So, just consider a mutex instead of spinlock everywhere in
this file.
