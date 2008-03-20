From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 20 Mar 2008 23:45:23 +0100
Message-ID: <200803202345.25083.rjw__38862.5761647292$1206053261$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0803182228520.10154-100000@netrider.rowland.org>
	<m1ve3jtmxk.fsf@ebiederm.dsl.xmission.com>
	<20080320104019.GA6870@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080320104019.GA6870@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday, 20 of March 2008, Pavel Machek wrote:
> On Tue 2008-03-18 21:25:27, Eric W. Biederman wrote:
> > Alan Stern <stern@rowland.harvard.edu> writes:
> > 
> > > On Wed, 19 Mar 2008, Rafael J. Wysocki wrote:
> > >
> > >> Well, I've been saying that for I-don't-remember-how-long: on my box, if you
> > >> use S5 instead of entering S4, the fan doesn't work correctly after the
> > >> resume.  Plain and simple.
> > >> 
> > >> Perhaps there's a problem with our ACPI drivers that causes this to happen,
> > >> but I have no idea what that can be at the moment.
> > >
> > > IMO it would be worthwhile to track this down.  It's a clear indication 
> > > that something is wrong somewhere.
> > >
> > > Could it be connected with the way the boot kernel hands control over
> > > to the image kernel?  Presumably ACPI isn't prepared to deal with that
> > > sort of thing during a boot from S5.  It would have to be fooled into
> > > thinking the two kernels were one and the same.
> > 
> > It should be easy to test if it is a hand over problem, by turning off
> > the laptop by placing it in S5 (shutdown -h now) and then booting same
> > kernel again.
> 
> Feel free to help with testing.
> 
> I believe ACPI is simply getting confused by us overwriting memory
> with that from old image. I don't see how you can emulate it with
> shutdown.

Well, in fact ACPI has something called the NVS memory, which we're supposed
to restore during the resume and which we're not doing.  The problem may be
related to this.

I have fixing that on my todo list, but frankly there's many different things
in there. :-)

Thanks,
Rafael
