From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Regression] Hibernation failure on dual core Athlon
	64 (64-bit)
Date: Tue, 4 Aug 2009 18:27:37 +0200
Message-ID: <200908041827.38547.rjw__19767.4613250003$1249403301$gmane$org@sisk.pl>
References: <200908032303.57859.rjw@sisk.pl> <20090803222359.GA3770@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090803222359.GA3770@Krystal>
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
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 August 2009, Mathieu Desnoyers wrote:
> * Rafael J. Wysocki (rjw@sisk.pl) wrote:
> > Hi Mathieu,
> > 
> > As reported at
> > 
> > http://bugzilla.kernel.org/show_bug.cgi?id=13903
> > 
> > one of my test systems suffers from a hibernation regression where the second
> > attempt to hibernate in a row makes it hang solid right before creating the
> > image.
> > 
> > Bisection turned up your commit 3f4a782b5ce2698b1870b5a7b573cd721d4fce33
> > ([CPUFREQ] fix (utter) cpufreq_add_dev mess) as the first bad one.
> > 
> 
> Can you try with the following patch applied ?
>
> http://www.spinics.net/lists/cpufreq/msg00964.html
>
> Subject: [PATCH 1/5] CPUFREQ: Fix a kobject reference bug related to managed CPUs
> From: Thomas Renninger <trenn@suse.de>

Tested (/me hates mailing list archives where you can't download raw messages
or at least raw patches) and it works.
 
Thanks a lot,
Rafael
