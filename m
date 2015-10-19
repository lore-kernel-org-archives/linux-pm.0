From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] Fix cpupower reporting uninitialized values for offline
 cpus
Date: Mon, 19 Oct 2015 11:45:58 -0400
Message-ID: <56251036.30309@redhat.com>
References: <1443726584-18709-1-git-send-email-jtanenba@redhat.com> <9276359.hpYRDABKuX@skinner> <5624F295.3070101@redhat.com> <2009729.RxmnnDn8cy@skinner>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46250 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544AbbJSPp7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 19 Oct 2015 11:45:59 -0400
In-Reply-To: <2009729.RxmnnDn8cy@skinner>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>, Jacob Tanenbaum <jtanenba@redhat.com>
Cc: linux-pm@vger.kernel.org



On 10/19/2015 11:39 AM, Thomas Renninger wrote:
> The idea is: physical_package_id and core_id always must be
> there, right? Not sure for other architectures, but what I see
> this is at least the case for x86.

Thomas ... FYI I just posted

http://marc.info/?l=linux-kernel&m=144526707105245&w=2

I've cc'd you directly on them.

P.
