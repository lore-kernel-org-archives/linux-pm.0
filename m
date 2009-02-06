From: Uli Luckas <u.luckas@road.de>
Subject: Re: [PATCH 02/13] PM: Add early suspend api.
Date: Fri, 6 Feb 2009 10:33:00 +0100
Message-ID: <200902061033.01252.u.luckas@road.de>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<20090205232624.GB19577@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090205232624.GB19577@linux.intel.com>
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
To: mgross@linux.intel.com
Cc: swetland@google.com, ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, 6. February 2009, mark gross wrote:
> On Wed, Feb 04, 2009 at 06:50:15PM -0800, Arve Hj=F8nnev=E5g wrote:
> > Signed-off-by: Arve Hj=F8nnev=E5g <arve@android.com>
> > ---
> >  Documentation/power/early-suspend.txt |   26 +++++++++++++++
> >  include/linux/earlysuspend.h          |   55
> > +++++++++++++++++++++++++++++++++ 2 files changed, 81 insertions(+), 0
> > deletions(-)
> >  create mode 100644 Documentation/power/early-suspend.txt
> >  create mode 100755 include/linux/earlysuspend.h
> >
> > diff --git a/Documentation/power/early-suspend.txt
> > b/Documentation/power/early-suspend.txt new file mode 100644
> > index 0000000..8286d3a
> > --- /dev/null
> > +++ b/Documentation/power/early-suspend.txt
> > @@ -0,0 +1,26 @@
> > +Early-suspend
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The early-suspend api allows drivers to get notified when user-space
> > writes to +/sys/power/request_state to indicate that the user visible
> > sleep state should +change. A level controls what order the handlers are
> > called in. Suspend +handlers are called in low to high level order,
> > resume handlers are called in +the opposite order.
> > +
> > +Four levels are defined:
> > +EARLY_SUSPEND_LEVEL_BLANK_SCREEN:
> > +  On suspend the screen should be turned off but the framebuffer must
> > still be +  accessible. On resume the screen can be turned back on.
> > +
> > +EARLY_SUSPEND_LEVEL_STOP_DRAWING:
> > +  On suspend this level notifies user-space that it should stop
> > accessing the +  framebuffer and it waits for it to complete. On resume
> > it notifies user-space +  that it should resume screen access.
> > +  Two methods are provided, console switch or a sysfs interface.
> > +
> > +EARLY_SUSPEND_LEVEL_DISABLE_FB:
> > +  Turn off the framebuffer on suspend and back on on resume.
> > +
> > +EARLY_SUSPEND_LEVEL_STOP_INPUT:
> > +  On suspend turn off input devices that are not capable of wakeup or
> > where +  wakeup is disabled. On resume turn the same devices back on.
>
> these levels names are domain and device profile centric.  How can we
> make these be applicable to more than the HTC dream?
>
> Why 4 levels?  4 seems like too many, but why stop at 4 why not 8?
>
The random number 4 comes from randomly pushing things from userspace to =

kernelspace.
The only thing that I can see the kernel really needs to do is inform user =

space when it comes back from suspend.
I never got a reply to why userspace should ever have to stop drawing to th=
e =

frame buffer. If there is a valid reason for that, we might also need a =

blocking pre-suspend notifier, telling userspace that the device will suspe=
nd =

imediately.

Uli

-- =


------- ROAD ...the handyPC Company - - -  ) ) )

Uli Luckas
Head of Software Development

ROAD GmbH
Bennigsenstr. 14 | 12159 Berlin | Germany
fon: +49 (30) 230069 - 62 | fax: +49 (30) 230069 - 69
url: www.road.de

Amtsgericht Charlottenburg: HRB 96688 B
Managing director: Hans-Peter Constien
