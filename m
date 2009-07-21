From: Deepak Saxena <dsaxena@plexity.net>
Subject: x86: Expected system state when resumed
Date: Tue, 21 Jul 2009 09:45:42 -0700
Message-ID: <20090721164542.GA30390@plexity.net>
Reply-To: dsaxena@plexity.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


I am working on getting suspend/resume working on an x86 system
(OLPC XO-1.5) where we are implementing ACPI based suspend/resume
using Open Firmware and what I am seeing right now is that on 
resume, we're not receiving interrupts so the system locks
up in the suspend path when msleep() is called from the EHCI
HCD resume code. lapic_resume() is being called so the APIC
is being restored.  I'm looking for information on what else
Linux's expectation from the firmware when control is handed back 
before I start dumping every system register pre and post resume.

Thanks,
~Deepak (an ARM person swimming in x86 land)

-- 
In the end, they will not say, "those were dark times,"  they will ask
"why were their poets silent?" - Bertold Brecht
