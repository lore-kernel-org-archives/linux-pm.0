From: Brian Swetland <swetland@google.com>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 06:14:34 -0800
Message-ID: <20090217141434.GA12378@bulgaria.corp.google.com>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
	<20090216231324.GA15435@srcf.ucam.org>
	<20090216232259.GK1370@ucw.cz>
	<20090216232619.GB15678@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090216232619.GB15678@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

[Matthew Garrett <mjg59@srcf.ucam.org>]
> On Tue, Feb 17, 2009 at 12:22:59AM +0100, Pavel Machek wrote:
> > On Mon 2009-02-16 23:13:24, Matthew Garrett wrote:
> > > Meanwhile, on embedded it's becoming a less interesting problem because 
> > > idle and suspended are often now equivalent states. 
> > 
> > Android people tell us otherwise.
> 
> https://lists.linux-foundation.org/pipermail/linux-pm/2009-January/019493.html 
> says that they're the same on their current platform.

Well on the Qualcomm MSM72xx SoCs, yeah they're pretty similar -- we can
reasonably enter power collapse (full shutdown of the ARM11 and
peripherals) from idle.  But this is not (to my knowledge) true of *all*
SoCs out there.  Also, resuming from this state can take 5-30ms
(depending on how distracted the baseband processor is by what's going
on on the network).

Brian
