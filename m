From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 linux-next 2/2] cpufreq: Convert the
 cpufreq_driver_lock to use the rcu
Date: Tue, 12 Feb 2013 07:59:54 -0800
Message-ID: <20130212155954.GP2666@linux.vnet.ibm.com>
References: <74F10842A85F514CA8D8C487E74474BB2D2F925E@P-EXMB1-DC21.corp.sgi.com>
 <16615226.2vj4EkkIZJ@vostro.rjw.lan>
 <74F10842A85F514CA8D8C487E74474BB2D30DC9E@P-EXMB1-DC21.corp.sgi.com>
 <1953281.cgEiiBGo0f@vostro.rjw.lan>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1953281.cgEiiBGo0f@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nathan Zimmer <nzimmer@sgi.com>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Feb 11, 2013 at 08:36:17PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 11, 2013 05:13:30 PM Nathan Zimmer wrote:
> > There are some spots that I need to give a much deeper review, cpufreq_register_driver for example.
> > 
> > But I believe 
> > > @@ -196,7 +195,7 @@ static void __cpufreq_cpu_put(struct cpufreq_policy *data, bool sysfs)
> > >  {
> > >       if (!sysfs)
> > >               kobject_put(&data->kobj);
> > > -     module_put(cpufreq_driver->owner);
> > > +     module_put(rcu_dereference(cpufreq_driver)->owner);
> > >  }
> > would be ok.  In the documentation whatisRCU.txt they give a very similar example.
> 
> Well, the very same document states the following:
> 
>         Note that the value returned by rcu_dereference() is valid
>         only within the enclosing RCU read-side critical section.

Ah, there is a code sample in that document showing a bug.  I added
comments to the code sample making it clear even to someone skimming
the document that the code is buggy.

							Thanx, Paul
------------------------------------------------------------------------

rcu: Make bugginess of code sample more evident

One of the code samples in whatisRCU.txt shows a bug, but someone scanning
the document quickly might mistake it for a valid use of RCU.  Add some
screaming comments to help keep speed-readers on track.

Reported-by: Nathan Zimmer <nzimmer@sgi.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/Documentation/RCU/whatisRCU.txt b/Documentation/RCU/whatisRCU.txt
index 0cc7820..10df0b8 100644
--- a/Documentation/RCU/whatisRCU.txt
+++ b/Documentation/RCU/whatisRCU.txt
@@ -265,9 +265,9 @@ rcu_dereference()
 		rcu_read_lock();
 		p = rcu_dereference(head.next);
 		rcu_read_unlock();
-		x = p->address;
+		x = p->address;	/* BUG!!! */
 		rcu_read_lock();
-		y = p->data;
+		y = p->data;	/* BUG!!! */
 		rcu_read_unlock();
 
 	Holding a reference from one RCU read-side critical section
