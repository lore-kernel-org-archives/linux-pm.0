From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 11 May 2015 16:22:26 -0400
Message-ID: <CAJvTdKk7tHoDC7N3=_7JB3KFSVrKyAhEEoS+RaM3bud=H4XXuw@mail.gmail.com>
References: <b1587e8b2c664632ecd0d9ad1a3e56733da76490.1431068823.git.len.brown@intel.com>
	<20150511014428.GB15721@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34580 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbbEKUW2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 May 2015 16:22:28 -0400
In-Reply-To: <20150511014428.GB15721@dastard>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Sun, May 10, 2015 at 9:44 PM, Dave Chinner <david@fromorbit.com> wrote:

> ...Please explain what your use case is that makes this
> so prohibitively expensive it needs to be removed.

wake on packet, process packet without turning on the display,
immediately suspend.  Do this potentially several times per second.

>> The user-space utilities s2ram and s2disk choose to invoke sync() today.
>> A user can invoke suspend directly via /sys/power/state to skip that cost.
>
> So, you want to have s2disk write all the dirty pages in memory to
> the suspend image, rather than to the filesystem?

The s2disk utility is unchanged by this proposal, it already includes a sync().

cheers,
Len Brown, Intel Open Source Technology Center
