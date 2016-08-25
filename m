From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result
        pointer
Date: Thu, 25 Aug 2016 10:27:27 +0200
Message-ID: <20160825082727.GA20497@lst.de>
References: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org> <20160825073810.GA18622@lst.de> <CALCETrWsJCwO6D9=LsYOV5ghbXMc_MdOYgXm1qzarJ1-cizuXw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from verein.lst.de ([213.95.11.211]:42851 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1758114AbcHYI13 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 25 Aug 2016 04:27:29 -0400
Content-Disposition: inline
In-Reply-To: <CALCETrWsJCwO6D9=LsYOV5ghbXMc_MdOYgXm1qzarJ1-cizuXw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christoph Hellwig <hch@lst.de>, Andy Lutomirski <luto@kernel.org>, Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-pm@vger.kernel.org

On Thu, Aug 25, 2016 at 12:54:00AM -0700, Andy Lutomirski wrote:
> I am, and I have a patch to do the former (and to add a length
> argument).  But that's not -stable material.

Great!

> While I have your attention: the new use is to enable APST (power
> saving).  In theory, it seems like I should integrate with dev_pm_qos
> so that the standard interface for setting a latency limit will work,
> but, on brief inspection, there are literally no drivers in the entire
> tree that do this.  Am I missing something?  My current draft patch
> just adds a sysfs attribute.  (It saves a *lot* of power on my laptop,
> so supporting APST is worth doing.)

I'm proably the wrong person to talk about PM interfaces, but not
having it used anywhere is a red herring and needs a ping to the PM
folks why we even have that code in the tree.

Integrating it with the PM core would be preferable, but until that
happens we should just enable it by default in the nvme driver and
have a local tweak (sysfs file, or maybe even just a run-time writeable
module parameter) to turn it off.
