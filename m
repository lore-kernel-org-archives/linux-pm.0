From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFD] Automatic suspend
Date: Thu, 19 Feb 2009 09:05:07 +1100
Message-ID: <1234994707.14060.466.camel@pasglop>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<20090217152811.GA12686@bulgaria.corp.google.com>
	<1234924840.14060.342.camel@pasglop>
	<200902180948.06039.jbarnes@virtuousgeek.org>
	<20090218175244.GA19235@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090218175244.GA19235@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Brian Swetland <swetland@google.com>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2009-02-18 at 17:52 +0000, Matthew Garrett wrote:
> On Wed, Feb 18, 2009 at 09:48:04AM -0800, Jesse Barnes wrote:
> 
> > I think "powernag" would be a better name, and it would probably work pretty 
> > well.  Users would be notified that certain apps should probably be shut down 
> > while they're on battery, and nag the authors to fix it.
> 
> How do you usefully tell the difference between an application that's 
> waking up a lot because it's dumb and an application that's waking up a 
> lot because it's doing something useful? One downside of powertop is 
> that it's resulted in a lot of "How do I reduce the number of wakeups 
> caused by i8042 whenever I use the mouse"-type questions. We don't want 
> innocent app writers to be hit by this kind of thing.

Which is why nagging might not be the best thing... One thing I quite
liked was something i had on MacOS 9 which was a watt-meter. I could
basically see at any time what my consumption was. If the needle wasn't
all the way to the left while I was expecting it to, I would dig for
the culprit.

Maybe we can try to do something similar, and when clicking on it,
you get an ordered list of apps from the biggest consumer down).

The main problem of course is for that "meter" to work, one need to have
an idea of what min and max are on a given machine... Absolute watt
numbers or things like that are a lot less telling to Joe average.

Cheers,
Ben.
