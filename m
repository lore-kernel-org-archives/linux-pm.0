From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/2] PM: Introduce suspend notifiers
Date: Sun, 22 Apr 2007 18:14:46 +0200
Message-ID: <200704221814.46824.rjw@sisk.pl>
References: <200704220002.37083.rjw@sisk.pl> <200704220007.14028.rjw@sisk.pl>
	<20070422130034.GB4236@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070422130034.GB4236@ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

Hi,

On Sunday, 22 April 2007 15:00, Pavel Machek wrote:
> Hi!
> 
> 
> > Index: linux-2.6.21-rc6-mm1/Documentation/power/suspend-notifiers.txt
> > ===================================================================
> > --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> > +++ linux-2.6.21-rc6-mm1/Documentation/power/suspend-notifiers.txt	2007-04-21 23:24:50.000000000 +0200
> > @@ -0,0 +1,41 @@
> > +Suspend notifiers
> > +	(C) 2007 Rafael J. Wysocki <rjw@sisk.pl>, GPL
> > +
> > +There are some operations that device drivers may want to carry out in their
> > +.suspend() routines, but shouldn't, because they can cause a suspend to fail.
> > +For example, a driver may want to allocate a substantial amount of memory
> > +(like 50 MB) in .suspend(), but that shouldn't be done after the swsusp's memory
> > +shrinker has run.  Also, there may be some operations, that subsystems may want
> > +to carry out before a suspend or after a resume, requiring the system to be
> > +fully functional, so the drivers' .suspend() and .resume() routines are not
> > +suitable for this purpose.
> > +
> > +The subsystems that have such needs can register suspend notifiers that will be
> > +notified of the following events by the suspend core:
> > +
> > +SUSPEND_PREPARE		the system is going to suspend, tasks will be frozen
> > +			immediately
> > +
> > +SUSPEND_ENTER_PREPARE	tasks have been frozen, memory is going to be freed
> > +			and devices are going to be suspended
> > +
> > +SUSPEND_THAW_PREPARE	devices have been resumed, tasks will be thawed
> > +			immediately
> > +
> > +SUSPEND_FINISHED	the resume is complete, the system is fully functional
> 
> + This hook is called even if suspend fails, so that we do not
> + leak memory.
> 
> 
> ?

Yes, I'll add something like this.
