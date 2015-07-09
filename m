From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Thu, 09 Jul 2015 09:32:51 +0200
Message-ID: <1436427171.2530.5.camel@suse.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	 <1522789.fQO6RUUx40@vostro.rjw.lan> <1436341873.5636.5.camel@suse.com>
	 <1850836.6zSgANe26P@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1850836.6zSgANe26P@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2015-07-09 at 00:03 +0200, Rafael J. Wysocki wrote:

> Nothing and I'm not discussing that (I've said that already at least once in
> this thread).
> 
> What I'm questioning is the "why" of calling sys_sync() from the kernel.

That's strictly speaking two questions

1. Why do it in the kernel

That is easy. It closes the window of a race condition.

2. Why do it at all

In essence because the system becomes inactive. For example we say that
data hits the disk after 30s maximum. We cannot meet such a limit unless
we sync.
There are additional issues, such as a system appearing inactive during
suspension and frankly the far greater likelihood of a crash.

	Regards
		Oliver
