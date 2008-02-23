From: Soeren Sonnenburg <kernel@nn7.de>
Subject: Re: 2.6.25-rc2 regression - hang on suspend
Date: Sat, 23 Feb 2008 08:38:38 +0100
Message-ID: <1203752318.4498.1.camel__11732.8881788582$1203752430$gmane$org@localhost>
References: <1203422386.10992.2.camel@localhost>
	<200802220006.39130.rjw@sisk.pl> <1203663628.8422.2.camel@localhost>
	<200802221656.28546.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802221656.28546.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 2008-02-22 at 16:56 +0100, Rafael J. Wysocki wrote:
> On Friday, 22 of February 2008, Soeren Sonnenburg wrote:
> > On Fri, 2008-02-22 at 00:06 +0100, Rafael J. Wysocki wrote: 
> > > On Thursday, 21 of February 2008, Soeren Sonnenburg wrote:
> > > > On Thu, 2008-02-21 at 01:31 +0100, Rafael J. Wysocki wrote:
> > > > > On Wednesday, 20 of February 2008, Soeren Sonnenburg wrote:
> > > > > > On Wed, 2008-02-20 at 00:50 +0100, Rafael J. Wysocki wrote:
> > [...] 
> > Also when compiling these many kernels via make -j4 I noted that I could
> > hardly move the mouse / use the keyboard, but saw random jumps and
> > key-repetitions...
> 
> This last bit is most likely a scheduler issue.  Do you have CONFIG_GROUP_SCHED
> set by chance?  If you do, please try to unset it and see if that helps.

Yes I had. Disabling this helped a lot -- the kernel seems to behave
normally with this option unset.

Soeren
