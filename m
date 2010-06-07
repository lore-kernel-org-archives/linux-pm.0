From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] [RFC] Save/restore MISC_ENABLE register
Date: Mon, 7 Jun 2010 17:09:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1006071708040.18836-100000__6905.26332841745$1275945006$gmane$org@iolanthe.rowland.org>
References: <201006072305.54829.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006072305.54829.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 7 Jun 2010, Rafael J. Wysocki wrote:

> On Monday 07 June 2010, H. Peter Anvin wrote:
> > On 06/07/2010 11:51 AM, Ondrej Zary wrote:
> > > 
> > > Something like this?
> > > 
> > > Save/restore MISC_ENABLE register on suspend/resume.
> > > This fixes OOPS (invalid opcode) on resume from STR on Asus P4P800-VM, which
> > > wakes up with MWAIT disabled.
> > > 
> > > Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> > > 
> > 
> > Yes, that's a lot better.
> > 
> > I presume you have tested it.  Rafael, do you want to take this or should I?
> 
> I can take it.  Is it OK to add your ACK?

You might in addition want to note that this patch fixes Bugzilla 
#15385.

Alan Stern
