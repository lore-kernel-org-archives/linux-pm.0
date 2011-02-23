From: Ian Campbell <Ian.Campbell@eu.citrix.com>
Subject: Re: [Xen-devel] Re: [PATCH] xen: fix XEN_SAVE_RESTORE
 Kconfig dependencies
Date: Wed, 23 Feb 2011 11:10:02 +0000
Message-ID: <1298459402.16356.10779.camel__26022.236623294$1298459456$gmane$org@zakaz.uk.xensource.com>
References: <1298446066-11754-1-git-send-email-rshriram@cs.ubc.ca>
	<1298452123.16356.10537.camel@zakaz.uk.xensource.com>
	<4D64F681020000780003347D@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D64F681020000780003347D@vpn.id2.novell.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jan Beulich <JBeulich@novell.com>
Cc: Shriram Rajagopalan <rshriram@cs.ubc.ca>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2011-02-23 at 10:58 +0000, Jan Beulich wrote:
> >>> On 23.02.11 at 10:08, Ian Campbell <Ian.Campbell@eu.citrix.com> wrote:
> > On Wed, 2011-02-23 at 07:27 +0000, Shriram Rajagopalan wrote:
> >> Make XEN_SAVE_RESTORE user visible and enable HIBERNATION and SWAP,
> >> if this option is enabled.
> > 
> > I was under the (perhaps mistaken?) impression that selecting user
> > visible Kconfig symbols was verboten since it has side-effects which
> > make it hard for users to figure out why something cannot be switched
> > off and/or how to turn things on etc.
> > 
> > In any case I think I preferred the "depends HIBERNATION" idea -- I
> > thought that was the consensus of the thread too?
> 
> Why HIBERNATION (and SWAP) instead of SUSPEND? Xen doesn't
> support the former (other than the latter)...

HIBERNATION provides the FREEZE, THAW and RESUME methods which we would
like to use to integrate save/restore/checkpoint with the PM core i.e.
choose THAW vs. RESUME based on whether the suspend was cancelled (aka a
checkpoint) or not. See Shriram's other recent patch for details.

Ian.
