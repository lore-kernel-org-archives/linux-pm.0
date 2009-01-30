From: Uli Luckas <u.luckas@road.de>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Fri, 30 Jan 2009 13:34:02 +0100
Message-ID: <200901301334.03007.u.luckas@road.de>
References: <d6200be20901291716g5b6f4542r54c2ba8672961c91@mail.gmail.com>
	<d6200be20901292040l5f540cf5ybbda03db9627c477@mail.gmail.com>
	<20090130091139.GB7967@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090130091139.GB7967@atrey.karlin.mff.cuni.cz>
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
To: linux-pm@lists.linux-foundation.org
Cc: swetland@google.com, Nigel Cunningham <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Friday, 30. January 2009, Pavel Machek wrote:
> > >> - The user-space input-event thread returns from read. It determines
> > >> that the key should not wake up the system, releases the
> > >> process-input-events wakelock and calls select or poll.
> > >
> > > This makes no sense.  If the system wasn't asleep to begin with, how
> > > could the key wake it up?  And if the system _was_ asleep to begin
> > > with, how could all of this happen without waking the system up?
> >
> > What I mean here is that the screen turns on and the system does not
> > immediately go back to sleep. The user-space framework has its own
> > idea of whether the system is awake or not. I can change this to
> > "fully wake up" or "turn on the screen".
>
> "turn on the screen", please. (But I still don't quite get it; screen
> should be at full control of userspace, so why is kernel interaction
> needed?) Pavel
>
Turning on the screen is only on thing userspace can do. What exactly happens 
is beyon the scope of the kernel interface.
The right term is probably something like "break out of auto-suspend" or "wake 
from auto suspend".
 

-- 

------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
