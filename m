From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 01/13] PM: Add wake lock api.
Date: Fri, 13 Feb 2009 19:13:52 +0100
Message-ID: <200902131913.54154.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902131746.42914.u.luckas@road.de>
	<20090213170518.GA29902@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090213170518.GA29902@srcf.ucam.org>
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
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, "ncunningham@crca.org.au" <ncunningham@crca.org.au>
List-Id: linux-pm@vger.kernel.org

On Friday, 13. February 2009, Matthew Garrett wrote:
> On Fri, Feb 13, 2009 at 05:46:42PM +0100, Uli Luckas wrote:
> > That's racy. By the time the daemon notices that a process crashed, the
> > kernel might already have triggered suspend. userspace might then be
> > frozen before it can accuire the 'process restarting' lock.
> > I also wonder, if it is immanently racy to use userspcae communication
> > (client/daemon) for suspend locks. What if the daemon is already frozen
> > when a client sends a lock request request?
>
> The daemon holds the lock in the first place.
When did the daemon take the lock? When it anticipated the process would 
crash?

> There's no race. As for issues with the freezer, I think my position on that
> is fairly well known...
Not to me.

Uli

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
