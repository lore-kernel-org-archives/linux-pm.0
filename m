From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: Platform-specific system power states
Date: Sun, 24 Jun 2007 17:10:52 -0700
Message-ID: <200706241710.53494.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0706222130440.11186-100000@netrider.rowland.org>
	<200706232220.06142.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200706232220.06142.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Saturday 23 June 2007, Rafael J. Wysocki wrote:
> On Saturday, 23 June 2007 03:32, Alan Stern wrote:

> > A good way to identify a sleep state would be a pointer to a string 
> > containing the state's name.  The PM core could use these pointers to 
> > export the states in sysfs.
> 
> Well, I thought of exactly the same thing.

There's an echo in the room ...


> Perhaps we can generalize it a bit by defining:
> 
> struct pm_sleep_state {
> 	char *name;
> };

I suppose having the core use only the name would be a bit radical;
but on the other hand, I really like the resulting notion that the
generic code must accordingly know *NOTHING* about the semantics
of any such states.  Having a struct sort of begs that it someday
be expanded.


> and make the platforms give us a NULL-terminated array of such things during
> the initializatiion.

And conceptually "typedef struct pm_sleep_state *suspend_state_t;"?
Though eventually "suspend_state_t" should vanish.

- Dave
