From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 8/9] PCI / ACPI / PM: Platform support for
	PCI PME wake-up (rev. 7)
Date: Wed, 10 Feb 2010 22:42:11 +0100
Message-ID: <201002102242.11088.rjw__45712.6055648134$1265838455$gmane$org@sisk.pl>
References: <201001101431.38630.rjw@sisk.pl> <201002101900.54478.rjw@sisk.pl>
	<20100210203852.GA17115@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100210203852.GA17115@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Gary Hade <garyhade@us.ibm.com>
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Moore,
	Robert" <robert.moore@intel.com>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 February 2010, Gary Hade wrote:
> On Wed, Feb 10, 2010 at 07:00:54PM +0100, Rafael J. Wysocki wrote:
> > On Wednesday 10 February 2010, Gary Hade wrote:
> > > On Wed, Feb 10, 2010 at 02:12:29AM +0100, Rafael J. Wysocki wrote:
> > > > On Wednesday 10 February 2010, Rafael J. Wysocki wrote:
> > > > > On Wednesday 10 February 2010, Gary Hade wrote:
> > > > > > On Tue, Feb 09, 2010 at 12:58:39PM -0800, Gary Hade wrote:
> > > > > ...
> > > > > > > OK.  I already confirmed that the problem reproduces with your
> > > > > > > patches applied.  I am now in the process of trying vanilla
> > > > > > > 2.6.33-rc7.  If hot-add works with 2.6.33-rc7 I will give
> > > > > > > your patch a try.
> > > > > > 
> > > > > > The hot-add worked fine with an unpatched 2.6.33-rc7.
> > > > > 
> > > > > Good.
> > > > > 
> > > > > > The new patch when added to the 2.6.33-rc7 tree that
> > > > > > included the original patchset unfortunately did not
> > > > > > correct the problem.
> > > > > 
> > > > > Bad.
> > > > > 
> > > > > Well, fortunately I have another one, but I haven't tested it myself yet except
> > > > > for checking that it builds.  Hopefully it won't break things more.
> > > > > 
> > > > > The patch below applies on top of 2.6.33-rc7 with my PCI runtime PM patchset
> > > > > applied.  Please test it and let me know the results.
> > > > 
> > > > Sorry, I sent a wrong version of the patch by mistake, it doesn't even build.
> > > > The correct one is appended.
> > > 
> > > No problem.  I received this message before doing anything with
> > > the previous one.
> > > 
> > > Sorry, both hot-add and hot-remove behaviors appear unchanged
> > > with this patch.
> > 
> > Hmm, that's kind of strange.  I'm getting suspicious.
> > 
> > > I would like to dig into the code and help with the debugging
> > > but I am swamped with other things right now.  However, feel 
> > > free to continue using me for testing if you have other ideas
> > > you want me to try.
> > 
> > Thanks, of course I have some ideas. :-)
> > 
> > First, please try to test 2.6.33-rc7 with patches [1/9] - [7/9] applied
> > (ie. without the $subject patch and [9/9]).  Let's make sure we're debugging
> > the right patch.
> 
> It does look like both the hot-add and hot-remove issues were
> introduced by something in 1/9 through 7/9.  I started with a
> clean 2.6.33-rc7 tree and applied only 1/9 through 7/9.  I still
> see that lingering blinking amber LED with hot-remove and no
> response from the driver during hot-add.
> 
> Now I suppose you want me to start reverting 1/9 through 7/9
> in reverse order to find the culprit. :)

Actually, I think [6/9] is the offending one, so please try with [1/9] - [5/9]
applied and if that works, please apply [6/9] and retest to confirm it's the
culprit.

Rafael
