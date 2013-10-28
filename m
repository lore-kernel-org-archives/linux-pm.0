From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: kernels 3.9.5 to 3.10.6 fail to boot on battery, vaio vgn-c2m/w
Date: Mon, 28 Oct 2013 10:33:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1310281033090.1246-100000@iolanthe.rowland.org>
References: <CAL3-7MrExuRWc-ugzU4c4y-trQaCfO_UU2c6tt+P4-8fwiWmUg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:60323 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756595Ab3J1Od4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2013 10:33:56 -0400
In-Reply-To: <CAL3-7MrExuRWc-ugzU4c4y-trQaCfO_UU2c6tt+P4-8fwiWmUg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ian Malone <ibmalone@gmail.com>
Cc: linux-pm@vger.kernel.org

On Sun, 27 Oct 2013, Ian Malone wrote:

> Hi,
> 
> Is there anything I can do that will help to resolve this bug?
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=60770
> >
> 
> Quick summary: removal of idle=mwait has led to laptop failing to boot
> on battery. Only known workaround so far is to use idle=poll which
> drains battery at an amazing rate.

You can try bringing this to the attention of the person who wrote the 
commit removing idle=mwait.

Alan Stern

