From: mark gross <markgross@thegnar.org>
Subject: Re: LPC 2011 Power Management Session notes
Date: Fri, 9 Sep 2011 15:50:52 -0700
Message-ID: <20110909225052.GA21769@gvim.org>
References: <alpine.DEB.2.00.1109081827360.17022@utopia.booyaka.com>
	<CAORVsuWKd9uvTTNCr_k9W6DeA+z3ZEaD99bqit++4xUy9zqKSQ@mail.gmail.com>
Reply-To: markgross@thegnar.org
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
> Hi,
> 
> On Fri, Sep 9, 2011 at 2:28 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >
> > Available at
> >
> > http://pad.ubuntu.com/plumbers-2011-pwr-mgt
> >
> > in real time if anyone's interested
> Thanks for the doc!
> 
> 
> About the Device PM QoS user space interface:
> 1. Proposal: For every device, there will be a sysfs wakeup latency attribute
> 2. Proposal: Userspace processes should communicate their needs via sysfs
> 
> I assume there can be only one user app that can open a given sysfs
> entry at a time, is that correct?
> 
> Let me think about it and propose a patch next week.


My recollection of the evening was that the exposing of per device qos
latencies was not considered a good idea without better articulation on
how it would be used.  (or misused) 

FWIW a few folks (ok maybe just me) are not comfortable with exposing
raw values without a good enough abstraction for them to user mode such
that the values used through that user mode ABI would be somewhat
portable between ISA's or even versions of the same chips / platforms.

--mark
 
> Regards,
> Jean
> 
> >
> >
> > - Paul
> > _______________________________________________
> > linux-pm mailing list
> > linux-pm@lists.linux-foundation.org
> > https://lists.linux-foundation.org/mailman/listinfo/linux-pm
> >
> _______________________________________________
> linux-pm mailing list
> linux-pm@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/linux-pm
