From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 4/8] ACPI: Use GPE reference counting to
 support shared GPEs
Date: Wed, 24 Feb 2010 14:26:12 -0800
Message-ID: <20100224142612.772e4bcc__14326.8643100329$1267050439$gmane$org@jbarnes-piketon>
References: <4911F71203A09E4D9981D27F9D83085859958760@orsmsx503.amr.corp.intel.com>
	<201002200018.02700.rjw@sisk.pl>
	<20100222162622.3d9c684a@jbarnes-piketon>
	<201002240052.08098.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002240052.08098.rjw@sisk.pl>
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
Cc: "Brown, Len" <len.brown@intel.com>, "Lin, Ming M" <ming.m.lin@intel.com>, Linux PCI <linux-pci@vger.kernel.org>, "Moore,
	Robert" <robert.moore@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 24 Feb 2010 00:52:08 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Tuesday 23 February 2010, Jesse Barnes wrote:
> > On Sat, 20 Feb 2010 00:18:02 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > > [Sorry for resending, tried to restore the CC list.]
> > > 
> > > On Friday 19 February 2010, Moore, Robert wrote:
> > > > 
> > > > Here's some comments and questions on the GPE changes in ACPICA.
> > > > Overall, looks good.
> > > 
> > > First of all, thanks a lot for the review.
> > 
> > I missed this one when applying the series, can you resend as an
> > incremental patch on top of linux-next?
> 
> Sure, appended.
> 
> Please note that it also fixes a bug I found earlier today.
> 
> I added a changelog in case you want to apply it as a separate patch.

Applied, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
