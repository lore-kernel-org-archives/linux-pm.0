From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 13:40:40 +1100
Message-ID: <1234924840.14060.342.camel@pasglop>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<13B9B4C6EF24D648824FF11BE896716203771DD01B@dlee02.ent.ti.com>
	<20090216145948.6fea81c3@infradead.org>
	<200902170019.40599.rjw@sisk.pl>
	<20090216232329.GA15678@srcf.ucam.org>
	<20090217142001.GB12378@bulgaria.corp.google.com>
	<20090217064630.688bf639@infradead.org>
	<20090217152811.GA12686@bulgaria.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090217152811.GA12686@bulgaria.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org


> You will end up with some crappy apps that do really dumb things.
> However, even if they're badly written users may still install and use
> these apps because hey, they do something the user likes.
> 
> >From the Android standpoint, we're trying to balance protecting the
> system from poorly designed apps and somehow letting the user know "hey
> app X is chewing up a lot of power" (work in progress on this).
> 
> While I'd love for every app developer to actively tune their apps for a
> good mobile experience, I am skeptical that this is going to happen.

One idea I've been toying around was to have powertune as some kind of
background thingy, and have it pop an icon in the notification area when
some app seems to behave badly (of course, defining "badly" is hard but
heh...). IE. actively inform the user "this application is sucking the
life out of your battery".

Cheers,
Ben.
