From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: pci 0000:0a:00.0: Refused to change power state,
	currently in D3
Date: Thu, 19 May 2011 23:35:22 +0200
Message-ID: <201105192335.22414.rjw__21492.3494183042$1305840928$gmane$org@sisk.pl>
References: <936833.81097.qm@web161805.mail.bf1.yahoo.com>
	<201105151526.41801.rjw@sisk.pl>
	<576614.9833.qm@web161818.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <576614.9833.qm@web161818.mail.bf1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mikko Vinni <mmvinni@yahoo.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, May 15, 2011, Mikko Vinni wrote:
> From: Rafael J. Wysocki:
> 
> >>  in an HP Pavilion dv5 laptop model dv5-1250eo always at resume
> >>  from s2ram the following messages are printed:
> >> 
> >>  pci 0000:0a:00.0: Refused to change power state, currently in D3
> >>  pci 0000:0a:00.1: Refused to change power state, currently in D3
> >>  pci 0000:0a:00.2: Refused to change power state, currently in D3
> >>  pci 0000:0a:00.3: Refused to change power state, currently in D3
> >>  pci 0000:0a:00.4: Refused to change power state, currently in D3
> > 
> > The lspci output indicates that this is a single multi-function
> > device that doesn't change its power state when programmed to go
> > into D0.  Perhaps it requires a power resource that is not available
> > at the point we're trying to restore those devices' registers.
> > 
> > Hard to say what that may be, though.  Please attach the output of
> > acpidump from the affected system.
> 
> Here it goes. Hopefully it contains the necessary parts and is not
> too big for the lists (produced without any parameters to acpidump):

Thanks.  Unfortunately, I didn't have the time to look into it.

Could you please go to https://bugzilla.kernel.org/show_bug.cgi?id=35452
and attach the acpidump output?

Rafael
