From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: Re: [PATCH 02/18] docs: fix location of request_firmware & friends
Date: Wed, 9 May 2018 09:26:18 -0300
Message-ID: <20180509092618.4a3801ac@vento.lan>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <9e40d0b3a085a937b42ec60a3b2409cf820ca713.1525684985.git.mchehab+samsung@kernel.org>
        <20180508154908.GD27853@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180508154908.GD27853@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@infradead.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masanari Iida <standby24x7@gmail.com>, linux-pm@vger.kernel.org, Kees Cook <keescook@chromium.org>
List-Id: linux-pm@vger.kernel.org

Em Tue, 8 May 2018 15:49:08 +0000
"Luis R. Rodriguez" <mcgrof@kernel.org> escreveu:

> On Mon, May 07, 2018 at 06:35:38AM -0300, Mauro Carvalho Chehab wrote:
> > commit 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> > and other commits renamed the old firmware_class.c file and split it
> > into separate files, but documentation was not changed accordingly,
> > causing Sphinx errors.
> > 
> > Change the location accordingly at the documentation files.
> > 
> > While here, add a missing entry at request_firmware.rst for
> > release_firmware() function.
> > 
> > Fixes: 5d6d1ddd2730 ("firmware: move firmware loader into its own directory")
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > ---
> >  Documentation/dell_rbu.txt                      |  4 ++--
> >  .../driver-api/firmware/fallback-mechanisms.rst |  2 +-
> >  .../driver-api/firmware/request_firmware.rst    | 17 +++++++++++------
> >  Documentation/driver-api/infrastructure.rst     |  2 +-
> >  Documentation/power/suspend-and-cpuhotplug.txt  |  2 +-
> >  5 files changed, 16 insertions(+), 11 deletions(-)
> > 
> > diff --git a/Documentation/dell_rbu.txt b/Documentation/dell_rbu.txt
> > index 0fdb6aa2704c..befeff80e7ec 100644
> > --- a/Documentation/dell_rbu.txt
> > +++ b/Documentation/dell_rbu.txt
> > @@ -121,8 +121,8 @@ read back the image downloaded.
> >  
> >  .. note::
> >  
> > -   This driver requires a patch for firmware_class.c which has the modified
> > -   request_firmware_nowait function.
> > +   This driver requires a patch for drivers/base/firmware_loader/main.c
> > +   which has the modified request_firmware_nowait() function.
> >  
> >     Also after updating the BIOS image a user mode application needs to execute
> >     code which sends the BIOS update request to the BIOS. So on the next reboot  
> 
> This part looks good and is needed.

Ok. I'll submit this as a separate patch.

> 
> > diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > index f353783ae0be..7aed31b5a439 100644
> > --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > @@ -72,7 +72,7 @@ the firmware requested, and establishes it in the device hierarchy by
> >  associating the device used to make the request as the device's parent.
> >  The sysfs directory's file attributes are defined and controlled through
> >  the new device's class (firmware_class) and group (fw_dev_attr_groups).
> > -This is actually where the original firmware_class.c file name comes from,
> > +This is actually where drivers/base/firmware_loader/fallback.c comes from,  
> 
> Not this part.
> 
> What I meant to keep well documented here was not just only the old firmware
> file name for the code, but also the module name firmware_class, and its
> respective sysfs class name which is registered. From what I recall testing, we
> could not rename the module now because of this. I believe it had to do with
> the modular case, given the sysfs class could still be registered.
> 
> The fact that I forget the exact *issue* which prevented the module rename shows
> how important it is to document this.
> 
> Folks 10 years from now may wonder why the hell that name stuck, and the point was
> to document that the *original* loader was the sysfs fallback mechanism.

Yeah, I was in doubt about this one too. Yet, IMHO, mentioning a filename
that got removed will also be problematic 10 years from now. Perhaps you 
could say something similar to:

	Originally, the only firmware loading mechanism available was the
	one that it is now used as fallback. The file containing it used
	to be named after it, as firmware_class.c (nowadays, the fallback
	mechanism is at drivers/base/firmware_loader/fallback.c).

This way, you keep providing the explanations while pointing to the new
location of the code.

Just my 2 cents.

Thanks,
Mauro
