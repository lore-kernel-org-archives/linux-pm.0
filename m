From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 01:17:33 +0200
Message-ID: <200804140117.34554.rjw__4359.23270783878$1208128763$gmane$org@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <1208126822.6958.63.camel@pasglop>
	<1208128289.29577.25.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208128289.29577.25.camel@nigel-laptop>
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
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of April 2008, Nigel Cunningham wrote:
> Hi Rafael etc.

Hi,
 
> On Mon, 2008-04-14 at 08:47 +1000, Benjamin Herrenschmidt wrote:
> > > Well, I'm not sure and I'm not going to introduce the change right now, after
> > > the paches have been included in -mm.
> > > 
> > > That would require quite some changes in the core code that I'd prefer to
> > > avoid for now.  We can do something like this in a separate patch series after
> > > the present one settles down a bit.
> > 
> > I disagree.
> > 
> > Doing it later would introduce yet another major semantic change.
> > 
> > I think we should get it right now. There's no hurry in pushing things
> > especially if they aren't quite right.
> > 
> > The ability for prepare() callbacks to sync with userland,
> > request_firmware, etc... is an important feature that's been needed for
> > some time imho.
> > 
> > Ben.
> 
> I agree. These calls have already been changing far too often in
> mainline. I know it's all been necessary but please, can we try to make
> one set of changes and just get it right this time?

Sorry, what exactly has been changing too often?  Device suspend callbacks??
They haven't changed since pm_message_t was introduced.

Thanks,
Rafael
