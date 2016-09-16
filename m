From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Should drivers like nvme let userspace control their latency
 via dev_pm_qos?
Date: Fri, 16 Sep 2016 16:54:31 +0100
Message-ID: <20160916165431.1f2e6df5@lxorguk.ukuu.org.uk>
References: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:60292 "EHLO
        lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932582AbcIPPz1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Sep 2016 11:55:27 -0400
In-Reply-To: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Christoph Hellwig <hch@lst.de>

On Fri, 16 Sep 2016 08:26:03 -0700
Andy Lutomirski <luto@kernel.org> wrote:

> I'm adding power management to the nvme driver, and I'm exposing
> exactly one knob via sysfs: the maximum permissible latency.  This
> isn't a power domain issue, and it has no dependencies -- it's
> literally just the maximum latency that the driver may impose on I/O
> for power saving purposes.

Why is this in the driver. Surely the latency is a property of the
request queue and the requests being made. Now it may well be that its
implement as min(list-of-queues) but a device sysfs node seems a strange
place to stick it.

Alan
