From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi: Fall back to manually changing SCI_EN
Date: Thu, 29 Apr 2010 23:05:11 +0200
Message-ID: <201004292305.11493.rjw@sisk.pl>
References: <1271711614-15527-1-git-send-email-mjg@redhat.com>
	<201004282058.20910.rjw@sisk.pl>
	<alpine.LFD.2.00.1004282019240.2598@sony>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1004282019240.2598@sony>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 April 2010, Len Brown wrote:
> 
> On Wed, 28 Apr 2010, Rafael J. Wysocki wrote:
> 
> > On Monday 19 April 2010, Matthew Garrett wrote:
> > > The ACPI spec tells us that the ACPI SCI_EN bit is under hardware control
> > > and shouldn't be touched by the OS. It seems that the Leading Other OS
> > > ignores this and some machines expect this behaviour. We have a blacklist
> > > for these, but given that we're able to detect the failure case and the
> > > alternative to breaking the spec is letting the machine crash and burn,
> > > let's try falling back when we know the alternative is a mostly-dead
> > > machine.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > 
> > I guess we can try that, but I'd prefer it if that went into .35.
> > 
> > It _should_ be safe, but ...
> > 
> > Anyway, Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> 
> I'd like to push this patch in .34,
> and in .35 remove the DMI list and the boot option.
> 
> One thing that has bothered me about the boot option
> is that it writes SCI_EN instead of callin acpi_enable()
> as opposed to in-addition-to acpi_enable().
> If all acpi_enable() did was set SCI_EN, then it would
> not make a difference.  However, acpi_enable() writes
> SMI_CMD and we really have no idea what other stuff
> the BIOS may do in SMM on this transition.
> 
> So if we don't end up reverting this one,
> I'd really like to see the boot option gone in .35.

There are some suspend changes in .34 that may cause problems to happen for
people, so I'm not sure if it's actually a good idea to introduce one more of
them after -rc5.

Also removing the boot option can easily wait until .36 IMHO.

Rafael
