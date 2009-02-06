From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 02/13] PM: Add early suspend api.
Date: Fri, 6 Feb 2009 15:26:42 -0800
Message-ID: <d6200be20902061526p14fd542by52e33692738155d1@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<1233802226-23386-3-git-send-email-arve@android.com>
	<20090205232624.GB19577@linux.intel.com>
	<200902061033.01252.u.luckas@road.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902061033.01252.u.luckas@road.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Uli Luckas <u.luckas@road.de>
Cc: swetland@google.com, linux-pm@lists.linux-foundation.org, ncunningham@crca.org.au
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 6, 2009 at 1:33 AM, Uli Luckas <u.luckas@road.de> wrote:
>> > +Four levels are defined:
>> > +EARLY_SUSPEND_LEVEL_BLANK_SCREEN:
>> > +  On suspend the screen should be turned off but the framebuffer must
>> > still be +  accessible. On resume the screen can be turned back on.
>> > +
>> > +EARLY_SUSPEND_LEVEL_STOP_DRAWING:
>> > +  On suspend this level notifies user-space that it should stop
>> > accessing the +  framebuffer and it waits for it to complete. On resume
>> > it notifies user-space +  that it should resume screen access.
>> > +  Two methods are provided, console switch or a sysfs interface.
>> > +
>> > +EARLY_SUSPEND_LEVEL_DISABLE_FB:
>> > +  Turn off the framebuffer on suspend and back on on resume.
>> > +
>> > +EARLY_SUSPEND_LEVEL_STOP_INPUT:
>> > +  On suspend turn off input devices that are not capable of wakeup or
>> > where +  wakeup is disabled. On resume turn the same devices back on.
>>
>> these levels names are domain and device profile centric.  How can we
>> make these be applicable to more than the HTC dream?
>>
>> Why 4 levels?  4 seems like too many, but why stop at 4 why not 8?
>>
> The random number 4 comes from randomly pushing things from userspace to
> kernelspace.

You can use as many levels as you want. We defined these four levels
because they should be called in a specific order.

> The only thing that I can see the kernel really needs to do is inform user
> space when it comes back from suspend.
> I never got a reply to why userspace should ever have to stop drawing to =
the
> frame buffer. If there is a valid reason for that, we might also need a
> blocking pre-suspend notifier, telling userspace that the device will sus=
pend
> imediately.

User-space should stop drawing into the framebuffer before it is
powered down. If the framebuffer that is accessible to user-space is
in main memory not stopping may be harmless since the screen is
blanked anyway.

The sequence for turning the screen off and on here was mostly
dictated by initially using the existing method of changing
framebuffer ownership, the console switch.

-- =

Arve Hj=F8nnev=E5g
