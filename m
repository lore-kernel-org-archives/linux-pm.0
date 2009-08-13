From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hibernate causes nobody cared on acpi irq
Date: Thu, 13 Aug 2009 22:20:01 +0200
Message-ID: <200908132220.01334.rjw__20951.6311101199$1250196365$gmane$org@sisk.pl>
References: <4A833CAD.5050209@gmail.com> <200908130021.34378.rjw@sisk.pl>
	<4A846F04.9050005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4A846F04.9050005@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 13 August 2009, Jiri Slaby wrote:
> On 08/13/2009 12:21 AM, Rafael J. Wysocki wrote:
> > On Thursday 13 August 2009, Jiri Slaby wrote:
> >> with current mmotm I get this while trying to hibernate from a system in
> >> qemu:
> > 
> > Does it trigger with the "core" test:
> 
> Yes, but I found out it's totally unrelated to the susp code. There is
> an interrupt storm on IRQ9 after system boot -- 150000 intrs on both
> CPUs in the first minute. Then the message emerges.
> 
> It's just a coincidence it appears during hibernation (after interrupts
> enable phase).
> 
> Any idea what it could be?

Well, nothing obvious comes to mind.

Rafael
