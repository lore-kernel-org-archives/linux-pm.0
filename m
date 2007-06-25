From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm] PM: Introduce set_target method
	=?iso-8859-1?q?in=09pm=5Fops?=
Date: Tue, 26 Jun 2007 00:16:58 +0200
Message-ID: <200706260016.59313.rjw__24165.5380385511$1182809450$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0706231937010.9663-100000@netrider.rowland.org>
	<467FC9DB.3080704@gmail.com> <20070625192808.GA2008@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070625192808.GA2008@elf.ucw.cz>
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
Cc: Len Brown <len.brown@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Monday, 25 June 2007 21:28, Pavel Machek wrote:
> Hi!
> 
> > >>> Right now the states we have are On, Standby, and Suspend, and the CPU
> > >>> runs only in the On state.  But on some platforms there could be
> > >>> multiple states in which the CPU is able to run, albeit with degraded 
> > >>> performance.
> > >> I wouldn't call those system sleep states.  For example, ACPI defines system
> > >> sleep states as the states in which no instructions are executed by any CPUs
> > >> and I think that's reasonable.
> > >
> > > Well, in some cases, we have 200MHz CPU running at 30kHz. ...that's so
> > > slow that it is pretty similar to ACPI sleep state.
> > > 									
> > Pavel,
> > 
> > let's do not mix the things. Rafael gave exact meaning of a sleep state --
> > "no instructions are executed by any CPUs", that, I assume, can be
> > interpreted
> > as "processor does not do any effective job". It does not mean if any clock
> > frequency supplied or not. In some cases the frequency supplied to speed up
> > the wakeup process, but, the processor can't operate on this frequency,
> > so this is a sleep state. But, if the processor can do some job,
> > even if a frequency very very slow, then this is an active mode.
> 
> Well, I'm trying to say that cpu (samsung arm in openmoko?) may be
> able to execute instructions at very very low speed, but that the
> speed is so low, that we should treat it as a sleep state.
> 
> I mean -- you can't use cpufreq to automatically chose between 32kHz
> and 200MHz.
> 
> ...but I guess it is all not too important...

Well, as I've just written to Dave, I think that we can define a 'system sleep
state' as a state that requires the main code path in kernel/power/main.c
(starting from enter_state()) to be executed in order for the system to enter
it.  Arguably, in such a state no useful work will be done by the system.

The other states can be regarded as 'running' or 'On' states.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
