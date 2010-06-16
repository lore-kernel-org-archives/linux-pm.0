From: Pavel Machek <pavel@ucw.cz>
Subject: Re: idle-test patches queued for upstream
Date: Wed, 16 Jun 2010 09:53:00 +0200
Message-ID: <20100616075259.GA1671__46616.4004909389$1276674958$gmane$org@ucw.cz>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<201005271045.33500.trenn@suse.de>
	<alpine.LFD.2.00.1005272023510.24823@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1005272023510.24823@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu 2010-05-27 20:59:07, Len Brown wrote:
> > > ... we think we can do better than ACPI.
> 
> > Why exactly? Is there any info missing in the ACPI tables?
> > Or is this just to be more independent from OEMs?
> 
> ACPI has a few fundmental flaws here.  One is that it reports
> exit latency instead of break-even power duration.
> The other is that it requires a BIOS writer to
> get the tables right.
> 
> Both of these are fatal flaws.

Intel is co-author of ACPI spec, right? So what about fixing those?
 
> > > Indeed, on my (production level commerically available) Nehalem desktop
> > > the ACPI tables are broken and an ACPI OS idles at 100W.  With this
> > > driver the box idles at 85W.
> 
> > What exactly was broken there?
> 
> Dell's BIOS developer botched a bug fix immediately before the system
> went to market and disabled support for all ACPI C-states except C1.
> After several month of shipping systems, they still were unable
> to ship them with a fixed BIOS.

I always thought that cpu vendors have ways to work with bios manufacturers...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
