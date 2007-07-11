From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Re: Hibernate after alarm wakes from STR
Date: Wed, 11 Jul 2007 02:23:02 +0100
Message-ID: <20070711012301.GA30596__18918.8018245206$1184117041$gmane$org@srcf.ucam.org>
References: <20070330235759.GC4252@cosmic.amd.com>
	<200707110816.42114.nigel@nigel.suspend2.net>
	<20070711004549.GA30249@srcf.ucam.org>
	<200707111053.36590.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707111053.36590.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: rtc-linux@googlegroups.com, Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 11, 2007 at 10:53:35AM +1000, Nigel Cunningham wrote:
> On Wednesday 11 July 2007 10:45:50 Matthew Garrett wrote:
> > How are you going to shift into suspend to disk without going via 
> > userspace? It's quite plausible that people will want different 
> > configuration at that point (or, realistically, need a different set of 
> > workarounds...)
> 
> This is done after writing the image, from kernel space. We do the 
> suspend-to-ram, and if/when we wake from that, we look at the lid switch 
> state before removing the image. If it's still closed, the kernel code powers 
> down again (this time properly) without userspace ever seeing the light of 
> day.

Yes. I'm sort of struggling to see how this is done especially reliably 
- if we have separate hibernation and suspend to ram pathways, which is 
executed in this scenario?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
