From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] PCI PM: More refinements of
	suspend-resume framework
Date: Tue, 3 Feb 2009 09:26:02 +0100
Message-ID: <200902030926.03361.rjw__31283.6807840087$1233649835$gmane$org@sisk.pl>
References: <200902012229.27517.rjw@sisk.pl>
	<200902021032.26819.jbarnes@virtuousgeek.org>
	<alpine.LFD.2.00.0902021924270.3247@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902021924270.3247@localhost.localdomain>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 03 February 2009, Linus Torvalds wrote:
> 
> On Mon, 2 Feb 2009, Jesse Barnes wrote:
> > >
> > > The last patch makes the warning in pci_legacy_suspend() more useful.
> > 
> > Linus, do you want these as part of the next pull request?  If so, I'll check 
> > them out, pull them in, and let them run the linux-next build gauntlet for a 
> > day before sending them.  Otherwise I'll just send a pull request today with 
> > the 8 or so fixes I have queued now.
> 
> I want them eventually, but I don't know if we got confirmation that this 
> particular series actually fixed the PCI-E bridge issue? The one that 
> Parag reported.. It would be good to have confirmation. Maybe we do 
> already and I missed that email?

An additional patch against the PCIe port driver will be necessary to fix this
issue, but I'm waiting for feedback from Parag about the patches already
posted to find out what's the minimal fix.

Thanks,
Rafael
