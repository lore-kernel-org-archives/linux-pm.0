From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sat, 5 Dec 2009 17:50:10 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912051745590.3560__10015.4992462651$1260064266$gmane$org@localhost.localdomain>
References: <200912052216.19540.rjw@sisk.pl> <200912060129.19245.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051648520.3560@localhost.localdomain>
	<200912060224.37752.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912060224.37752.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Sun, 6 Dec 2009, Rafael J. Wysocki wrote:
> 
> > Multi-function PCI devices commonly share registers - they're on the same
> > chip, after all.  And even when the _hardware_ is totally independent, we
> > often have discovery rules and want to initialize in order because different
> > drivers  will do things like unregister entirely on suspend, and then
> > re-register on resume.
> 
> Do any of the PCI drivers do that?

It used to be common at least for ethernet - there were a number of 
drivers that essentially did the same thing on suspend/resume and on 
module unload/reload.

The point is, I don't know. And neither do you. It's much safer to just do 
drivers one by one, and not touch drivers that people don't test.

			Linus
