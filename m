From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 12 May 2015 08:11:38 +0200
Message-ID: <1431411098.5048.3.camel@suse.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	 <Pine.LNX.4.44L0.1505091556001.5397-100000@netrider.rowland.org>
	 <20150509202518.GB20282@khazad-dum.debian.net>
	 <CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43681 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752354AbbELGM3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 12 May 2015 02:12:29 -0400
In-Reply-To: <CAJvTdKmGFPHtO-rOwXWJr6bPDS4PuEo+g7H-uQhuMc_+kh4CuA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Mon, 2015-05-11 at 16:34 -0400, Len Brown wrote:
> But upon reflection, I do not believe that the kernel is adding value
> here,
> instead it is imposing a policy, and that policy decision is sometimes
> prohibitively expensive.
> User-space can do this for itself (and in the case of desktop distros,
> already does),
> and so the kernel should butt-out.

There is however a race condition with doing it in user space.
So adding a parameter to select behavior would increase safety a bit.

	Regards
		Oliver


