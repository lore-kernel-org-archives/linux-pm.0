From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFD] Automatic suspend
Date: Wed, 18 Feb 2009 17:52:44 +0000
Message-ID: <20090218175244.GA19235__26368.6789935038$1234979817$gmane$org@srcf.ucam.org>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<20090217152811.GA12686@bulgaria.corp.google.com>
	<1234924840.14060.342.camel@pasglop>
	<200902180948.06039.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902180948.06039.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Kyle Moffett <kyle@moffetthome.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 18, 2009 at 09:48:04AM -0800, Jesse Barnes wrote:

> I think "powernag" would be a better name, and it would probably work pretty 
> well.  Users would be notified that certain apps should probably be shut down 
> while they're on battery, and nag the authors to fix it.

How do you usefully tell the difference between an application that's 
waking up a lot because it's dumb and an application that's waking up a 
lot because it's doing something useful? One downside of powertop is 
that it's resulted in a lot of "How do I reduce the number of wakeups 
caused by i8042 whenever I use the mouse"-type questions. We don't want 
innocent app writers to be hit by this kind of thing.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
