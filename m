From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC]runtime pm:what does the runtime_usage really mean?
Date: Thu, 18 Apr 2013 11:04:34 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1304181103141.1525-100000@iolanthe.rowland.org>
References: <CACbbJyZbk_SEF2g5GrK5kWSPF9r-THc-TQgZg7c6tiHCE1geMQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60519 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S965506Ab3DRPEf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 11:04:35 -0400
In-Reply-To: <CACbbJyZbk_SEF2g5GrK5kWSPF9r-THc-TQgZg7c6tiHCE1geMQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ren zhen <darwin.xupt@gmail.com>
Cc: linux-pm@vger.kernel.org

On Thu, 18 Apr 2013, ren zhen wrote:

> 'runtime_usage' is an attribution of device power, which appears in
> /sys/devices/.../power/ directory.
> 
> On Thu, Apr 18, 2013 at 4:18 PM, ren zhen <darwin.xupt@gmail.com> wrote:
> > Hi all:
> >        The power management maillist says:
> >                  " runtime_usage: the runtime PM usage count of a device".
> >         What does 'runtime_usage' really mean? what situations should
> > we use it? And when increase it or decrease it?
> >          Anyone who know about that, please give me a detailed account
> > of 'runtime_usage', a actual example cannot be more better!
> >        I will appreciate any help.

See Documentation/power/runtime_pm.txt.  That file calls it 
"usage_count" or "usage counter".

Alan Stern

