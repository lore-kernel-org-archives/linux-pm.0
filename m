From: Oliver Neukum <oliver@neukum.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Fri, 6 Jul 2007 11:31:07 +0200
Message-ID: <200707061131.08475.oliver__17154.3427547023$1183714321$gmane$org@neukum.org>
References: <Pine.LNX.4.44L0.0707051713440.2753-100000@iolanthe.rowland.org>
	<200707060913.24131.rjw@sisk.pl>
	<1183712354.3388.126.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1183712354.3388.126.camel@localhost.localdomain>
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
Cc: mjg59@srcf.ucam.org, Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org, pavel@ucw.cz, johannes@sipsolutions.net, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 6. Juli 2007 schrieb Benjamin Herrenschmidt:
> On Fri, 2007-07-06 at 09:13 +0200, Rafael J. Wysocki wrote:
> > 
> > The only reason (I know of) why we don't handle uninterruptible tasks in the
> > freezer is that we're afraid of the suspend process deadlocking with an
> > uninterruptible task holding a lock, but AFAICS the probability of such an
> > event is extremely small.
> 
> What would deadlock specifically ? One of the drivers trying to acquire
> that lock ? It would be a driver bug then.

Your driver's write method looks like:

mutex_lock();
poke_some_hardware();
wait_event_uninterruptible(); //for result
res = evaluate_result();
mutex_unlock();
return res;

If you put a task into the refrigerator at wait_event_interruptible()
you will deadlock if you need this lock for the driver to go to suspend.
The suspend method then must not take the lock _and_ it must be
aware that there may be an ongoing operation.

	Regards
		Oliver
