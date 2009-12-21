From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Asynchronous suspend/resume - test results
Date: Mon, 21 Dec 2009 15:00:56 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0912211456320.21722__36249.7623813853$1261436520$gmane$org@localhost.localdomain>
References: <Pine.LNX.4.44L0.0912211200200.2979-100000@iolanthe.rowland.org>
	<200912212136.12665.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912212136.12665.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 21 Dec 2009, Rafael J. Wysocki wrote:
> 
> Do you think it's a good idea to mark all SCSI devices as async?  Well, for
> testing it probably is, but I doubt in general.

As long as things aren't multi-path, or multi-lun, it's probably fine.

With multi-path (ie same disk reachable multiple ways), it's probably fine 
too, but let's face it, who the hell knows? But it's not going to be an 
issue for laptops and normal desktops.

For multi-lun, I suspect the luns are related, and there might be some 
ordering issues. But it's _likely_ all fine there too.

The nice thing about systems with wires (ie USB, SCSI, SATA) is that it's 
really hard to make different devices have odd dependencies on each other. 
The wires tend to _be_ the topology.

			Linus
