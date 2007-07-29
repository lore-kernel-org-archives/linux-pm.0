From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] Introduce CONFIG_HIBERNATION and
	CONFIG_SUSPEND (updated)
Date: Sun, 29 Jul 2007 23:23:28 +0200
Message-ID: <200707292323.29601.rjw__27559.6324042001$1185744150$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<alpine.LFD.0.999.0707281130110.3442@woody.linux-foundation.org>
	<200707291220.14880.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707291220.14880.rjw@sisk.pl>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: david@lang.hm, Nigel Cunningham <nigel@nigel.suspend2.net>, linux-kernel@vger.kernel.org, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, Stefan Richter <stefanr@s5r6.in-berlin.de>, Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 29 July 2007 12:20, Rafael J. Wysocki wrote:
> On Saturday, 28 July 2007 20:31, Linus Torvalds wrote:
> > 
> > On Sat, 28 Jul 2007, Rafael J. Wysocki wrote:
> > > 
> > > OK, I'll prepare a patch to introduce CONFIG_SUSPEND, but that will require
> > > quite a bit of (compilation) testing on different architectures.
> > 
> > Sure. I'm not too worried, the fallout should be of the trivial kind. 
> >
> > Also, mind basing it on the (independent) cleanups that Adrian already 
> > sent out. This is all intertwined..
> 
> OK, it took more time than I had hoped, but I wanted CONFIG_HIBERNATION and
> CONFIG_SUSPEND to be really independent of each other.
> 
> The two patches in the next messages implement the idea:
> * replace CONFIG_SOFTWARE_SUSPEND with CONFIG_HIBERNATION
> * introduce CONFIG_SUSPEND that selects CONFIG_HOTPLUG_CPU, if necessary,
>   and make it possible to choose suspend and hibernation independently of each
>   other.

Unfortunately, the patches that I have posted are against 2.6.23-rc1 with the
suspend and hibernation patchset applied
(http://www.sisk.pl/kernel/hibernation_and_suspend/2.6.23-rc1/patches/) .

Sorry for that.

The corresponding patches on top of the current -git are in the next two
messages.

They do the following:
* replace CONFIG_SOFTWARE_SUSPEND with CONFIG_HIBERNATION
* introduce CONFIG_SUSPEND that selects CONFIG_HOTPLUG_CPU, if necessary,
  and make it possible to choose suspend and hibernation independently of each
  other
* update the top-level PM-related headers and the ACPI code related to suspend
  and hibernation to use the new definitions

Greetings,
Rafael
