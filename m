From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/2] Introduce CONFIG_HIBERNATION and
	CONFIG_SUSPEND (was: CONFIG_SUSPEND?)
Date: Sun, 29 Jul 2007 12:20:13 +0200
Message-ID: <200707291220.14880.rjw__44082.0719850764$1185711869$gmane$org@sisk.pl>
References: <200707251238.50218.lenb@kernel.org>
	<200707282029.03563.rjw@sisk.pl>
	<alpine.LFD.0.999.0707281130110.3442@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0707281130110.3442@woody.linux-foundation.org>
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

On Saturday, 28 July 2007 20:31, Linus Torvalds wrote:
> 
> On Sat, 28 Jul 2007, Rafael J. Wysocki wrote:
> > 
> > OK, I'll prepare a patch to introduce CONFIG_SUSPEND, but that will require
> > quite a bit of (compilation) testing on different architectures.
> 
> Sure. I'm not too worried, the fallout should be of the trivial kind. 
>
> Also, mind basing it on the (independent) cleanups that Adrian already 
> sent out. This is all intertwined..

OK, it took more time than I had hoped, but I wanted CONFIG_HIBERNATION and
CONFIG_SUSPEND to be really independent of each other.

The two patches in the next messages implement the idea:
* replace CONFIG_SOFTWARE_SUSPEND with CONFIG_HIBERNATION
* introduce CONFIG_SUSPEND that selects CONFIG_HOTPLUG_CPU, if necessary,
  and make it possible to choose suspend and hibernation independently of each
  other.

Greetings,
Rafael
