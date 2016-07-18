From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: Kernel stability on baytrail machines
Date: Mon, 18 Jul 2016 14:30:03 +0100
Message-ID: <20160718143003.3477c0bc@lxorguk.ukuu.org.uk>
References: <606d9b223f3c12775d108b98c4df72ae@feix.cz>
	<20160409160119.GA19362@xo-6d-61-c0.localdomain>
	<20160409201417.4436d4bd@lxorguk.ukuu.org.uk>
	<20160712194158.GA4834@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50598 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcGRNaT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 18 Jul 2016 09:30:19 -0400
In-Reply-To: <20160712194158.GA4834@laptop>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc: Pavel Machek <pavel@ucw.cz>, Michal Feix <michal@feix.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org

On Tue, 12 Jul 2016 16:41:58 -0300
Ezequiel Garcia <ezequiel@vanguardiasur.com.ar> wrote:

> Hi Alan,
> 
> (Adding interested people to this thread)
> 
> On 09 Apr 08:14 PM, One Thousand Gnomes wrote:
> > > > I do feel that the importance of the mentioned bug is currently
> > > > underestimated. Can anyone here give a note, how much current linux
> > > > kernel is supposed to be stable on general baytrail machines?    
> > > 
> > > If you did not get any replies... you might want to check MAINTAINERS file, and
> > > put Intel x86 maintainers on Cc list.
> > > 
> > > I'm sure someone cares :-).  
> > 
> > Yes we care, and there are people looking at the various reports.
> >   
> 
> Are there any updates on the status of this issue?
> 
> The current bugzilla report [1] marks this as a power management
> issue. However, many reports indicate that it would only freeze
> when running X, so it's not completely clear if it's related to
> the gfx driver too.

There are two things we are currently tracking. One of them was merged
which seems to have made my machine stable at least and fixes a problem
related to the MMC. The second one we may need is a power related changed
to SPI to hold the CPU in C0/C1 whenever the ACPI _SEM is held.

Graphics shows these problems up because of the way the GPU causes power
state changes.

Alan
