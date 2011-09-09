From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: LPC 2011 Power Management Session notes
Date: Fri, 9 Sep 2011 17:50:06 +0100
Message-ID: <20110909165006.GB4302@sirena.org.uk>
References: <alpine.DEB.2.00.1109081827360.17022@utopia.booyaka.com>
	<CAORVsuWKd9uvTTNCr_k9W6DeA+z3ZEaD99bqit++4xUy9zqKSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAORVsuWKd9uvTTNCr_k9W6DeA+z3ZEaD99bqit++4xUy9zqKSQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-pm@lists.linuxfoundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, Sep 09, 2011 at 10:09:48AM +0200, Jean Pihet wrote:
> On Fri, Sep 9, 2011 at 2:28 AM, Paul Walmsley <paul@pwsan.com> wrote:

> About the Device PM QoS user space interface:
> 1. Proposal: For every device, there will be a sysfs wakeup latency attribute
> 2. Proposal: Userspace processes should communicate their needs via sysfs

> I assume there can be only one user app that can open a given sysfs
> entry at a time, is that correct?

No, that's not the case.  The file implementation doesn't get to see
opens and closes at all, it just gets passed buffers to fill or read
from.
