From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 2/5] driver core: Functional dependencies tracking
 support
Date: Wed, 9 Nov 2016 10:41:45 +0100
Message-ID: <20161109094145.GA9540@kroah.com>
References: <20161026111902.GA6447@wunner.de>
 <20161027152551.GA15718@kroah.com>
 <20161107212250.GH1764@wotan.suse.de>
 <20161108064541.GA13024@kroah.com>
 <20161108192103.GN1764@wotan.suse.de>
 <20161108194335.GA22680@kroah.com>
 <20161108205824.GA13978@wotan.suse.de>
 <CGME20161109064501epcas1p1f941d54ffd06a051aa7072569d1cc2e3@epcas1p1.samsung.com>
 <20161109064501.GA5252@kroah.com>
 <32dbffe7-5c68-88f9-4631-7b9cd6bf445e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <32dbffe7-5c68-88f9-4631-7b9cd6bf445e@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrzej Hajda <a.hajda@samsung.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Mark Brown <broonie@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Lars-Peter Clausen <lars@metafoo.de>, Grant Likely <grant.likely@secretlab.ca>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 09, 2016 at 10:36:54AM +0100, Andrzej Hajda wrote:
> On 09.11.2016 07:45, Greg Kroah-Hartman wrote:
> > On Tue, Nov 08, 2016 at 09:58:24PM +0100, Luis R. Rodriguez wrote:
> >>>> Furthermore -- how does this framework compare to Andrzej's resource tracking
> >>>> solution? I confess I have not had a chance yet to review yet but in light of
> >>>> this question it would be good to know if Andrzej's framework also requires
> >>>> deferred probe as similar concerns would exist there as well.
> >>> I have no idea what "framework" you are talking about here, do you have
> >>> a pointer to patches?
> >> I'm surprised given Andrzej did both Cc you on his patches [2] *and* chimed
> >> in on Rafael's patches to indicate that we likely can integrate PM concerns
> >> into his own "framework" [3]. There was no resolution to this discussion, however
> >> its not IMHO sufficient to brush off Andrzej's points in particular because
> >> Andrzej *is* indicating that his framework:
> > Dude, those patches were from 2014!  I can't remember patches people
> > sent to me a month ago...
> >
> >> - Eliminates deferred probe and resulting late_initcall(), consumer registers
> >> callbacks informing when given resources (clock, regulator, etc) becomes
> >> available
> >> - Properly handle resource disappearance (driver unbind, hotplug)
> >> - Track resources which are not vital to the device, but can influence behavior
> >> - Offers simplified resource allocation
> >> - Can be easily expanded to help with power management
> >>
> >> Granted I have not reviewed this yet but it at least was on my radar, and
> >> I do believe its worth reviewing this further given the generally expressed
> >> interest to see if we can have a common framework to address both ordering
> >> problems, suspend and probe. At a quick glance the "ghost provider" idea
> >> seems like a rather crazy idea but hey, there may be some goods in there.
> > >From what I remember, and I could be totally wrong, these patches were
> > way too complex and required that every subsystem change their
> > interfaces.  That's not going to work out well, but read the email
> > threads for the details...
> 
> I haven't seen your comment on my patches, except few general questions
> regarding one of earlier version of the framework.
> So maybe you are talking about different framework.
> 
> Regarding complexity, if the subsystem have simple way of
> '(un)publishing' resources it just adds single calls to restrack core:
> restrack_up, restrack_down in proper places.
> Additionally it adds quite simple stuff to encapsulate resource
> description and allocation routines into generic *_restrack_desc
> structure, see for example patch adding restrack to phy framework[1].

Ok, again, I have no idea what my response was to a 2 year-old patchset,
again, I can't remember my response to a patchset that was sent just a
month ago...

update it, and repost and we can all go from there if you think it is a
viable solution.

thanks,

greg k-h
