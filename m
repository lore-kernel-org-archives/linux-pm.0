From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sat, 5 Dec 2009 16:45:41 -0800
Message-ID: <20091205164541.5e0f209a__48837.4330838726$1260060279$gmane$org@infradead.org>
References: <200912052216.19540.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051334461.3649@localhost.localdomain>
	<alpine.LFD.2.00.0912051349000.3649@localhost.localdomain>
	<200912060055.36130.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912060055.36130.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 6 Dec 2009 00:55:36 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> 
> Disk spinup/spindown takes time, but also some ACPI devices resume
> slowly, serio devices do that too and there are surprisingly many
> drivers that wait (using msleep() during suspend and resume).  Apart
> from this, every PCI device going from D0 to D3 during suspend and
> from D3 to D0 during resume requires us to sleep for 10 ms (the
> sleeping is done by the PCI core, so the drivers don't even realize
> its there).

maybe a good step is to make a scripts/bootgraph.pl equivalent for
suspend/resume (or make a debug mode that outputs in a compatible format
so that the script can be used as is.. I don't mind either way, and
consider this my offer to help with such a script as long as there's
sufficient logging in dmesg ;-)

that way we can SEE which ones are an issue.... and by how much.


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
