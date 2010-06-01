From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to
	generic suspend functionality
Date: Wed, 2 Jun 2010 00:40:22 +0200
Message-ID: <201006020040.22429.rjw__20075.4473837607$1275431998$gmane$org@sisk.pl>
References: <1275416390.3778.7.camel@maxim-laptop>
	<201006012331.59747.rjw@sisk.pl>
	<1275429125.5573.7.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1275429125.5573.7.camel@maxim-laptop>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 01 June 2010, Maxim Levitsky wrote:
> On Tue, 2010-06-01 at 23:31 +0200, Rafael J. Wysocki wrote: 
> > On Tuesday 01 June 2010, Maxim Levitsky wrote:
> > > Saving platform non-volatile state may be required for suspend to RAM as
> > > well as hibernation. Move it to more generic code.
> > > 
> > > Signed-off-by: Matthew Garrett <mjg@redhat.com>
> > > Signed-off-by: Matthew Garrett <maximlevitsky@gmail.com>
> > 
> > You made a mistake here.
> > 
> > Also, why are you resending the Matthews patches?  I think Len has seen them
> > already.
> Yea, a copypaste.
> 
> (I was told that if one submits modified patch, it adds his
> Signed-off-by.)
> 
> I rebased these on top of 
> ACPI / EC / PM: Fix race between EC transactions and system suspend'
> 
> To be honest, I just want to get some feedback on this.
> This was major issue that kept me from using otherwise prefect suspend
> to ram.

I think this is a change we should try, but there is a chance it will break
some systems.

> Thus I am thinking that maybe ready to apply patch will have more
> chances to be reviewed....

Not really (as far as I'm concerned at least). :-)

Rafael
