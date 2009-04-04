From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Warn if interrupts are enabled
	during suspend-resume of sysdevs
Date: Sun, 5 Apr 2009 00:10:26 +0200
Message-ID: <200904050010.26855.rjw__8630.35953739217$1238883216$gmane$org@sisk.pl>
References: <200904042323.19866.rjw@sisk.pl>
	<200904050003.33609.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200904050003.33609.elendil@planet.nl>
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
To: Frans Pop <elendil@planet.nl>
Cc: linux-pm@lists.linux-foundation.org, mingo@elte.hu, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday 05 April 2009, Frans Pop wrote:
> > @@ -377,6 +381,9 @@ int sysdev_suspend(pm_message_t state)
> >         if (ret)
> >                 return ret;
> >  
> > +       WARN_ONCE(!irqs_disabled(),
> > +               "Interrupts enabled while suspending system devices");
> > +
> 
> Missing \n ?
> 
> > @@ -452,6 +465,9 @@ int sysdev_resume(void)
> >  {
> >         struct sysdev_class *cls;
> >  
> > +       WARN_ONCE(!irqs_disabled(),
> > +               "Interrupts enabled while resuming system devices");
> > +
> 
> Again.

Yes, thank.

Rafael
