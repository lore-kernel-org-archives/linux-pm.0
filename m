From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 09:48:04 -0800
Message-ID: <200902180948.06039.jbarnes__47456.0720533647$1234979537$gmane$org@virtuousgeek.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<20090217152811.GA12686@bulgaria.corp.google.com>
	<1234924840.14060.342.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1234924840.14060.342.camel@pasglop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Brian Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, February 17, 2009 6:40 pm Benjamin Herrenschmidt wrote:
> > You will end up with some crappy apps that do really dumb things.
> > However, even if they're badly written users may still install and use
> > these apps because hey, they do something the user likes.
> >
> > >From the Android standpoint, we're trying to balance protecting the
> >
> > system from poorly designed apps and somehow letting the user know "hey
> > app X is chewing up a lot of power" (work in progress on this).
> >
> > While I'd love for every app developer to actively tune their apps for a
> > good mobile experience, I am skeptical that this is going to happen.
>
> One idea I've been toying around was to have powertune as some kind of
> background thingy, and have it pop an icon in the notification area when
> some app seems to behave badly (of course, defining "badly" is hard but
> heh...). IE. actively inform the user "this application is sucking the
> life out of your battery".

I think "powernag" would be a better name, and it would probably work pretty 
well.  Users would be notified that certain apps should probably be shut down 
while they're on battery, and nag the authors to fix it.

-- 
Jesse Barnes, Intel Open Source Technology Center
