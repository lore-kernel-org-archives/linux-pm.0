From: Len Brown <lenb@kernel.org>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Wed, 27 May 2009 14:26:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0905271411570.4277__27503.2487967566$1243452560$gmane$org@localhost.localdomain>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905260039.43626.rjw@sisk.pl>
	<1243298374.16743.161.camel@nigel-laptop>
	<200905270027.41898.rjw@sisk.pl>
	<1243382551.13930.109.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1243382551.13930.109.camel@nigel-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <nigel@tuxonice.net>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > > The possibilities I see are:
> > > 
> > > 1) Assume we can't know exactly how much but can allow a ball-park
> > > figure (current method)
> > > 2) Implement a means by which components that might allocate memory can
> > > tell us how much they might allocate (currently used internally by
> > > tuxonice - part of the modular design). I'd love to see this for the
> > > drivers' suspend code.
> > 
> > The drivers' suspend code is too late, we need to know that before the drivers'
> > suspend callbacks are run.
> 
> Yeah, sorry for not being clear enough. I meant I'd like to see a new
> function in the API that lets us enquire early on as to how much memory
> will be needed. That said, I like the idea of just asking them to
> allocate memory earlier better.

The more we require of driver writers, the more likely it is that
they'll get it wrong and we will fail.

I believe it must remain a fundamental design goal that
the correctness burden on driver writers be as small as possible.

Of couse if optional hooks are availalble for an unusual driver that has
special requirements, that is fine, as long as unusual really is unusual.

thanks,
Len Brown, Intel Open Source Technology Center
